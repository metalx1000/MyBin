    BITS 16

    start:
    ;Clears screen
    ;----------------------------------------------
    mov ah, 0x0F            ;get current video mode
    int 0x10                ;get video mode
    mov ah, 0x00            ;set video mode
    int 0x10                ;reset screen
    mov ah, 0x02            ;set cursor pos
    int 0x10                ;set pos
    ;----------------------------------------------

    mov dl,1
    .repeat:
        lodsb ; Get character from string
        cmp al, 0
        je .cursor_pointer; If char is zero, end of string
        int 10h ; Otherwise, print it
        jmp .repeat
    .cursor_pointer:
        mov ah,2h ;set the value to "ah" to move the cursor pointer
        mov bh,0 ;select page
        mov dh,22 ;set row position of the cursor
        add dl,1 ;set column position of the cursor
        int 10h ;tell bios "hey dude now we are done,take action!!!"
        jmp .character_read
    .character_read:
        mov ah,4h
        mov ah,00h ;remeber set the value to "ah" now you are going to read a keyboard input
        int 16h ;this interrupt is given to control keystrokes of keyboard
        jmp .print_input ;now lets print what we took as input
    .print_input:
        mov ah,9h ;set the value to "ah" to print one character to std out
        mov bh,0 ;set page number
        mov bl,5h ;set the color attribute of the font to be print
        mov cx,1 ;set the value how many time the character in "al" should be print
        int 10h ;tell bios "hey dude now we are done,take action!!!"
        jmp .cursor_pointer
    times 510-($-$$) db 0 ; fill up the rest part of the boot secotr with 0 s
    dw 0xAA55 ; The standard PC boot signature
