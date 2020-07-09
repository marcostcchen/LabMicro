#include <stdio.h>

void imprime(N) {
  if (N<0) {
    return;
  }
  char str[16];
  int2str(N, str);
  puts(str);
  imprime(N-1);
}

int main(void ) {
     imprime(9833065);
}
