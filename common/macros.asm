; macros.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list


; space savings macros
skip_one_byte       MACRO
                    fcb $c5                 ; actually a BITB #$xx instruction (2 clocks)
                    ENDM

skip_two_bytes      MACRO
                    fcb $8c                 ; actually a CMPX #$xxxx instruction (3 clocks)
                    ENDM


; convenient macros
disable_interrupts  MACRO
                    orcc #$50
                    ENDM

enable_interrupts   MACRO
                    andcc #$af
                    ENDM

clru                MACRO
                    ldu #0
                    ENDM

clrx                MACRO
                    ldx #0
                    ENDM

clry                MACRO
                    ifpragma 6809
                      ldy #0
                    else
                      tfr 0,y
                    endc
                    ENDM

                    ifpragma no6309conv
clrq                MACRO
                    clrd
                    clrw
                    ENDM
                    endc

tstu                MACRO
                    ifpragma 6809
                      cmpu #0
                    else
                      cmpr u,0
                    endc
                    ENDM

tstx                MACRO
                    cmpx #0
                    ENDM

tsty                MACRO
                    ifpragma 6809
                      cmpy #0
                    else
                      cmpr y,0
                    endc
                    ENDM

                    ifpragma no6309conv
tstq                MACRO
                    stq -4,s
                    ENDM
                    endc


                    *pragmapop list         ; restore assembly listing to previous state
