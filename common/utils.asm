; utils.asm


;------------------------------------------------------------------------------
; Function    : word2asciihex
; Entry       : Reg D = word to convert
; Exit        : Reg Q = converted hexdecimal string
; Destroys    : none
; Calls       : none
; Description : Convert word to ASCII hexdecimal
;------------------------------------------------------------------------------
word2asciihex       tfr a,e
                    tfr b,a
                    bsr byte2asciihex
                    exg d,w
                    ;bra byte2asciihex


;------------------------------------------------------------------------------
; Function    : byte2asciihex
; Entry       : Reg A = byte to convert
; Exit        : Reg D = converted hexdecimal
; Destroys    : none
; Calls       : none
; Description : Convert byte to ASCII hexdecimal
;------------------------------------------------------------------------------
byte2asciihex       pshs x
                    ldx #hex_digits
                    tfr a,b
                    lsra
                    lsra
                    lsra
                    lsra
                    lda a,x
                    andb #$0f
                    ldb b,x
                    puls x,pc

hex_digits          fcc '0123456789ABCDEF'


;------------------------------------------------------------------------------
; Function    : to_lower
; Entry       : Reg A = character to convert
; Exit        : Reg A = converted character
; Destroys    : none
; Calls       : none
; Description :
;------------------------------------------------------------------------------
to_lower            cmpa #$40
                    bls return@
                    cmpa #$5b
                    bhs return@
                    ora #$20
return@             rts


;------------------------------------------------------------------------------
; Function    : to_upper
; Entry       : Reg A = character to convert
; Exit        : Reg A = converted character
; Destroys    : none
; Calls       : none
; Description :
;------------------------------------------------------------------------------
to_upper            cmpa #$60
                    bls return@
                    cmpa #$7b
                    bhs return@
                    anda #$df
return@             rts
