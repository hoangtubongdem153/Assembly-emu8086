;Dem so luong phan tu am duong trong chuoi
.data
    tbao db "Dem so luong phan tu am duong$"
    tb1 db 10,13,"So phan tu n: $"
    tb2 db 10,13,"Liet ke cac phan tu trong mang: $"
    newline db 10,13,"$"
    result1 db 10,13,"So luong phan tu duong: $"
    result2 db 10,13,"So luong phan tu am: $"
    
    x dw ?
    y dw ?
    suma dw ?     ;luu so so am
    sumd dw ?     ;luu so so duong
.code 
main proc
    mov ax,@data
    mov ds,ax 
    
    mov ah,09h
    lea dx,tbao     ;in tbao ctrinh
    int 21h
    
    mov ah,09h
    lea dx,tb1     ;in tbao nhap so phan tu (n) cua mang
    int 21h
    
    call nhap_n     ;goi ham nhap n
    mov cx,x         ; gan so phan tu chuoi (n) vao bo dem counter cx
    
    mov ah,09h
    lea dx,tb2      ;in thong bao nhap cac phan tu cua mang 
    int 21h
    
    mov suma,0      ;khoi tao gia tri = 0 cho cac bien luu tru kqua
    mov sumd,0    
    
  nhap_mang:
    mov ah,09h
    lea dx,newline     ;xuong dong
    int 21h          
    
    mov di,0         ;di=0 , chi dinh so duong
    call nhap_n
    cmp di,1           ;di=1 , chi dinh so am
    je  tinh_soam
    inc sumd           ;dem so luong so duong neu 
    loop nhap_mang 
    jmp tinhxong
    
    tinh_soam:         ;dem so luong so am
    inc suma
    loop nhap_mang
    
    tinhxong:
    mov ah,09h
    lea dx,result1           ;in tbao ket qua so phan tu duong
    int 21h
    
    mov ax,sumd
    call xuat_n            ;goi ham in kqua sumd ra mhinh
    
    mov ah,09h
    lea dx,result2           ;in tbao kqua so luong phan tu am
    int 21h
    
    mov ax,suma
    call xuat_n             ;goi ham in kqua suma ra mhinh
    
    exit:
    mov ah,04Ch            ;thoat ctrinh
    int 21h
main endp

nhap_n proc         ;ham nhap cac phan tu tu ban phim va chuyen doi tu ASCII thanh so nguyen 
    mov x,0 
    mov y,0   
    
    mov bx,10        ;co so 10 cho tinh toan
    
    lap_nhap:
    mov ah,01h         ;nhap so
    int 21h     
    
    cmp al,2Dh       ;kiem tra dau tru ( "-"=2Dh in ASCII)
    je  soam        
    
    cmp al,0Dh             ;ktra ky tu Enter
    je  nhap_xong  
    
    check_convert:      
    
    cmp al,30h         ;kiem tra dinh dang so trong gia tri vua nhap vao AL
    jl  exit
    cmp al,39h
    jg  exit     
    
    sub al,30h        ;chuyen doi so sang ky tu ASCII
    xor ah,ah
    mov y,ax
    mov ax,x
    mul bx
    add ax,y  
    mov x,ax
    jmp lap_nhap
    
    soam:                   ;xu ly so am
    mov di,1
    mov ah,01h            ;tiep tuc nhap so (sau dau - , neu la so am)
    int 21h         
    
    cmp al,2Dh              ;kiem tra ky tu Enter, va dau '-' , thoat neu co
    je  exit
    cmp al,0Dh           
    je  exit
    jmp check_convert
       
    nhap_xong:
    ret
nhap_n endp 

xuat_n proc           ;chuyen doi so ketqua thanh chuoi ky tu va in ra man hinh
    mov di,0
    itos:               ;chuyen doi so thanh mang ky tu va luu trong stack
    mov dx,0 
    mov bx,10
    div bx
    push dx   
    inc di  
    cmp al,0
    je lap_xuat
    jmp itos
    
    lap_xuat:
    pop dx                ;chuyen doi mang so sang chuoi ky tu ASCII
    add dx,30h
    mov bx,dx  
    mov ah,02h
    lea dx,bx
    int 21h
    dec di
    cmp di,0
    je  xuat_xong
    jmp lap_xuat 
    
    xuat_xong:               ;ket thuc thu tuc
    ret
xuat_n endp    
end main
