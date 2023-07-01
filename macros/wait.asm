; wait.asm

  *pragmapush list    ; Save state of list pragma
  pragma nolist       ; Turn off assembly listing and exclude from symbol list
  ifndef WAIT_MACROS  ; Load defines only once


wait macro
  *pragmapush list
  pragma nolist

; wait 1 clock cycle
  ifeq \1-1
  ifpragma 6809
    error one clock cycle NOP is not supported on MC68809
  else
    nop
  endc
  endc

; wait 2 clock cycles
  ifeq \1-2
  ifpragma 6809
    nop
  else
    nop
    nop
  endc
  endc

; wait 3 clock cycles
  ifeq \1-3
    bra *+2
  endc

; wait 4 clock cycles
  ifeq \1-4
    leas ,s
  endc

; wait 5 clock cycles
  ifeq \1-5
  ifpragma 6809
    fdb $3400  ; PSHS #0
  else
    exg s,s
  endc
  endc

; wait 6 clock cycles
  ifeq \1-6
  ifpragma 6809
    tfr s,s
  else
    leas ,s++
  endc
  endc

; wait 7 clock cycles
  ifeq \1-7
  ifpragma 6309
    nop
  endc
  leas ,s++
  endc

; wait 8 clock cycles
  ifeq \1-8
  ifpragma 6809
    exg s,s
  else
    tfr s,s
    tfr s,s
  endc
  endc

; wait 9 clock cycles
  ifeq \1-9
  ifpragma 6809
    leas ,s++
    nop
  else
   tfr s,s
   exg s,s
  endc
  endc

; wait 10 clock cycles
  ifeq \1-10
  ifpragma 6809
    leas ,s+
    leas ,s
  else
    exg s,s
    exg s,s
  endc
  endc

; wait 11 clock cycles
  ifeq \1-11
  ifpragma 6809
    pshs a
    leas 1,s
  else
    exg s,s
    leas ,s++
  endc
  endc

; wait 12 clock cycles
  ifeq \1-12
  ifpragma 6809
    bsr *+2
    leas 2,s
  else
    leas ,s++
    leas ,s++
  endc
  endc

; wait 13 clock cycles
  ifeq \1-13
  ifpragma 6809
    pshs a,x
    leas 3,s
  else
    pshs x,y
    leas 4,s
  endc
  endc

; wait 14 clock cycles
  ifeq \1-14
  ifpragma 6809
    leas ,s++
    leas ,s++
  else
    pshs a,x
    puls a,x
  endc
  endc

; wait 15 clock cycles
  ifeq \1-15
  ifpragma 6809
    pshs a,x,y
    leas 5,s
  else
    pshs x,y,u
    leas 6,s
  endc
  endc

; wait 16 clock cycles
  ifeq \1-16
  ifpragma 6809
    exg s,s
    exg s,s
  else
    pshs d,x
    puls d,x
  endc
  endc

; wait 17 clock cycles
  ifeq \1-17
  ifpragma 6809
    pshs a,x,y,u
    leas 7,s
  else
    pshs d,x,y,u
    leas 8,s
  endc
  endc

; wait 18 clock cycles
  ifeq \1-18
  ifpragma 6809
    pshs d,x
    puls d,x
  else
    pshs a,x,y
    puls a,x,y
  endc
  endc

; wait 19 clock cycles
  ifeq \1-19
  ifpragma 6809
    pshs cc,d,x,y,u
    leas 9,s
  else
    pshs cc,d,dp,x,y,u
    leas 10,s
  endc
  endc

; wait 20 clock cycles
  ifeq \1-20
  ifpragma 6809
    pshs a,x,y
    puls a,x,y
  else
    pshs d,x,y
    puls d,x,y
  endc
  endc

; wait 21 clock cycles
  ifeq \1-21
  ifpragma 6809
    pshs d,dp,x,y,u,pc
    leas 11,s
  else
    pshs cc,d,dp,x,y,u,pc
    leas 12,s
  endc
  endc

; wait 22 clock cycles
  ifeq \1-22
  ifpragma 6809
    pshs cc,d,dp,x,y,u,pc
    leas 12,s
  else
    pshs a,x,y,u
    puls a,x,y,u
  endc
  endc

; wait 23 clock cycles
  ifeq \1-23
  ifpragma 6809
    pshs d,dp,x,y,u,pc
    nop
    leas 11,s
  else
    pshs a,x,y,u
    nop
    puls a,x,y,u
  endc
  endc

; wait 24 clock cycles
  ifeq \1-24
  ifpragma 6809
    pshs a,x,y,u
    puls a,x,y,u
  else
    pshs d,x,y,u
    puls d,x,y,u
  endc
  endc

; wait 25 clock cycles
  ifeq \1-25
  ifpragma 6809
    pshs d
    mul
    puls d
  else
    pshs d,x,y,u
    nop
    puls d,x,y,u
  endc
  endc

; wait 26 clock cycles
  ifeq \1-26
  ifpragma 6809
    pshs cc,d,dp,x,y
    puls cc,d,dp,x,y
  else
    pshs d,dp,x,y,u
    puls d,dp,x,y,u
  endc
  endc

; wait 27 clock cycles
  ifeq \1-27
  ifpragma 6809
    pshs cc,d
    mul
    puls cc,d
  else
    pshs d,dp,x,y,u
    nop
    puls d,dp,x,y,u
  endc
  endc

; wait 28 clock cycles
  ifeq \1-28
  ifpragma 6809
    pshs d,dp,x,y,u
    puls d,dp,x,y,u
  else
    pshs cc,d,dp,x,y,u
    puls cc,d,dp,x,y,u
  endc
  endc

  ifge \1-29
    error wait time is not supported
  endc

  *pragmapop list
  endm

WAIT_MACROS equ 1  ; Set flag for defines being loaded
  endc
  *pragmapop list  ; restore assembly listing to previous state
