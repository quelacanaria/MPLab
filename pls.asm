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
	btfss PORTC,2
	bra off
	bra rotate_led
check1 
	btfss PORTC,2
	bra off1
	bra rotate_ledR	
check2 
	btfss PORTC,2
	bra off2
	bra on	
check3 
	btfss PORTC,2
	bra off3
	bra off4	
rotate_led
	call delay0
	call delay0
	rlncf MYREG3,1
	movff MYREG3,PORTD
btfss PORTC,2
	bra check1
	bra check
rotate_ledR
	call delay0
	call delay0
	rrncf MYREG3,1
	movff MYREG3,PORTD
btfss PORTC,2
	bra check2
	bra check1
on 
setf PORTD
btfss PORTC,2
	bra check3
	bra check2
off	
	clrf PORTD
	call delay0
	bra check
off1	
	clrf PORTD
	call delay0
btfss PORTC,2
	bra off1
	bra check1
off2	
	clrf PORTD
	call delay0
btfss PORTC,2
	bra off2
	bra check2
off3	
	clrf PORTD
	call delay0
btfss PORTC,2
	bra off3
	bra check3
off4
	clrf PORTD
	call delay0
btfss PORTC,2
	bra check
	bra check3
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