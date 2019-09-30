; optimizations.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_OPTIMIZE_DEFS   ; Load macros only once


; space savings macros
skip_one_byte       macro
                    fcb $c5                 ; actually a BITB #$xx instruction (2 clocks)
                    endm

skip_two_bytes      macro
                    fcb $8c                 ; actually a CMPX #$xxxx instruction (3 clocks)
                    endm


; increment memory word by +1
incword             macro
                    inc \1+1                ; increment LSB
                    bne a@
                    inc \1                  ; increment MSB
a@                  equ *
                    endm


MACROS_OPTIMIZE_DEFS   equ 1                   ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
