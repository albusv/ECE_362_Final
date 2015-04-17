		XDEF dlyLoopMS,
		XREF delayCount,

dlyLoopMS:	
		pshc				;preserve registers (2 cycles)
		pshx				;preserve registers (2 cycles)
		sei
		ldx		delayCount		;delay in ms (2 cycles)
DELAY:	dex				;dec x (1 cycle)
		bne		DELAY			;(3 cycles up, 1 down)
		pulx				;preserve registers (3 cycles)
		pulc				;preserve registers (3 cycles)
		rts				;return from subroutine
