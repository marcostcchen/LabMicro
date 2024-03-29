volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;
volatile unsigned int *TIMER0X = 0x101E200c;

int print_uart0(const char *s) {
   while(*s != '\0') { /* Loop until end of string */
   *UART0DR = (unsigned int)(*s); /* Transmit char */
   s++; /* Next char */
   }
return 0;
}
 
int handler() {
    *TIMER0X = 0;

    print_uart0("#");   
    return 0;
}

void handler_taskA() {
    int i = 0;
    while(i < 5000000) {
        print_uart0("0");
        i++;
    }
}

void handler_taskB() {
    int i = 0;
    while(i < 5000000) {
        print_uart0("1");
        i++;
    }
    i = 0;
}

int printSpaces() {
    print_uart0(" "); 
    return 0;  
}