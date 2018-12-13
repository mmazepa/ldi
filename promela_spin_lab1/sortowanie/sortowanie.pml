#define MAX 5
#define DIM 5
byte a[DIM];

proctype Losowanie() {
    int i = 0;
    for (i : 0 .. DIM - 1) {
        // wypełnianie tablicy
        byte b;
        select(b : 1 .. MAX);
        a[i] = b;
    }
}

proctype Straznik(int index) {
    byte tmp;
    do
    :: (a[index] > a[index+1]) -> tmp = a[index]; a[index] = a[index+1]; a[index+1] = a[index];
    od;
}

init {
    run Losowanie();

    // sortowanie tablicy
    // run Straznik(0);
    // run Straznik(1);
    // run Straznik(2);
    // run Straznik(3);

    // wypisanie tablicy
    int i = 0;
    _nr_pr == 1;
    printf("a[] = ");
    for (i : 0 .. DIM - 1) {
        printf("%d", a[i]);
    }
    printf("\n");
}