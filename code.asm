[org 0x0100]
jmp start
msg1: db '<========= Welcome to Program =========>',0
msg2: db '1. Reverse string.',0
msg3: db '2. Arithmetic operations (+,-,*).',0
msg4: db '3. convert string to uppercase.',0
msg5: db '4. string to integer conversion.',0
msg6: db '5. palindrome check.',0
msg7: db 'Enter input (esc to exit)!',0
msg8: db 'wrong input! Enter again!',0
msg9: db 'Enter string: ',0
msg10: db 'string is:',0
msg11: db 'Reversed string is: ',0
msg12: db 'Enter any key to continue...',0
msg13: db '1. For addition.',0
msg14: db '2. For Subtraction.',0
msg15: db '3. For Multiplication under 16 bytes.',0 
forinput: db '                     '
msg17: db 'Enter first val:',0
msg18: db 'Enter Second val:',0
msg19: db 'String converted to upper case is: ',0
msg20: db 'After conversion integer is: ',0
msg21: db 'After checking string is palindrome (1==yes && 0==no):',0
clrscr:
	pusha
	mov ax,0xb800
	mov es,ax
	mov cx,2000
	mov di,0
	mov ax,0x1E20
	rep stosw
	popa 
	ret
printmenu:
	call clrscr
	pusha
	mov di,0
	push di
	mov si,msg1
	push si
	call printstr
	mov di,160
	push di
	mov si,msg2
	push si
	call printstr
	mov di,320
	push di
	mov si,msg3
	push si
	call printstr
	mov di,480
	push di
	mov si,msg4
	push si
	call printstr
	mov di,640
	push di
	mov si,msg5
	push si
	call printstr
	mov di,800
	push di
	mov si,msg6
	push si
	call printstr
	mov di,960
	push di
	mov si,msg7
	push si
	call printstr
	popa
	ret
printstr:
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	mov ax,0xb800
	mov es,ax
	mov si,[bp+4];address of string
	mov di,[bp+6]; location
	mov ah,0x1E
print:
	lodsb
	cmp al,0
	jz endprinting
	stosw
	jmp print
endprinting:
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 4
ispalindrom:
    push ds
    pop es
    mov di, forinput     
    xor cx, cx            
    mov al, 0  
	mov cx,0xFFFF
    repne scasb      
	mov ax,0xFFFF
	sub ax,cx
	mov cx,ax
	dec cx   
    mov si, forinput     
	mov di,forinput
    add di, cx  
	dec di
    xor ax, ax          
check_loop:
    mov al, [si]         
    mov dl, [di]        
    cmp al, dl          
    jne not_palindrome    
    inc si              
    dec di               
    loop check_loop       
    mov ax, 1             
    jmp display_result
not_palindrome:
    mov ax, 0             
display_result:
	push ax
    mov ax, 0xb800        
    mov es, ax  
	pop ax
    mov di, 268          
    cmp ax, 1          
    je print_palindrome
	mov ah,0x1E
    mov al, 'N'          
    mov [es:di], ax      
    add di, 2            
    mov al, 'O'          
    mov [es:di], ax      
    add di, 2             
    mov al, 'T'           
    mov [es:di], ax  
    add di, 2         
    mov al, ' '         
    mov [es:di], ax        ; Display space
    add di, 2              ; Move to next position

print_palindrome:
	mov ah,0x1E
    mov al, 'P'          
    mov [es:di], ax       
    add di, 2            
    mov al, 'A'          
    mov [es:di], ax       
    add di, 2          
    mov al, 'L'         
    mov [es:di], ax       
    add di, 2              
    mov al, 'I'            
    mov [es:di], ax        
    add di, 2              
    mov al, 'N'            
    mov [es:di], ax        
    add di, 2              
    mov al, 'D'            
    mov [es:di], ax        
    add di, 2              
    mov al, 'R'            
    mov [es:di], ax        
    add di, 2              
    mov al, 'O'            
    mov [es:di], ax        
    add di, 2              
    mov al, 'M'            
    mov [es:di], ax      
    add di, 2           
    mov al, 'E'          
    mov [es:di], ax      
    add di, 2             
    mov al, ' '          
    mov [es:di], ax        
    add di, 2            
    ret

palindromecheck:
	call clrscr
	pusha
	mov ax,0xb800
	mov es,ax
	mov di,0
	push di
	mov si,msg9
	push si
	call printstr
	mov si,forinput
	mov bx,0
	mov di,28
lpp5:
	mov ah,0x00
	int 0x16
	cmp al,0x0D
	je done6
	mov ah,0x1E
	mov word[es:di],ax
	add di,2
	mov byte[si+bx],al
	inc bx
	cmp bx,21
	jl lpp5
done6:
	mov byte[bx+si],0
	call clrscr
	mov di,0
	push di
	mov si,msg10
	push si
	call printstr
	mov di,22
	push di
	mov si,forinput
	push si
	call printstr
	call ispalindrom
	mov di,160
	push di
	mov si,msg21;108 di next
	push si
	call printstr
	mov di,320
	push di
	mov si,msg12
	push si
	call printstr
	mov ah,0x00
	int 0x16
	popa 
	ret
string_to_int:
	call clrscr
	pusha
	mov ax,0xb800
	mov es,ax
	mov di,0
	push di
	mov si,msg9
	push si
	call printstr
	mov si,forinput
	mov bx,0
	mov di,28
lpp4:
	mov ah,0x00
	int 0x16
	cmp al,0x0D
	je done5
	mov ah,0x1E
	mov word[es:di],ax
	add di,2
	mov byte[si+bx],al
	inc bx
	cmp bx,21
	jl lpp4
done5:
	mov byte[bx+si],0
	call clrscr
	mov di,0
	push di
	mov si,msg10
	push si
	call printstr
	mov di,22
	push di
	mov si,forinput
	push si
	call printstr
	call stringtointeger
	mov di,160
	push di
	mov si,msg20;60 di next
	push si
	call printstr
	mov di,320
	push di
	mov si,msg12
	push si
	call printstr
	mov ah,0x00
	int 0x16
	popa 
	ret
stringtointeger:
	push ax
	push bx
	xor ax, ax 
    xor bx, bx
	xor cx,cx
	xor dx,dx
    mov si, forinput 
convert_loop:  
    lodsb  
    cmp al, 0 
    je done_conversion  
    sub al, '0'  
    mov bl, al 
    mov ax, dx 
    mov cx, 10  
    mul cx       
    add ax, bx  
    mov dx, ax 
    jmp convert_loop 
done_conversion:
	xor ax,ax
	mov ax,dx
	mov bx,10
	xor cx,cx
looop:
	xor dx,dx
	div bx
	add dl,0x30
	push dx
	inc cx
	cmp ax,0
	jnz looop
	mov di,220
nextt3:
	pop ax
	mov ah,0x1E
	mov word[es:di],ax
	dec cx
	add di,2
	cmp cx,0
	jnz nextt3
	pop bx
	pop ax
	ret
conversiontoupper:
    push ax
    push bx
    push cx
    push dx
    mov si, forinput   
    mov bx, 0        
loppp:
    mov al, [si + bx] 
    cmp al, 0        
    je doneee           
    cmp al, 'a'      
    jb notconvert     
    cmp al, 'z'      
    ja notconvert    
    sub al, 32        
    mov [si + bx], al  
notconvert:
    inc bx           
    jmp loppp         
doneee:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

converttoupper:
	call clrscr
	pusha
	mov ax,0xb800
	mov es,ax
	mov di,0
	push di
	mov si,msg9
	push si
	call printstr
	mov si,forinput
	mov bx,0
	mov di,28
lpp3:
	mov ah,0x00
	int 0x16
	cmp al,0x0D
	je done4
	mov ah,0x1E
	mov word[es:di],ax
	add di,2
	mov byte[si+bx],al
	inc bx
	cmp bx,21
	jl lpp3
done4:
	mov byte[bx+si],0
	call clrscr
	mov di,0
	push di
	mov si,msg10
	push si
	call printstr
	mov di,22
	push di
	mov si,forinput
	push si
	call printstr
	call conversiontoupper
	mov di,230
	push di
	mov si,forinput
	push si
	call printstr
	mov di,160
	push di
	mov si,msg19;70 di next
	push si
	call printstr
	mov di,320
	push di
	mov si,msg12
	push si
	call printstr
	mov ah,0x00
	int 0x16
	popa 
	ret
reversestring:
	call clrscr
	pusha
	mov ax,0xb800
	mov es,ax
	mov di,0
	push di
	mov si,msg9
	push si
	call printstr
	mov si,forinput
	mov bx,0
	mov di,28
lpp:
	mov ah,0x00
	int 0x16
	cmp al,0x0D
	je done3
	mov ah,0x1E
	mov word[es:di],ax
	add di,2
	mov byte[si+bx],al
	inc bx
	cmp bx,21
	jl lpp
done3:
	mov byte[bx+si],0
	call clrscr
	mov di,0
	push di
	mov si,msg10
	push si
	call printstr
	mov di,22
	push di
	mov si,forinput
	push si
	call printstr
	call reverseprint
	popa
	call printmenu
	jmp takinginput
reverseprint:
	mov ax,0xb800
	mov es,ax
	mov di,160
	push di
	mov si,msg11
	push si
	call printstr
	push ds
	pop es
    mov di,forinput   
    mov cx, 0xFFFF   
    xor ax, ax       
    repne scasb        
    sub di, forinput  
    dec di             
	mov ax,0xFFFF
	sub ax,cx
	dec ax
	mov cx,ax
	inc cx
    mov si, forinput   
    add si, di              
	mov ax,0xb800
	mov es,ax
	mov di,200
    mov ah, 0x1E        ; Attribute byte (green text on black background)
reverse_loop:
	std
    lodsb               ; Load the current character from SI
	cld
    stosw               ; Store character with attribute at screen
    loop reverse_loop   ; Repeat until CX = 0
	cld
	mov di,320
	push di
	mov si,msg12
	push si
	call printstr
	mov ah,0x00
	int 0x16
	ret
	
takinginput:
	mov ah,0x00
	int 0x16
	cmp al,0x1B
	je donee
	mov di, 1280          ; Set screen location to row 5, column 10 (1320 = 10*80*2)
    mov ah, 0x1E          ; Attribute byte (green text on black background)
    mov [es:di], ax       ; Store the character and attribute at screen location
    add di, 2             ; Move to the next position (2 bytes per character)
	cmp al,'1'
	jz reversestring
	cmp al,'2'
	jz arithmeticoperations
	cmp al,'3'
	jz converttoupper1
	cmp al,'4'
	jz strintoint1
	cmp al,'5'
	jz palindromecheck1
	mov di,1120
	push di
	mov si,msg8
	push si
	call printstr
	jmp takinginput
donee:
	ret
	
palindromecheck1:
	call palindromecheck
	call printmenu
	jmp takinginput 
strintoint1:
	call string_to_int
	call printmenu
	jmp takinginput
converttoupper1:
	call converttoupper
	call printmenu
	jmp takinginput
arithmeticoperations:
	call clrscr
	xor di,di
	push di
	mov si,msg13
	push si
	call printstr
	mov di,160
	push di
	mov si,msg14
	push si
	call printstr
	mov di,320
	push di
	mov si,msg15
	push si
	call printstr
	mov di,480
	push di
	mov si,msg7
	push si
	call printstr
	mov ah,0x00
	int 0x16
	push ax
	mov ax,0xb800
	mov es,ax
	pop ax
	mov ah,0x1E
	mov di,640
	mov word[es:di],ax
	cmp al,0x1B
	je ending
	cmp al,'1'
	jz foraddition1
	cmp al,'2'
	jz forsubtraction1
	cmp al,'3'
	jz formultiply1
	mov di,800
	push di
	mov si,msg8
	push si
	call printstr
	jmp arithmeticoperations
ending:
	call printmenu
	jmp takinginput
foraddition1:
	call foraddition
	jmp arithmeticoperations
forsubtraction1:
	call forsubtraction
	jmp arithmeticoperations
formultiply1:
	call formultiply
	jmp arithmeticoperations
forsubtraction:
	pusha
	call clrscr
	mov di,0
	push di
	mov si,msg17
	push si
	call printstr
	mov ah,0x00
	int 0x16
	push ax
	mov ax,0xb800
	mov es,ax
	pop ax
	mov ah,0x1E
	mov di,34
	mov word[es:di],ax
	mov cl,al
	mov di,160
	push di
	mov si,msg18
	push si
	call printstr
	mov ah,0x00
	int 0x16
	push ax
	mov ax,0xb800
	mov es,ax
	pop ax
	mov ah,0x1E
	mov di,198
	mov word[es:di],ax
	mov dl,al
	sub cl,'0'
	sub dl,'0'
	sub cl,dl
	xor ax,ax
	mov al,cl
	mov bx,10
	xor cx,cx
loooop1:
	xor dx,dx
	div bx
	add dl,0x30
	push dx
	inc cx
	cmp ax,0
	jnz loooop1
	mov di,320
nextt1:
	pop ax
	mov ah,0x1E
	mov word[es:di],ax
	dec cx
	add di,2
	cmp cx,0
	jnz nextt1
	mov di,480
	push di
	mov si,msg12
	push si
	call printstr
	mov ah,0x00
	int 0x16
	popa
	ret
foraddition:
	pusha
	call clrscr
	mov di,0
	push di
	mov si,msg17
	push si
	call printstr
	mov ah,0x00
	int 0x16
	push ax
	mov ax,0xb800
	mov es,ax
	pop ax
	mov ah,0x1E
	mov di,34
	mov word[es:di],ax
	mov cl,al
	mov di,160
	push di
	mov si,msg18
	push si
	call printstr
	mov ah,0x00
	int 0x16
	push ax
	mov ax,0xb800
	mov es,ax
	pop ax
	mov ah,0x1E
	mov di,198
	mov word[es:di],ax
	mov dl,al
	sub cl,'0'
	sub dl,'0'
	add cl,dl
	xor ax,ax
	mov al,cl
	mov bx,10
	xor cx,cx
loooop:
	xor dx,dx
	div bx
	add dl,0x30
	push dx
	inc cx
	cmp ax,0
	jnz loooop
	mov di,320
nextt:
	pop ax
	mov ah,0x1E
	mov word[es:di],ax
	dec cx
	add di,2
	cmp cx,0
	jnz nextt
	mov di,480
	push di
	mov si,msg12
	push si
	call printstr
	mov ah,0x00
	int 0x16
	popa
	ret
formultiply:
	pusha
	call clrscr
	mov di,0
	push di
	mov si,msg17
	push si
	call printstr
	mov ah,0x00
	int 0x16
	push ax
	mov ax,0xb800
	mov es,ax
	pop ax
	mov ah,0x1E
	mov di,34
	mov word[es:di],ax
	xor cx,cx
	mov cl,al
	sub cx,'0'
	mov di,160
	push di
	mov si,msg18
	push si
	call printstr
	mov ah,0x00
	int 0x16
	push ax
	mov ax,0xb800
	mov es,ax
	pop ax
	mov ah,0x1E
	mov di,198
	mov word[es:di],ax
	xor dx,dx
	mov dl,al
	sub dx,'0'
	call multiply
	mov ax,cx
	mov bx,10
	xor cx,cx
loooop2:
	xor dx,dx
	div bx
	add dl,0x30
	push dx
	inc cx
	cmp ax,0
	jnz loooop2
	mov di,320
nextt2:
	pop ax
	mov ah,0x1E
	mov word[es:di],ax
	dec cx
	add di,2
	cmp cx,0
	jnz nextt2
	mov di,480
	push di
	mov si,msg12
	push si
	call printstr
	mov ah,0x00
	int 0x16
	popa
	ret
multiply:
	push ax
	push bx
	xor ax,ax
	xor bx,bx
	mov al,cl
	mov bl,dl
	xor cx,cx
lopp:
	shr bx,1
	jnc skip
	add cx,ax
skip:
	shl ax,1
	cmp bx,0
	jnz lopp
	pop bx
	pop ax
	ret
start:
	call printmenu
	call takinginput
done:
	mov ax, 0x4c00 
	int 0x21 
