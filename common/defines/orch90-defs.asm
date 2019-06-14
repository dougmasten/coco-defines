; Orchestra-90 Cartridge

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef ORCH90_DEFS  ; Load defines only once


ORCH90                  equ $ff7a           ; Orchestra-90 Cartridge
ORCH90_LEFT             equ ORCH90          ; Orchestra-90 (Left channel)
ORCH90_RIGHT            equ ORCH90+1        ; Orchestra-90 (Right channel)


ORCH90_DEFS             equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
