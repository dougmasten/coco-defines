; coco3-defs.asm
; Tandy Color Computer 3 hardware definitions


                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list

                        ifndef COCO3_DEFS   ; Load defines only once


                        include defines/rsdos-defs.asm
                        include defines/pia-defs.asm
                        include defines/gime-defs.asm
                        include defines/interrupts-defs.asm
                        include defines/extra-defs.asm


COCO3_DEFS              equ 1               ; Set flag for defines being loaded
                        endc

                        *pragmapop list     ; restore assembly listing to previous state
