; stack-defs.asm

; Registers position on stack for SWI, SWI2, SWI3 instructions
; and H6309's Division-By-Zero and invalid instruction exception.

; STACK_NM = 0 M6809 (Default)
;          = 1 H6309 w/ NM bit set

                    ifndef STACK_NM
STACK_NM            equ 0  ; default to M6809 stack
                    endc


                    ifeq STACK_NM-1

; Registers position on stack for H6309 with NM bit set
Stack               struct
CC                  rmb 1
A                   rmb 1
B                   rmb 1
E                   rmb 1
F                   rmb 1
DP                  rmb 1
X                   rmb 2
Y                   rmb 2
U                   rmb 2
PC                  rmb 2
                    endstruct

Stack.W             equ Stack.E

                    else

; Registers position on stack for M6809
Stack               struct
CC                  rmb 1
A                   rmb 1
B                   rmb 1
DP                  rmb 1
X                   rmb 2
Y                   rmb 2
U                   rmb 2
PC                  rmb 2
                    endstruct

                    endc

Stack.D             equ Stack.A
