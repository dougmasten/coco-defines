; becker-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef BECKER_DEFS  ; Load defines only once


; Becker port is a simple interface used in CoCo emulators and Gary Becker's
; CoCo3FPGA project to allow high speed I/O between the CoCo and the DriveWire
; server.
;
; When reading you must make sure you only read when data is present by the status bit.
; As far as writing you just write the data to the port.


BECKER_STATUS           equ $ff41           ; Bit 1 - Data ready to read
BECKER_DATA             equ $ff42           ; Read/Write port


BECKER_DEFS             equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
