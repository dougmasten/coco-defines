; fdc-defs.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef FDC_DEFS     ; Load defines only once


; Floppy Disk Controller
FDC_CTRL_REG           equ $ff40            ; Floppy Disk Controller                                    (Write Only)
                                            ; Bit 7 - Halt flag: 0=disabled, 1=enabled
                                            ; Bit 6 - Drive select 3
                                            ; Bit 5 - Density flag: 0=single, 1=double
                                            ; Bit 4 - Write precompensation: 0=no precomp, 1=precomp
                                            ; Bit 3 - Drive motor enable: 0=motors off, 1=motors on
                                            ; Bit 2 - Drive select 2
                                            ; Bit 1 - Drive select 1
                                            ; Bit 0 - Drive select 0
FDC_COMMAND_REG        equ $ff48            ; Floppy status/command register for disk controller
FDC_TRACK_REG          equ $ff49            ; Floppy disk controller track register
FDC_SECTOR_REG         equ $ff4a            ; Floppy disk controller sector register
FDC_DATA_REG           equ $ff4b            ; Floppy disk controller data register


FDC_DEFS                equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
