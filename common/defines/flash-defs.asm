; flash-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef FLASH_DEFS   ; Load defines only once


; CoCo FLASH Cartridge by RETRO Innovations
; http://www.go4retro.com/products/cocoflash/
FLASH_CONFIG            equ $ff64           ; CoCo FLASH Cartridge
                                            ; Bit 7 - Enable FLASH write at $C000 (1=enabled)
                                            ; Bit 6 - Read bank or Device ID (1=Device ID visible)
                                            ; Bit 5 - Enable offset register (1=enabled)
                                            ; Bit 4 - Force single reset (1=selected)
                                            ; Bit 3:2 - Select SPI source
                                            ;             00 = none
                                            ;             01 = EEPROM
                                            ;             10 = Secondard SPI channel
                                            ;             11 = Third SPI channel (not currently implemented)
                                            ; Bit 1 - Autostart (1=on)
                                            ; Bit 0 - LED (1=on)
FLASH_BANK_LO           equ $ff65           ; Bit 7:0 - bits 7-0 of bank register
FLASH_BANK_HI           equ $ff66           ; Bit 7:4 - n/a
                                            ; Bit 3:0 - bits 10-8 of bank register
FLASH_SPI               equ $ff67           ; SPI data out
FLASH_INFO0             equ $ff7a           ; CoCo FLASH Cartridge (READ Only)
                                            ; Bit 7:4 - Device Family
                                            ; Bit 3:0 - Device ID
FLASH_INFO1             equ $ff7b           ; CoCo FLASH Cartridge (READ Only)
                                            ; Bit 7:4 - Device version
                                            ; Bit 3:0 - Config jumpers
FLASH_COMMAND_REG       equ $ff80           ; Remap CoCoFlash registers
                                            ;
                                            ; To unlock the command system, first read from command_reg to
                                            ; reset the command system. After send a special sequence to
                                            ; command_reg of $55,$AA,<DEVICE_FAMILY:DEVICE_ID>.
                                            ;
                                            ; Family ID Device
                                            ; ------ -- ------------------------
                                            ; $1     $1 Tandy/RS Orchestra 90-CC
                                            ; $2     $1 CoCoFlash
                                            ;
                                            ; Once proper sequence is sent, a program must send a command
                                            ; to execute.
                                            ;
                                            ; Command            Value    Data Length   Data Value
                                            ; ----------------   -----    -----------   ---------------------------------
                                            ; Set Base Address   $01      1             Low byte of base address
                                            ;                                           (setting high bit will hide device)


FLASH_DEFS              equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
