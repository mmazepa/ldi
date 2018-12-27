#define MAX 5
#define DIM 5
byte a[DIM];
bool posortowane = false;

proctype Losowanie() {
    // wypełnianie tablicy
    int i = 0;
    do
    :: i < DIM ->
        byte b;
        select(b : 1 .. MAX);
        a[i] = b;
        i = i + 1;
    :: else -> break;
    od;
}

proctype Straznik(int index) {
    byte tmp;
    do
    :: (a[index] > a[index + 1]) ->
        atomic {
            tmp = a[index];
            a[index] = a[index + 1];
            a[index + 1] = tmp;
        }
    :: posortowane -> break;
    od;
}

proctype SprawdzSort() {
    timeout -> posortowane = true;
}

init {
    int i = 0;

    run Losowanie();
    _nr_pr == 1; // aktywny tylko 1 proces

    // sortowanie tablicy
    atomic {
        run SprawdzSort();
        for (i : 0 .. DIM - 2) {
            run Straznik(i);
        }
    }
    _nr_pr == 1; // aktywny tylko 1 proces

    // asercja
    for (i : 0 .. DIM - 2) {
        assert(a[i] <= a[i + 1]);
    }

    // wypisanie tablicy
    printf("a[] = ");
    for (i : 0 .. DIM - 1) {
        printf("%d", a[i]);
    }
    printf("\n");
}