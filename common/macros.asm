; macros.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list


; space savings macros
skip_one_byte       macro
                    fcb $c5                 ; actually a BITB #$xx instruction (2 clocks)
                    endm

skip_two_bytes      macro
                    fcb $8c                 ; actually a CMPX #$xxxx instruction (3 clocks)
                    endm


; convenient macros
disable_interrupts  macro
                    orcc #$50
                    endm

enable_interrupts   macro
                    andcc #$af
                    endm

clru                macro
                    ldu #0
                    endm

clrx                macro
                    ldx #0
                    endm

clry                macro
                    ifpragma 6809
                      ldy #0
                    else
                      tfr 0,y
                    endc
                    endm

                    ifpragma no6309conv
clrq                macro
                    clrd
                    clrw
                    endm
                    endc

tstu                macro
                    ifpragma 6809
                      cmpu #0
                    else
                      cmpr u,0
                    endc
                    endm

tstx                macro
                    cmpx #0
                    endm

tsty                macro
                    ifpragma 6809
                      cmpy #0
                    else
                      cmpr y,0
                    endc
                    endm

                    ifpragma no6309conv
tstq                macro
                    stq -4,s
                    endm
                    endc


                    *pragmapop list         ; restore assembly listing to previous state
