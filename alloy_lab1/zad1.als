abstract sig Osoba {
	płeć: Płeć,
	stanowisko: Stanowisko,
	związek: lone Osoba
}
one sig Ames, Brown, Conroy, Davis, Evans extends Osoba {}

abstract sig Płeć {}
one sig Kobieta, Mężczyzna extends Płeć {}

abstract sig Stanowisko {}
one sig Zaopatrzeniowiec, Kasjer, Ekspedient, Piętrowy, Menadżer extends Stanowisko {}

fact {
	// ----- ZAŁOŻENIA PODSTAWOWE ---------------	

	// Kto jest jakiej płci?
	Ames.płeć = Kobieta
	Brown.płeć = Kobieta
	Conroy.płeć = Mężczyzna
	Davis.płeć = Mężczyzna
	Evans.płeć = Mężczyzna

	// Różne osoby mają różne stanowiska.
	all disj x,y:Osoba | x.stanowisko!=y.stanowisko

	// Związek jest relacją działającą w obydwie strony.
	all disj x,y:Osoba | x.związek=y => y.związek=x

	// Nie można wiązać się z samym sobą.
	all o:Osoba | o.związek!=o

	// Uznajemy tylko związki "damsko-męskie".
	all disj x,y:Osoba | x.związek=y => x.płeć+y.płeć=Mężczyzna+Kobieta


	// ----- ZAŁOŻENIA Z ZADANIA ----------------

	// Kasjer i Menadżer mieszkali w jednym pokoju w internacie, kiedy byli w szkole.
	all disj x,y:Osoba | x.stanowisko=Kasjer and y.stanowisko=Menadżer => x.płeć=y.płeć

	// Zaopatrzeniowiec jest „starym kawalerem”.
	all o:Osoba | o.stanowisko=Zaopatrzeniowiec => o.płeć=Mężczyzna and no o.związek

	// Pana Evansa i pannę Ames łączą (i kiedykolwiek łączyły) jedynie stosunki służbowe.
	Evans.związek != Ames
	Evans.stanowisko+Ames.stanowisko != Kasjer+Ekspedient

	// Pani Conroy była bardzo rozczarowana kiedy mąż powiedział jej, że
	// Menadżer nie wyraził zgody na podwyżkę dla niego.
	Conroy.stanowisko != Menadżer
	Conroy.stanowisko != Zaopatrzeniowiec
	no Conroy.związek // zakładamy, że pan Conroy jest w związku z kimś spoza miejsca pracy

	// Pan Davis będzie świadkiem na ślubie osób pracujących jako Kasjer i Ekspedient.
	// Zakładamy tutaj „tradycyjny model rodziny” ;)
	all disj x,y:Osoba | x.stanowisko=Kasjer and y.stanowisko=Ekspedient => x.płeć!=y.płeć and x.związek=y
	Davis.stanowisko != Kasjer
	Davis.stanowisko != Ekspedient
}

run {}
