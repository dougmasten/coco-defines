; psg-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef PSG_DEFS     ; Load defines only once


; CoCo PSG by Ed Snider
;   - YM2149 classic sound chip
;   - Digital joystick/controller 4-ports
;   - 512K of RAM
;   - 512K of FLASH memory
; https://thezippsterzone.com/2018/05/08/coco-psg/
PSG_MEM0                equ $ff5a           ; Memory Bank 0 Register
PSG_MEM1                equ $ff5b           ; Memory Bank 1 Register
PSG_CTRL_REG            equ $ff5d           ; Control Register
                                            ; Bit 7:6 - n/a
                                            ; Bit 5 - FLASH programming: 0=disabled, 1=enabled
                                            ; Bit 4 - Autostart: 0=enabled, 1=disabled
                                            ; Bit 3 - Write Enable (for FLASH/SRAM); 0=disabled, 1=enabled
                                            ; Bit 2 - Gameport B Sel Signal (pin 7 of controller port B)
                                            ; Bit 1 - Gameport A Sel signal (pin 7 of controller port A)
                                            ; Bit 0 - YM2149 Master Clock: 0=2MHz, 1=1MHz
PSG_YM_REG              equ $ff5e           ; YM Register Select Port
PSG_YM_DATA             equ $ff5f           ; YM Data Port
PSG_FLASH_5555          equ $bfff           ; Programming Register for 512K FLASH chip
PSG_FLASH_2AAA          equ $baaa           ; Programming Register for 512K FLASH chip


PSG_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
