	processor 6502

    include "vcs.h"
	include "macro.h"

	seg code
    org $F000

Start:
	CLEAN_START      ; call macro to safely clear RAM and TIA
StartFrame:
	lda #2           ; same as binary value %00000010
    sta VBLANK       ; turn on VBLANK
    sta VSYNC        ; turn on VSYNC

	sta WSYNC        ; first scanline
    sta WSYNC        ; second scanline
    sta WSYNC        ; third scanline

	lda #0
	sta VSYNC        ; turn off VSYNC
	ldx #37          ; X = 37 (to count 37 scanlines)
LoopVBlank:
	sta WSYNC        ; hit WSYNC and wait for the next scanline
	dex				 ; X--
    bne LoopVBlank   ; loop while X != 0

	lda #0
	sta VBLANK		 ; turn off VBLANK

	ldx #192		 ; counter for 192 visible scanlines
LoopVisible:
    stx COLUBK       ; set the background color
    sta WSYNC		 ; wait for the next scanline
	dex				 ; X--
	bne LoopVisible  ; loop while X != 0

	lda #2
	sta VBLANK       ; hit and turn on VBLANK again

	ldx #30			 ; counter for 30 scanlines
LoopOverscan:
	sta WSYNC		 ; wait for the next scanline
	dex				 ; X--
	bne	LoopOverscan ; loop while X != 0

	jmp StartFrame   ; go to next frame

	org $FFFC
	.word Start
	.word Start