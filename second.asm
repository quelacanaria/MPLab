#include <p18f4550.inc>

start
    setf TRISC            ; Set PORTC as input
    clrf TRISD            ; Set PORTD as output
    clrf PORTC            ; Clear PORTC
    clrf PORTD            ; Clear PORTD

    MYREG EQU 0x08        ; Define register MYREG at 0x08
    MYREG2 EQU 0x18       ; Define register MYREG2 at 0x18
    MYREG3 EQU 0x36       ; Define register MYREG3 at 0x36
    STATE EQU 0x20        ; Define state register at 0x20
    BUTTON_PREV EQU 0x21  ; Define previous button state register at 0x21

    clrf STATE            ; Clear the state register
    clrf BUTTON_PREV      ; Clear the previous button state register

    movlw 0x01            ; Load 0x01 into WREG
    movwf MYREG3          ; Move WREG to MYREG3

check
    btfsc PORTC,1         ; Check if button is not pressed
    bra button_not_pressed

    movlw 0x01            ; Load 0x01 into WREG
    xorwf BUTTON_PREV, W  ; Compare with previous button state
    btfsc STATUS, Z       ; Skip if the button state has not changed
    bra check             ; Check again

    ; Button press detected
    incf STATE, F         ; Increment the state
    movlw 0x04            ; Load 4 into WREG
    movwf MYREG           ; Load 4 into MYREG
    movf STATE, W         ; Move state to WREG
    subwf MYREG, W        ; Subtract MYREG from WREG
    btfss STATUS, Z       ; Skip if state < 4
    clrf STATE            ; Reset state to 0 if it reached 4

    movlw 0x01            ; Load 0x01 into WREG
    movwf BUTTON_PREV     ; Update previous button state

button_not_pressed
    ; State machine
    movf STATE, W
    addlw -1              ; Subtract 1 from WREG
    btfsc STATUS, Z       ; If STATE == 1
    bra rotate_led
    addlw -1              ; Subtract 2 from WREG
    btfsc STATUS, Z       ; If STATE == 2
    bra rotate_ledR
    addlw -1              ; Subtract 3 from WREG
    btfsc STATUS, Z       ; If STATE == 3
    bra on
    bra off               ; Default case (STATE == 0)

rotate_led
    call delay0           ; Call delay0 subroutine
    call delay0           ; Call delay0 subroutine again
    rlncf MYREG3, F       ; Rotate MYREG3 left through carry
    movff MYREG3, PORTD   ; Move MYREG3 to PORTD
    bra check             ; Branch back to check

rotate_ledR
    call delay0           ; Call delay0 subroutine
    call delay0           ; Call delay0 subroutine again
    rrncf MYREG3, F       ; Rotate MYREG3 right through carry
    movff MYREG3, PORTD   ; Move MYREG3 to PORTD
    bra check             ; Branch back to check

on
    setf PORTD            ; Set PORTD (turn on all LEDs)
    bra check             ; Branch back to check

off
    clrf PORTD            ; Clear PORTD (turn off all LEDs)
    call delay0           ; Call delay0 subroutine
    bra check             ; Branch back to check

delay0
    movlw 0xff            ; Load 0xff into WREG
    movwf MYREG2          ; Move WREG to MYREG2
again0
    call delay            ; Call delay subroutine
    decf MYREG2, F        ; Decrement MYREG2
    bnz again0            ; If MYREG2 is not zero, loop again
    return                ; Return from subroutine

delay
    movlw 0xff            ; Load 0xff into WREG
    movwf MYREG           ; Move WREG to MYREG
again
    nop                   ; No operation (NOP) for delay
    nop                   ; No operation (NOP) for delay
    decf MYREG, F         ; Decrement MYREG
    bnz again             ; If MYREG is not zero, loop again
    return                ; Return from subroutine

end                       ; End of program
