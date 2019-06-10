; coco3-defs.asm
; Tandy Color Computer 3 hardware definitions


                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list

                        ifndef COCO3_DEFS   ; Load defines only once


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
RSDOS_RJOY_LR           equ $15a            ; Right joystick, left/right value
RSDOS_RJOY_UD           equ $15b            ; Right joystick, up/down value
RSDOS_LJOY_LR           equ $15c            ; Left joystick, left/right value
RSDOS_LJOY_UD           equ $15d            ; Left joystick, up/down value
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



; CoCo 3 Interrupts jump vectors
JUMP_INT_FLAG           equ $feed           ; Interrupt jump table valid flag: 0=not valid, $55=valid
SWI3_JUMP               equ $feee           ; CoCo3 SWI3 jump vector
SWI2_JUMP               equ $fef1           ; CoCo3 SWI2 jump vector
FIRQ_JUMP               equ $fef4           ; CoCo3 FIRQ jump vector
IRQ_JUMP                equ $fef7           ; CoCo3 IRQ jump vector
SWI_JUMP                equ $fefa           ; CoCo3 SWI jump vector
NMI_JUMP                equ $fefd           ; CoCo3 NMI jump vector


; PIA Registers
PIA0_DATA_A             equ $ff00           ; PIA 0 side A data register
                                            ; Bit 7 - Joystick comparison input
                                            ; Bit 6 - Keyboard row 7
                                            ; Bit 5 - Keyboard row 6
                                            ; Bit 4 - Keyboard row 5
                                            ; Bit 3 - Keyboard row 4 & Left Joystick Switch 2
                                            ; Bit 2 - Keyboard row 3 & Right Joystick Switch 2
                                            ; Bit 1 - Keyboard row 2 & Left Joystick Switch 1
                                            ; Bit 0 - Keyboard row 1 & Right Joystick Switch 1
PIA0_BASE               equ PIA0_DATA_A
PIA_KEYBOARD_ROW        equ PIA0_DATA_A
PIA_HSYNC_ACK           equ PIA0_DATA_A     ; Read register to acknowledge the PIA HSYNC interrupt

PIA0_CTRL_A             equ $ff01           ; PIA 0 side A control register
                                            ; Bit 7 - HSYNC Flag 0=not sync, 1=triggered
                                            ; Bit 6 - n/a
                                            ; Bit 5 - Always a "1"
                                            ; Bit 4 - Always a "1"
                                            ; Bit 3 - Select line LSB of MUX
                                            ;         MSB (FF03 bit 3)   LSB (FF01 bit 3)   Sound Source
                                            ;          0                  0                  DAC
                                            ;          0                  1                  Cassette
                                            ;          1                  0                  Cartridge
                                            ;          1                  1                  No Sound
                                            ; Bit 2 - Data direction toggle 0=$FF00 sets data direction, 1=normal
                                            ; Bit 1 - IRQ Polarity 0=flag set on falling edge, 1=set on rising edge
                                            ; Bit 0 - HSYNC IRQ 0=disabled, 1=enabled
PIA_HSYNC_FLAG          equ PIA0_CTRL_A

PIA0_DATA_B             equ $ff02           ; PIA 0 side B data register
                                            ; Bit 7 - Keyboard column 8
                                            ; Bit 6 - Keyboard column 7
                                            ; Bit 5 - Keyboard column 6
                                            ; Bit 4 - Keyboard column 5
                                            ; Bit 3 - Keyboard column 4
                                            ; Bit 2 - Keyboard column 3
                                            ; Bit 1 - Keyboard column 2
                                            ; Bit 0 - Keyboard column 1
PIA_KEYBOARD_COL        equ PIA0_DATA_B
PIA_VSYNC_ACK           equ PIA0_DATA_B     ; Read register to acknowledge the VSYNC interrupt

PIA0_CTRL_B             equ $ff03           ; PIA 0 side B control register
                                            ; Bit 7 - VSYNC Flag 0=not sync, 1=triggered
                                            ; Bit 6 - n/a
                                            ; Bit 5 - Always a "1"
                                            ; Bit 4 - Always a '1"
                                            ; Bit 3 - Select line MSB of MUX
                                            ;         MSB (FF03 bit 3)   LSB (FF01 bit 3)   Sound Source
                                            ;          0                  0                  DAC
                                            ;          0                  1                  Cassette
                                            ;          1                  0                  Cartridge
                                            ;          1                  1                  No Sound
                                            ; Bit 2 - Data direction toggle 0=$FF02 sets data direction, 1=normal
                                            ; Bit 1 - IRQ Polarity 0=flag set on falling edge, 1=set on rising edge
                                            ; Bit 0 - VSYNC IRQ 0=disabled, 1=enabled
PIA_VSYNC_FLAG          equ PIA0_CTRL_B

MAME_DEBUG_CTRL         equ $ff04           ; MAME Debug Control (Milliluk's branch only)
                                            ; Bit 7:2 - n/a
                                            ; Bit 1 - Set to '1' snapshots Video Frame count to mame_framecount
                                            ; Bit 0 - Set to '1' snapshots System Cycle count to mame_cyclecount
MAME_CYCLE_COUNT        equ $ff05           ; MAME System cycle counter (32-bit) snapshot
MAME_FRAME_COUNT        equ $ff09           ; MAME Video frame counter (32-bit) snapshot


PIA1_DATA_A             equ $ff20           ; PIA 1 side A data register
                                            ; Bit 7:2 - DAC (6 bits)
                                            ; Bit 1 - RS-232C Data Output
                                            ; Bit 0 - Cassette Data Input

PIA_DAC                 equ PIA1_DATA_A
PIA1_BASE               equ PIA1_DATA_A

PIA1_CTRL_A             equ $ff21           ; PIA 1 side A control register
                                            ; Bit 7 - CD FIRQ Flag
                                            ; Bit 6:4 - n/a
                                            ; Bit 3 - Cassette motor control 0=off, 1=on
                                            ; Bit 2 - Data direction control of $FF20: 0=input and 1=output (normal)
                                            ; Bit 1 - FIRQ polarity 0=falling, 1=rising
                                            ; Bit 0 - CD FIRQ (RS-232C) 0=FIRQ disabled, 1=enabled

PIA1_DATA_B             equ $ff22           ; PIA 1 side B data register
                                            ; Bit 7:2 - n/a
                                            ; Bit 1 - Single bit sound output
                                            ; Bit 0 - RS-232C data input

PIA1_CTRL_B             equ $ff23           ; PIA 1 side B control register
                                            ; Bit 7 - Cartridge FIRQ Flag
                                            ; Bit 6:4 - n/a
                                            ; Bit 3 - Sound enable
                                            ; Bit 2 - Data direction control of $FF22: 0=input and 1=output (normal)
                                            ; Bit 1 - FIRQ Polarity 0=falling, 1=rising
                                            ; Bit 0 - Cart FIRQ 0=FIRQ disabled, 1=enabled

; Disk Controller Cartridge
DISK_CTRL_REG           equ $ff40           ; Floppy Disk Controller
                                            ; Bit 7 - Halt flag: 0=disabled, 1=enabled
                                            ; Bit 6 - Drive select 3
                                            ; Bit 5 - Density flag: 0=single, 1=double
                                            ; Bit 4 - Write precompensation: 0=no precomp, 1=precomp
                                            ; Bit 3 - Drive motor enable: 0=motors off, 1=motors on
                                            ; Bit 2 - Drive select 2
                                            ; Bit 1 - Drive select 1
                                            ; Bit 0 - Drive select 0
DISK_COMMAND_REG        equ $ff49           ; Floppy status/command register for disk controller
DISK_TRACK_REG          equ $ff4a           ; Floppy disk controller track register
DISK_SECTOR_REG         equ $ff4b           ; Floppy disk controller sector register
DISK_DATA_REG           equ $ff4c           ; Floppy disk controller data register


; Game Master Cartridge by John Linville
; https://en.wikipedia.org/wiki/Texas_Instruments_SN76489
GMC_BANK                equ $ff40
GMC_SOUND               equ $ff41           ; Texas Instruments SN76489 data bus (Write-only)


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


; YMF262 (OPL3) Sound Chip
; Used in Mega-Mini and CoCoSDC Extender
OPL3_BASE               equ $ff50
OPL3_PORT0_REG          equ OPL3_BASE       ; Write only - Port #0 Register number
OPL3_STATUS             equ OPL3_BASE       ; Read only  - Timer interrupt status
OPL3_PORT0_DATA         equ OPL3_BASE+1     ; Write only - Port #0 Register value
OPL3_PORT1_REG          equ OPL3_BASE+2     ; Write only - Port #1 Register number
OPL3_PORT1_DATA         equ OPL3_BASE+3     ; Write only - Port #1 Register value
OPL3_RESET              equ OPL3_BASE+4     ; Read or write performs a reset of chip registers (initial clear)


; CoCo PSG by Ed Snider
;   - YM2149 classic sound chip
;   - Digital joystick/controller 4-ports
;   - 512K of RAM
;   - 512K of FLASH memory
; https://thezippsterzone.com/2018/05/08/coco-psg/
PSG_MEM0                equ $ff5a           ; Memory Bank 0 Register
PSG_MEM1                equ $ff5b           ; Memory Bank 1 Register
PSG_CTRL_REG            equ $ff5d           ; Control Register
                                            ; Bit 7:6 - n/a
                                            ; Bit 5 - FLASH programming: 0=disabled, 1=enabled
                                            ; Bit 4 - Autostart: 0=enabled, 1=disabled
                                            ; Bit 3 - Write Enable (for FLASH/SRAM); 0=disabled, 1=enabled
                                            ; Bit 2 - Gameport B Sel Signal (pin 7 of controller port B)
                                            ; Bit 1 - Gameport A Sel signal (pin 7 of controller port A)
                                            ; Bit 0 - YM2149 Master Clock: 0=2MHz, 1=1MHz
PSG_YM_REG              equ $ff5e           ; YM Register Select Port
PSG_YM_DATA             equ $ff5f           ; YM Data Port
PSG_FLASH_5555          equ $bfff           ; Programming Register for 512K FLASH chip
PSG_FLASH_2AAA          equ $baaa           ; Programming Register for 512K FLASH chip


; X-Pad
XPAD_X                  equ $ff60           ; X coordinate for X-Pad, 0-255
XPAD_Y                  equ $ff61           ; Y coordinate for X-Pad, 0-191
XPAD_STATUS             equ $ff62           ; Status register for X-Pad
                                            ; Bit 3 - Pen in Y-Margin
                                            ; Bit 2 - Pen in X-Margin
                                            ; Bit 1 - Pen within 1" of surface
                                            ; Bit 0 - Pen down


; CoCo FLASH Cartridge by RETRO Innovations
; http://www.go4retro.com/products/cocoflash/
FLASH_CONFIG            equ $ff64           ; CoCo FLASH Cartridge
                                            ; Bit 7 - Enable FLASH write at $C000 (1=enabled)
                                            ; Bit 6 - Read bank or Device ID (1=Device ID visible)
                                            ; Bit 5 - Enable offset register (1=enabled)
                                            ; Bit 4 - Force single reset (1=selected)
                                            ; Bit 3:2 - Select SPI source
                                            ;             00 = none
                                            ;             01 = EEPROM
                                            ;             10 = Secondard SPI channel
                                            ;             11 = Third SPI channel (not currently implemented)
                                            ; Bit 1 - Autostart (1=on)
                                            ; Bit 0 - LED (1=on)
FLASH_BANK_LO           equ $ff65           ; Bit 7:0 - bits 7-0 of bank register
FLASH_BANK_HI           equ $ff66           ; Bit 7:4 - n/a
                                            ; Bit 3:0 - bits 10-8 of bank register
FLASH_SPI               equ $ff67           ; SPI data out
FLASH_INFO0             equ $ff7a           ; CoCo FLASH Cartridge (READ Only)
                                            ; Bit 7:4 - Device Family
                                            ; Bit 3:0 - Device ID
FLASH_INFO1             equ $ff7b           ; CoCo FLASH Cartridge (READ Only)
                                            ; Bit 7:4 - Device version
                                            ; Bit 3:0 - Config jumpers
FLASH_COMMAND_REG       equ $ff80           ; Remap CoCoFlash registers
                                            ;
                                            ; To unlock the command system, first read from command_reg to
                                            ; reset the command system. After send a special sequence to
                                            ; command_reg of $55,$AA,<DEVICE_FAMILY:DEVICE_ID>.
                                            ;
                                            ; Family ID Device
                                            ; ------ -- ------------------------
                                            ; $1     $1 Tandy/RS Orchestra 90-CC
                                            ; $2     $1 CoCoFlash
                                            ;
                                            ; Once proper sequence is sent, a program must send a command
                                            ; to execute.
                                            ;
                                            ; Command            Value    Data Length   Data Value
                                            ; ----------------   -----    -----------   ---------------------------------
                                            ; Set Base Address   $01      1             Low byte of base address
                                            ;                                           (setting high bit will hide device)


ORCH90                  equ $ff7a           ; Orchestra-90 Cartridge
ORCH90_LEFT             equ ORCH90          ; Orchestra-90 (Left channel)
ORCH90_RIGHT            equ ORCH90+1        ; Orchestra-90 (Right channel)

SSC_RESET               equ $ff7d           ; Sound/Speech Cartridge reset
SSC_RW                  equ $ff7e           ; Sound/Speech Cartridge read/write


; MEGA-mini MPI (4-slots plus sound chip) by Ed Snider
; https://thezippsterzone.com/2018/05/09/mega-mini-mpi/
;
; Mini MPI (2-slots) by Ed Snider
; https://thezippsterzone.com/2018/05/07/mini-mpi/
;
MPI_REG                 equ $ff7f           ; Multi-pak programming register (Read and Write)
                                            ; Bit 7:4 - # of active CART and CTS slot   (ROM $C000-$DFFF)
                                            ; Bit 3:0 - # of active SCS slot            (I/O $FF40-$FF5F)
                                            ;
                                            ;   0000 - Slot 1 selected
                                            ;   0001 - Slot 2 selected
                                            ;   0010 - Slot 3 selected
                                            ;   0011 - Slot 4 selected
                                            ;   0100 - MEGA-mini Virtual Slot 5 selected - VMF-262M (OPL3) Sound Chip
                                            ;   0101 - MEGA-mini Virtual Slot 6 selected - UARTs
                                            ;   1111 - MEGA-mini Virtual Slot 16 selected - Enhanched IRQ system
                                            ;                                               analog switch
                                            ;                                               programmer timer


; CoCo 3 GIME Registers
GIME_BASE               equ $ff90

GIME_INIT0              equ $ff90           ; Initialization Register 0 (Write-only)
                                            ; Bit 7 - 1 = CoCo 1/2 Video Mode compatible, 0=CoCo 3 Video Modes
                                            ; Bit 6 - 1 = MMU enabled, 0 = GIME maps block 38-3F by default
                                            ; Bit 5 - 1 = GIME chip IRQ enabled
                                            ; Bit 4 - 1 = GIME chip FIRQ enabled
                                            ; Bit 3 - 1 = Vector RAM at $FExx enabled
                                            ; Bit 2 - 1 = Standard SCS
                                            ; Bit 1 - ROM map control       0X = 16K internal, 16K external
                                            ; Bit 0 -  "   "                10 = 32K internal
                                            ;                               11 = 32K external (except interrupt vectors)

; Initialization Register Bits Flags (Used for GIME_INIT0)
IR_Compatible           equ %10000000
IR_MMU                  equ %01000000
IR_IRQ                  equ %00100000
IR_FIRQ                 equ %00010000
IR_VectorRAM            equ %00001000
IR_StandardSCS          equ %00000100
IR_ROMInt16kExt16K      equ %00000000
IR_ROMInt32k            equ %00000010
IR_ROMExt32K            equ %00000011

GIME_INIT1              equ $ff91           ; Initialization Register 1 (Write-only)
                                            ; Bit 7   - n/a
                                            ; Bit 6   - Memory type: 0 = 64K chips, 1 = 256K chips
                                            ; Bit 5   - Timer Input clock select: 0 = 63.695 usec, 1 = 279.365 nsec
                                            ; Bit 4:1 - n/a
                                            ; Bit 0   - MMU Task register select: 0 = enable $FFA0-$FFA7
                                            ;                                     1 = enable $FFA8-$FFAF

GIME_IRQ                equ $ff92           ; Interrupt Request Enable Register (Read and write)
                                            ; Bit 7:6 - n/a
                                            ; Bit 5   - 1 = enable Timer IRQ
                                            ; Bit 4   - 1 = enable HSYNC IRQ
                                            ; Bit 3   - 1 = enable VSYNC IRQ
                                            ; Bit 2   - 1 = enable Serial IRQ
                                            ; Bit 1   - 1 = enable Keyboard IRQ
                                            ; Bit 0   - 1 = enable Cartridge IRQ

GIME_FIRQ               equ $ff93           ; Fast Interrupt Request Enable Register (Read and write)
                                            ; Bit 7:6 - n/a
                                            ; Bit 5   - 1 = enable Timer FIRQ
                                            ; Bit 4   - 1 = enable HSYNC FIRQ
                                            ; Bit 3   - 1 = enable VSYNC FIRQ
                                            ; Bit 2   - 1 = enable Serial FIRQ
                                            ; Bit 1   - 1 = enable Keyboard FIRQ
                                            ; Bit 0   - 1 = enable Cartridge FIRQ

; CoCo 3 Interrupt Flags (Used for GIME_IRQ and GIME_FIRQ)
TIMER_INTERRUPT         equ %00100000       ; Cenerated whenever the 12 bit timer counts down to zero
HSYNC_INTERRUPT         equ %00010000       ; Generated on the falling edge of HSYNC
VSYNC_INTERRUPT         equ %00001000       ; Generated on the falling edgde of VSYNC
SERIAL_INTERRUPT        equ %00000100       ; Generated on the falling edge fo the signal on PIN 4 of the serial port
KEY_INTERRUPT           equ %00000010       ; Generated whenever a zero appears on any one of PA0-PA6 on the PIA0
CART_INTERRUPT          equ %00000001       ; Generated on the falling edge of the signal on PIN 8 of the cartridge port

GIME_TIMER              equ $ff94
GIME_TIMER_MSB          equ GIME_TIMER      ; Timer bits 11:8 - write here to start timer (Write-only)
GIME_TIMER_LSB          equ GIME_TIMER+1    ; Timer bits 7:0 (Write-only)
                                            ; The 12-bit timer can be loaded with any number from 0-4095.
                                            ; Storing a zero to both registers stops the timer from operating.
                                            ;
                                            ; Neither 1986 and 1987 version of GIME can actually run a clock of 1.
                                            ;   1986 GIME actually processes this as a '3'.
                                            ;   1987 GIME actually processes this as a '2'.
                                            ; All other values stored are affected the same way:
                                            ;   1986 GIME: nnn+2
                                            ;   1987 GIME: nnn+1


GIME_VIDEO_MODE         equ $ff98           ; Video mode register - VMODE (Write-only)
                                            ; Bit 7   - 0 = Text modes, 1 = Graphics modes
                                            ; Bit 6   - n/a
                                            ; Bit 5   - 1 = Composite color phase invert
                                            ; Bit 4   - 1 = Monochrome on Composite video output
                                            ; Bit 3   - 0 = 60Hz video, 1 = 50Hz video
                                            ; Bit 2:0 - Number of lines/char row
                                            ;            00x = 1 lines per row
                                            ;            010 = 2 lines per row
                                            ;            011 = 8 lines per row
                                            ;            100 = 9 lines per row
                                            ;            101 = 10 lines per row
                                            ;            110 = 11 lines per row
                                            ;            111 = *infinite lines per row

GIME_VIDEO_RES          equ $ff99           ; Video resolution register - VRES (Write-only)
                                            ; Bit 7   - n/a
                                            ; Bit 6:5 - Lines per field
                                            ;              00 = 192 lines
                                            ;              01 = 200 lines
                                            ;              10 = *zero/infinite lines on screen (210 undefined)
                                            ;              11 = 225 lines
                                            ;
                                            ; Bit 4:2 - Horizontal resolution HRES
                                            ;            Graphics:
                                            ;               000 = 16 bytes per row
                                            ;               001 = 20 bytes per row
                                            ;               010 = 32 bytes per row
                                            ;               011 = 40 bytes per row
                                            ;               100 = 64 bytes per row
                                            ;               101 = 80 bytes per row
                                            ;               110 = 128 bytes per row
                                            ;               111 = 160 bytes per row
                                            ;
                                            ;            Text:
                                            ;               0x0 = 32 characters per row
                                            ;               0x1 = 40 characters per row
                                            ;               1x0 = 64 characters per row
                                            ;               1x1 = 80 characters per row
                                            ;
                                            ; Bit 1:0 - Color resolution bits CRES
                                            ;             00 = 2 colors (8 pixels per byte)
                                            ;             01 = 4 colors (4 pixels per byte)
                                            ;             10 = 16 colors (2 pixels per byte)
                                            ;             11 = Undefined
                                            ;
                                            ; Graphics modes:
                                            ;         HRES   CRES   Commonly used graphics mode
                                            ;         ----   ----   ---------------------------
                                            ;         111    01      640 pixels, 4 colors
                                            ;         101    00      640 pixels, 2 colors
                                            ;         110    01      512 pixels, 4 colors
                                            ;         100    00      512 pixels, 2 colors
                                            ;         111    10      320 pixels, 16 colors
                                            ;         101    01      320 pixels, 4 colors
                                            ;         011    00      320 pixels, 2 colors
                                            ;         110    10      256 pixels, 16 colors
                                            ;         100    01      256 pixels, 4 colors
                                            ;         010    00      256 pixels, 2 colors
                                            ;         101    10      160 pixels, 16 colors
                                            ;         011    01      160 pixels, 4 colors
                                            ;         001    00      160 pixels, 2 colors
                                            ;         100    10      128 pixels, 16 colors
                                            ;         010    01      128 pixels, 4 colors
                                            ;         000    00      128 pixels, 2 colors

GIME_BORDER_PALETTE     equ $ff9a           ; Border color register (Write-only)
                                            ; Bit 7:6 - n/a
                                            ; Bit 5:0 - Border color (same format as GIME_PALETTE)

GIME_MMU_EXT            equ $ff9b           ; Distro and NoCan Memory Upgrade
                                            ; Bit 7 - 16MB Video Bit            NoCan3 bits for 16MB (Write only)
                                            ; Bit 6 - 16MB Memory Bit           NoCan3 bits for 16MB
                                            ; Bit 5 -  8MB Memory Bit           NoCan3 bits for 8MB
                                            ; Bit 4 -  4MB Memory Bit           NoCan3 bits for 8MB
                                            ; Bit 3 -  8MB Video Bit            NoCan3 bits for 8MB
                                            ; Bit 2 -  4MB Video Bit            NoCan3 bits for 8MB
                                            ; Bit 1 -  2MB Video Bit   Distro & NoCan2/3 bits for 2MB (Write only)
                                            ; Bit 0 -  1MB Video Bit   Distro & NoCan2/3 bits for 1MB (Write only)
                                            ;
                                            ; Only bits 4-6 are sequence dependant. All other bits are immediate.
                                            ; 1. Write page bits to $FF9B, bits 4-6 only,
                                            ; 2. Write page bits to $FFAx all 8 bits.
                                            ;    When this write occurs the memory bits at $FF9B combine with the
                                            ;    MMU register to create a pseudo 11 bit register. This enables
                                            ;    access to 2048 (2^11) MMU blocks for a total memory of
                                            ;    2024 * 8192 = 16,580,608 (16MB).
                                            ; 3. Change the $FF9B bits 4-6 before writing to any more $FFAx pages.

GIME_V_SCROLL           equ $ff9c           ; Vertical scroll register - VSC (Write-only)
GIME_V_OFFSET           equ $ff9d           ; Vertical offset register MSB Y15-Y0 (Write-only)

GIME_H_OFFSET           equ $ff9f           ; Horizontal offset register (Write-only)
                                            ; Bit 7   - 1 = Horizontal virtual screen enable (256 bytes per row)
                                            ;           0 = Normal horizontal display
                                            ; Bit 6:0 - 0-127 byte offset from vertical_offset_reg ($FF9E/$FF9D)


GIME_MMU0               equ $ffa0           ; MMU bank registers (task 0)
GIME_MMU1               equ $ffa8           ; MMU bank registers (task 1)
                                            ;
                                            ;  Task0  Task1   Logical Address   Blk #   RSDOS Memory Map
                                            ;  -----  -----   ---------------   -----   -----------------------------------
                                            ;  $FFA0  $FFA8    $0000 - $1FFF     0       $38 - BASIC memory
                                            ;  $FFA1  $FFA9    $2000 - $3FFF     1       $39 - BASIC memory
                                            ;  $FFA2  $FFAA    $4000 - $5FFF     2       $3A - BASIC memory
                                            ;  $FFA3  $FFAB    $6000 - $7FFF     3       $3B - BASIC memory
                                            ;  $FFA4  $FFAC    $8000 - $9FFF     4       $3C - Extended Basic ROM
                                            ;  $FFA5  $FFAD    $A000 - $BFFF     5       $3D - Color Basic ROM
                                            ;  $FFA6  $FFAE    $C000 - $DFFF     6       $3E - Cartridge or Disk Basic ROM
                                            ;  $FFA7  $FFAF    $E000 - $FFFF     7       $3F - Super Basic, GIME regs, I/O
                                            ;
                                            ;  $30-$3F - 128K
                                            ;  $00-$3F - 512K
                                            ;  $00-$7F - 1024K
                                            ;  $00-$FF - 2048K
GIME_MMU0_0000          equ GIME_MMU0
GIME_MMU0_2000          equ GIME_MMU0+1
GIME_MMU0_4000          equ GIME_MMU0+2
GIME_MMU0_6000          equ GIME_MMU0+3
GIME_MMU0_8000          equ GIME_MMU0+4
GIME_MMU0_A000          equ GIME_MMU0+5
GIME_MMU0_C000          equ GIME_MMU0+6
GIME_MMU0_E000          equ GIME_MMU0+7
GIME_MMU1_0000          equ GIME_MMU1
GIME_MMU1_2000          equ GIME_MMU1+1
GIME_MMU1_4000          equ GIME_MMU1+2
GIME_MMU1_6000          equ GIME_MMU1+3
GIME_MMU1_8000          equ GIME_MMU1+4
GIME_MMU1_A000          equ GIME_MMU1+5
GIME_MMU1_C000          equ GIME_MMU1+6
GIME_MMU1_E000          equ GIME_MMU1+7

GIME_PALETTE            equ $ffb0           ; Color palette registers (16 bytes)
                                            ;
                                            ;           CMP  RGB
                                            ;           ---  ---
                                            ; Bit 7   -  xx   xx
                                            ; Bit 6   -  xx   xx
                                            ; Bit 5   -  I1   R1
                                            ; Bit 4   -  I0   G1
                                            ; Bit 3   -  P3   B1
                                            ; Bit 2   -  P2   R0
                                            ; Bit 1   -  P1   G0
                                            ; Bit 0   -  P0   B0
                                            ;
                                            ; CMP - 16 colors x 4 shades
                                            ; RGB - 64 RGB combinations
                                            ;
                                            ; Reading and writing palette registers causes a small 'glitch' on screen.
                                            ; To avoid, change palette registers in VSYNC or HSYNC.


SAM_V0_CLEAR            equ $ffc0           ; SAM registers V0 through V2 sets the video display mode
SAM_V0_SET              equ $ffc1           ;
SAM_V1_CLEAR            equ $ffc2           ;
SAM_V1_SET              equ $ffc3           ;
SAM_V2_CLEAR            equ $ffc4           ;
SAM_V2_SET              equ $ffc5           ;

SAM_F0_CLEAR            equ $ffc6           ; SAM registers F0 through F6 sets the video display starting address
SAM_F0_SET              equ $ffc7           ;
SAM_F1_CLEAR            equ $ffc8           ;
SAM_F1_SET              equ $ffc9           ;
SAM_F2_CLEAR            equ $ffca           ;
SAM_F2_SET              equ $ffcb           ;
SAM_F3_CLEAR            equ $ffcc           ;
SAM_F3_SET              equ $ffcd           ;
SAM_F4_CLEAR            equ $ffce           ;
SAM_F4_SET              equ $ffcf           ;
SAM_F5_CLEAR            equ $ffd0           ;
SAM_F5_SET              equ $ffd1           ;
SAM_F6_CLEAR            equ $ffd2           ;
SAM_F6_SET              equ $ffd3           ;


NORMAL_SPEED_MODE       equ $ffd8           ; Any write selects 0.89 Mhz CPU clock
HIGH_SPEED_MODE         equ $ffd9           ; Any write selects 1.79 Mhz CPU clock


ROM_MODE_ENABLE         equ $ffde           ; Any write selects RAM/ROM mode
RAM_MODE_ENABLE         equ $ffdf           ; Any write selects all-RAM mode


; Boomerang 2MB Memory board by BoysonTech
; https://boysontech.com/marketplace/
BOOMERANG_LED           equ $ffef           ; Programmable Tricolor LED to illuminate inside of CoCo3 case
                                            ; Bit 7:6 - 00 = Set Red, Green and Blue intensity
                                            ;           01 = Set Red intensity
                                            ;           10 = Set Green intensity
                                            ;           11 = Set Blue intensity
                                            ; Bit 5   - n/a
                                            ; Bit 4:0 - Intensity (0-31)
                                            ;
                                            ; The LED can also operate in "speed" mode, where the red LED will signify
                                            ; the CoCo running in "slow" mode and the green LED denotes "fast" mode. To
                                            ; activate, see "special mode" below.
                                            ;
BOOMERANG_MAGIC_1       equ $fdfd           ; Boomerang magic addresses to place device in "special mode"  (READ ONLY)
BOOMERANG_MAGIC_2       equ $fd55           ;                                                              (READ ONLY)
BOOMERANG_MAGIC_3       equ $fdaa           ; Read BOOMERANG_MAGIC_1-6 sequential, followed by             (READ ONLY)
BOOMERANG_MAGIC_4       equ $fdff           ; either BOOMERANG_512K, BOOMERANG_512K_TURBO,                 (READ ONLY)
BOOMERANG_MAGIC_5       equ $fd00           ; BOOMERANG_2M or BOOMERANG_2M_TUBRO.                          (READ ONLY)
BOOMERANG_MAGIC_6       equ $fdff           ;                                                              (READ ONLY)
BOOMERANG_512K          equ $fd01           ; Enable 512K mode                                             (READ ONLY)
BOOMERANG_512K_TURBO    equ $fd81           ; Enable 512K and turbo LED mode                               (READ ONLY)
BOOMERANG_2M            equ $fd00           ; Enable 2M mode                                               (READ ONLY)
BOOMERANG_2M_TURBO      equ $fd80           ; Enable 2M and turbo LED mode                                 (READ ONLY)



; Interrupt Vectors
TRAP_VECTOR             equ $fff0           ; Illegal Opcode and Division by Zero Trap (Hitachi 6309 Only)
SWI3_VECTOR             equ $fff2           ; SWI3  -> $FEEE -> $0100
SWI2_VECTOR             equ $fff4           ; SWI2  -> $FEF1 -> $0103
FIRQ_VECTOR             equ $fff6           ; FIRQ  -> $FEF4 -> $010F
IRQ_VECTOR              equ $fff8           ; IRQ   -> $FEF7 -> $010C
SWI_VECTOR              equ $fffa           ; SWI   -> $FEFA -> $0106
NMI_VECTOR              equ $fffc           ; NMI   -> $FEFD -> $0109
RESET_VECTOR            equ $fffe           ; RESET -> $8C1B


COCO3_DEFS              equ 1               ; Set flag for defines being loaded
                        endc

                        *pragmapop list     ; restore assembly listing to previous state
