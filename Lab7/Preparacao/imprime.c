void imprime(N) {
    if(N<0) {
        return;
    }
    printf("numero = %d", N);
    imprime(N-1);
}

int main (void ) {
    imprime(5);
}