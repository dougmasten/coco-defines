; boomerang-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef BOOMERANG_DEFS  ; Load defines only once


; Boomerang 2MB Memory board by BoysonTech
; https://boysontech.com/marketplace/
BOOMERANG_LED           equ $ffef           ; Programmable Tricolor LED on Guardian+ CPU/DAT board
                                            ; Bit 7:6 - 00 = Set Red, Green and Blue intensity
                                            ;           01 = Set Red intensity
                                            ;           10 = Set Green intensity
                                            ;           11 = Set Blue intensity
                                            ; Bit 5   - n/a
                                            ; Bit 4:0 - Intensity (0-31)


; The LED can also operate in "speed" mode, where the red LED will signify
; the CoCo running in "slow" mode and the green LED denotes "fast" mode. To
; activate, see "special mode" below.

; To activate "special mode", read BOOMERANG_MAGIC_1 thur BOOMERANG_MAGIC_6, followed by
; either BOOMERANG_512K, BOOMERANG_512K_TURBO, BOOMERANG_2M or BOOMERANG_2M_TUBRO.


; Boomerang magic addresses to place device in "special mode"
BOOMERANG_MAGIC_1       equ $fdfd           ; reset lock                       (READ ONLY)
BOOMERANG_MAGIC_2       equ $fd55           ; combination pattern              (READ ONLY)
BOOMERANG_MAGIC_3       equ $fdaa           ;    "          "                  (READ ONLY)
BOOMERANG_MAGIC_4       equ $fdff           ;    "          "                  (READ ONLY)
BOOMERANG_MAGIC_5       equ $fd00           ; combination unlocked             (READ ONLY)
BOOMERANG_MAGIC_6       equ $fdff           ; commmand = set flags             (READ ONLY)


; Boomerang "special modes" options
BOOMERANG_512K          equ $fd01           ; Enable 512K mode                 (READ ONLY)
BOOMERANG_512K_TURBO    equ $fd81           ; Enable 512K and turbo LED mode   (READ ONLY)
BOOMERANG_2M            equ $fd00           ; Enable 2M mode                   (READ ONLY)
BOOMERANG_2M_TURBO      equ $fd80           ; Enable 2M and turbo LED mode     (READ ONLY)


BOOMERANG_DEFS          equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
