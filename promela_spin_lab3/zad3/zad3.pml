mtype = {PLN2, PLN5, MILK, DARK}
bool koniec = false;

byte ile_mlecznych = 10;
byte ile_gorzkich = 10;

chan kanal_zakup = [0] of { byte }

active proctype Klient() {
    mtype odpowiedz;
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
    :: kanal_zakup?odpowiedz ->
        printf("[KLIENT]: uzyskałem %e\n", odpowiedz);
        if
        :: odpowiedz == MILK ->
            mniamMniam2: skip;
        :: odpowiedz == DARK ->
            mniamMniam5: skip;
        :: odpowiedz == PLN2 ->
            buuu2: mleczne = false;
            printf("[KLIENT]: oddało mi PLN2, nie ma więcej MILK\n");
        :: odpowiedz == PLN5 ->
            buuu5: gorzkie = false;
            printf("[KLIENT]: oddało mi PLN5, nie ma więcej DARK\n");
        fi
    :: koniec -> break;
    od
}

active proctype Maszyna() {
    mtype zaplata;

    do
    :: kanal_zakup?zaplata ->
        if
        :: (ile_mlecznych > 0 && zaplata == PLN2) -> ile_mlecznych--; kanal_zakup!MILK;
        :: (ile_gorzkich > 0 && zaplata == PLN5) -> ile_gorzkich--; kanal_zakup!DARK;
        :: else -> kanal_zakup!zaplata;
        fi
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
ltl WszystkoCoDobreKiedysSieKonczy {
    <>[] (Klient@dwojkaWrzucona -> Klient@buuu2)
}

// kiedyś po wrzuceniu PLN5 dostanę PLN5 od maszyny
ltl WszystkoCoDobreKiedysSieKonczy2 {
    <> (Klient@piatkaWrzucona -> Klient@buuu5)
}

// jak wrzucę PLN2 to dostanę ją lub batonik MILK
ltl BatonikAlboKasa {
    [] (Klient@dwojkaWrzucona -> <> (Klient@mniamMniam2 | Klient@buuu2))
}

// jak wrzucę PLN5 to dostanę ją lub batonik DARK
ltl BatonikAlboKasa2 {
    [] (Klient@piatkaWrzucona -> <> (Klient@mniamMniam5 | Klient@buuu5))
}

ltl Prop1 { [] true }
ltl KasaSieZgadza { <> true }