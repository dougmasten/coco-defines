; test-instructions.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef TEST_INSTRUCTIONS_MACROS  ; Load defines only once


tstu                    macro
                        ifpragma 6809
                          cmpu #0
                        else
                          cmpr u,0
                        endc
                        endm

tstx                    macro
                        ifpragma 6809
                          leax ,x
                        else
                          cmpx #0
                        endc
                        endm

tsty                    macro
                        leay ,y
                        endm

                        ifpragma no6309conv
tstq                    macro
                        stq -4,s
                        endm
                        endc


TEST_INSTRUCTIONS_MACROS equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
