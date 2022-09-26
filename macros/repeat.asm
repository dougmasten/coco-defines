; repeat.asm

                  *pragmapush list    ; Save state of list pragma
                  pragma nolist       ; Turn off assembly listing and exclude from symbol list
                  ifndef REPEAT_MACRO ; Load macro only once


; Set defaults in case repeat macro is never called to pass assembler
; checks. Otherwise assembler will stop with error "Conditions must
; be constant on pass 1".
rpt_count      set 0
rpt1_count     set 0
rpt2_count     set 0
rpt4_count     set 0
rpt8_count     set 0
rpt16_count    set 0
rpt32_count    set 0


;------------------------------------------------------------------------------
; Repeat a macro X number of times
;
; examples:
;   1) rpt 4,lsra                     ; repeat instruction "lsra" four times
;
;   2) copy_one_line macro            ; an example of a macro to repeat
;                    lda ,u
;                    sta ,x
;                    abx
;                    endm
;      rpt 100,copy_one_line          ; repeat macro 100 times
;
;   3) rpt 4,lsra,rorb             ; repeat combination up to 8
;
;------------------------------------------------------------------------------
rpt               macro
                  *pragmapush list    ; Save state of list pragma
                  pragma nolist       ; Turn off assembly listing and exclude from symbol list

rpt_count         set \1
                  ifne rpt_count   ; test for zero repeat case

rpt32_count         set rpt_count/32
rpt_count           set rpt_count-(rpt32_count*32)
rpt16_count         set rpt_count/16
rpt_count           set rpt_count-(rpt16_count*16)
rpt8_count          set rpt_count/8
rpt_count           set rpt_count-(rpt8_count*8)
rpt4_count          set rpt_count/4
rpt_count           set rpt_count-(rpt4_count*4)
rpt2_count          set rpt_count/2
rpt1_count          set rpt_count-(rpt2_count*2)

                    ifne rpt32_count
                      rpt32plus rpt32_count,\2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne rpt16_count
                      rpt16 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne rpt8_count
                      rpt8 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne rpt4_count
                      rpt4 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne rpt2_count
                      rpt2 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                    ifne rpt1_count
                      rpt1 \2,\3,\4,\5,\6,\7,\8,\9
                    endc

                  endc
                  *pragmapop list     ; restore assembly listing to previous state
                  endm


rpt1              macro noexpand
                  \1
                  \2
                  \3
                  \4
                  \5
                  \6
                  \7
                  \8
                  endm

rpt2              macro noexpand
                  rpt1 \1,\2,\3,\4,\5,\6,\7,\8
                  rpt1 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

rpt4              macro noexpand
                  rpt2 \1,\2,\3,\4,\5,\6,\7,\8
                  rpt2 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

rpt8              macro noexpand
                  rpt4 \1,\2,\3,\4,\5,\6,\7,\8
                  rpt4 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

rpt16             macro noexpand
                  rpt8 \1,\2,\3,\4,\5,\6,\7,\8
                  rpt8 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

rpt32             macro noexpand
                  rpt16 \1,\2,\3,\4,\5,\6,\7,\8
                  rpt16 \1,\2,\3,\4,\5,\6,\7,\8
                  endm

rpt32plus          macro noexpand
                  rpt32 \2,\3,\4,\5,\6,\7,\8,\9
rpt32_count       set \1-1
                  ifgt rpt32_count
                    rpt32plus rpt32_count,\2,\3,\4,\5,\6,\7,\8,\9
                  endc
                  endm


REPEAT_MACRO      equ 1               ; Set flag for macro being loaded
                  endc
                  *pragmapop list     ; restore assembly listing to previous state
