; gimex-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef GIMEX_DEFS   ; Load defines only once


; https://thezippsterzone.com/2019/03/27/gime-x/


; Acceleration mode
GIMEX_SPEED_MAGIC       equ $a5             ; magic value to select 2.86 MHz speed


; Video palette - 256 color palette set
GIMEX_256_PALETTE       equ $ffe0           ; Set color palette position for 256 color mode


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

GIMEX_DEFS              equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
