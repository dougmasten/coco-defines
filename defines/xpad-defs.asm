; xpad-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef XPAD_DEFS    ; Load defines only once


; X-Pad
XPAD_X                  equ $ff60           ; X coordinate for X-Pad, 0-255
XPAD_Y                  equ $ff61           ; Y coordinate for X-Pad, 0-191
XPAD_STATUS             equ $ff62           ; Status register for X-Pad
                                            ; Bit 3 - Pen in Y-Margin
                                            ; Bit 2 - Pen in X-Margin
                                            ; Bit 1 - Pen within 1" of surface
                                            ; Bit 0 - Pen down


XPAD_DEFS               equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
