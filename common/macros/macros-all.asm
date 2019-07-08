; macros.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_DEFS      ; Load macros only once


                    include boomerang.asm
                    include clear-instructions.asm
                    include fdc.asm
                    include register-cc.asm
                    include shifts.asm
                    include space-saving.asm
                    include test-instructions.asm
                    include wait-cycles.asm


MACROS_DEFS         equ 1                   ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
