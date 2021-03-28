; wait-cycles-macros.asm

                        *pragmapush list        ; Save state of list pragma
                        pragma nolist           ; Turn off assembly listing and exclude from symbol list
                        ifndef WAIT_CYCLES_MACROS  ; Load defines only once


; wait 1 clock cycle
wait1                   macro
                        ifpragma 6809
                          error one clock cycle NOP is not supported on MC6809
                        else
                          nop
                        endc
                        endm


; wait 2 clock cycles
wait2                   macro
                        ifpragma 6809
                          nop
                        else
                          nop
                          nop
                        endc
                        endm


; wait 3 clock cycles
wait3                   macro
                        bra *+2
                        endm


; wait 4 clock cycles
wait4                   macro
                        leas ,s
                        endm


; wait 5 clock cycles
wait5                   macro
                        ifpragma 6809
                          nop
                          bra *+2
                        else
                          exg 0,0
                        endc
                        endm


; wait 6 clock cycles
wait6                  macro
                       ifpragma 6809
                         tfr s,s
                       else
                         leas ,s++
                       endc
                       endm


; wait 7 clock cycles
wait7                  macro
                       ifpragma 6309
                         nop
                       endc
                       leas ,s++
                       endm


; wait 8 clock cycles
wait8                   macro
                        ifpragma 6809
                          exg s,s
                        else
                          tfr 0,0
                          tfr 0,0
                        endc
                        endm


; wait 9 clock cycles
wait9                   macro
                        ifpragma 6809
                          leas ,s++
                          nop
                        else
                          tfr 0,0
                          exg 0,0
                        endc
                        endm


; wait 10 clock cycles
wait10                  macro
                        ifpragma 6809
                          leas ,s+
                          leas ,s
                        else
                          pshs cc
                          puls cc
                        endc
                        endm


; wait 11 clock cycles
wait11                  macro
                        ifpragma 6809
                          pshs a
                          leas 1,s
                        else
                          exg 0,0
                          leas ,s++
                        endc
                        endm


; wait 12 clock cycles
wait12                  macro
                        ifpragma 6809
                          bsr *+2
                          leas 2,s
                        else
                          pshsw
                          pulsw
                        endc
                        endm


; wait 13 clock cycles
wait13                  macro
                        ifpragma 6809
                          pshs a,x
                          leas 3,s
                        else
                          pshs x,y
                          leas 4,s
                        endc
                        endm


; wait 14 clock cycles
wait14                  macro
                        ifpragma 6809
                          leas ,s++
                          leas ,s++
                        else
                          pshs a,x
                          puls a,x
                        endc
                        endm


; wait 15 clock cycles
wait15                  macro
                        ifpragma 6809
                          pshs a,x,y
                          leas 5,s
                        else
                          pshs x,y,u
                          leas 6,s
                        endc
                        endm


; wait 16 clock cycles
wait16                  macro
                        ifpragma 6809
                          exg s,s
                          exg s,s
                        else
                          pshs a,b,x
                          puls a,b,x
                        endc
                        endm


; wait 17 clock cycles
wait17                  macro
                        ifpragma 6809
                          pshs a,x,y,u
                          leas 7,s
                        else
                          pshs a,b,x,y,u
                          leas 8,s
                        endc
                        endm


; wait 18 clock cycles
wait18                  macro
                        ifpragma 6809
                          pshs a,b,x
                          puls a,b,x
                        else
                          pshs a,x,y
                          puls a,x,y
                        endc
                        endm


; wait 19 clock cycles
wait19                  macro
                        ifpragma 6809
                          pshs cc,a,b,x,y,u
                          leas 9,s
                        else
                          pshs cc,a,b,dp,x,y,u
                          leas 10,s
                        endc
                        endm


; wait 20 clock cycles
wait20                  macro
                        ifpragma 6809
                          pshs a,x,y
                          puls a,x,y
                        else
                          pshs d,x,y
                          puls d,x,y
                        endc
                        endm


; wait 21 clock cycles
wait21                  macro
                        ifpragma 6809
                          pshs cc,b,dp,x,y,u,pc
                          leas 11,s
                        else
                          pshs cc,a,b,dp,x,y,u,pc
                          leas 12,s
                        endc
                        endm


; wait 22 clock cycles
wait22                  macro
                        ifpragma 6809
                          pshs cc,a,b,dp,x,y,u,pc
                          leas 12,s
                        else
                          pshs a,x,y,u
                          puls a,x,y,u
                        endc
                        endm


; wait 23 clock cycles
wait23                  macro
                        ifpragma 6809
                          pshs cc,a,dp,x,y,u,pc
                          nop
                          leas 11,s
                        else
                          pshs a,x,y,u
                          nop
                          puls a,x,y,u
                        endc
                        endm


; wait 24 clock cycles
wait24                  macro
                        ifpragma 6809
                          pshs a,x,y,u
                          puls a,x,y,u
                        else
                          pshs a,b,x,y,u
                          puls a,b,x,y,u
                        endc
                        endm


; wait 25 clock cycles
wait25                  macro
                        ifpragma 6809
                          pshs a,b
                          mul
                          puls a,b
                        else
                          pshs a,b,x,y,u
                          nop
                          puls a,b,x,y,u
                        endc
                        endm


; wait 26 clock cycles
wait26                  macro
                        ifpragma 6809
                          pshs cc,a,b,dp,x,y
                          puls cc,a,b,dp,x,y
                        else
                          pshs a,b,dp,x,y,u
                          puls a,b,dp,x,y,u
                        endc
                        endm


; wait 27 clock cycles
wait27                  macro
                        ifpragma 6809
                          pshs cc,a,b
                          mul
                          puls cc,a,b
                        else
                          pshs a,b,dp,x,y,u
                          puls a,b,dp,x,y,u
                          nop
                        endc
                        endm


; wait 28 clock cycles
wait28                  macro
                        ifpragma 6809
                          pshs a,b,dp,x,y,u
                          puls a,b,dp,x,y,u
                        else
                          pshs cc,a,b,dp,x,y,u
                          puls cc,a,b,dp,x,y,u
                        endc
                        endm


WAIT_CYCLES_MACROS      equ 1                   ; Set flag for defines being loaded
                        endc
                        *pragmapop list         ; restore assembly listing to previous state
