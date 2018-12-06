// W historii kryminalnej występuje sześć osób – panowie: Clayton, Forbes, Graham, Holgate,
// McFee i Warren odegrali w niej role: ofiary, mordercy, świadka, policjanta, sędziego oraz kata
// (niekoniecznie w podanej kolejności). Fakty były proste. Ofiara zmarła na skutek rany postrzałowej,
// zadanej z bliskiej odległości. Świadek, co prawda nie widział samej zbrodni, ale zeznał, że słyszał
// awanturę, po której nastąpił wystrzał. Po długim procesie morderca został skazany na śmierć
// i powieszony.

//   [1] Pan McFee znał zarówno ofiarę, jak i mordercę.
//   [2] W sądzie, sędzia zapytał pana Claytona o jego przebieg zdarzenia.
//   [3] Pan Warren był ostatnią osobą, która widziała pana Forbesa żywego.
//   [4] Policjant zeznał, że spotkał pana Grahama w pobliżu miejsca znalezienia ciała.
//   [5] Panowie Holgate i Warren nigdy się nie spotkali.

// Pytanie: jakie role odegrali poszczególni panowie w powyższej historii?

abstract sig Osoba {
	rola: Rola
}
one sig Clayton, Forbes, Graham, Holgate, McFee, Warren
extends Osoba {}

abstract sig Rola {}
one sig Ofiara, Morderca, Świadek, Policjant, Sędzia, Kat
extends Rola {}

fact {
	//all disj x,y:Osoba | x.rola!=y.rola			// to samo co niżej
	Osoba.rola = Rola						// to samo co wyżej
	
	// --- INFORMACJA 1 -----
	// Pan McFee znał zarówno ofiarę, jak i mordercę.

	McFee.rola not in Ofiara + Morderca
		
	// --- INFORMACJA 2 -----
	// W sądzie, sędzia zapytał pana Claytona o jego przebieg zdarzenia.

	Clayton.rola not in Sędzia + Ofiara + Kat

	// --- INFORMACJA 3 -----
	// Pan Warren był ostatnią osobą, która widziała pana Forbesa żywego.

	Warren.rola in Morderca + Kat
	Forbes.rola in Ofiara + Morderca	

	// --- INFORMACJA 4 -----
	// Policjant zeznał, że spotkał pana Grahama w pobliżu miejsca znalezienia ciała.

	//Graham.rola not in Policjant + Ofiara
	Graham.rola in Świadek + Morderca + Kat

	// --- INFORMACJA 5 -----
	// Panowie Holgate i Warren nigdy się nie spotkali.

	Holgate.rola + Warren.rola = Ofiara + Kat
}

run {}
