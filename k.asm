#include<p18f4550.inc>
org 0x00
goto start
org 0x08
retfie
org 0x18
retfie

start	setf TRISC,A
		clrf TRISD,A
		clrf PORTC
		clrf PORTD
check btfss PORTC,1,A
		bra off
		bra on_led
on_led	setf PORTD
		bra check
off		clrf PORTD
		bra check
		end