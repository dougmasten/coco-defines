; shift.asm

                    *pragmapush list        ; Save state of list pragma
                    pragma nolist           ; Turn off assembly listing and exclude from symbol list
                    ifndef SHIFT_MACROS     ; Load macros only once

                    include repeat.asm

asl4a               macro
                    repeat 4,asla
                    endm

asl4b               macro
                    repeat 4,aslb
                    endm

asr4a               macro
                    repeat 4,asra
                    endm

asr4b               macro
                    repeat 4,asrb
                    endm

lsr4a               macro
                    repeat 4,lsra
                    endm

lsr4b               macro
                    repeat 4,lsrb
                    endm

lsl4a               macro
                    repeat 4,lsla
                    endm

lsl4b               macro
                    repeat 4,lslb
                    endm


SHIFT_MACROS        equ 1                   ; Set flag for macros being loaded
                    endc
                    *pragmapop list         ; restore assembly listing to previous state
