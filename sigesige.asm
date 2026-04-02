    #include <p16f877A.inc>

    ; Define registers
    MYREG EQU 0x08
    MYREG2 EQU 0x18
    MYREG3 EQU 0x36

    ; Configuration
    __CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _HS_OSC

    ; Start of the program
    ORG 0x00
start
    bsf STATUS, RP0    ; Bank 1
    clrf TRISC         ; Set TRISC to all outputs
    clrf TRISD         ; Set TRISD to all outputs
    bcf STATUS, RP0    ; Bank 0
    clrf PORTC         ; Clear PORTC
    clrf PORTD         ; Clear PORTD
    movlw 0x01
    movwf MYREG3       ; Initialize MYREG3 with 0x01

check
    btfss PORTC, 2
    goto off
    goto rotate_led

check1
    btfss PORTC, 2
    goto off1
    goto rotate_ledR

check2
    btfss PORTC, 2
    goto off2
    goto on

check3
    btfss PORTC, 2
    goto off3
    goto off4

rotate_led
    call delay0
    call delay0
    rlf MYREG3, F      ; Rotate left MYREG3
    movf MYREG3, W
    movwf PORTD
    btfss PORTC, 2
    goto check1
    goto check

rotate_ledR
    call delay0
    call delay0
    rrf MYREG3, F      ; Rotate right MYREG3
    movf MYREG3, W
    movwf PORTD
    btfss PORTC, 2
    goto check2
    goto check1

on
    movlw 0xFF
    movwf PORTD        ; Set all bits of PORTD
    btfss PORTC, 2
    goto check3
    goto check2

off
    clrf PORTD         ; Clear PORTD
    call delay0
    goto check

off1
    clrf PORTD
    call delay0
    btfss PORTC, 2
    goto off1
    goto check1

off2
    clrf PORTD
    call delay0
    btfss PORTC, 2
    goto off2
    goto check2

off3
    clrf PORTD
    call delay0
    btfss PORTC, 2
    goto off3
    goto check3

off4
    clrf PORTD
    call delay0
    btfss PORTC, 2
    goto check
    goto check3

delay0
    movlw 0xFF
    movwf MYREG2
again0
    call delay
    decfsz MYREG2, F
    goto again0
    return

delay
    movlw 0xFF
    movwf MYREG
again
    nop
    nop
    decfsz MYREG, F
    goto again
    return

    END
