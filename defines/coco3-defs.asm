; coco3-defs.asm
; Tandy Color Computer 3 hardware definitions


                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list

                        include sam-defs.asm
                        include fdc-defs.asm
                        include gime-defs.asm
                        include interrupts-defs.asm
                        include mpi-defs.asm
                        include pia-defs.asm
                        include regcc-defs.asm
                        include rsdos-defs.asm

                        *pragmapop list     ; restore assembly listing to previous state
