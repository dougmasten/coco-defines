; comments.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_COMMENTS_DEFS  ; Load macros only once


comment             macro
                    if 0
                    endm

end_comment         macro
                    endc
                    endm

MACROS_COMMENTS_DEFS equ 1                  ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
