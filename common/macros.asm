; macros.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_DEFS      ; Load macros only once


; space savings macros
skip_one_byte       macro
                    fcb $c5                 ; actually a BITB #$xx instruction (2 clocks)
                    endm

skip_two_bytes      macro
                    fcb $8c                 ; actually a CMPX #$xxxx instruction (3 clocks)
                    endm


; convenient macros
disable_interrupts  macro
                    orcc #$50
                    endm

enable_interrupts   macro
                    andcc #$af
                    endm

clear_carry_flag    macro
                    andcc #^1
                    endm

set_carry_flag      macro
                    orcc #1
                    endm

clear_overflow_flag macro
                    andcc #^%00000010
                    endm

set_overflow_flag   macro
                    orcc #%00000010
                    endm

clear_zero_flag     macro
                    andcc #^%00000100
                    endm

set_zero_flag       macro
                    orcc #%00000100
                    endm

clear_negative_flag macro
                    andcc #^%00001000
                    endm

set_negative_flag   macro
                    orcc #%00001000
                    endm

clear_irq_flag      macro
                    andcc #^%00010000
                    endm

set_irq_flag        macro
                    orcc #%00010000
                    endm

clear_half_carry_flag macro
                    andcc #^%00100000
                    endm

set_half_carry_flag macro
                    orcc #%00100000
                    endm

clear_firq_flag     macro
                    andcc #^%01000000
                    endm

set_firq_flag       macro
                    orcc #%01000000
                    endm

clear_stack_flag    macro
                    andcc #^%10000000
                    endm

set_stack_flag      macro
                    orcc #%10000000
                    endm

high_nibble         macro
                    lsr\1
                    lsr\1
                    lsr\1
                    lsr\1
                    endm

low_nibble          macro
                    and\1 #%00001111
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
