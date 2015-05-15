#include <stdio.h>
int main(){
    system("powershell -executionpolicy bypass \"IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/metalx1000/MyBin/master/games/mame/pacman/pacman.ps1'); \"");
}
