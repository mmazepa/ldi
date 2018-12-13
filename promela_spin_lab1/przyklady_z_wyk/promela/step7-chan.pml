/* Kanały */

chan ch = [1] of {byte};

proctype H(byte i) {
    byte input;
    ch?input;
    printf("I am H(%d), got %d.\n", i, input);
    ch!i
}

init {
  byte i = 1;
  do
  :: (i>10) -> break;
  :: else -> 
       run H(i);
       i = i + 1
  od;
  ch!0
}
