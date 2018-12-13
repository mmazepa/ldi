typedef Field {
  short f = 3;
  byte g
}

typedef Record {
  byte a[3];
  Field fld
}

proctype me(Field f) {
  f.g = 12
}

init {
  Field foo;
  run me(foo)
}
