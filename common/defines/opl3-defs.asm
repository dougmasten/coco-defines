; opl3-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef OPL3_DEFS    ; Load defines only once


; YMF262 (OPL3) Sound Chip
; Used in Mega-Mini and CoCoSDC Extender
OPL3_BASE               equ $ff50
OPL3_PORT0_REG          equ OPL3_BASE       ; Write only - Port #0 Register number
OPL3_STATUS             equ OPL3_BASE       ; Read only  - Timer interrupt status
OPL3_PORT0_DATA         equ OPL3_BASE+1     ; Write only - Port #0 Register value
OPL3_PORT1_REG          equ OPL3_BASE+2     ; Write only - Port #1 Register number
OPL3_PORT1_DATA         equ OPL3_BASE+3     ; Write only - Port #1 Register value
OPL3_RESET              equ OPL3_BASE+4     ; Read or write performs a reset of chip registers (initial clear)


OPL3_DEFS               equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
