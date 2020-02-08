; pia-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef PIA_DEFS     ; Load defines only once


; PIA Registers
PIA0_DATA_A             equ $ff00           ; PIA 0 side A data register
                                            ; Bit 7 - Joystick comparison input
                                            ; Bit 6 - Keyboard row 7
                                            ; Bit 5 - Keyboard row 6
                                            ; Bit 4 - Keyboard row 5
                                            ; Bit 3 - Keyboard row 4 & Left Joystick Switch 2
                                            ; Bit 2 - Keyboard row 3 & Right Joystick Switch 2
                                            ; Bit 1 - Keyboard row 2 & Left Joystick Switch 1
                                            ; Bit 0 - Keyboard row 1 & Right Joystick Switch 1
PIA0_BASE               equ PIA0_DATA_A
PIA_KEYBOARD_ROW        equ PIA0_DATA_A
PIA_HSYNC_ACK           equ PIA0_DATA_A     ; Read register to acknowledge the PIA HSYNC interrupt

PIA0_CTRL_A             equ $ff01           ; PIA 0 side A control register
                                            ; Bit 7 - HSYNC Flag 0=not sync, 1=triggered
                                            ; Bit 6 - n/a
                                            ; Bit 5 - Always a "1"
                                            ; Bit 4 - Always a "1"
                                            ; Bit 3 - Select line LSB of MUX
                                            ;         MSB (FF03 bit 3)   LSB (FF01 bit 3)   Sound Source
                                            ;          0                  0                  DAC
                                            ;          0                  1                  Cassette
                                            ;          1                  0                  Cartridge
                                            ;          1                  1                  No Sound
                                            ; Bit 2 - Data direction toggle 0=$FF00 sets data direction, 1=normal
                                            ; Bit 1 - IRQ Polarity 0=flag set on falling edge, 1=set on rising edge
                                            ; Bit 0 - HSYNC IRQ 0=disabled, 1=enabled
PIA_HSYNC_FLAG          equ PIA0_CTRL_A

PIA0_DATA_B             equ $ff02           ; PIA 0 side B data register
                                            ; Bit 7 - Keyboard column 8
                                            ; Bit 6 - Keyboard column 7
                                            ; Bit 5 - Keyboard column 6
                                            ; Bit 4 - Keyboard column 5
                                            ; Bit 3 - Keyboard column 4
                                            ; Bit 2 - Keyboard column 3
                                            ; Bit 1 - Keyboard column 2
                                            ; Bit 0 - Keyboard column 1
PIA_KEYBOARD_COL        equ PIA0_DATA_B
PIA_VSYNC_ACK           equ PIA0_DATA_B     ; Read register to acknowledge the VSYNC interrupt

PIA0_CTRL_B             equ $ff03           ; PIA 0 side B control register
                                            ; Bit 7 - VSYNC Flag 0=not sync, 1=triggered
                                            ; Bit 6 - n/a
                                            ; Bit 5 - Always a "1"
                                            ; Bit 4 - Always a '1"
                                            ; Bit 3 - Select line MSB of MUX
                                            ;         MSB (FF03 bit 3)   LSB (FF01 bit 3)   Sound Source
                                            ;          0                  0                  DAC
                                            ;          0                  1                  Cassette
                                            ;          1                  0                  Cartridge
                                            ;          1                  1                  No Sound
                                            ; Bit 2 - Data direction toggle 0=$FF02 sets data direction, 1=normal
                                            ; Bit 1 - IRQ Polarity 0=flag set on falling edge, 1=set on rising edge
                                            ; Bit 0 - VSYNC IRQ 0=disabled, 1=enabled
PIA_VSYNC_FLAG          equ PIA0_CTRL_B


PIA1_DATA_A             equ $ff20           ; PIA 1 side A data register
                                            ; Bit 7:2 - DAC (6 bits)
                                            ; Bit 1 - RS-232C Data Output
                                            ; Bit 0 - Cassette Data Input

PIA_DAC                 equ PIA1_DATA_A
PIA1_BASE               equ PIA1_DATA_A

PIA1_CTRL_A             equ $ff21           ; PIA 1 side A control register
                                            ; Bit 7 - CD FIRQ Flag
                                            ; Bit 6:4 - n/a
                                            ; Bit 3 - Cassette motor control 0=off, 1=on
                                            ; Bit 2 - Data direction control of $FF20: 0=input and 1=output (normal)
                                            ; Bit 1 - FIRQ polarity 0=falling, 1=rising
                                            ; Bit 0 - CD FIRQ (RS-232C) 0=FIRQ disabled, 1=enabled

PIA1_DATA_B             equ $ff22           ; PIA 1 side B data register
                                            ; Bit 7:2 - n/a
                                            ; Bit 1 - Single bit sound output
                                            ; Bit 0 - RS-232C data input

PIA1_CTRL_B             equ $ff23           ; PIA 1 side B control register
                                            ; Bit 7 - Cartridge FIRQ Flag
                                            ; Bit 6:4 - n/a
                                            ; Bit 3 - Sound enable
                                            ; Bit 2 - Data direction control of $FF22: 0=input and 1=output (normal)
                                            ; Bit 1 - FIRQ Polarity 0=falling, 1=rising
                                            ; Bit 0 - Cart FIRQ 0=FIRQ disabled, 1=enabled


PIA_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state

