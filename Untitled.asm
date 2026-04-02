#include<p18f4550.inc>

start 
    setf TRISC
    clrf TRISD
    clrf PORTC
    clrf PORTD
    clrf COUNTER

MYREG EQU 0x08
MYREG2 EQU 0x18
MYREG3 EQU 0x36
COUNTER EQU 0x20

movlw 0x01
movwf MYREG3

main_loop
    incf COUNTER,F
    movf COUNTER,W
    andlw 0x01
    btfsc STATUS,Z
    bra rotate_led
    bra off

rotate_led
    call delay0
    call delay0
    rlncf MYREG3,1
    movff MYREG3,PORTD
    bra main_loop

off
    clrf PORTD
    call delay0
    bra main_loop

delay0
    movlw 0xff
    movwf MYREG2
again0
    call delay
    decf MYREG2,F
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
