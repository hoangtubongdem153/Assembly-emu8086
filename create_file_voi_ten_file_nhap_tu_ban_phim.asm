;Tao mot tap tin moi, ten tap tin nhap vao tu ban phim, ghi noi dung vao tap tin do
.data   
    tbao db "Tao va ghi tap tin$"
    msg1 db 10,13,"Nhap ten file: $"  
    sucess1 db 10,13,"Tao file thanh cong!$"
    msg2 db 10,13,"Nhap noi dung file: $" 
    sucess2 db 10,13,"Ghi file thanh cong!$"
    fail db 10,13,"That bai!$"
    ;file luu trong c:\emu8086\mybuild\tungtt.txt 
    
    thefile dw ?
    tenfile db 50 dup(?)
    buffer db 50 dup("$") 
.code
start:
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,tbao          ;tbao chuong trinh
    int 21h
    
    mov ah,09h
    lea dx,msg1          ;in tbao nhap ten file
    int 21h
    
    mov si,0
    nhap_file:           ;nhap ten file , luu vao mang tenfile[]
    mov ah,01h
    int 21h
    cmp al,0Dh
    je tao_file
    mov tenfile[si],al      ;luu tru cac ky tu vao mang tenfile[]
    inc si
    jmp nhap_file
    
    tao_file:   
    mov ah,03Ch         ;ham tao file voi tenfile in dx
    lea dx,tenfile
    mov cx,0h
    int 21h
    
    jc err             ;neu co loi xay ra , CF dc set => xu ly loi o err
    
    sucess:
    mov thefile,ax      ;luu tru file handle code file vua tao tu AX => thefile
                        ;file handle (mot so nguyen dinh danh tep dang mo)
    ;mov ah,03Dh
    ;mov al,2
    ;lea dx,file
    ;int 21h
    
    mov ah,09h
    lea dx,sucess1       ;tbao tao file thanh congg
    int 21h
    
    mov ah,09h
    lea dx,msg2        ;tbao nhap noi dung file
    int 21h
    
    mov di,0
    nhap_nd:
    mov ah,01h        ;nhap ky tu
    int 21h        
    
    cmp al,0Dh
    je  ghi_file
    mov buffer[di],al        ;chuyen ky tu vua nhap vao mang buffer[]
    inc di
    jmp nhap_nd
    
    ghi_file:
    mov ah,40h           ;chuc nang ghi du lieu vao tep dang mo
    mov cx,di
    mov bx,thefile         ;ten tep chi dinh boi bien thefile => bx
    lea dx,buffer             ;ghi du lieu tu mang buffer => dx
    int 21h
    
    jc err                ;xay ra loi => di toi err
    
    mov ah,09h
    lea dx,sucess2         ;in tbao thanh cong
    int 21h 
    
    mov ah,03Eh            ;ham chuc nang dong tep luu trong bx (thefile)
    mov bx,thefile
    int 21h     
    jmp exit
    
    err:
    mov ah,09h
    lea dx,fail            ;in tbao that bai
    int 21h
    
    exit:
    mov ah,04Ch            ;thoat ctrinh
    int 21h 

end start  
