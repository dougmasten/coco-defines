; repeat.asm

                       *pragmapush list    ; Save state of list pragma
                       pragma nolist       ; Turn off assembly listing and exclude from symbol list
                       ifndef REPEAT_MACRO ; Load macro only once

;------------------------------------------------------------------------------
; Repeat a macro X number of times
;
; examples:
;
;   copy_one_line macro                    ; an example of a macro to repeat
;                 lda ,u
;                 sta ,x
;                 abx
;                 endm
;
;   repeat copy_one_line,100               ; repeat macro 100 times
;
;   num_of_lines  equ 100                  ;
;   repeat copy_one_line,num_of_lines      ; repeat macro for number value of a variable
;
;   repeat lsra,4                          ; repeat instruction "lsra" four times
;------------------------------------------------------------------------------

repeat                 macro
                       *pragmapush list    ; Save state of list pragma
                       pragma nolist       ; Turn off assembly listing and exclude from symbol list
repeatc                set \2
                       ifne repeatc        ; test for zero repeat case

repeat32_count           set repeatc/32
repeatc                  set repeatc-(repeat32_count*32)
repeat16_count           set repeatc/16
repeatc                  set repeatc-(repeat16_count*16)
repeat8_count            set repeatc/8
repeatc                  set repeatc-(repeat8_count*8)
repeat4_count            set repeatc/4
repeatc                  set repeatc-(repeat4_count*4)
repeat2_count            set repeatc/2
repeatc                  set repeatc-(repeat2_count*2)
repeat1_count            set repeatc/1
repeatc                  set repeatc-repeat1_count

                         ifne repeat32_count
                           repeat32 \1,repeat32_count
                         endc

                         ifne repeat16_count
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                         endc

                         ifne repeat8_count
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                           \1
                         endc

                         ifne repeat4_count
                           \1
                           \1
                           \1
                           \1
                         endc

                         ifne repeat2_count
                           \1
                           \1
                         endc

                         ifne repeat1_count
                           \1
                         endc

                       endc
                       *pragmapop list     ; restore assembly listing to previous state
                       endm


repeat32               macro
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
                       \1
repeat32_count         set \2-1
                       ifgt repeat32_count
                         repeat32 \1,repeat32_count
                       endc
                       endm


REPEAT_MACRO           equ 1               ; Set flag for macro being loaded
                       endc
                       *pragmapop list     ; restore assembly listing to previous state
