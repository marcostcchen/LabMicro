volatile unsigned int *TIMER0X = 0x101E200c;
 

void handler_timer()
{
    *TIMER0X = 0;
}