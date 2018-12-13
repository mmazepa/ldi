/* Kanały: testowanie wejścia*/

chan ch = [1] of {byte};

proctype H(byte i) {
    byte input;
    ch?eval(i-1);
    printf("I am H(%d), got %d.\n", i, i-1);
    ch!i
}

init {
  byte i = 1;
  ch!0;
  do
  :: (i>10) -> break;
  :: else -> 
       run H(i);
       ch?<eval(i)>;
       i = i + 1
  od;
}
