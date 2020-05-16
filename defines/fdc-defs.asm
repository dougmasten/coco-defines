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
FDC_TRACK               equ $ff49            ; Floppy disk controller track register
FDC_SECTOR              equ $ff4a            ; Floppy disk controller sector register
FDC_DATA                equ $ff4b            ; Floppy disk controller data register


; FDC control register bits at $ff40 (FDC_CTRL)
FDC_CR_HALT            equ %10000000
FDC_CR_DRIVE3          equ %01000000
FDC_CR_DENSITY         equ %00100000
FDC_CR_WRITE           equ %00010000
FDC_CR_MOTOR           equ %00001000
FDC_CR_DRIVE2          equ %00000100
FDC_CR_DRIVE1          equ %00000010
FDC_CR_DRIVE0          equ %00000001


; FDC Commands
FDC_CMD_RESTORE        equ $03               ; Restore
FDC_CMD_SEEK           equ $17               ; Seek
FDC_CMD_STEP           equ $23               ; Step
FDC_CMD_STEP_IN        equ $43               ; Step In
FDC_CMD_STEP_OUT       equ $53               ; Step Out
FDC_CMD_READ_SECTOR    equ $80               ; Read Sector
FDC_CMD_WRITE_SECTOR   equ $a0               ; Write Sector
FDC_CMD_STEP_OUT       equ $c0               ; Read Address
FDC_CMD_READ_TRACK     equ $e4               ; Read Track
FDC_CMD_WRITE_TRACK    equ $f4               ; Write Track
FDC_CMD_FORCE_INTERRUPT equ $d0               ; Force Interrupt


; FDC Status for Type I Commands
FDC_STATUS_NOT_READY   equ %10000000        ; Drive is not ready
FDC_STATUS_PROTECTED   equ %01000000        ; Write protect is activated
FDC_STATUS_HEAD_LOADED equ %00100000        ; Head is loaded and engaged
FDC_STATUS_SEEK_ERROR  equ %00010000        ; Desired track was not verified
FDC_STATUS_CRC_ERROR   equ %00001000        ; CRC encountered in ID field
FDC_STATUS_TRACK_0     equ %00000100        ; Read/Write head is positioned to track #0
FDC_STATUS_INDEX       equ %00000010        ; Index mark detected from drive
FDC_STATUS_BUSY        equ %00000001        ; Command is in progress


; FDC Status for Type II and III Commands
FDC_WRITE_FAULT        equ %00100000        ; Write fault
FDC_RNF                equ %00010000        ; Desired track, sector or side was not found
FDC_DATA_REQUEST       equ %00000010        ;


FDC_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
