abstract sig Osoba {
	płeć: Płeć,
	stanowisko: Stanowisko
}
one sig Ames, Brown, Conroy, Davis, Evans extends Osoba {}

abstract sig Płeć {}
one sig Kobieta, Mężczyzna extends Płeć {}

abstract sig Stanowisko {}
one sig Zaopatrzeniowiec, Kasjer, Ekspedient, Piętrowy, Menadżer extends Stanowisko {}

fact {
	// - Kto jest jakiej płci?
	Ames.płeć = Kobieta
	Brown.płeć = Kobieta
	Conroy.płeć = Mężczyzna
	Davis.płeć = Mężczyzna
	Evans.płeć = Mężczyzna

	// - Różne osoby mają różne stanowiska.
	all disj x,y:Osoba | x.stanowisko!=y.stanowisko

	// - Kasjer i Menadżer mieszkali w jednym pokoju w internacie, kiedy byli w szkole.
	all disj x,y:Osoba | x.stanowisko=Kasjer and y.stanowisko=Menadżer => x.płeć=y.płeć

	// - Zaopatrzeniowiec jest „starym kawalerem”.
	all o:Osoba | o.stanowisko=Zaopatrzeniowiec => o.płeć=Mężczyzna

	// - Pana Evansa i pannę Ames łączą (i kiedykolwiek łączyły) jedynie stosunki służbowe.
	Evans.stanowisko != Kasjer
	Evans.stanowisko != Ekspedient
	Ames.stanowisko != Kasjer
	Ames.stanowisko != Ekspedient

	// --- (sugestia z zajęć) ------- (ale chyba nie działa) -----
	// Evans.stanowisko+Ames.stanowisko != Kasjer+Ekspedient

	// - Pani Conroy była bardzo rozczarowana kiedy mąż powiedział jej, że
		// Menadżer nie wyraził zgody na podwyżkę dla niego.
	Conroy.stanowisko != Menadżer

	// - Pan Davis będzie świadkiem na ślubie osób pracujących jako Kasjer i Ekspedient.
		// Zakładamy tutaj „tradycyjny model rodziny” ;)
	all disj x,y:Osoba | x.stanowisko=Kasjer and y.stanowisko=Ekspedient => x.płeć!=y.płeć
}

run {}
