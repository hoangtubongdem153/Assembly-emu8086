;Chuong trinh doi tat ca cac ky tu in hoa thanh in thuong
.data
    tbao db "Chuong trinh doi tat ca cac ky tu in hoa thanh in thuong$"
    tb1 db 10,13,"Chuoi can chuyen doi: $"
    result db 10,13,"Ket qua: $" 
                                   
    chuoi db 50 dup(?) 
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,tbao    ;in tbao chuong trinh
    int 21h
    
    mov ah,09h
    lea dx,tb1      ;in tbao y/c nhap so can chuyen doi
    int 21h
    
    mov si,0        ;luu tru chi muc bat dau cua mang ky tu 
  nhap_chuoi:
    mov ah,01h
    int 21h           ;nhap ky tu
    
    cmp al,0Dh        ;ktra gia tri Enter
    je  nhap_xong                          
    mov chuoi[si],al      ;ghi gia tri vao mang chuoi[]
    inc si
    jmp nhap_chuoi
    
  nhap_xong:
    mov di,0   
    mov ax,0 
    
  convert: 
    cmp di,si
    je  done 
    mov al,chuoi[di]      ;lay tung ki tu trong mang ky tu      
    
    cmp al,41h                                            
    jl  continue
    cmp al,5Ah            ;kiem tra neu ky tu khong phai chu HOA, tiep tuc
    jg  continue
    add al,20h
    mov chuoi[di],al 
      
  continue:
    inc di
    jmp convert
    
  done:
    mov ah,09h
    lea dx,result     ;in tbao kqua
    int 21h
    
    mov si,0
    mov bx,0
  xuat:                      ;xuat ketqua va thoat chuong trinh
    mov bl,chuoi[si]
    mov ah,02h
    lea dx,bx  
    int 21h
    inc si
    cmp si,di
    je  exit
    jmp xuat
    
    exit:
    mov ah,04Ch
    int 21h
main endp
end main
