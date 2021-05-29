; repeat-macros.asm

                  *pragmapush list    ; Save state of list pragma
                  pragma nolist       ; Turn off assembly listing and exclude from symbol list
                  ifndef REPEAT_MACRO ; Load macro only once


; Set defaults in case repeat macro is never called to pass assembler
; checks. Otherwise assembler will stop with error "Conditions must
; be constant on pass 1"
repeat_count      set 0
repeat1_count     set 0
repeat2_count     set 0
repeat4_count     set 0
repeat8_count     set 0
repeat16_count    set 0
repeat32_count    set 0


;------------------------------------------------------------------------------
; Repeat a macro X number of times
;
; examples:
;   1) repeat 4,lsra                  ; repeat instruction "lsra" four times
;
;   2) copy_one_line macro            ; an example of a macro to repeat
;                    lda ,u
;                    sta ,x
;                    abx
;                    endm
;      repeat 100,copy_one_line       ; repeat macro 100 times
;
;   3) repeat 4,lsra,rorb             ; repeat combination up to 8
;
;------------------------------------------------------------------------------
repeat            macro
                  *pragmapush list    ; Save state of list pragma
                  pragma nolist       ; Turn off assembly listing and exclude from symbol list

repeat_count      set \1
                  ifne repeat_count   ; test for zero repeat case

repeat32_count      set repeat_count/32
repeat_count        set repeat_count-(repeat32_count*32)
repeat16_count      set repeat_count/16
repeat_count        set repeat_count-(repeat16_count*16)
repeat8_count       set repeat_count/8
repeat_count        set repeat_count-(repeat8_count*8)
repeat4_count       set repeat_count/4
repeat_count        set repeat_count-(repeat4_count*4)
repeat2_count       set repeat_count/2
repeat1_count       set repeat_count-(repeat2_count*2)

                    ifne repeat32_count
                      repeat32plus repeat32_count,\2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne repeat16_count
                      repeat16 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne repeat8_count
                      repeat8 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne repeat4_count
                      repeat4 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne repeat2_count
                      repeat2 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne repeat1_count
                      repeat1 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                  endc
                  *pragmapop list     ; restore assembly listing to previous state
                  endm


repeat1           macro noexpand
                  \1
                  \2
                  \3
                  \4
                  \5
                  \6
                  \7
                  \8
                  endm

repeat2           macro noexpand
                  repeat1 \1,\2,\3,\4,\5,\6,\7,\8
                  repeat1 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

repeat4           macro noexpand
                  repeat2 \1,\2,\3,\4,\5,\6,\7,\8
                  repeat2 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

repeat8           macro noexpand
                  repeat4 \1,\2,\3,\4,\5,\6,\7,\8
                  repeat4 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

repeat16          macro noexpand
                  repeat8 \1,\2,\3,\4,\5,\6,\7,\8
                  repeat8 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

repeat32          macro noexpand
                  repeat16 \1,\2,\3,\4,\5,\6,\7,\8
                  repeat16 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

repeat32plus      macro noexpand
                  repeat32 \2,\3,\4,\5,\6,\7,\8,\9
repeat32_count    set \1-1
                  ifgt repeat32_count
                    repeat32plus repeat32_count,\2,\3,\4,\5,\6,\7,\8,\9
                  endc
                  endm


REPEAT_MACRO      equ 1               ; Set flag for macro being loaded
                  endc
                  *pragmapop list     ; restore assembly listing to previous state
