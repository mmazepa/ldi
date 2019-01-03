chan k = [0] of { bit };

proctype P () {
    // producent
    bit b;
    do
    :: select(b : 0 .. 1); printf("wyprodukowałem %d\n", b); k!b;
    od
}

proctype C() {
    // konsument
    bit b;
    do
    :: k?b; printf("dostałem %d\n", b);
    od
}

init {
    run P();
    run C();
}