; gmc-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef GMC_DEFS     ; Load defines only once


; Game Master Cartridge by John Linville
; https://en.wikipedia.org/wiki/Texas_Instruments_SN76489
GMC_BANK                equ $ff40
GMC_SOUND               equ $ff41           ; Texas Instruments SN76489 data bus (Write-only)


GMC_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
