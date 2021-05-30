; convenience-macros.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_CONVENIENCE_DEFS  ; Load macros only once

                    include repeat-macros.asm

; rotate left in register A
rotate_left_a       macro
                    lsla
                    adca #0
                    endm

; rotate left in register B
rotate_left_b       macro
                    lslb
                    adcb #0
                    endm

; swap nibbles in register A
swap_a              macro
                    rotate 4,rotate_left_a
                    endm

; swap nibbles in register B
swap_b              macro
                    rotate 4,rotate_left_b
                    endm


MACROS_CONVENIENCE_DEFS equ 1               ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
