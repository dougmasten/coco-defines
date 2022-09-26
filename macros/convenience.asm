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

MACROS_CONVENIENCE_DEFS equ 1               ; Set flag for macros being loaded
                    endc

                    *pragmapop list         ; restore assembly listing to previous state
