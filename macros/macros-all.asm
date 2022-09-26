; macros-all.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_ALL_LOADED    ; Load macros only once


                    include convenience.asm
                    include hardware.asm
                    include optimizations.asm
                    include regcc.asm
                    include repeat.asm
                    include wait-cycles.asm


MACROS_ALL_LOADED   equ 1                   ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
