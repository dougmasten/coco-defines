; hardware.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef HARDWARE_MACROS  ; Load defines only once


; make sure defines are included
                        ifndef EXTRA_DEFS
                        include ../defines/extra-defs.asm
                        endc


enable_normal_speed     macro
                        sta NORMAL_SPEED_MODE
                        endm

enable_high_speed       macro
                        sta HIGH_SPEED_MODE
                        endm

enable_rom_mode         macro
                        sta ROM_MODE_ENABLE
                        endm

enable_ram_mode         macro
                        sta RAM_MODE_ENABLE
                        endm


HARDWARE_MACROS         equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state

