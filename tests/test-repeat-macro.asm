; test-repeat-macro.asm


                include ../common/macros/repeat.asm

copy_one_line   macro
                lda ,u
                sta ,x
                abx
                endm


; test #1
                repeat copy_one_line,10

; test #2
num_of_lines    equ 10
                repeat copy_one_line,num_of_lines

; test #3
                repeat lsra,4
