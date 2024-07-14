;Xoa mot tap tin (.txt) da tao san trong may
.data
    noti db "Xoa mot tap tin .txt da tao san trong may$"
    sucess db 10,13,"Thanh cong!$"
    fail db 10,13,"That bai!$"
    file db "c:\emu8086\mybuild\xinchao.txt",0
    
    thefile dw ?
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,tbao     ;tbao chuong trinh
    int 21h

    ;xoa file
    mov ah,41h      ;ham xoa file voi ten file = file
    lea dx,file
    int 21h
    
    jc err 
    
    mov ah,09h
    lea dx,sucess    ;neu k co loi, in ra thong bao thanh cong
    int 21h
    jmp exit
    
    err:
    mov ah,09h
    lea dx,fail      ;neu co loi,in ra thong bao that bai
    int 21h
    
    exit:
    mov ah,04Ch      ;thoat ctrinh
    int 21h
main endp
end main
