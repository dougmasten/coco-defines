; boomerang-macros.asm

                        *pragmapush list    ; Save state of list pragma
                        pragma nolist       ; Turn off assembly listing and exclude from symbol list
                        ifndef BOOMERANG_MACROS  ; Load defines only once


; make sure defines are included
                        ifndef BOOMERANG_DEFS
                        include ../defines/boomerang-defs.asm
                        endc


enable_boomerang_magic  macro
                        lda BOOMERANG_MAGIC_1
                        lda BOOMERANG_MAGIC_2
                        lda BOOMERANG_MAGIC_3
                        lda BOOMERANG_MAGIC_4
                        lda BOOMERANG_MAGIC_5
                        lda BOOMERANG_MAGIC_6
                        endm


enable_boomerang_512k   macro
                        enable_boomerang_magic
                        lda BOOMERANG_512K
                        endm


enable_boomerang_2m     macro
                        enable_boomerang_magic
                        lda BOOMERANG_2M
                        endm


enable_boomerang_512k_turbo  macro
                        enable_boomerang_magic
                        lda BOOMERANG_512K_TURBO
                        endm


enable_boomerang_2m_turbo  macro
                        enable_boomerang_magic
                        lda BOOMERANG_2M_TURBO
                        endm


BOOMERANG_MACROS        equ 1               ; Set flag for defines being loaded
                        endc
                        *pragmapop list     ; restore assembly listing to previous state
