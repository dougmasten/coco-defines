; regcc.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef REGCC_MACROS     ; Load macros only once


                    include ../defines/regcc-defs.asm


; convenient macros
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

disable_interrupts  macro
                    orcc #CC_FIRQ+CC_IRQ
                    endm

enable_interrupts   macro
                    andcc #^(CC_FIRQ+CC_IRQ)
                    endm

disable_firq        macro
                    set_firq_flag
                    endm

enable_firq         macro
                    clear_firq_flag
                    endm

disable_irq         macro
                    set_irq_flag
                    endm

enable_irq          macro
                    clear_irq_flag
                    endm

REGCC_MACROS        equ 1                   ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
