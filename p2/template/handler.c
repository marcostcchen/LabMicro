volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;

void print_uart0(const char *s) {
 while(*s != '\0') { /* Loop until end of string */
 *UART0DR = (unsigned int)(*s); /* Transmit char */
 s++; /* Next char */
 }
}

void hello_word() {
 print_uart0("Hello world!\n");
}

void imprimeHash(){
  print_uart0("#");
}

void imprime1(){
  print_uart0("1");
  int i = 0;
  while(i<1000000){
    i++;
  }
}

void imprime2(){
  print_uart0("2");
  int i = 0;
  while(i<1000000){
    i++;
  }
}
