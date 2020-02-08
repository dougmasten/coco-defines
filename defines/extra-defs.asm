; extra-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef EXTRA_DEFS   ; Load defines only once


NORMAL_SPEED_MODE       equ $ffd8           ; Any write selects 0.89 Mhz CPU clock
HIGH_SPEED_MODE         equ $ffd9           ; Any write selects 1.79 Mhz CPU clock


ROM_MODE_ENABLE         equ $ffde           ; Any write selects RAM/ROM mode
RAM_MODE_ENABLE         equ $ffdf           ; Any write selects all-RAM mode


EXTRA_DEFS              equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
