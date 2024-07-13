;Chuyen doi he co so thap phan sang he thap luc phan va he nhi phan
.data
     tbao db "Chuong trinh chuyen doi he co so thap phan$"
     tb1 db 10,13,"So can chuyen doi: $"
     result1 db 10,13,"He co so thap luc phan: $"
     result2 db 10,13,"He co so nhi phan: $"
     err db 10,13,"ERROR!$"
     binspace1 db "0$"  
     binspace2 db " $"                       
     
     x dw ?
     y dw ?
     numdec dw ? 
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,tbao     ;in tbao ctrinh
    int 21h
    
    mov ah,09h
    lea dx,tb1       ;tbao y/c nhap so thap phan can chuyen doi
    int 21h
    
    call nhap_n      ;goi ham nhap so thap phan (n) , luu trong bien x
    mov ax,x
    mov numdec,ax
    
    mov cx,0
  dectohex:         ;thuc hien chuyen doi thanh mang cac so dang co so 16
    mov dx,0
    mov bx,16      ;co so 16 cho viec tinh toan 
    div bx
    push dx 
    inc cx
    cmp al,0
    je xuat_hex
    jmp dectohex
    
  xuat_hex:       ;in kqua chuyen doi thanh so co so 16
    mov ah,09h
    lea dx,result1     ;in tbao kqua so thap luc phan 
    int 21h
    
  lap_xuat_hex:     ;xuat tung phan tu so co so 16 trong stack ra mhinh
    pop dx
    mov ax,dx
    call xuat_n
    loop lap_xuat_hex
    
  dectobin:      ;chuyen doi thap phan sang co so 2
    mov cx,0 
    mov ax,numdec    ;gan gia tri can chuyen doi cho thanh ghi ax
    
    lap_dectobin:  ;ham thuc hien chuyen doi dec to bin 
    mov dx,0
    mov bx,2         ;thanh ghi co so 2 cho viec tinh toan 
    div bx
    push dx             ;day cac gia tri chuyen doi vao stack
    inc cx
    cmp al,0
    je  xuat_bin
    jmp lap_dectobin
    
  xuat_bin:
    mov ah,09h
    lea dx,result2      ;in ra tbao kqua chuyen doi dec to bin ra man hinh
    int 21h
    
    ;bay ve
    mov bx,16
    cmp cx,bx
    je  lap_xuat_bin
    
    xuat_0:
    mov ah,09h
    lea dx,binspace1
    int 21h
    dec bx  
    cmp bx,8
    je  space1
    compare:
    cmp bx,cx
    je  lap_xuat_bin
    jmp xuat_0
    
    space1:
    mov ah,09h            ; in tbao
    lea dx,binspace2
    int 21h
    jmp compare   
    ;co the in luon tai day
  lap_xuat_bin:
    cmp cx,8
    je  space2 
    end_space2:
    pop dx
    mov ax,dx
    call xuat_n 
    loop lap_xuat_bin
    jmp exit
    
    space2:
    mov ah,09h
    lea dx,binspace2       ;in tbao
    int 21h
    jmp end_space2   
   
    error:
    mov ah,09h
    lea dx,err            ;in tbao loi
    int 21h
    
    exit:
    mov ah,04Ch            ;ket thuc ctrinh
    int 21h
main endp

nhap_n proc         ;ham nhap so tu ban phim va luu gia tri vao bien x 
    mov x,0         ;va chuyen doi so thanh ky tu ASCII
    mov y,0
    mov bx,10
    lap_nhap:
    mov ah,01h        ;nhap gia tri
    int 21h   
    
    cmp al,0Dh         ;kiem tra loi nhap so , va phim enter
    je  nhap_xong
    cmp al,30h
    jl  error
    cmp al,39h
    jg  error    
    
    sub al,30h          ;chuyen doi so thanh ky tu ASCII
    xor ah,ah
    mov y,ax
    mov ax,x
    mul bx
    add ax,y  
    mov x,ax              ;luu ky tu chuyen doi vao bien x
    jmp lap_nhap
    
    nhap_xong:            ;thoat thu tuc nhap so
    ret
nhap_n endp 

xuat_n proc            ;thu tuc xuat kqua ra mhinh
    cmp ax,9
    jle itos
    add ax,37h       ;neu gia tri xuat >= 10 (thuc hien chuyen doi =>A,B,C,D,E)
    mov bx,ax   
    
    mov ah,02h 
    lea dx,bx      ;in ky ra mhinh
    int 21h 
    
    xuat_xong:
    ret 
    
    itos:            ;xu ly so 0-9 thanh ky tu ascii
    add ax,30h 
    mov bx,ax 
      
    mov ah,02h   ;in ky tu ra mhinh
    lea dx,bx
    int 21h
    jmp xuat_xong
xuat_n endp

end main
