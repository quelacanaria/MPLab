#include<P18f4550.h>
char call[]="Hello";
int i,x;
void data(char call)
{
TXREG=call;
while(PIR1bits.TXIF==0);
PIR1bits.TXIF=0;
}
void main()
{
TXSTA=0X20;
SPBRG=12;
TXSTAbits.TXEN=0XFF;
RCSTAbits.SPEN=0xFF;
for(i=0;i<6;i++)
{
x = call[i];
data(x);
}}