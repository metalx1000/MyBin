#include <stdio.h>
#include <string.h>

int main(){
  char *myStrings[] = { "one", "two", "three", "four", "five" };
  int array_length = sizeof(myStrings) / sizeof(myStrings[0]);
  printf("Array Count: %d\n", array_length);
  printf("===================\n");

  for( int i = 0; i < array_length; i++){
    printf("%s\n",myStrings[i]);
  }
  return 0;
}
