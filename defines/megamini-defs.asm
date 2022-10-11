; megamini-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef MEGA_DEFS    ; Load defines only once

                        include mpi-defs.asm

; MEGA-mini MPI by Ed Snider
; https://thezippsterzone.com/wp-content/uploads/2018/12/MEGAmini-manual.pdf
;
;  4-slot multipak interface
;  Yamaha YMF262 (OPL3) sound chip
;  (2) high speed UARTS (5v TTL)
;  (3) programmable timers (two on the YMF chip)
;  Source maskable IRQ system using FIRQ (/CART)
;  Improved sound routing (software selectable source)
;
;MPI_REG            equ $ff7f                ; Multi-pak programming register (Read and Write)
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

; Slot numbers
MEGA_SLOT1              equ %00000000       ; Slot #1
MEGA_SLOT2              equ %00000001       ; Slot #2
MEGA_SLOT3              equ %00000010       ; Slot #3
MEGA_SLOT4              equ %00000011       ; Slot #4
MEGA_YMF262             equ %00000100       ; Slot #5 (Virtual) - YMF262 sound chip
MEGA_SERIAL             equ %00000101       ; Slot #6 (Virtual) - Serial UARTS
MEGA_EXT                equ %00001111       ; Slot #16 (Virtual) - Extended MPI features



; YMF262 (OPL3) Sound Chip
                        ifndef YMF262_DEFS
                        include ymf262-defs.asm
                        endc

; UART A
MEGA_UARTA              equ $ff40
MEGA_UARTA_THR          equ MEGA_UARTA+0
MEGA_UARTA_IER          equ MEGA_UARTA+1
MEGA_UARTA_FCR          equ MEGA_UARTA+2
MEGA_UARTA_LCR          equ MEGA_UARTA+3
MEGA_UARTA_MCR          equ MEGA_UARTA+4
MEGA_UARTA_LSR          equ MEGA_UARTA+5
MEGA_UARTA_MSR          equ MEGA_UARTA+6
MEGA_UARTA_SPR          equ MEGA_UARTA+7
MEGA_UARTA_RESET        equ MEGA_UARTA+8
MEGA_UARTA_DATA_MSB     equ MEGA_UARTA+10
MEGA_UARTA_DATA_LSB     equ MEGA_UARTA+11

; UART B
MEGA_UARTB              equ $ff50
MEGA_UARTB_THR          equ MEGA_UARTB+0
MEGA_UARTB_IER          equ MEGA_UARTB+1
MEGA_UARTB_FCR          equ MEGA_UARTB+2
MEGA_UARTB_LCR          equ MEGA_UARTB+3
MEGA_UARTB_MCR          equ MEGA_UARTB+4
MEGA_UARTB_LSR          equ MEGA_UARTB+5
MEGA_UARTB_MSR          equ MEGA_UARTB+6
MEGA_UARTB_SPR          equ MEGA_UARTB+7
MEGA_UARTB_RESET        equ MEGA_UARTB+8
MEGA_UARTB_DATA_MSB     equ MEGA_UARTB+10
MEGA_UARTB_DATA_LSB     equ MEGA_UARTB+11

; Extended MPI features
MEGA_EXT_BASE           equ $ff40
MEGA_EXT_IRQ            equ MEGA_EXT_BASE   ;
                                            ; Bit 7 - Timer IRQ
                                            ; Bit 6 - UART B IRQ
                                            ; Bit 5 - UART A IRQ
                                            ; Bit 4 - YMF262 IRQ
                                            ; Bit 3 - Slot #4
                                            ; Bit 2 - Slot #3
                                            ; Bit 1 - Slot #2
                                            ; Bit 0 - Slot #1

MEGA_EXT_ACTIVE_IRQ     equ MEGA_EXT_BASE+1 ;
                                            ; Bit 7 - Timer
                                            ; Bit 6 - UART B
                                            ; Bit 5 - UART A
                                            ; Bit 4 - YMF262
                                            ; Bit 3 - Slot #4 - /Cart
                                            ; Bit 2 - Slot #3 - /Cart
                                            ; Bit 1 - Slot #2 - /Cart
                                            ; Bit 0 - Slot #1 - /Cart

MEGA_EXT_SOUND_SOURCE   equ MEGA_EXT_BASE+2 ;
                                            ; Bit    7 - Enable IRQ System
                                            ; Bit    6 - Enable Timer
                                            ; Bits 5:3 - n/a
                                            ; Bits 2:0 - Analog switch
                                            ;            000 - Slot #1
                                            ;            001 - Slot #2
                                            ;            010 - Slot #3
                                            ;            011 - Slot #4
                                            ;            100 - YMF262

MEGA_EXT_TIMER_MSB      equ MEGA_EXT_BASE+3 ;
MEGA_EXT_TIMER_LSB      equ MEGA_EXT_BASE+4 ;
MEGA_EXT_TIMER_RESET    equ MEGA_EXT_BASE+5 ;


; Enhanced IRQ management system (Used for MEGA_EXT_IRQ and MEGA_EXT_ACTIVE_IRQ)
MEGA_IRQ_SLOT1          equ %00000001       ; Slot #1 /cart signal
MEGA_IRQ_SLOT2          equ %00000010       ; Slot #2 /cart signal
MEGA_IRQ_SLOT3          equ %00000100       ; Slot #3 /cart signal
MEGA_IRQ_SLOT4          equ %00001000       ; Slot #4 /cart signal
MEGA_IRQ_YMF262         equ %00010000       ; YMF262
MEGA_IRQ_UARTA          equ %00100000       ; UART A IRQ
MEGA_IRQ_UARTB          equ %01000000       ; UART B IRQ
MEGA_IRQ_TIMER          equ %10000000       ; Timer IRQ


; Sound source select (analog switch) (Used for MEGA_EXT_EXTENDED)
MEGA_SOUND_SLOT0        equ %00000000       ; Analog Switch - Slot #1 (Default at startup)
MEGA_SOUND_SLOT1        equ %00000001       ; Analog Switch - Slot #2
MEGA_SOUND_SLOT2        equ %00000010       ; Analog Switch - Slot #3
MEGA_SOUND_SLOT3        equ %00000011       ; Analog Switch - Slot #4
MEGA_SOUND_YMF262       equ %00000100       ; Analog Switch - YMF262
MEGA_ENABLE_TIMER       equ %01000000       ; Enable Timer
MEGA_ENABLE_IRQ         equ %10000000       ; Enable IRQ System


MEGA_DEFS               equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
