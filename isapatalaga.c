#include<p18f4550.h>
#define led PORTDbits.RD4
		
void main()
	{
			TRISC=0X00;
			while(1)
			{
			led=1;	
			}
	}