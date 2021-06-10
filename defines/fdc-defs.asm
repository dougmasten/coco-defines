; fdc-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef FDC_DEFS     ; Load defines only once


; Floppy Disk Controller (Western Digital 1793)
FDC_CTRL                equ $ff40            ; Floppy disk controller control register (Write Only)
                                             ; Bit 7 - Halt flag: 0=disabled, 1=enabled
                                             ; Bit 6 - Drive select 3
                                             ; Bit 5 - Density flag: 0=single, 1=double
                                             ; Bit 4 - Write precompensation: 0=no precomp, 1=precomp
                                             ; Bit 3 - Drive motor enable: 0=motors off, 1=motors on
                                             ; Bit 2 - Drive select 2
                                             ; Bit 1 - Drive select 1
                                             ; Bit 0 - Drive select 0

FDC_COMMAND             equ $ff48            ; Floppy command register
FDC_STATUS              equ $ff48            ; Floppy status register
FDC_TRACK               equ $ff49            ; FDC track register
FDC_SECTOR              equ $ff4a            ; FDC sector register
FDC_DATA                equ $ff4b            ; FDC data register


; FDC control register bits at $ff40 (FDC_CTRL)
FDC_CR_HALT             equ %10000000
FDC_CR_DRIVE3           equ %01000000
FDC_CR_DENSITY          equ %00100000
FDC_CR_WRITE            equ %00010000
FDC_CR_MOTOR            equ %00001000
FDC_CR_DRIVE2           equ %00000100
FDC_CR_DRIVE1           equ %00000010
FDC_CR_DRIVE0           equ %00000001


; Command Summary (models 1791, 1792, 1793, 1794)
;   Type Command         b7 b6 b5 b4 b3 b2 b1 b0
;   I    Restore         0  0  0  0  h  V  r1 r0
;   I    Seek            0  0  0  1  h  V  r1 r0
;   I    Step            0  0  1  T  h  V  r1 r0
;   I    Step-In         0  1  0  T  h  V  r1 r0
;   I    Step-Out        0  1  1  T  h  V  r1 r0
;   II   Read Sector     1  0  0  m  S  E  C  0
;   II   Write Sector    1  0  1  m  S  E  C  a0
;   III  Read Address    1  1  0  0  0  E  0  0
;   III  Read Track      1  1  1  0  0  E  0  0
;   III  Write Track     1  1  1  1  0  E  0  0
;   IV   Force Interrupt 1  1  0  1  i3 i2 i1 i0
;
; Flag Summary
;   r1 r0  Stepping Motor Rate
;   V      Track Number Verify Flag (0: no verify, 1: verify on dest track)
;   h      Head Load Flag (1: load head at beginning, 0: unload head)
;   T      Track Update Flag (0: no update, 1: update Track Register)
;   a0     Data Address Mark (0: FB, 1: F8 (deleted DAM))
;   C      Side Compare Flag (0: disable side compare, 1: enable side comp)
;   E      15 ms delay (0: no 15ms delay, 1: 15 ms delay)
;   S      Side Compare Flag (0: compare for side 0, 1: compare for side 1)
;   m      Multiple Record Flag (0: single record, 1: multiple records)
;
;   i3 i2 i1 i0 Interrupt Condition Flags
;        i3-i0 = 0 Terminate with no interrupt (INTRQ)
;           i3 = 1 Immediate interrupt, requires a reset
;           i2 = 1 Index pulse
;           i1 = 1 Ready to not ready transition
;           i0 = 1 Not ready to ready transition
;
; Stepping Rate
;   r1 r0 Stepping rate
;   0  0   6 ms
;   0  1   12 ms
;   1  0   20 ms
;   1  1   30 ms

; FDC Stepping rate
FDC_STEP_6MS            equ %00000000        ; 6 ms
FDC_STEP_12MS           equ %00000001        ; 12 ms
FDC_STEP_20MS           equ %00000010        ; 20 ms
FDC_STEP_30MS           equ %00000011        ; 30 ms

; FDC Track Update Flag
FDC_TRACK_UPDATE_ON     equ %00010000        ; Update track register
FDC_TRACK_UPDATE_OFF    equ 0                ; no update

; FDC Commands Type I
FDC_CMD_RESTORE         equ %00000000        ; Restore (Seek track #0)
FDC_CMD_SEEK            equ %00010100        ; Seek
FDC_CMD_STEP            equ %00100000        ; Step
FDC_CMD_STEP_IN         equ %01000000        ; Step In
FDC_CMD_STEP_OUT        equ %01100000        ; Step Out

; FDC Commands Type II
FDC_CMD_READ_SECTOR     equ %10000000        ; Read Sector
FDC_CMD_WRITE_SECTOR    equ %10100000        ; Write Sector

; FDC Commands Type III
FDC_CMD_READ_ADDRESS    equ %11000000        ; Read Address
FDC_CMD_READ_TRACK      equ %11100000        ; Read Track
FDC_CMD_WRITE_TRACK     equ %11110000        ; Write Track

; FDC Commands Type IV
FDC_CMD_FORCE_INTERRUPT equ %11010000        ; Force Interrupt

; FDC Status for Type I Commands
FDC_STATUS_NOT_READY    equ %10000000        ; Drive is not ready
FDC_STATUS_PROTECTED    equ %01000000        ; Write protect is activated
FDC_STATUS_HEAD_LOADED  equ %00100000        ; Head is loaded and engaged
FDC_STATUS_SEEK_ERROR   equ %00010000        ; Desired track was not verified
FDC_STATUS_CRC_ERROR    equ %00001000        ; CRC encountered in ID field
FDC_STATUS_TRACK_0      equ %00000100        ; Read/Write head is positioned to track #0
FDC_STATUS_INDEX        equ %00000010        ; Index mark detected from drive
FDC_STATUS_BUSY         equ %00000001        ; Command is in progress

; FDC Status for Type II and III Commands
FDC_WRITE_FAULT         equ %00100000        ; Write fault
FDC_RNF                 equ %00010000        ; Desired track, sector or side was not found
FDC_DATA_REQUEST        equ %00000010        ;


FDC_DEFS                equ 1                ; Set flag for defines being loaded
                        endc
                        *pragmapop list      ; restore assembly listing to previous state
