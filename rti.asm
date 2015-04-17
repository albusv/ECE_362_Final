;this will be the RTI file


	   xdef motor_direct, port_p, ddr_p, motor_cnt_v, motor_cmd, vtoi_flg, motor_pos
        xdef mtr_cnt_trg_v, menu_flg, motor_cnt_f, mtr_cnt_trg_f, throttle, engine_start_flg 
        xdef rtiSvc, raw_count, sec_binary, menu_counter, cmbt_flg, temp_key, new_key_flg
        xdef delayPWMMS, delayHexMS, port_u, ppsr_u, peru, ddr_u, port_s, ddr_s, initialNULL
        xdef delayHexCount,  delayPWMCount, delayCount, pwm_on_time,  pwm_off_time, port_t_ddr
        
        xref RTIFLG, dispPtrArray, LCD_disp, hexKeypad
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
My_constants: section

motor_cmd:		dc.b		$0,$0a,$12,$14,$0c,$0
port_p:			equ		$258
ddr_p:			equ		$25a
port_t:			equ		$240
delayHexMS:		equ		$1
delayPWMMS:		equ		$4
port_u:			equ		$268
ppsr_u:			equ		$26d
peru:			equ		$26c
ddr_u:			equ		$26a
port_s:			equ		$248
ddr_s:			equ		$24a
port_t_ddr:		equ		$242
initialNULL:		equ		$ff

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
My_variable: section

delayHexCount:		ds.w		$1			;XDEF'd for delay subroutine
delayPWMCount:		ds.w		$1
delayCount:		ds.w		$1
pwm_on_time:		ds.b		$1		;
pwm_off_time:		ds.b		$1		;
raw_count:    		ds.w   	1
sec_binary:  		ds.w   	1
menu_counter: 		ds.b   	1
motor_direct:		ds.b		1	    ; 1 for clockwise, 0 CCW
motor_pos:		ds.w		1		;pointer
motor_cnt_v:		ds.b		1
mtr_cnt_trg_v:		ds.b		1
motor_cnt_f:		ds.b		1
mtr_cnt_trg_f		ds.b		1

temp_key:			ds.b		1

throttle:			ds.b		1		;throttle % controls mtr_cnt_trgt


vtoi_flg:			ds.b		1
menu_flg:			ds.b		1	 	
missile_flg:		ds.b		1		;true for missile, false for machine gun
refuel_flg:		ds.b		1		;true for refuel mode
reload_flg:		ds.b		1		;true for reload cmd
eng_pwr_flg:		ds.b		1		;true for power on
flare_flg:		ds.b		1		;true for flare cmd
cmbt_flg:			ds.b		1		;true for combat mode
engine_start_flg:	ds.b		1		;true for start occurred (push button)
d_thrtl_flg:		ds.b		1		;change throttle flag (toggled true in menu)
new_key_flg		ds.b		1		;true for keypad returning non $ff value

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
My_code: section

rtiSvc:
			;counter updates			
			inc		motor_cnt_v
			inc		motor_cnt_f	

			;switch updates			
			ldaa		port_t
			anda		#$1
			staa		eng_pwr_flg
			
			ldaa		port_t
			anda		#$2			; missiles or machine gun
			staa		missile_flg
			
			ldaa		port_t
			anda		#$4			;reload
			staa		reload_flg
			
			ldaa		port_t	
			anda		#$8			 ;refuel
			staa		refuel_flg	

			ldaa		port_t
			anda		#$20			;deploy flare
			staa		flare_flg	
			
			ldaa		port_t
			anda		#$40			 ; menu/ hud
			staa		menu_flg
			
			ldaa		port_t
			anda		#$80
			staa		vtoi_flg		;vtoi mode
			
			
			;think of this as rti main, anything above is "init" logic
			
			; mode determination
;for testing			ldaa		engine_start_flg  		;this comes from the push button
;for testing			beq		menu_disp			;can't do anything without engine start
			ldaa		cmbt_flg
			beq		no_cmbat
			jmp		cmbt_mode			 ; if not combat, then menu/ vtoi/ flight	
no_cmbat:		ldaa		vtoi_flg
			bne		vtoi_mode
			bra		flt_mode 			;else we're in flight mode

vtoi_mode:	ldaa		eng_pwr_flg
			beq		menu_disp
			
;			jsr		hexKeypad			;update throttle
			
			
			ldab		#25
			subb		throttle  ; 25 - throttle
			ldaa		#3
			mul		 				; count target = (25-throttle)*3
			stab		mtr_cnt_trg_v
			subb		motor_cnt_v
			bne		menu_disp
			clr		motor_cnt_v	;time to spin motor		
			
;			ldab		motor_cnt_v	;check against desired count (speed)
;			cmpb		mtr_cnt_trg_v
;			beq		spin_mtr_v	;execute spin
;			bra		menu_disp
spin_mtr_v:	ldx		motor_pos
			ldaa		1, x-
			beq		rst_motor_v			;if zero, reset
			staa		port_p
			stx		motor_pos
			jmp		exitISR
rst_motor_v:	ldx		#motor_cmd
			ldab		#$4
			abx
			stx		motor_pos
			bra		menu_disp	          

flt_mode:		ldaa		eng_pwr_flg
			beq		menu_disp
			
			ldaa		throttle		;load up the throttle
			cmpa		#24
			bhi		dcflt	; branch if higher than 24%
		
			; for stepper motor
			; 12 ms or every 3 runs (counter == counter+=3)
			; per every percentage of throttle for the stepper motor
			
			;acca has throttle in it
			ldaa		d_thrtl_flg
			beq		spin_decision
			;counter target = (25 - throttle) * 3
chg_thrtl:	ldaa		new_key_flg
			beq		spin_decision
			movb		temp_key, throttle
			ldab		#25	   	;loads b and clears a
			subb		throttle  ; 25 - throttle
			ldaa		#3
			mul
			stab		mtr_cnt_trg_f
			clr		d_thrtl_flg		;clear throttle update flag
			clr		new_key_flg
spin_decision:	ldab		mtr_cnt_trg_f		;necessary
			subb		motor_cnt_f
			bhi		menu_disp
			clr		motor_cnt_f	;time to spin motor

spin_mtr_f:	ldx		motor_pos
			ldaa		1, x+
			beq		rst_motor_f			;if zero, reset
			staa		port_p
			stx		motor_pos
			bra		exitISR
rst_motor_f:	ldx		#motor_cmd
			inx		
			stx		motor_pos
			bra		menu_disp
			
			
			

dcflt:		;power the dc motor with appropriate duty cycle based on throttle

cmbt_mode:				
            
menu_disp:  	ldaa		menu_flg
			beq		exitISR

;			JOEL STEFAN the keypad is slowing us down considerably

;			jsr		hexKeypad 			;hexKeypad returns ff for no value in acc A
			cmpa		#$ff					;null key read value
			beq		menu_cont
			;staa		temp_key
			;cmpa
			cmpa		#$6
			beq		thrust_mode			;thrust 6
			cmpa		#$7
			beq		time_mode
			cmpa		#$a
			beq		psswrd_mode
			cmpa		#$b
			beq		repair_mode
			cmpa		#$f	;JOEL STEFAN this is "back" logic for menus
						
menu_cont:	ldd   	raw_count               
            	addd    	#$1					; cant just do inc raw_count
            	std     	raw_count				; becasue raw_count is 16 bits
            	cpd     	#500  				;equal 2 seconds?
           	blo     	exitISR
           	ldx     	#0 					;reset to 0 if = 1 sec
           	stx     	raw_count
	          ldd     	sec_binary
     	     addd    	#$2
           	std     	sec_binary
           	ldx     	#dispPtrArray
           	ldab    	menu_counter
           	abx                   			;effective address formed
           	ldy     	0,x
           	sty     	LCD_disp
           	addb    	#$2                		;mult by 2 for 2 bytes/ address
           	stab    	menu_counter
           	cmpb    	#18            
           	blo     	exitISR
           	movb    	#$0, menu_counter
exitISR:   	bset    	RTIFLG, $80     		;CLEAR ENABLE AT RTI REGISTER
           	rti           	

thrust_mode:
		 	; i think we might need a "change throttle" flag
		 	; otherwise, we're gonna be calculating a new throttle
		 	; every interrupt, which means polling the keypad. we don't want that.
		 	bra		exitISR
time_mode:
			bra		exitISR
psswrd_mode:
			bra		exitISR
repair_mode:
			bra		exitISR
