; macros-all.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list

                    include convenience.asm
                    include hardware.asm
                    include optimizations.asm
                    include regcc.asm
                    include repeat.asm
                    include wait-cycles.asm


                    *pragmapop list         ; restore assembly listing to previous state
