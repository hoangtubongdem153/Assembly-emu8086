;Đề bài: thực hiện nhập vào msv và kiểm tra, nếu đúng thì in họ và tên ra màn hình!
.model small
.stack 100     

.data        
tb1 db "Nhap MSV: $"
msv db "AT180350","$"
hoten db 13,10,"TRAN THANH TUNG $"
error db 13,10,"sai msv$"
str1 db 100,0,100 dup('$')  

.code
main proc
    mov ax,@data
    mov ds,ax
    
    ;in tb nhap masv    
        mov ah,09h  
        lea dx,tb1
        int 21h     
    
    ;luu masv vao bien str1     
        mov ah,10      
        lea dx,str1
        int 21h     
                    
    ;gan cx = 0                
        xor cx,cx 
        
  
    
    check:
    ;Tro den vi tri ky tu thu 3 trong str1
    lea si,str1+2          
    
    ;Lay gia tri do dai cua chuoi str1
    mov cl,[str1+1]  
    
    ;Tro den masv mau
    lea di, msv
       
    lap:       
        ;xoa noi dung thanh ghi ax
        xor ax,ax  
        
        ;lay ki tu tu str1 gan vao AL
        mov al,[si]    
        ;so sanh voi ky tu cua str1 va tb2
        cmp al,[di]   
        
        ;Neu khong khop , in tb roi thoat
        jne notsame    
        ;tiep tuc vong lap
        inc si
        inc di
        loop lap
                       
        ;in ra hovaten neu so sanh khop
        mov ah,9 
        lea dx, hoten
        int 21h   
        ;thoat
        jmp Exit
        
        notsame:
            lea dx, error
            mov ah,9
            int 21h
            jmp Exit
                   
    Exit:
        mov ah,4ch
        int 21h
main endp
end main
