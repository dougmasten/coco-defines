; macros-all.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_ALL_LOADED    ; Load macros only once


                    include boomerang-macros.asm
                    include clear-instructions-macros.asm
                    include convenience-macros.asm
                    include fdc-macros.asm
                    include hardware-macros.asm
                    include optimizations-macros.asm
                    include regcc-macros.asm
                    include shifts-macros.asm
                    include test-instructions-macros.asm


MACROS_ALL_LOADED   equ 1                   ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
