	processor 6502

    	include "vcs.h"
	include "macro.h"

	seg code
    	org $F000

Start:
	CLEAN_START 
StartFrame:
	lda #2           
    	sta VBLANK       
    	sta VSYNC        

	sta WSYNC        
	sta WSYNC        
    	sta WSYNC        

	lda #0
	sta VSYNC        
	ldx #37          
LoopVBlank:
	sta WSYNC        
	dex				
    	bne LoopVBlank   

	lda #0
	sta VBLANK		

	ldx #192
LoopVisible:
    	stx COLUBK   
    	sta WSYNC	
	dex	
	bne LoopVisible 

	lda #2
	sta VBLANK     

	ldx #30		
LoopOverscan:
	sta WSYNC
	dex	
	bne

	jmp StartFrame 

	org $FFFC
	.word Start
	.word Start
