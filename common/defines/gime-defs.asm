; gime-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef GIME_DEFS    ; Load defines only once


; CoCo 3 GIME Registers
GIME_BASE               equ $ff90

GIME_INIT0              equ $ff90           ; Initialization Register 0 (Write-only)
                                            ; Bit 7 - 1 = CoCo 1/2 Video Mode compatible, 0 = CoCo 3 Video Modes
                                            ; Bit 6 - 1 = MMU enabled, 0 = GIME maps block 38-3F by default
                                            ; Bit 5 - 1 = GIME chip IRQ enabled
                                            ; Bit 4 - 1 = GIME chip FIRQ enabled
                                            ; Bit 3 - 1 = Vector RAM at $FExx enabled
                                            ; Bit 2 - 1 = Standard SCS (Spare chip select)
                                            ; Bit 1 - ROM map control       0X = 16K internal, 16K external
                                            ; Bit 0 -  "   "                10 = 32K internal
                                            ;                               11 = 32K external (except interrupt vectors)

; Initialization register bit flags (Used for GIME_INIT0)
IR0_Compatible          equ %10000000
IR0_MMU                 equ %01000000
IR0_IRQ                 equ %00100000
IR0_FIRQ                equ %00010000
IR0_VectorRAM           equ %00001000
IR0_StandardSCS         equ %00000100
IR0_ROMInt16kExt16K     equ %00000000
IR0_ROMInt32k           equ %00000010
IR0_ROMExt32K           equ %00000011

GIME_INIT1              equ $ff91           ; Initialization Register 1 (Write-only)
                                            ; Bit 7   - n/a
                                            ; Bit 6   - Memory type: 0 = 64K chips, 1 = 256K chips
                                            ; Bit 5   - Timer Input clock select: 0 = 63.695 usec, 1 = 279.365 nsec
                                            ; Bit 4:1 - n/a
                                            ; Bit 0   - MMU Task register select: 0 = enable $FFA0-$FFA7 MMU registers
                                            ;                                     1 = enable $FFA8-$FFAF MMU registers

; Initialization register bit flags (Used for GIME_INIT1)
IR1_Memory_64K          equ %00000000
IR1_Memory_256K         equ %01000000
IR1_Timer_63usec        equ %00000000       ; timer input source of 63 usec
IR1_Timer_279ns         equ %00100000       ; timer input source of 279 ns
IR1_MM0                 equ %00000000
IR1_MM1                 equ %00000001


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
                                            ;             Graphics:
                                            ;               000 = 16 bytes per row
                                            ;               001 = 20 bytes per row
                                            ;               010 = 32 bytes per row
                                            ;               011 = 40 bytes per row
                                            ;               100 = 64 bytes per row
                                            ;               101 = 80 bytes per row
                                            ;               110 = 128 bytes per row
                                            ;               111 = 160 bytes per row
                                            ;
                                            ;             Text:
                                            ;               0x0 = 32 characters per row
                                            ;               0x1 = 40 characters per row
                                            ;               1x0 = 64 characters per row
                                            ;               1x1 = 80 characters per row
                                            ;
                                            ; Bit 1:0 - Color resolution bits CRES
                                            ;             Graphics:
                                            ;               00 = 2 colors (8 pixels per byte)
                                            ;               01 = 4 colors (4 pixels per byte)
                                            ;               10 = 16 colors (2 pixels per byte)
                                            ;               11 = Undefined
                                            ;
                                            ;             Text:
                                            ;               x0 = No color attributes
                                            ;               x1 = Color attributes enabled
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


GIME_DEFS               equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
