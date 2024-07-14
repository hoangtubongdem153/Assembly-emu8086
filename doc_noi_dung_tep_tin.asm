;Doc noi dung mot tep tin (.txt) da tao san trong may tinh
.data
    tbao db "Doc noi dung tep .txt co san$"
    ;tao tep
    file db "c:\emu8086\mybuild\haha.txt",0     ;chi dinh file can doc
    fail db 10,13,"That bai!$"
    sucess db 10,13,"Thanh cong!$"  
    msg db 10,13,"Noi dung file: $"  
    string db "Hello world!"
    len db $ - string
    
    buffer db 50 dup("$")
    thefile dw ?   
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,tbao     ;in tbao chuong trinh
    int 21h
    
    
    ;doc noi dung file
    mov ah,09h
    lea dx,msg             ;in tbao noi dung file
    int 21h 
    
    mov ah,03Dh     ;mo file
    mov al,2        ;al=2 , chi dinh che do mo tep la doc
    lea dx,file
    int 21h
    
    jc err
    
    mov thefile,ax
    
    mov ah,03Fh     ;doc file
    lea dx,buffer       ;dx chua dia chi mang buffer[] de luu du lieu doc duoc
    mov cx,100      ;so byte can doc
    mov bx,thefile       ;dua file can doc (ma file handle) vao bx
    int 21h    
    
    jc err
    
    mov ah,03Eh          ;ham dong tep in bx
    mov bx,thefile
    int 21h
    
    mov ah,09h
    lea dx,buffer      ;in chuoi tu buffer[]
    int 21h
    jmp exit 
    
    err:
    mov ah,09h
    lea dx,fail      ;in tbao that bai neu co loi xay ra
    int 21h
                
    exit:
    mov ah,04Ch
    int 21h
main endp
end main
