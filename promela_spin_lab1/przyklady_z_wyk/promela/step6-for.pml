init {
  int i;
  int a[10];
  
  for (i : 1 .. 10) {
    printf("i = %d\n", i)
  }
  /* to samo co: */
  i = 1;
  do
  :: i <= 10 -> printf("i = %d\n", i); i++
  :: else -> break
  od;

  /* nieco inny sposób */
  for (i in a) {
    printf("i = %d\n", i)
  }

  /* istnieje jeszcze forma iterująca po
     zawartości kanału/bufora – patrz dok.
  */
}
