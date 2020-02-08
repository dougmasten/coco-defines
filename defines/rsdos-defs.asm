; rsdos-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef RSDOS_DEFS   ; Load defines only once


; RSDOS Variables
RSDOS_DEVNUM            equ $6f             ; Device number: 0=screen, $FE=printer
RSDOS_REBOOT_FLAG       equ $71             ; $55=warm boot, other=cold boot
RSDOS_REBOOT_VECTOR     equ $72             ; Warm start vector - jump address for warm start
RSDOS_CURPOS            equ $88             ; cursor position
RSDOS_ZERO              equ $8a             ; dummy - these two bytes are always zero
RSDOS_DCOPC             equ $ea             ; DSKCON operation code 0-3
RSDOS_DCDRV             equ $eb             ; DSKCON drive number 0-3
RSDOS_DCTRK             equ $ec             ; DSKCON track number 0-34
RSDOS_DSEC              equ $ed             ; DSKCON sector number 1-18
RSDOS_DCBPT             equ $ee             ; DSKCON data pointer
RSDOS_DCSTA             equ $f0             ; DSKCON status byte
RSDOS_SW3VEC            equ $100            ; SWI3 Vector
RSDOS_SW2VEC            equ $103            ; SWI2 Vector
RSDOS_SWIVEC            equ $106            ; SWI Vector
RSDOS_NMIVEC            equ $109            ; NMI Vector
RSDOS_IRQVEC            equ $10c            ; IRQ Vector
RSDOS_FRQVEC            equ $10f            ; FIRQ Vector
RSDOS_RJOY_LR           equ $15a            ; Right joystick, left/right value
RSDOS_RJOY_UD           equ $15b            ; Right joystick, up/down value
RSDOS_LJOY_LR           equ $15c            ; Left joystick, left/right value
RSDOS_LJOY_UD           equ $15d            ; Left joystick, up/down value
RSDOS_RVEC0             equ $15e            ; BASIC's RAM Vector - Open Command
RSDOS_RVEC1             equ $161            ; BASIC's RAM Vector - Device # Validity Check
RSDOS_RVEC2             equ $164            ; BASIC's RAM Vector - Set print parameters
RSDOS_RVEC3             equ $167            ; BASIC's RAM Vector - Console Out
RSDOS_RVEC4             equ $16a            ; BASIC's RAM Vector - Console In
RSDOS_RVEC5             equ $16d            ; BASIC's RAM Vector - Input device # check
RSDOS_RVEC6             equ $170            ; BASIC's RAM Vector - Print device # check
RSDOS_RVEC7             equ $173            ; BASIC's RAM Vector - Close all files
RSDOS_RVEC8             equ $176            ; BASIC's RAM Vector - Close one file
RSDOS_RVEC9             equ $179            ; BASIC's RAM Vector - Print
RSDOS_RVEC10            equ $17c            ; BASIC's RAM Vector - Input
RSDOS_RVEC11            equ $17f            ; BASIC's RAM Vector - Break check
RSDOS_RVEC12            equ $182            ; BASIC's RAM Vector - Inputting a BASIC line
RSDOS_RVEC13            equ $185            ; BASIC's RAM Vector - Terminating BASIC line input
RSDOS_RVEC14            equ $188            ; BASIC's RAM Vector - EOF Command
RSDOS_RVEC15            equ $18b            ; BASIC's RAM Vector - Evaluate an expression
RSDOS_RVEC16            equ $18e            ; BASIC's RAM Vector - Reserved for ON ERROR GOTO command
RSDOS_RVEC17            equ $191            ; BASIC's RAM Vector - Error driver
RSDOS_RVEC18            equ $194            ; BASIC's RAM Vector - Run
RSDOS_RVEC19            equ $197            ; BASIC's RAM Vector - ASCII to floating point conversion
RSDOS_RVEC20            equ $19a            ; BASIC's RAM Vector - BASIC's command interpretation loop
RSDOS_RVEC21            equ $19d            ; BASIC's RAM Vector - Reset/Set/Point commands
RSDOS_RVEC22            equ $1a0            ; BASIC's RAM Vector - EXBAS' Get/Put
RSDOS_RVEC23            equ $1a3            ; BASIC's RAM Vector - Crunch BASIC line
RSDOS_RVEC24            equ $1a6            ; BASIC's RAM Vector - Uncrunch BASIC line
RSDOS_VIDRAM            equ $400            ; Video Text Low-res display area
RSDOS_VIDRAM_LEN        equ 512             ; Video Text screen size
RSDOS_POLCAT            equ $a000           ; get a keystroke
RSDOS_CHROUT            equ $a002           ; output a character
RSDOS_CSRDON            equ $a004           ; turn on cassette motor, start reading
RSDOS_BLKIN             equ $a006           ; read a block from cassette
RSDOS_BLKOUT            equ $a008           ; write a block to cassette
RSDOS_JOYIN             equ $a00a           ; read joysticks
RSDOS_WRTLDR            equ $a00c           ; turn on motor and write $55's to cassette


; Disk
RSDOS_DOS_MAGIC         equ $c000           ; flag to identify Disk ROM is present. ASCII 'DK'
RSDOS_DSKCON            equ $c004           ; DSKCON pointer
RSDOS_DSKVAR            equ $c006           ; address of DSKCON variables
RSDOS_SECTOR_LEN        equ 256             ; length of sector in bytes
RSDOS_SECTOR_MAX        equ 18              ; maximum number of sectors per track
RSDOS_TRACK_LEN         equ RSDOS_SECTOR_LEN*RSDOS_SECTOR_MAX ; length of track in bytes

RSDOS_DIR_ENTRY         struct
DIR_NAME                rmb 8               ; filename
DIR_EXT                 rmb 3               ; extension
DIR_TYPE                rmb 1               ; file type
DIR_ASCII               rmb 1               ; ASCII flag
DIR_FIRST_GRN           rmb 1               ; First granule in file
DIR_LAST                rmb 1               ; Number of bytes used in last sector
                        rmb 16              ; unused
                        ends

; DSKCON Variables
RSDOS_DSKCON_VAR        struct
OPERATION               rmb 1               ; Operation code 0-3
DRIVE                   rmb 1               ; Drive # 0-3
TRACK                   rmb 1               ; Track # 0-34
SECTOR                  rmb 1               ; Sector # 1-18
DATA_PTR                rmb 2               ; Data Pointer
STATUS                  rmb 1               ; Status
                        ends


RSDOS_DEFS              equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
