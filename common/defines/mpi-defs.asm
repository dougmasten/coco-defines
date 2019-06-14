; mpi-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef MPI_DEFS     ; Load defines only once


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


MPI_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
