;Chuong trinh doi tat ca cac ky tu in thuong thanh in hoa
.data
    tbao db "Chuong trinh doi tat ca cac ky tu in thuong thanh in hoa$"
    tb1 db 10,13,"Chuoi can chuyen doi: $"
    result db 10,13,"Ket qua: $" 
                                   
    chuoi db 50 dup(?) 
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,tbao   ;in noi dung chuong trinh
    int 21h
    
    mov ah,09h
    lea dx,tb1   ;in y/c nhap chuoi can chuyen doi 
    int 21h
    
    mov si,0      ;luu chi so cua mang  
    
  nhap_chuoi:    ;nhap chuoi ky tu 
    mov ah,01h            ;doc 1 ky tu va luu vao AL
    int 21h     
    
    cmp al,0Dh         ;kiem tra Enter
    je  nhap_xong
    mov chuoi[si],al   ;luu gia tri vao mang chuoi[]
    inc si
    jmp nhap_chuoi       ;nhap den khi gap ky tu Enter
    
  nhap_xong:
    mov di,0   
    mov ax,0          
    
  convert: 
    cmp di,si
    je  done 
    mov al,chuoi[di]      ;lay tung ky tu trong mang chuoi   
    
    cmp al,61h       ;kiem tra dk thoa man ky tu thuong
    jl  continue        ;neu la ky tu in hoa , thi bo qua, tiep tuc kiem tra ky tu tiep theo 
    cmp al,7Ah
    jg  exit
    sub al,20h       ;chuyen doi ky tu thuong => ky tu hoa (- 20H)
    mov chuoi[di],al    
    
  continue:
    inc di
    jmp convert
    
  done:
    mov ah,09h
    lea dx,result        ;in tbao ketqua
    int 21h
    
    mov si,0
    mov bx,0       
    
  xuat:               ;in tung gia tri cua mang ra man hinh
    mov bl,chuoi[si]
    mov ah,02h
    lea dx,bx  
    int 21h  
    
    inc si
    cmp si,di         ;tiep tuc thuc hien in ky tu den het mang
    je  exit
    jmp xuat
    
  exit:
    mov ah,04Ch        ;thoat ctrinh
    int 21h 
    
main endp
end main
