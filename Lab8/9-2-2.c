#include <stdio.h>

int mostra = 0;

void imprime(int N) {
  if (N<0) {
    return;
  }
  printf("numero = %d\n", N);
  imprime(N-1);
}

int main() {

__asm__( 
 "ldr r0, =mostra\n\t"
 "ldr r1, #1\n\t"
 "str r1,[r0]\n\t"
 );

imprime(mostra);
   
   return 0;
}


