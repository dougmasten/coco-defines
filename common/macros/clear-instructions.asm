; clear_instructions.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef CLEAR_INSTRUCTIONS_MACROS  ; Load defines only once


clru                    macro
                        ldu #0
                        endm

clrx                    macro
                        ldx #0
                        endm

clry                    macro
                        ifpragma 6809
                          ldy #0
                        else
                          tfr 0,y
                        endc
                        endm

                        ifpragma no6309conv
clrq                    macro
                        clrd
                        clrw
                        endm
                        endc


CLEAR_INSTRUCTIONS_MACROS equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
