mtype = {PLN2, PLN5, MILK, DARK}

chan kanal_zakup = [0] of { byte }

proctype Klient() {
    mtype batonik;
    
    do
    :: kanal_zakup!PLN2; printf("-------\n[KLIENT]: zapłaciłem 2zł\n", PLN2);
    :: kanal_zakup!PLN5; printf("-------\n[KLIENT]: zapłaciłem 5zł\n", PLN5);
    :: kanal_zakup?batonik;
        if
        :: batonik -> printf("[KLIENT]: uzyskałem %e\n", batonik);
        fi
    od
}

proctype Maszyna(byte ileM; byte ileC) {
    mtype zaplata;
    mtype batonik;

    do
    :: atomic {
            kanal_zakup?zaplata;
            if
            :: zaplata == PLN2 -> batonik = MILK;
            :: zaplata == PLN5 -> batonik = DARK;
            fi
            printf("[MASZYNA]: zapłacono %e, wypuszczam %e\n", zaplata, batonik);
            kanal_zakup!batonik;
        }
    od
}

init {
    run Klient();
    run Maszyna(10, 10);
}