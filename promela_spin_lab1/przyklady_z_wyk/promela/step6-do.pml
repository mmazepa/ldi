/* Zmienne lokalne i pętle */

byte state = 1;

proctype H(byte i) {
    state == i;
    printf("Hello world, I am H(%d).\n", i);
    state = state + 1
}

init {
  byte i = 1;
    do
    :: (i>10) -> break;
    :: else -> 
         run H(i);
         i = i + 1
    od
}
