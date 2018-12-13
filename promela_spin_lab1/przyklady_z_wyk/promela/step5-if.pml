/* Konstrukcja warunkowa */

byte state = 1;

proctype H(byte i) {
  state == i;
  if
  :: (state > 1) -> printf("Hello world, I am H(%d).\n", i)
  :: (state < 3) -> printf("Ah, whatever. I am H(%d).\n", i)
  fi;
  state = state + 1
}

init {
  run H(1);
  run H(2);
  run H(3);
}
