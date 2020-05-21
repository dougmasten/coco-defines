; fdc-macros.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef FDC_MACROS   ; Load defines only once


; make sure defines are included
                        ifndef FDC_DEFS
                        include ../defines/fdc-defs.asm
                        endc


turn_fdc_motor_off      macro                ; turn off all drive motors
                        clr FDC_CTRL
                        endm


FDC_MACROS              equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
