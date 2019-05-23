; macros.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_DEFS      ; Load macros only once


; convenient definitions
CC_STACK            equ %10000000           ; entire register state stacked
CC_FIRQ             equ %01000000           ; FIRQ interrupt masked
CC_HCARRY           equ %00100000           ; half-carry
CC_IRQ              equ %00010000           ; IRQ interrupt masked
CC_NEGATIVE         equ %00001000           ; negative result (twos complement)
CC_ZERO             equ %00000100           ; zero result
CC_OVERFLOW         equ %00000010           ; overflow
CC_CARRY            equ %00000001           ; carry (or borrow)


; space savings macros
skip_one_byte       macro
                    fcb $c5                 ; actually a BITB #$xx instruction (2 clocks)
                    endm

skip_two_bytes      macro
                    fcb $8c                 ; actually a CMPX #$xxxx instruction (3 clocks)
                    endm


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

lsr4a               macro
                    lsra
                    lsra
                    lsra
                    lsra
                    endm

lsr4b               macro
                    lsrb
                    lsrb
                    lsrb
                    lsrb
                    endm

lsl4a               macro
                    lsla
                    lsla
                    lsla
                    lsla
                    endm

lsl4b               macro
                    lslb
                    lslb
                    lslb
                    lslb
                    endm

clru                macro
                    ldu #0
                    endm

clrx                macro
                    ldx #0
                    endm

clry                macro
                    ifpragma 6809
                      ldy #0
                    else
                      tfr 0,y
                    endc
                    endm

                    ifpragma no6309conv
clrq                macro
                    clrd
                    clrw
                    endm
                    endc

tstu                macro
                    ifpragma 6809
                      cmpu #0
                    else
                      cmpr u,0
                    endc
                    endm

tstx                macro
                    cmpx #0
                    endm

tsty                macro
                    ifpragma 6809
                      cmpy #0
                    else
                      cmpr y,0
                    endc
                    endm

                    ifpragma no6309conv
tstq                macro
                    stq -4,s
                    endm
                    endc

MACROS_DEFS         equ 1                   ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
