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
	btfss RC0,1	
	bra off
	bra rotate_led
	
rotate_led
	call delay0
	call delay0
	rlncf MYREG3,1
	movff MYREG3,PORTD
	bra check
rotate_ledR
	call delay0
	call delay0
	rrncf MYREG3,1
	movff MYREG3,PORTD
	bra check
on 
	setf PORTD
	bra check
off	
	clrf PORTD
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