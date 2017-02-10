#include <stdio.h>
#include <string.h>
#include <ctype.h>

void sort(char **, int);//Function prototype
int main()
{
    char *string_database[4]={'\0'};
    string_database[0]="Florida";
    string_database[1]="Oregon";
    string_database[2]="California";
    string_database[3]="Georgia";
    sort(string_database, 4);
    return 0;
}

void sort(char **strings, int n)
{
    int i;
    for (i=0; i<n; i++) {
        printf("String %d: %s\n", i, strings[i]);
    }
}
