#include <stdlib.h>
#include <stdio.h>
#include <time.h>

void shuffle(char **arr, int len);
 
char *myStrings[] = { "one", "two", "three", "four", "five" };

int main() {
  srand(time(0));//generate random seed

  int len = sizeof(myStrings) / sizeof(myStrings[0]); //array length
  shuffle(myStrings,len);
  return 0;
}

void shuffle(char **arr, int len){
  printf("Array Count: %d\n", len);
  printf("===================\n");

  for( int i = 0; i < len; i++){
    int pick_index = rand() % ( len - i);
    printf("%s\n",arr[pick_index]);
    arr[pick_index] = arr[ len - i - 1];
  }

}

