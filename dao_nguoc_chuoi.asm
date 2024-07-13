;Dao nguoc chuoi ky tu tu ban phim  (y tuong: su dung stack)
.model small
.stack 100

.data
    tbao db "Dao nguoc chuoi ky tu$"
    tb1 db 10,13,"Chuoi ky tu can chuyen doi: $"
    result db 10,13,"Ket qua: $"
    
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,tbao     ;in tbao chuong trinh
    int 21h
    
    mov ah,09h
    lea dx,tb1      ;tbao y/c nhap chuoi ky tu can dao nguoc
    int 21h
    
    mov si,0     ;thanh ghi chi so bat dau mang ky tu
  nhap_chuoi:
    mov ah,01h     ;nhap ky tu
    int 21h    
    
    cmp al,0Dh        ;kiem tra ky tu ket thuc - Enter
    je  nhap_xong
    mov ah,0
    push ax          ;day cac ky tu da nhap vao stack
    inc si
    jmp nhap_chuoi:
    
  nhap_xong:
    mov ah,09h
    lea dx,result    ;in tbao ketqua
    int 21h
    
  xuat_chuoi:
    pop ax             ;lay tung phan tu , xuat ra man hinh
    mov bx,ax  
     
    mov ah,02h
    lea dx,bx          ;in ra tung ky tu
    int 21h    
    
    dec si
    cmp si,0
    je exit
    jmp xuat_chuoi
    
    exit:
    mov ah,04Ch
    int 21h
main endp
end main
    
    
