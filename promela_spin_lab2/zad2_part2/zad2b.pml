bool p = false;
bool q = false;
bool r = false;

inline toS1() {
    atomic { set(true, false, false); goto S1; }
}

inline toS2() {
    atomic { set(false, false, true); goto S2; }
}

inline toS3() {
    atomic { set(false, true, true); goto S3; }
}

inline toS4() {
    atomic { set(false, true, false); goto S4; }
}

inline toS5() {
    atomic { set(true, true, true); goto S5; }
}

inline set(pv, qv, rv) {
    p = pv;
    q = qv;
    r = rv;
}

active proctype System() {
    toS1();
    toS2();
    S1: toS3(); toS4();
    S2: toS4();
    S3: toS4();
    S4: toS2(); toS3(); toS5();
    S5: toS4(); toS5();
}

ltl frm1 { <>[]r }
ltl frm2 { []<>r }
ltl frm4 { []p }
ltl frm5 { (p V [](q || r)) }