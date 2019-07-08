; space_saving.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_SPACE_DEFS   ; Load macros only once



; space savings macros
skip_one_byte       macro
                    fcb $c5                 ; actually a BITB #$xx instruction (2 clocks)
                    endm

skip_two_bytes      macro
                    fcb $8c                 ; actually a CMPX #$xxxx instruction (3 clocks)
                    endm




MACROS_SPACE_DEFS   equ 1                   ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
