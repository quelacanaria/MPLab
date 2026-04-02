#include<p18f4550.inc>
 #pragma config PLLDIV = 1      
#pragma config CPUDIV = OSC1_PLL2
#pragma config USBDIV = 1       

#pragma config FOSC = INTOSCIO_EC
#pragma config FCMEN = OFF    
#pragma config IESO = OFF      

#pragma config PWRT = OFF       // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOR = OFF        // Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
#pragma config BORV = 3         // Brown-out Reset Voltage bits (Minimum setting 2.05V)
#pragma config VREGEN = OFF     // USB Voltage Regulator Enable bit (USB voltage regulator disabled)

// CONFIG2H
#pragma config WDT = OFF        // Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
#pragma config WDTPS = 32768    // Watchdog Timer Postscale Select bits (1:32768)

// CONFIG3H
#pragma config CCP2MX = ON      // CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
#pragma config PBADEN = OFF     // PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
#pragma config LPT1OSC = OFF    // Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
#pragma config MCLRE = ON       // MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

// CONFIG4L
#pragma config STVREN = ON      // Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
#pragma config LVP = OFF        // Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
#pragma config ICPRT = OFF      // Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
#pragma config XINST = OFF      // Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

// CONFIG5L
#pragma config CP0 = OFF        // Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
#pragma config CP1 = OFF        // Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
#pragma config CP2 = OFF        // Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
#pragma config CP3 = OFF        // Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

// CONFIG5H
#pragma config CPB = OFF        // Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
#pragma config CPD = OFF        // Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

// CONFIG6L
#pragma config WRT0 = OFF       // Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
#pragma config WRT1 = OFF       // Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
#pragma config WRT2 = OFF       // Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
#pragma config WRT3 = OFF       // Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

// CONFIG6H
#pragma config WRTC = OFF       
#pragma config WRTB = OFF       
#pragma config WRTD = OFF       

// CONFIG7L
#pragma config EBTR0 = OFF     
#pragma config EBTR1 = OFF      
#pragma config EBTR2 = OFF      
#pragma config EBTR3 = OFF      
#pragma config EBTRB = OFF    
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
btfss PORTC,3
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