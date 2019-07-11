; repeat.asm

                       *pragmapush list    ; Save state of list pragma
                       pragma nolist       ; Turn off assembly listing and exclude from symbol list
                       ifndef REPEAT_MACRO ; Load macro only once

;------------------------------------------------------------------------------
; Repeat a macro X number of times
;
; example:
;
;    include repeat.asm                    ; include this macro file
;
;    copy_one_line macro                   ; an example of a macro to repeat
;                  lda ,u
;                  sta ,x
;                  abx
;                  endm
;
;    repeat copy_one_line,100              ; repeat macro 100 times
;
;    num_of_lines  equ 100                 ;
;    repeat copy_one_line,num_of_lines     ; repeat macro for number value of a variable
;
;    repeat lsra,4                         ; repeat instruction "lsra" four times
;------------------------------------------------------------------------------

repeat                 macro
                       *pragmapush list    ; Save state of list pragma
                       pragma nolist       ; Turn off assembly listing and exclude from symbol list
                       ifne \2             ; test for zero repeat case
repeatc                  set \2-1
                         \1
                         ifgt repeatc
                           repeat \1,repeatc
                         endc
                       endc
                       *pragmapop list     ; restore assembly listing to previous state
                       endm


REPEAT_MACRO           equ 1               ; Set flag for macro being loaded
                       endc
                       *pragmapop list     ; restore assembly listing to previous state
