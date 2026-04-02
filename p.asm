#include<p18f4550.inc>
start setf TRISC
	clrf TRISD
	clrf PORTC
	clrf PORTD
	MYREG EQU 0x08
	MYREG2 EQU 0x18
	MYREG3 EQU 0x36
	movlw 0x01
	movwf MYREG3
check 
	btfss PORTC,1
	bra on
	bra rotate_led2
	
rotate_led
	call delay0
	call delay0
	rlncf MYREG3,1
	movff MYREG3,PORTD
	bra check
rotate_led2
	call delay0
	call delay0
	rrncf MYREG3,1
	movff MYREG3,PORTD
	bra check
off	
	clrf PORTD
	call delay0
	bra check
on
	setf PORTD
	call delay0
	bra check

delay0 	
		movlw 0xff
		movwf MYREG2
again0 
		call delay
		Decf MYREG2,F
		BNZ again0
		RETURN
delay 
		movlw 0xff
		movwf MYREG
again
	nop
	nop
decf MYREG,F
BNZ again
RETURN
end