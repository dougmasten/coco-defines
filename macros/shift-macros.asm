; shift-macros.asm

                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef SHIFT_MACROS     ; Load macros only once


                    ifndef REPEAT_MACRO
                    include repeat-macros.asm
                    endc


asl4a               macro
                    rpt 4,asla
                    endm

asl4b               macro
                    rpt 4,aslb
                    endm

asr4a               macro
                    rpt 4,asra
                    endm

asr4b               macro
                    rpt 4,asrb
                    endm

lsr4a               macro
                    rpt 4,lsra
                    endm

lsr4b               macro
                    rpt 4,lsrb
                    endm

lsl4a               macro
                    rpt 4,lsla
                    endm

lsl4b               macro
                    rpt 4,lslb
                    endm


SHIFT_MACROS        equ 1                   ; Set flag for macros being loaded
                    endc
                    *pragmapop list         ; restore assembly listing to previous state
