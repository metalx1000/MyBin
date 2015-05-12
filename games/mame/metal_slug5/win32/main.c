#include <stdio.h>
int main(){
    system("powershell -executionpolicy bypass \"IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/metalx1000/MyBin/master/games/mame/metal_slug5/mslug5.ps1'); \"");
}
