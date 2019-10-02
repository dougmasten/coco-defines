; optimizations.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_OPTIMIZE_DEFS  ; Load macros only once


; space savings macros
skip_byte           macro
                    fcb $c5                 ; actually a BITB #$xx instruction (2 clocks)
                    endm

skip_word           macro
                    fcb $8c                 ; actually a CMPX #$xxxx instruction (3 clocks)
                    endm


; increment memory word by +1
inc_word            macro
                    inc \1+1                ; increment LSB
                    bne a@
                    inc \1                  ; increment MSB
a@                  equ *
                    endm


; faster long branch instructions if branch is not taken (same cycles otherwise but with one extra byte)
long_bcc            macro
                    bcs a@
                    jmp \1
a@                  equ *
                    endm

long_bcs            macro
                    bcc a@
                    jmp \1
a@                  equ *
                    endm

long_beq            macro
                    bne a@
                    jmp \1
a@                  equ *
                    endm

long_bmi            macro
                    bpl a@
                    jmp \1
a@                  equ *
                    endm

long_bne            macro
                    beq a@
                    jmp \1
a@                  equ *
                    endm

long_bpl            macro
                    bmi a@
                    jmp \1
a@                  equ *
                    endm

long_bvc            macro
                    bvs a@
                    jmp \1
a@                  equ *
                    endm

long_bvs            macro
                    bvc a@
                    jmp \1
a@                  equ *
                    endm

MACROS_OPTIMIZE_DEFS equ 1                  ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
