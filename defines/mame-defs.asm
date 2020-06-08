; mame-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef MAME_DEFS    ; Load defines only once


; Erik Milliluk's development fork of MAME with developers enhancements
; https://github.com/milliluk/mame
MAME_DEBUG_CTRL         equ $ff04           ; MAME Debug Control (Milliluk's branch only)
                                            ; Bit 7:2 - n/a
                                            ; Bit 1 - Set to '1' snapshots Video Frame count to $FF09
                                            ; Bit 0 - Set to '1' snapshots System Cycle count to $FF05
MAME_CYCLE_COUNT        equ $ff05           ; MAME System cycle counter (32-bit) snapshot
MAME_FRAME_COUNT        equ $ff09           ; MAME Video frame counter (32-bit) snapshot


MAME_DEFS               equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
