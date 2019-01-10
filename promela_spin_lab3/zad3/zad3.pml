mtype = {PLN2, PLN5, MILK, DARK}
bool koniec = false;

byte ileM = 10;
byte ileC = 10;

chan kanal_zakup = [0] of { byte }

active proctype Klient() {
    mtype batonik;
    bool mleczne = true;
    bool gorzkie = true;
    
    do
    :: mleczne ->
        dwojkaWrzucona: skip;
        kanal_zakup!PLN2;
        printf("[KLIENT]: zapłaciłem PLN2\n");
    :: gorzkie ->
        piatkaWrzucona: skip;
        kanal_zakup!PLN5;
        printf("[KLIENT]: zapłaciłem PLN5\n");
    :: kanal_zakup?batonik ->
        if
        :: batonik -> printf("[KLIENT]: uzyskałem %e\n", batonik);
            if
            :: batonik == MILK ->
                mniamMniam2: skip;
            :: batonik == DARK ->
                mniamMniam5: skip;
            :: batonik == PLN2 ->
                buuu2: mleczne = false;
                printf("[KLIENT]: oddało mi PLN2, nie ma więcej MILK\n");
            :: batonik == PLN5 ->
                buuu5: gorzkie = false;
                printf("[KLIENT]: oddało mi PLN5, nie ma więcej DARK\n");
            fi
        fi
    :: koniec -> break;
    od
}

active proctype Maszyna() {
    mtype zaplata;

    do
    :: kanal_zakup?zaplata -> atomic {
            if
            :: (ileM > 0 && zaplata == PLN2) -> ileM--; kanal_zakup!MILK;
            :: (ileC > 0 && zaplata == PLN5) -> ileC--; kanal_zakup!DARK;
            :: else -> kanal_zakup!zaplata;
            fi
        }
    :: koniec -> break;
    od
}

active proctype Straznik() {
    timeout -> koniec = true;
}

// init {
//     run Klient();
//     run Maszyna();
//     run Straznik();
// }

// P@etykieta
// kiedyś po wrzuceniu PLN2 dostanę PLN2 od maszyny
// kiedyś po wrzuceniu PLN5 dostanę PLN5 od maszyny
ltl WszystkoCoDobreKiedysSieKonczy {
    <> (Klient@dwojkaWrzucona & Klient@buuu2)
}

// jak wrzucę PLN2 to dostanę ją lub batonik MILK
// ...
// jak wrzucę PLN5 to dostanę ją lub batonik DARK
// ...

ltl Prop1 { [] true }
ltl KasaSieZgadza { <> true}