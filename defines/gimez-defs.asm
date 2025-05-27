; gimez-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef GIMEZ_DEFS   ; Load defines only once

; GIME-Z
; A GIME chip replacement plus some enhancements like 2MB RAM support and a turbo clock mode.
; Developed by Alan Lovell, aka "AC's 8-Bit Zone"


; Acceleration mode
GIMEZ_SPEED_MAGIC       equ $5a             ; Magic value to select 2.864 MHz speed
                                            ;
                                            ; Acceleration mode requires a fast SRAM memory upgrade.
                                            ;
                                            ; 1) First system must be in 1.79 MHz mode (STA $FFD9).
                                            ; 2) And then write $5A to $FFD9. (LDA #$5A; STA $FFD9).
                                            ;
                                            ; Ex:
                                            ;    LDA #GIMEX_SPEED_MAGIC
                                            ;    STA HIGH_SPEED_MODE  ; select 1.78 MHz mode
                                            ;    STA HIGH_SPEED_MODE  ; select 2.86 MHz mode


GIMEZ_DEFS              equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
