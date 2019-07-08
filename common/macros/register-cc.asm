; regcc.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_REGCC_DEFS  ; Load macros only once


; convenient definitions
CC_STACK            equ %10000000           ; entire register state stacked
CC_FIRQ             equ %01000000           ; FIRQ interrupt masked
CC_HCARRY           equ %00100000           ; half-carry
CC_IRQ              equ %00010000           ; IRQ interrupt masked
CC_NEGATIVE         equ %00001000           ; negative result (twos complement)
CC_ZERO             equ %00000100           ; zero result
CC_OVERFLOW         equ %00000010           ; overflow
CC_CARRY            equ %00000001           ; carry (or borrow)


; convenient macros
disable_interrupts  macro
                    orcc #CC_FIRQ+CC_IRQ
                    endm

enable_interrupts   macro
                    andcc #^(CC_FIRQ+CC_IRQ)
                    endm

clear_stack_flag    macro
                    andcc #^CC_STACK
                    endm

set_stack_flag      macro
                    orcc #CC_STACK
                    endm

clear_firq_flag     macro
                    andcc #^CC_FIRQ
                    endm

set_firq_flag       macro
                    orcc #CC_FIRQ
                    endm

clear_half_carry_flag macro
                    andcc #^CC_HCARRY
                    endm

set_half_carry_flag macro
                    orcc #CC_HCARRY
                    endm

clear_irq_flag      macro
                    andcc #^CC_IRQ
                    endm

set_irq_flag        macro
                    orcc #CC_IRQ
                    endm

clear_negative_flag macro
                    andcc #^CC_NEGATIVE
                    endm

set_negative_flag   macro
                    orcc #CC_NEGATIVE
                    endm

clear_zero_flag     macro
                    andcc #^CC_ZERO
                    endm

set_zero_flag       macro
                    orcc #CC_ZERO
                    endm

clear_overflow_flag macro
                    andcc #^CC_OVERFLOW
                    endm

set_overflow_flag   macro
                    orcc #CC_OVERFLOW
                    endm

clear_carry_flag    macro
                    andcc #^CC_CARRY
                    endm

set_carry_flag      macro
                    orcc #CC_CARRY
                    endm


MACROS_REGCC_DEFS   equ 1                   ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
