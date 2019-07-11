; test-repeat-macro.asm


                include ../common/macros/repeat.asm

copy_one_line   macro
                lda ,u
                sta ,x
                abx
                endm


                repeat copy_one_line,10

num_of_lines    equ 10
                repeat copy_one_line,num_of_lines

                repeat abx,10
                repeat lsra,4
                repeat lslb,4

