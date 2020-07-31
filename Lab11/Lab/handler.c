volatile unsigned int * const TIMER0X = (unsigned int *)0x101E200c;
volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;
 
void print_uart0(const char *s) {
    while(*s != '\0') { /* Loop until end of string */
        *UART0DR = (unsigned int)(*s); /* Transmit char */
        s++; /* Next char */
    }
}
 
void c_entry() {
    print_uart0("Hello world!\n");
}

void print_hash(){
    *TIMER0X = 0;
    print_uart0("#");
    return;
}

void print_space() {
	print_uart0(" ");
}

void print_1() {
    int i = 0;
    while (1) {
        print_uart0("1");
        while(i < 100000) {
            i++;
        }
        i = 0;
    }
}

void print_2() {
    int i = 0;
    while (1) {
        print_uart0("2");
        while(i < 100000) {
            i++;
        }
        i = 0;
    }
}

