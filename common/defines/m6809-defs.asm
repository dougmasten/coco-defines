; m6809-defs.asm

                    *pragmapush list    ; Save state of list pragma
                    pragma nolist       ; Turn off assembly listing and exclude from symbol list
                    ifndef M6809_DEFS   ; Load defines only once


; convenient definitions
CC_STACK            equ %10000000           ; entire register state stacked
CC_FIRQ             equ %01000000           ; FIRQ interrupt masked
CC_HCARRY           equ %00100000           ; half-carry
CC_IRQ              equ %00010000           ; IRQ interrupt masked
CC_NEGATIVE         equ %00001000           ; negative result (twos complement)
CC_ZERO             equ %00000100           ; zero result
CC_OVERFLOW         equ %00000010           ; overflow
CC_CARRY            equ %00000001           ; carry (or borrow)


M6809_DEFS          equ 1               ; Set flag for defines being loaded
                    endc
                    *pragmapop list     ; restore assembly listing to previous state
