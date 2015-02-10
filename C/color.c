#include <stdio.h>

#define BLACK   "\x1b[30m"
#define RED     "\x1b[31m"
#define GREEN   "\x1b[32m"
#define YELLOW  "\x1b[33m"
#define BLUE    "\x1b[34m"
#define MAGENTA "\x1b[35m"
#define CYAN    "\x1b[36m"
#define WHITE   "\x1b[37m"
#define RESET   "\x1b[0m"

#define BOLD_ON    "\x1b[1m"
#define INVERSE_ON "\x1b[7m"
#define BOLD_OFF   "\x1b[22m"

#define BG_RED     "\x1b[41m"
#define BG_GREEN   "\x1b[42m"
#define BG_YELLOW  "\x1b[43m"
#define BG_BLUE    "\x1b[44m"
#define BG_MAGENTA "\x1b[45m"
#define BG_CYAN    "\x1b[46m"
#define BG_WHITE   "\x1b[47m"



int main () {

  printf(RED     "This text is RED!"     RESET "\n");
  printf(GREEN   "This text is GREEN!"   RESET "\n");
  printf(YELLOW  "This text is YELLOW!"  RESET "\n");
  printf(BLUE    "This text is BLUE!"    RESET "\n");
  printf(MAGENTA "This text is MAGENTA!" RESET "\n");
  printf(CYAN    "This text is CYAN!"    RESET "\n");

  printf(CYAN BG_RED    "This text is CYAN!"    RESET "\n");
  printf(RED BG_WHITE    "This text is RED!"     RESET "\n");
  printf(BLUE BOLD_ON    "This text is BOLD!"     RESET "\n");

  return 0;
}
