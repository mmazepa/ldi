bool p = false;
bool q = false;

inline toS1() {
    atomic { set(true, false); goto S1; }
}

inline toS2() {
    atomic { set(true, false); goto S2; }
}

inline toS3() {
    atomic { set(true, true); goto S3; }
}

inline toS4() {
    atomic { set(false, true); goto S4; }
}

inline set(pv, qv) {
    p = pv;
    q = qv;
}

active proctype System() {
    toS4();
    S4: toS2();
    S1: toS2();
    S2: toS3();
    S3: toS1();
}

ltl frm3 { []q }
ltl frm4 { []<>q }
ltl frm5 { [](q V p) }
ltl frm6 { <>(p V q) }