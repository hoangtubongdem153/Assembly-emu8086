; Đề bài: Chuyển một số từ hệ 10 sang hệ 2 trên emu8086 (asembly) 


.model small     
.stack 100h
.data   
    tb0 DB 'Nhap vao mot so thap phan: $'
    tb1 DB 10, 13 , 'So da nhap dang nhi phan: $'
    str DB 5 dup ('$') ; bien luu tru chuoi nhap vao , toi da 5 ky tu

.code
main proc
    mov ax, @data
    mov ds, ax ; khoi tao thanh ghi data segment
    
    mov ax , '#' ; # dung de danh dau trong stack
    push ax     ; push ky tu '#' vao stack  
    
    ;in thong bao nhap 
    mov ah, 9
    lea dx, tb0
    int 21h
    
    ;nhap so dang chuoi
    mov ah, 10
    lea dx , str
    int 21h
                     
    mov cx, 0 ; lam rong bien dem
    ;chuyen chuoi thanh so 
    mov CL, [str+1] ; lay so ky tu cua chuoi duoc nhap vao (byte thu 2) 
    lea si, str+2 ; tro den dia chi cua ky tu dau tien cua chuoi str
    mov ax, 0;
    mov bx, 10 ; he so nhan
    
    thapphan: ; chuyen chuoi thanh so
        mul bx ; == ax * bx , nhan ax voi he so (10 or 16 or 2)
        mov dl, [si] ; lay gia tri tai vtri [si] cua chuoi ( '1' or '0' )
        sub dl, '0' ; tru voi '0' de chuyen doi tu ky tu ASCII sang ky tu so
        add ax, dx      ; ax dung de luu tru gia tri dang duoc tinh toan
        inc si ; tang si 1 donvi , tro den gia tri tiep theo trong chuoi 
        loop thapphan ; CL luu gia tri so lan lap , dung lai khi CL = 0    
    
    ; chuyen doi so thap phan thanh dang so nhi phan
    mov CL, 2 ; luc nay , CL luu gia tri he so chia 
    
    nhiphan: ;chuyen so thap phan sang nhi phan va day cac so vao ngan xep
        mov ah, 0 ; dat phan du = 0
        div CL ;  ax = ax : CL       ( thuong = al, du = ah)
        push ax   ; day ax vao ngan xep
        cmp al, 0 ; neu thuong (AL), neu khac 0 ,tiep tuc chia
        jne nhiphan ; jump if not equal
                                        
    ; in ra thong bao                                     
    mov ah , 9 
    lea dx, tb1 ; in ra thong bao tb1    
    int 21h
    
    mov ah ,2
    inkq: 
        pop dx ; lay tung phan tu trong stack , gan vao dx
        cmp dx , '#' ; kiem tra ky tu danh giau ket thuc stack
        je done 
        mov dl, dh  ; lay gia tri phan du (dh = ah) cua dx (ax) lay tu ngan xep
                    ; phan du duoc tinh tu dinh stack den cuoi stack
        add dl, '0' ; chuyen doi dang so sang dang ky tu ASCII
        int 21h ; ham 2h in ra 1 ky ra man hinh
        jmp inkq 
    
    done:       ;ket thuc chuong trinh
        mov ah, 4ch 
        int 21h
main endp 
end main 
