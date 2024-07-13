;Nhap vao mot chuoi, dem so ky tu trong chuoi
.data
    tbao db "Dem so ky tu trong chuoi$"
    tb1 db 10,13,"Nhap chuoi: $"
    result db 10,13,"Ket qua: $"
    
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,tbao     ;tbao chuong trinh
    int 21h
    
    mov ah,09h
    lea dx,tb1      ;in tbao y/c nhap chuoi
    int 21h
    
    mov cx,0
  nhap_chuoi:
    mov ah,01h        ;nhap ky tu
    int 21h        
    
    cmp al,0Dh
    je  nhap_xong
    inc cx             ;cx luu tru do dai chuoi
    jmp nhap_chuoi
    
  nhap_xong:
    mov ah,09h
    lea dx,result      ;in tbao ketqua
    int 21h
    
    mov ax,cx
    mov si,0
 lap:                 ;chuyen doi so luong ky tu thanh mang cac so, luu vao stack
    mov bx,10       ;co so chia
    mov dx,0
    div bx
    push dx        ;day gia tri vao stack
    inc si
    cmp al,0
    je  xuat
    jmp lap 
    
  xuat:          ;chuyen doi ky tu so sang ky tu ASCII, rui in ra mhinh
    pop dx
    mov bx,dx
    add bx,30h  
    
    mov ah,02h
    lea dx,bx
    int 21h  
    
    dec si
    cmp si,0
    je exit
    jmp xuat
       
  exit:
    mov ah,04Ch      ;ket thuc chuong trinh
    int 21h
main endp
end main
