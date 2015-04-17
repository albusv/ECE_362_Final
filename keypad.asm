;*****************************************************
;* -This file is designed to be used in conjunction
;* 		with a project that handles port initialization.
;* - This file does not handle port initialization.
;* - This file does not handle setting the delay
;* - This file will return the depressed key value
;* - to the calling scope in Acc A.
;* - This file will return FF in Acc A if nothing found.
;*****************************************************






		XDEF		hexKeypad
		XREF		dlyLoopMS, delayHexCount, delayCount

MY_CONSTANTS: SECTION

port_u:		equ		$268		
table_Max:	equ		$10
keyARR_Max:	equ		$4
keyARR:		dc.b		$70,$b0,$d0,$e0
keyLookup:	dc.b		$77,$7b,$7d,$7e,$b7,$bb,$bd,$be
			dc.b		$d7,$db,$dd,$de,$e7,$eb,$ed,$ee
symbl_tbl:	dc.b		$1,$2,$3,$c,$4,$5,$6,$d
			dc.b		$7,$8,$9,$e,$a,$0,$b,$f
		
		
MyCode: SECTION

hexKeypad:
		pshc
		sei
		pshb
		pshx
		ldx			#delayHexCount
		stx			delayCount
start:	jsr			dlyLoopMS		;saves logic after "send" to delay here
		ldx			#keyARR		;store our pointer in X
		ldab			#$0			;initialize counter
loop:	ldaa			b,x			;to read LSnibble   
		incb						;inc counter
		staa			port_u		;store column mask to keypad
		jsr			dlyLoopMS		;delay subroutine
		ldaa			port_u		;load raw port u
		jsr			hexLookup		;lookup read value in acc A
		cmpa			#$ff		
		bne			good_val		;if data found
		cmpb			#keyARR_Max	;compare cnt to MAX keypad rows
		beq			no_val		;if count is maxed, reinitialize
		bra			loop			;else loop back to reread

good_val:							;good data will be returned in a
		ldx			#symbl_tbl
		ldaa			a, x
no_val:
		pulx						;b and x will be preserved from the
		pulb						;calling scope
		pulc
		rts



hexLookup: 						;acc A contains useful data
		pshx						;preserve our pointer
		pshb						;preserve the counter
		ldx			#keyLookup	;initialize the pointer
		ldab			#$0			;initialize counter
loop_h:	cmpa			b,x			;compare against table element
		beq			found		;if found, bra to found
		incb						;increment count
		cmpb			#table_Max	;b < table Max
		beq			nofind		;exit loop
		bra			loop_h		;if b < tableMax, loop again
nofind:	ldaa			#$ff			;not found NULL value
		bra			done			;exit
found:	tba						;return index
done:	pulb						;preserve the counter
		pulx						;preserve the pointer
		rts						;exit




