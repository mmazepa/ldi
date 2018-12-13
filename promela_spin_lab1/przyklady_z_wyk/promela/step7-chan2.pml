/* Kanały */

chan ch = [1] of {byte};

proctype A() {
    byte input=2;
    ch?1;
    printf("Przesłano wartość 1\n");
    ch?eval(input);
    printf("Przesłano wartość 2\n");
    ch?input;
    printf("Przesłano wartość %d\n", input);
    ch?<input>;
    printf("W kanale czeka: %d\n", input);
    ch?eval(input);
    printf("Odczytałem: %d\n", input);
}

proctype B() {
  ch!1;
  ch!2;
  ch!3;
  ch!4
}

init {
  run A(); run B();
}
