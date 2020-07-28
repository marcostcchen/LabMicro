volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;

int print_uart0(const char *s) {
   while(*s != '\0') { /* Loop until end of string */
   *UART0DR = (unsigned int)(*s); /* Transmit char */
   s++; /* Next char */
   }
return 0;
}
 
int handler() {
    int *TIMER0X;
    TIMER0X = 0x101E200c;
    *TIMER0X = 0;

    print_uart0("#");   
    return 0;
}

int printSpaces() {
    print_uart0(" "); 
    return 0;  
}