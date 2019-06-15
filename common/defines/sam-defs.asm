; sam-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef SAM_DEFS     ; Load defines only once


; SAM Video Display (Motorola 6883) for CoCo 1 and 2 text and graphics modes

; +------------------------+-----------------------+----------+---------------+
; | Mode                   | VDG Settings          | SAM      | Description   |
; |                        | A/G | GM2 | GM1 | GM0 | V2 V1 V0 |               |
; |------------------------+-----------+-----+-----+----------+---------------|
; | Internal alphanumeric  |  0  |  X  |  X  |  0  | 0  0  0  | 32 x 16       |
; | External alphanumeric  |  0  |  X  |  X  |  1  | 0  0  0  | 32 x 16       |
; | Semigraphic-4          |  0  |  X  |  X  |  0  | 0  0  0  | 32 x 16       |
; | Semigraphic-6          |  0  |  X  |  X  |  1  | 0  0  0  | 64 x 48       |
; | Full graphice 1-C      |  1  |  0  |  0  |  0  | 0  0  1  | 64 x 64 x 4   |
; | Full graphice 1-R      |  1  |  0  |  0  |  1  | 0  0  1  | 128 x 64 x 2  |
; | Full graphice 2-C      |  1  |  1  |  1  |  0  | 0  1  0  | 128 x 64 x 4  |
; | Full graphice 2-R      |  1  |  1  |  1  |  1  | 0  1  1  | 128 x 96 x 2  |
; | Full graphice 3-C      |  1  |  0  |  0  |  0  | 1  0  0  | 128 x 96 x 4  |
; | Full graphice 3-R      |  1  |  0  |  0  |  1  | 1  0  1  | 128 x 192 x 2 |
; | Full graphice 6-C      |  1  |  1  |  1  |  0  | 1  1  0  | 128 x 192 x 4 |
; | Full graphice 6-R      |  1  |  1  |  1  |  1  | 1  1  0  | 256 x 192 x 2 |
; | Direct memory access   |  X  |  X  |  X  |  X  | 1  1  1  |               |
; +------------------------+-----+-----+-----+-----+----------+---------------+


; SAM Video Display Mode
SAM_V_BASE              equ $ffc0
SAM_V0_CLEAR            equ SAM_V_BASE
SAM_V0_SET              equ SAM_V_BASE+1
SAM_V1_CLEAR            equ SAM_V_BASE+2
SAM_V1_SET              equ SAM_V_BASE+3
SAM_V2_CLEAR            equ SAM_V_BASE+4
SAM_V2_SET              equ SAM_V_BASE+5


; SAM Page Select Registers
SAM_F_BASE              equ $ffc6
SAM_F0_CLEAR            equ SAM_F_BASE
SAM_F0_SET              equ SAM_F_BASE+1
SAM_F1_CLEAR            equ SAM_F_BASE+2
SAM_F1_SET              equ SAM_F_BASE+3
SAM_F2_CLEAR            equ SAM_F_BASE+4
SAM_F2_SET              equ SAM_F_BASE+5
SAM_F3_CLEAR            equ SAM_F_BASE+6
SAM_F3_SET              equ SAM_F_BASE+7
SAM_F4_CLEAR            equ SAM_F_BASE+8
SAM_F4_SET              equ SAM_F_BASE+9
SAM_F5_CLEAR            equ SAM_F_BASE+10
SAM_F5_SET              equ SAM_F_BASE+11
SAM_F6_CLEAR            equ SAM_F_BASE+12
SAM_F6_SET              equ SAM_F_BASE+13


SAM_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state

