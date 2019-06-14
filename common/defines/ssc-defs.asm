; ssc-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef SSC_DEFS     ; Load defines only once


; Sound/Speech Cartridge
SSC_RESET               equ $ff7d           ; Sound/Speech Cartridge reset
SSC_RW                  equ $ff7e           ; Sound/Speech Cartridge read/write


SSC_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
