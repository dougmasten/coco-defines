; sam-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef SAM_DEFS     ; Load defines only once


SAM_V0_CLEAR            equ $ffc0           ; SAM registers V0 through V2 sets the video display mode
SAM_V0_SET              equ $ffc1           ;
SAM_V1_CLEAR            equ $ffc2           ;
SAM_V1_SET              equ $ffc3           ;
SAM_V2_CLEAR            equ $ffc4           ;
SAM_V2_SET              equ $ffc5           ;

SAM_F0_CLEAR            equ $ffc6           ; SAM registers F0 through F6 sets the video display starting address
SAM_F0_SET              equ $ffc7           ;
SAM_F1_CLEAR            equ $ffc8           ;
SAM_F1_SET              equ $ffc9           ;
SAM_F2_CLEAR            equ $ffca           ;
SAM_F2_SET              equ $ffcb           ;
SAM_F3_CLEAR            equ $ffcc           ;
SAM_F3_SET              equ $ffcd           ;
SAM_F4_CLEAR            equ $ffce           ;
SAM_F4_SET              equ $ffcf           ;
SAM_F5_CLEAR            equ $ffd0           ;
SAM_F5_SET              equ $ffd1           ;
SAM_F6_CLEAR            equ $ffd2           ;
SAM_F6_SET              equ $ffd3           ;

SAM_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state

