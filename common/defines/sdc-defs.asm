; sdc-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef SDC_DEFS     ; Load defines only once


; CoCo SDC by Darren Atkinson
; http://cocosdc.blogspot.com/
SDC_REG_CTRL            equ $ff40           ; Controller Latch (Write)
SDC_REG_DATA            equ $ff42           ; Flash Data Register
SDC_REG_FCTL            equ $ff43           ; Flash Control Register
SDC_REG_STATUS          equ $ff48           ; Status Register (Read)
SDC_REG_CMD             equ $ff48           ; Command Register (Write)
SDC_REG_PARAM1          equ $ff49           ; Param Register #1
SDC_REG_PARAM2          equ $ff4a           ; Param Register #2
SDC_REG_PARAM3          equ $ff4b           ; Param Register #3
SDC_REG_DATA_A          equ SDC_REG_PARAM2  ; First data register
SDC_REG_DATA_B          equ SDC_REG_PARAM3  ; Second data register

; CoCo SDC Mode and Command values
SDC_CMD_MODE_ENABLE     equ $43             ; Control latch value to enable command mode
SDC_CMD_READ            equ $80             ; Read logical sector
SDC_CMD_READ_MYSTERY    equ $82             ; Read UNDOCUMENTED Mode (what does it do?) (256 bytes)
SDC_CMD_READ_6309       equ $84             ; Read logical sector (Hitachi 6309 TFM mode)
SDC_CMD_STREAM          equ $90             ; Continuous read of 512 byte blocks
SDC_CMD_WRITE           equ $A0             ; Write logical sector
SDC_CMD_EXT             equ $C0             ; Extended command
SDC_CMD_ABORT           equ $D0             ; Abort I/O command
SDC_CMD_EXT_DATA        equ $E0             ; Extended command with data block

; CoCo SDC Extended Commands
SDC_EXT_CURRENT_DIR     equ 'C              ; (0x43) Get current directory
SDC_EXT_INFO            equ 'I              ; (0x49) Get info for mounted image
SDC_EXT_QUERY           equ 'Q              ; (0x51) Query the size of DSK image
SDC_EXT_DIR_PAGE        equ '>              ; (0x3e) Directory page
SDC_EXT_GLOBAL          equ 'g              ; (0x67) Set global Flags

; CoCo SDC Command Strings
SDC_STR_DIR_LIST        equ "L:             ; (0x4c3a) Initiate directory Listing
SDC_STR_CD              equ "D:             ; (0x443a) Set current directory
SDC_STR_NEW_DIR         equ "K:             ; (0x4b3a) Create new directory
SDC_STR_DELETE          equ "X:             ; (0x583a) Deletes file or an empty directory
SDC_STR_MOUNT           equ "M:             ; (0x4d3a) Mount image
SDC_STR_MOUNT_NEW       equ "N:             ; (0x4e3a) Mount new image (create image if not present)
SDC_STR_CURRENT_PATH    equ '.*256+0        ; (0x2e00) Current path location
SDC_STR_PARENT_DIR      equ "..             ; (0x2e2e) Parent directory

; CoCO SDC Status Register Masks
SDC_BUSY                equ %00000001       ; Set while a command is executing
SDC_READY               equ %00000010       ; Set when ready for a data transfer
SDC_PATH_INVALID        equ %00000100       ; Set if path name is invalid
SDC_ERROR               equ %00001000       ; Set on miscellaneous hardware errors
SDC_DIR_NOT_FOUND       equ %00010000       ; Set if target directory not found
SDC_FILE_NOT_FOUND      equ %00100000       ; Set if target file is already in use
SDC_WRITE_PROTECTED     equ %01000000       ; Set if image is write protected
SDC_FAIL                equ %10000000       ; Set on command failure


SDC_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
