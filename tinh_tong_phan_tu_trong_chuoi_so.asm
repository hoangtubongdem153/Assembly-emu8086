;Chuong trinh tinh tong cac phan tu trong chuoi so
.data
    tb1 db "Tinh tong cac phan tu trong chuoi so$"
    tb2 db 10,13,"Nhap so phan tu n: $"
    tb3 db 10,13,"Liet ke cac phan tu trong mang: $"
    result db 10,13,"Ket qua: $" 
    newline db 10,13,"$"    
    
    x dw ? 
    y dw ? 
    n dw ?
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah, 09h    ;in ten chuong trinh
    lea dx, tb1
    int 21h
    
    mov ah,09h     ;in thong bao nhap so phan tu (n)
    lea dx,tb2
    int 21h  
    
    call nhap_n    ;goi ham nhap phan tu
    mov cx,x
    
    mov ah,09h
    lea dx,tb3     ;in thong bao nhap 
    int 21h
    
  nhap_mang:
    mov si,0       ;thanh ghi luu chi so mang n[]
    
  lap_nhap_mang:  
    mov ah,09h        ; xuong dong
    lea dx,newline
    int 21h    
    
    call nhap_n  
    mov ax,x
    mov n[si],ax 
    inc si
    loop lap_nhap_mang   ;lap den het cx
    
    mov di,0  
    mov ax,0
  tinh_tong:
    mov bx,n[di]         ;lay tung phan tu trong mang n[]
    add al,bl
    cmp di,si
    je  tinh_xong
    inc di
    jmp tinh_tong
    
  tinh_xong:
    mov di,0  
    
  in_str:        ;thuc hien chuyen doi so thanh chuoi, luu vao stack
    mov dx,0 
    mov bx,10
    div bx
    push dx      ;thuc hien phep chia, day phan du vao stack
    inc di  
    cmp ax,0
    je xuat      ;thoat vong lap neu ax = 0  (k con so de chia
    jmp in_str
    
  xuat: 
    mov ah,09h
    lea dx,result    ;in thong bao ket qua
    int 21h     
    
  lap_xuat:
    pop dx
    add dx,30h      ;chuyen doi sang dang ky tu ASCII
    mov bx,dx       
    
    mov ah,02h      ;in ky tu ra man hinh
    lea dx,bx
    int 21h       
    
    dec di
    cmp di,0
    je  exit        ;thoat chuong trinh neu in xong
    jmp lap_xuat

    exit:
    mov ah,04Ch
    int 21h 
main endp  

nhap_n proc   
    mov x,0       ;x,y luu gia tri , y luu gia tri nhap, x luu kq cuoi cung
    mov y,0     
    
    mov bx,10     ;co so 10  
    
  lap_nhap:
    mov ah,01h       ;nhap 1 ky tu
    int 21h       
    
    cmp al,0Dh       ;so sanh gia tri nhap voi CRLF , ket thuc qua trinh nhap
    je  nhap_xong   
    
    cmp al,30h       ;thoat chuong trinh neu k nhap dung dinh dang
    jl  exit
    cmp al,39h
    jg  exit
    sub al,30h     
    
    xor ah,ah
    mov y,ax         ;gan gia tri vua nhap cho y
    mov ax,x         
    mul bx
    add ax,y         ; thuc hien phep tinh x = x*10 + y
    mov x,ax
    jmp lap_nhap
    
  nhap_xong:         ;thuc hien thoat thu tuc nhap phan tu, tiep tuc ham main
    ret              ;kq duoc luu trong x
nhap_n endp
end main
