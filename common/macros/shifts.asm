; shifts.asm

                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef SHIFT_MACROS     ; Load macros only once


lsr4a               macro
                    lsra
                    lsra
                    lsra
                    lsra
                    endm

lsr4b               macro
                    lsrb
                    lsrb
                    lsrb
                    lsrb
                    endm

lsl4a               macro
                    lsla
                    lsla
                    lsla
                    lsla
                    endm

lsl4b               macro
                    lslb
                    lslb
                    lslb
                    lslb
                    endm


SHIFT_MACROS        equ 1                   ; Set flag for macros being loaded
                    endc
                    *pragmapop list         ; restore assembly listing to previous state

