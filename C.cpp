#include <xc.h>

// Configuration bits
#pragma config FOSC = HSPLL_HS
#pragma config WDT = OFF
#pragma config LVP = OFF
#pragma config PBADEN = OFF

// Define constants
#define MYREG  0x08
#define MYREG2 0x18
#define MYREG3 0x36

// Function prototypes
void delay0(void);
void delay(void);

void main(void) {
    TRISC = 0xFF; // Set PORTC as input
    TRISD = 0x00; // Set PORTD as output
    PORTC = 0x00; // Clear PORTC
    PORTD = 0x00; // Clear PORTD

    unsigned char MYREG3 = 0x01;

    while (1) {
        if (PORTCbits.RC1 == 0) {
            // If RC1 is low, turn off LEDs and wait
            PORTD = 0x00;
            delay0();
        } else {
            // Rotate the LEDs on PORTD
            delay0();
            delay0();
            MYREG3 = (MYREG3 << 1) | (MYREG3 >> 7); // Rotate left
            PORTD = MYREG3;
        }
    }
}

void delay0(void) {
    unsigned char MYREG2 = 0xFF;
    while (MYREG2--) {
        delay();
    }
}

void delay(void) {
    unsigned char MYREG = 0xFF;
    while (MYREG--) {
        __nop(); // No operation
        __nop(); // No operation
    }
}
