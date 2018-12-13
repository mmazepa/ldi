/* Parametry procesu */

proctype H(byte i) {
  printf("Hello world, I am H(%d).\n", i)
}

init {
  run H(1);
  run H(2);
  run H(3);
}
