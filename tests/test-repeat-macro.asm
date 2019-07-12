; test-repeat-macro.asm


                include ../common/macros/repeat.asm

copy_one_line   macro
                lda ,u
                sta ,x
                abx
                endm


; test #1
; repeat macro for hardcoded value
                repeat copy_one_line,10


; test #2
; repeat macro for value of variable
num_of_lines    equ 225
                repeat copy_one_line,num_of_lines


; test #3
; repeat one word instruction
                repeat lsra,4


; test #4
; check for zero repeat special case
                repeat lsrb,0


; test #5
; worst case scenario
                repeat nop,65536
