;dem so nguyen to tu day so cho truoc, in ra ket qua so snt co trong day
.model small
isngto macro
        xor bx,bx 
        mov bl,2
        xor ah,ah
        mov al, [si]
        lap:  
            cmp ax, 2
            jb bang0
            cmp ax,2
            jz bang1
            xor dx,dx 
            div bx
            cmp dx, 0
            jz bang0
            mov al, [si]
            inc bx 
            cmp bx,ax
            jz bang1 
            jmp lap
        bang1: 
            jmp cong1    
        bang0:
            mov tmp,0 
endm         

.stack 100h
.data 
    msg1 db "So luong so nguyen to la: $"
    chuoi db 3,4,5,6,7,8,9,10
    tmp db 1 
    s db 0 
.code
    MAIN PROC 
        mov ax,@data
        mov ds,ax   
        
        mov es,ax
        mov bx,13
        push bx  
        
        mov ah,9
        lea dx, msg1       ;in thong bao
        int 21h
         
        xor cx,cx
        mov cl, 8        ;so luong phan tu trong mang cua chuoi
        ktra:
            lea si,chuoi      ;chi so si tro den dau mang chuoi[]
            tungso:
                isngto
                inc si
                loop tungso
            vao: 
                xor ax,ax
                mov al,s        ;gan kq so snt vao AL  
                ;chuyen doi so thanh chuoi roi in ra mhinh
                inra:
                    mov bx, 10
                    xor dx,dx
                    div bx
                    push dx
                    cmp ax,0
                    jz hienthi
                    jmp inra
                hienthi: 
                    pop dx
                    cmp dx,13
                    jz thoat
                    mov ah,2
                    add dl,30h      ;chuyen doi so thanh ky tu ASCII
                    int 21h
                    jmp hienthi    
                thoat:
                     mov ah,4Ch
                     int 21h 
            cong1:              ; thuc hien tang bien dem snt khi so ktra la snt
                add s,1
                inc si 
                loop tungso
                jmp vao 
        main endp
    end main
