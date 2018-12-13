/* Zmienne globalne i wykonywalność */

byte state = 1;

proctype H(byte i) {
  state == i;
  printf("Hello world, I am H(%d).\n", i);
  state = state + 1
}

init {
  run H(2);
  run H(3);
  run H(1);
}
