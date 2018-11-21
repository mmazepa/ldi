abstract sig Imie {
	nazwisko: one Nazwisko,
	rozmawia: some Imie
}
one sig Louis, Martin, Norris, Oliver, Peter extends Imie {}


abstract sig Nazwisko {
	imie: one Imie
}
one sig Atwood, Bartlett, Campbell, Donovan, Easterling extends Nazwisko {}

fact {
	// ----- ZAŁOŻENIA PODSTAWOWE ---------------

	// Różne imiona mają różne nazwiska i vice versa.
	all disj x,y:Imie | x.nazwisko!=y.nazwisko
	all disj x,y:Nazwisko | x.imie!=y.imie

	// Jeśli jakieś imię ma nazwisko, to to nazwisko nie może mieć innego imienia.
	all i:Imie, n:Nazwisko | i.nazwisko=n => n.imie=i

	// Rozmowa jest relacją działającą w obydwie strony.
	all disj x,y:Imie | x.rozmawia=y => y.rozmawia=x
	all disj i:Imie, n:Nazwisko | i.rozmawia=n.imie => n.imie.rozmawia=i

	// Nie można rozmawiać z samym sobą.
	all i:Imie | i.rozmawia!=i
	all n:Nazwisko | n.imie.rozmawia!=n.imie
	all disj i:Imie, n:Nazwisko | i=n.imie => i.rozmawia!=n.imie
	
	// ----- ZAŁOŻENIA Z ZADANIA ----------------

    // Bartlett rozmawia z jedynie dwoma z pozostałych.
	// ...

	// Podczas gdy Peter rozmawia ze wszystkimi za wyjątkiem jednego z mężczyzn,
	// Louis rozmawia wyłącznie z jednym z piątki.
	all i:Imie | i=Louis => one i.rozmawia

    // Donovan i Martin nie rozmawiają ze sobą.
	// Dla odmiany Norris i Easterling są kumplami.
	Donovan.imie.rozmawia!=Martin
	Norris.rozmawia=Easterling.imie

    // Martin, Norris i Oliver stanowią świetną „paczkę”.
	Martin.rozmawia=Norris+Oliver

    // Atwood nie rozmawia jedynie z jednym z piątki.
	// Dla odmiany Campbell rozmawia wyłącznie z jednym.
	// ...
}

run {}
