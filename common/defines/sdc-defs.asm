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

; SDC Mode and Command values
SDC_CMD_MODE_ENABLE     equ $43             ; Control latch value to enable command mode
SDC_CMD_READ            equ $80             ; Read logical sector
                                            ;   Bit 2 - Hitach 6309 TFM Mode
                                            ;   Bit 1 - Single-sided LSN flag
                                            ;   Bit 0 - Drive number
SDC_CMD_STREAM          equ $90             ; Continuous read of 512 byte blocks
                                            ;   Bit 2 - Hitach 6309 TFM Mode
                                            ;   Bit 1 - Single-sided LSN flag
                                            ;   Bit 0 - Drive number
SDC_CMD_WRITE           equ $A0             ; Write logical sector
                                            ;   Bit 2 - NOT SUPPORTED for write command
                                            ;   Bit 1 - Single-sided LSN flag
                                            ;   Bit 0 - Drive number
SDC_CMD_EXT             equ $C0             ; Extended command
SDC_CMD_ABORT           equ $D0             ; Abort I/O command
SDC_CMD_EXT_DATA        equ $E0             ; Extended command with data block

; SDC command options
SDC_DRIVE0              equ 0               ; Select Drive #0 (Default)
SDC_DRIVE1              equ %00000001       ; Select Drive #1
SDC_LSN_DOUBLE          equ 0               ; Select drive image is a double-sided floppy (Default)
SDC_LSN_SINGLE          equ %00000010       ; Select drive image is a single-sided floppy
SDC_M6809               equ 0               ; Select double-byte registers for Motorola 6809 CPU (Default)
SDC_H6309               equ %00000100       ; Select single-byte register for Hitachi 6309's TFM instruction

; SDC commands that utilizes Hitachi 6309's TFM instruction
SDC_CMD_READ_H6309      equ SDC_CMD_READ+SDC_H6309
SDC_CMD_STREAM_H6309    equ SDC_CMD_STREAM+SDC_H6309

; CoCo SDC Extended Commands
SDC_EXT_CURRENT_DIR     equ 'C              ; Get current directory
SDC_EXT_INFO            equ 'I              ; Get info for mounted image
SDC_EXT_QUERY           equ 'Q              ; Query the size of DSK image
SDC_EXT_DIR_PAGE        equ '>              ; Directory page
SDC_EXT_GLOBAL          equ 'g              ; Set global Flags

; CoCo SDC Command Strings
SDC_STR_DIR_LIST        equ "L:             ; Initiate directory Listing
SDC_STR_CD              equ "D:             ; Set current directory
SDC_STR_NEW_DIR         equ "K:             ; Create new directory
SDC_STR_DELETE          equ "X:             ; Deletes file or an empty directory
SDC_STR_MOUNT           equ "M:             ; Mount image
SDC_STR_MOUNT_NEW       equ "N:             ; Mount new image (create image if not present)
SDC_STR_CURRENT_PATH    equ '.*256+0        ; Current path location
SDC_STR_PARENT_DIR      equ "..             ; Parent directory

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
