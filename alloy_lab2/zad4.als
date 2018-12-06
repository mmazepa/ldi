// Ola i Marek zaprosili na przyjęcie cztery pary swoich znajomych. Niektórzy z gości
// znali się wcześniej, inni - nie, niektórzy byli uprzejmi, a inni – mniej. Tak więc doszło
// do wymiany pewnej liczby uścisków dłoni, chociaż nie wszyscy się przywitali (oczywiście
// nikt nie ściskał swojej własnej dłoni, ani też dłoni swojego partnera/partnerki). Z ciekawości,
// pod koniec przyjęcia Ola zapytała każdego z gości z iloma osobami wymienił uścisk dłoni.
// Od każdej z dziewięciu osób usłyszała inną odpowiedź. Jak wiele dłoni uścisnął Marek?

//    [1] Rozwiąż powyższy problem modelując go w Alloy-u i używając jego analizatora
// 	do znalezienia odpowiedzi.
//    [2] Czy możliwe jest inne rozwiązanie, w którym Marek uścisnął inną liczbę dłoni?
// 	Rozszerz swój model tak, aby można było to sprawdzić.

sig Osoba {
	para: Osoba,
	usciski: set Osoba
}
one sig Ola, Marek
extends Osoba {}

fact {
	para = ~para					// pary muszą być symetryczne
	no (para & iden)					// nie można stworzyć pary ze sobą
	Ola.para = Marek

	//no (usciski & iden)				// ponoć ta linijka "nie ma wpływu na nic"
	all o:Osoba | o.para not in o.usciski		// przerobić predykat na relację
	all o:Osoba | o not in o.usciski		// przerobić predykat na relację
}

run {} for exactly 10 Osoba, 5 Int
