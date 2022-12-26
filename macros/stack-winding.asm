; stack-winding.asm
; Book "Game Programming Gems 2", Section 1.13 Stack Winding by Byron Hapgood


; stack winding macro
; ex:
;    createwindow
;       ; open window
;       temp_rts
;       ; close it
;       rts
;
;    changedisplaymode
;       ; set 640x480
;       temp_rts
;       ; restore
;       rts
;
;    setupdisplay
;       jsr createwindow
;       jsr changedisplaymode
;       jmp someuserfunction

temp_rts    macro
            jsr [,s++]
            endm

