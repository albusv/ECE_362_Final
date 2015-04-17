;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, LCD_disp, RTIFLG,
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK,      ; symbol defined by the linker for the end of the stack
            
            ; LCD References
	        XREF init_LCD, display_string ;c functions

            ; Potentiometer References
	XREF read_pot, pot_value		;c function, returned global c variable
     XREF rtiSvc, initDispMsg, raw_count, sec_binary, menu_counter, dispPtrArray
     xref motor_direct, port_p, ddr_p, vtoi_flg, motor_cmd, motor_cnt_v, cmbt_flg, engine_start_flg
	xref motor_pos, mtr_cnt_trg_v, menu_flg, motor_cnt_f,  mtr_cnt_trg_f, throttle, temp_key, new_key_flg
	
	xref delayPWMMS, delayHexMS, port_u, ppsr_u, peru, ddr_u, port_s, ddr_s, initialNULL
     xref delayHexCount,  delayPWMCount, delayCount, pwm_on_time,  pwm_off_time, port_t_ddr, hexKeypad
; constants section
my_constants: SECTION
RTIE:         equ   $80
RTIFLG:       equ   $37
RTIENA:       equ   $38

; variable/data section
my_variable: SECTION
LCD_disp:			ds.b    $2
disp_data:			ds.w	$1



; code section
MyCode:     SECTION
Entry:
	  	lds		#__SEG_END_SSTACK
	  	jsr     	initDispMsg
	  	jsr	   	init_LCD				;initializes the LCD
        	movb    	#$60, RTICTL ;Init RTI to one 4 ms interval
        	movw   	#$0, raw_count   ;Init RTI count to zero
        	movw   	#$0, sec_binary  ;Init RTI binary count to zero
        	movb    	#$0, menu_counter  ;Init RTI menu counter to zero
		movb		#$ff, ddr_p		;init motor to output
		movb		#$0, menu_flg		;init menu flag
		movb    	#RTIE, RTIENA ;Enable RTI
        	movb		#$0,	motor_direct     ;motor_direction init (ccw)
        	movb		#$0, motor_cnt_v		;counter init to zero
        	movb		#$0, motor_cnt_f		;counter init to zero
        	movb		#$2, mtr_cnt_trg_v
        	movb		#$2, mtr_cnt_trg_f
        	ldd		#motor_cmd		  ;init motor position
        	addd		#$4
        	std		motor_pos		  ;init motor position
        	movb		#12, throttle
        	clr		cmbt_flg
        	clr		engine_start_flg
        	clr		new_key_flg
        	
        	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        	; pwm and keypad stuff
        	
        	ldd		#delayHexMS			;delay in ms
		ldy		#$3e8				;magnitude adjustment 10e3
		emul						;multiplication
		std		delayHexCount			;only care about 16 bits	
		ldd		#delayPWMMS	
		ldy		#$3e8				;magnitude adjustment 10e3
		emul						;multiplication
		std		delayPWMCount			;only care about 16 bits
		
		;initialization of ports
		bset	ddr_u,$f0			;for ddr_u
		bset	ppsr_u,$f0			;MSnibble polarity sel reg
		bset	peru,$0f			;enable pull up registers
		bclr	pwm_on_time, $ff	;initialNULL
		bset	port_t_ddr, #$8		;bit 3 to be an output
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
        
        
		;Password logic
        	
        		cli                 ;enable interrupt
men_disp:		ldaa			menu_flg
			beq			men_disp
			jsr			hexKeypad
			cmpa			#$ff
			bset			new_key_flg, #1
			beq			disp_cont
			staa			temp_key
disp_cont:	ldd			LCD_disp					;load d with char pointer
			jsr			display_string
			bra			men_disp


