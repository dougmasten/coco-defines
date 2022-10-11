; convenience.asm
                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef MACROS_CONVENIENCE_DEFS  ; Load macros only once


; increment 16-bit registers
incx                macro
                    leax 1,x
                    endm

incy                macro
                    leay 1,y
                    endm

incu                macro
                    leau 1,u
                    endm

incs                macro
                    leas 1,s
                    endm


; decrement 16-bit registers
decx                macro
                    leax -1,x
                    endm

decy                macro
                    leay -1,y
                    endm

decu                macro
                    leau -1,u
                    endm

decs                macro
                    leas -1,s
                    endm


; test instructions
tstu                macro
                    ifpragma 6809
                      cmpu #0
                    else
                      cmpr u,0
                    endc
                    endm

tstx                macro
                    ifpragma 6809
                      leax ,x
                    else
                      cmpx #0
                    endc
                    endm

tsty                macro
                    leay ,y
                    endm

                    ifpragma no6309conv
tstq                macro
                    stq -4,s
                    endm
                    endc


; shift left/right 4 times
asl4a               macro
                    asla
                    asla
                    asla
                    asla
                    endm

asl4b               macro
                    aslb
                    aslb
                    aslb
                    aslb
                    endm

asr4a               macro
                    asra
                    asra
                    asra
                    asra
                    endm

asr4b               macro
                    asrb
                    asrb
                    asrb
                    asrb
                    endm

lsr4a               macro
                    lsra
                    lsra
                    lsra
                    lsra
                    endm

lsr4b               macro
                    lsrb
                    lsrb
                    lsrb
                    lsrb
                    endm

lsl4a               macro
                    lsla
                    lsla
                    lsla
                    lsla
                    endm

lsl4b               macro
                    lslb
                    lslb
                    lslb
                    lslb
                    endm


; clear instructions
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


MACROS_CONVENIENCE_DEFS equ 1               ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
