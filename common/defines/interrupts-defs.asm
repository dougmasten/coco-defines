; interrupts-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef INTERRUPTS_DEFS   ; Load defines only once


; CoCo 3 Interrupts jump vectors
JUMP_INT_FLAG           equ $feed           ; Interrupt jump table valid flag: 0=not valid, $55=valid
SWI3_JUMP               equ $feee           ; CoCo3 SWI3 jump vector
SWI2_JUMP               equ $fef1           ; CoCo3 SWI2 jump vector
FIRQ_JUMP               equ $fef4           ; CoCo3 FIRQ jump vector
IRQ_JUMP                equ $fef7           ; CoCo3 IRQ jump vector
SWI_JUMP                equ $fefa           ; CoCo3 SWI jump vector
NMI_JUMP                equ $fefd           ; CoCo3 NMI jump vector


; Interrupt Vectors
TRAP_VECTOR             equ $fff0           ; Illegal Opcode and Division by Zero Trap (Hitachi 6309 Only)
SWI3_VECTOR             equ $fff2           ; SWI3  -> $FEEE -> $0100
SWI2_VECTOR             equ $fff4           ; SWI2  -> $FEF1 -> $0103
FIRQ_VECTOR             equ $fff6           ; FIRQ  -> $FEF4 -> $010F
IRQ_VECTOR              equ $fff8           ; IRQ   -> $FEF7 -> $010C
SWI_VECTOR              equ $fffa           ; SWI   -> $FEFA -> $0106
NMI_VECTOR              equ $fffc           ; NMI   -> $FEFD -> $0109
RESET_VECTOR            equ $fffe           ; RESET -> $8C1B


INTERRUPTS_DEFS         equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
