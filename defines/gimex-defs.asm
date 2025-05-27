; gimex-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef GIMEX_DEFS   ; Load defines only once


; https://thezippsterzone.com/2019/03/27/gime-x/


; Acceleration mode
GIMEX_SPEED_MAGIC       equ $5a             ; Magic value to select 2.86 MHz speed
                                            ;
                                            ; Acceleration mode is only supported on DDR firmware with
                                            ; a fast SRAM memory upgrade.
                                            ;
                                            ; 1) First system must be in 1.78 MHz mode (STA $FFD9).
                                            ; 2) And then write $A5 to $FFD9. (LDA #$A5; STA $FFD9).
                                            ;
                                            ; Ex:
                                            ;    LDA #GIMEX_SPEED_MAGIC
                                            ;    STA HIGH_SPEED_MODE  ; select 1.78 MHz mode
                                            ;    STA HIGH_SPEED_MODE  ; select 2.86 MHz mode


; GIME_VIDEO_MODE ($FF98) option
VM_GIMEX_NEW_VIDEO      equ %01000000       ; Activate GIME-X new video modes


; GIME_VIDEO_RES ($FF99) option
VR_GIMEX_GRX_320_BPR    equ %00000000       ; 320 bytes per row
VR_GIMEX_GRX_640_BPR    equ %00000100       ; 640 bytes per row
VR_GIMEX_GRX_256_COLORS equ %00000011       ; 256 colors (1 pixel per byte)


; Direct Memory Access
GIMEX_DMA_DEST_MSB      equ $ffe1           ; Destination Address: bits 20-16
GIMEX_DMA_DEST_CSB      equ $ffe2           ; Destination Address: bits 15-8
GIMEX_DMA_DEST_LSB      equ $ffe3           ; Destination Address: bits 7-0
GIMEX_DMA_SRC_MSB       equ $ffe4           ; Source Address: bits 20-16
GIMEX_DMA_SRC_CSB       equ $ffe5           ; Source Address: bits 15-8
GIMEX_DMA_SRC_LSB       equ $ffe6           ; Source Address: bits 7-0
GIMEX_DMA_INC           equ $ffe7           ; Auto-increment reg (1 = auto inc)
                                            ;   bit 1 = reads
                                            ;   bit 0 = writes
GIMEX_DMA_DATA          equ $ffe8           ; 8-bit data
GIMEX_DMA_DATA_MSB      equ $ffe8           ; 8-bit data or high byte of 16-bit data
GIMEX_DMA_DATA_LSB      equ $ffe9           ; low byte of 16-bit data

GIMEX_VERSION           equ $ffef           ; GIME-X Version #
                                            ; Bits 7:6 = Major Version
                                            ; Bits 5:0 = Minor Version
                                            ; Bit 0    = SDR/DDR Flag (1 = DDR)
                                            ;
                                            ; SDR (Standard data rate) supports all memory types,
                                            ; but does not support >160 bytes per line video modes or
                                            ; the 2.86 MHz turbo mode.
                                            ;
                                            ; DDR (Double data rate) supports all GIME-X features.
                                            ; A fast SRAM memory upgrade (Triad 2MB, Boomerange E2 w/ a
                                            ; firmware upgrade, or Zippster 2MB board) is required.


; Video palette - 9-bit RGB
GIMEX_PALETTE           equ $ffb0           ; GIME-X 9-bit RGB (16 bytes)
                                            ;
                                            ; 1) First write the most significant bits to the palette register.
                                            ;
                                            ;         *  *  R2 G2 B2 R1 G1 B1
                                            ;    Bit  7  6   5  4  3  2  1  0
                                            ;
                                            ; 2) And then write the least significant bits along with a 1 in bit 7.
                                            ;
                                            ;         1  *  R0 G0 B0  *  *  *
                                            ;    Bit  7  6   5  4  3  2  1  0
                                            ;
                                            ; 3) To use a normal 6-bit color value write it normally (see gime-defs.asm $FFB0).
GIMEX_PALETTE0          equ GIMEX_PALETTE
GIMEX_PALETTE1          equ GIMEX_PALETTE+1
GIMEX_PALETTE2          equ GIMEX_PALETTE+2
GIMEX_PALETTE3          equ GIMEX_PALETTE+3
GIMEX_PALETTE4          equ GIMEX_PALETTE+4
GIMEX_PALETTE5          equ GIMEX_PALETTE+5
GIMEX_PALETTE6          equ GIMEX_PALETTE+6
GIMEX_PALETTE7          equ GIMEX_PALETTE+7
GIMEX_PALETTE8          equ GIMEX_PALETTE+8
GIMEX_PALETTE9          equ GIMEX_PALETTE+9
GIMEX_PALETTE10         equ GIMEX_PALETTE+10
GIMEX_PALETTE11         equ GIMEX_PALETTE+11
GIMEX_PALETTE12         equ GIMEX_PALETTE+12
GIMEX_PALETTE13         equ GIMEX_PALETTE+13
GIMEX_PALETTE14         equ GIMEX_PALETTE+14
GIMEX_PALETTE15         equ GIMEX_PALETTE+15


; Video palette - 256 color palette set
GIMEX_256_PALETTE       equ $ffe0           ; Set color palette position for 256 color mode
                                            ;
                                            ; 1) Write a 6 or 9 bit color value into palette #0.
                                            ; 2) Then write 256 color palette slot # into $FFE0.


GIMEX_DEFS              equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
