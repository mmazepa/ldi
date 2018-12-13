/* Deklarowanie i uruchamianie procesu */

proctype H() {
  printf("Hello world, I am H.\n")
}

init {
  run H();
  printf("Hello world.\n")
}
