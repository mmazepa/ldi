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

proctype Swap(int index) {
    byte tmp;
    atomic {
        tmp = a[index];
        a[index] = a[index+1];
        a[index+1] = tmp;
    }
}

proctype Straznik(int index) {
    do
    :: (a[index] > a[index+1]) -> run Swap(index);
    :: timeout -> break;
    od;
}

init {
    int i = 0;
    run Losowanie();

    // sortowanie tablicy
    _nr_pr == 1;
    for (i : 0 .. DIM - 2) {
        run Straznik(i);
    }

    // wypisanie tablicy
    _nr_pr == 1;
    printf("a[] = ");
    for (i : 0 .. DIM - 1) {
        printf("%d", a[i]);
    }
    printf("\n");
}