
org 100h
.model small
.stack 100h
.data 
g dw 1      ;green color 
g1 dw 1
r dw 220     ;red color
r1 dw 1
y dw 110     ;yellow
y1 dw 1
s dw 165      ;star 
s1 dw 65 
y2 dw 131
y3 dw 1        ;color outer of star
y4 dw 1  
yl dw 132       ;fill up left outer side of star
yl1 dw 85  
yr dw 200     ;fill up right outer side of star
yr1 dw 85
r2 dw ?        ;fill up down side  outer side of star
r3 dw 200d    
tem dw 109d 
tem1 dw 100d
.code
main proc
    mov ax,@data
    mov ds, ax
    mov ah, 0h
    mov al,13h
    int 10h 
    call drawGreen       ;green box color
    call drawstar        ;draw star line with yellow border
    call Yellowbox       ;fill up outer side of star
    MOV AH, 4CH          ;DOS EXIT
    INT 21H  
    ret
    endp main

drawGreen proc   
   Gbox: 
    mov cx,g
    mov dx,g1 
    mov ah,0ch          ;for green color  al=2
    mov al,2
    int 10h             ;increasing  g1(y++) vertically
    inc g1
    cmp g1,199d
    je hgreen
    jmp Gbox
    hgreen:
    inc g
    mov ax,1d         ;increasing  g(x++) horizotally
    mov g1,ax
    cmp g,220d
    je Rbox
    jmp Gbox 
    Rbox:
    mov cx,r
    mov dx,r1 
    mov ah,0ch    ;for red color
    mov al,4h     ;increasing  r1(y++) vertically
    int 10h 
    inc r1
    cmp r1,199d
    je hred
    jmp Rbox
    hred:
    inc r
    mov ax,1d
    mov r1,ax        ;increasing  r(x++) horizontally
    cmp r,319d
    je Ybox
    jmp Rbox  
    Ybox:   
    mov cx,y
    mov dx,y1 
    mov ah,0ch    
    mov al,14d        ;increasing  y1(y++) vertically
    int 10h 
    inc y1
    cmp y1,199d
    je hYellow
    jmp Ybox
  
    hYellow:
    inc y
    mov ax,1d         ;for Yellow color   
    mov y1,ax
    cmp y,132d          ;increasing  y(x++) horizontally
    je ybox2 
    mov r,220d
    jmp Ybox  
    
     HYellow1:
    mov cx,y
    mov dx,y1 
    mov ah,0ch    
    mov al,14d
    int 10h           ;increasing  Y1(y++) vertically
    inc y1
    cmp y1,199d
    je ybox2
    jmp HYellow1
    
    ybox2:
    dec r
    mov cx,r
    mov y,cx
    mov ax,1d
    mov y1,ax            ;increasing  r(x++) horizontally
    cmp y,197d
    je exit
    jmp   hYellow1
     
    exit:
    ret
endp drawGreen 

                   
drawstar proc 
               
        DstarUp1:
        mov cx ,s
        mov dx,s1
        mov ah,0ch         ;for Yellow star line color
        mov al ,14d 
        int 10h
        inc s               ;x+1=2+y
        inc s1
        inc s1
        cmp s1,87d
        jl DstarUp1
        mov s,165d
        mov s1,65d          ;upper1 triangle of star
        jmp DstarUp2
        
        DstarUp2:   
        mov cx ,s
        mov dx,s1
        mov ah,0ch         ;for Yellow star line color
        mov al ,14d 
        int 10h
        dec s                ; x-1=2+y
        inc s1
        inc s1
        cmp s1,87d
        jl DstarUp2 
        mov s,155d
        mov s1,85d      ;upper2 triangle of star
        jmp Dstarleft 
        
        DstarDown1:
            
        mov cx ,s
        mov dx,s1
        mov ah,0ch         ;for line4 
        mov al ,14d 
        int 10h
        dec s                 ; x-1=y+2
        inc s1
        inc s1
        cmp s1,116d
        jl DstarDown1 
        mov s,175d
        mov s1,85d 
       
        jmp Dstarright  
        
        Dstarleft :
        mov cx,s
        mov dx,s1
        mov ah,0ch
        mov al,14d
        int 10h
        dec s
        cmp s,132d
        jne Dstarleft
        mov s,131
        jmp Dstarleft2  
        
        Dstarleft2: 
        mov cx,s
        mov dx,s1
        mov ah,0ch
        mov al,14d
        int 10h
        inc s              ; 2+x=y+1
        inc s
        inc s1
        cmp s1,95d
        jl Dstarleft2
        jmp DstarDown1 
        
        DstarDown2:     
        mov cx ,s
        mov dx,s1
        mov ah,0ch              
        mov al ,14d 
        int 10h
        inc s                ;x+1= y+2
        inc s1 
        inc s1
        cmp s1,116d
        jl DstarDown2 
        mov s,165d
        mov s1,102d     
        jmp Dstardown3  
        
        Dstarright :
        mov cx,s
        mov dx,s1
        mov ah,0ch
        mov al,14d
        int 10h
        inc s             ;x++
        cmp s,198d
        jne Dstarright
        mov s ,199d
        jmp Dstarright2  
        
        Dstarright2: 
        mov cx,s
        mov dx,s1
        mov ah,0ch
        mov al,14d
        int 10h
        dec s
        dec s                ;x-2=y+1
        inc s1
        cmp s1,95d
        jne Dstarright2
        jmp DstarDown2  
        
        Dstardown3: 
        mov cx,s
        mov dx,s1
        mov ah,0ch
        mov al,14d
        int 10h             ;last line left
         dec s
         dec s               ;x-2=y+1
         inc s1
        cmp s1,114d
        jl Dstardown3
        mov s,165d
        mov s1,102d 
        jmp Dstardown4
       
        Dstardown4: 
        mov cx,s
        mov dx,s1
        mov ah,0ch
        mov al,14d
        int 10h               ;last line right
         inc s
         inc s                ;x+2=y+1
         inc s1
         cmp s1,115d
        jl Dstardown4
        jmp exit2 
        exit2:
        ret        
   endp drawstar
    
 Yellowbox proc
    
    YboxUp:
    mov cx,y2
    mov dx,y3
    mov ah,0ch
    mov al,14d
    int 10h 
    inc y3
    cmp y3,85d
    je Vyellow
    jmp YboxUp 
    
    Vyellow:
    inc y2
    mov ax,1d   ;1st half
    mov y3,ax
    cmp y2,155d
    jne YboxUp
    mov bx,85d  
    mov y3,85d
    jmp YboxUp1
    
    YboxUp1:
    mov cx ,y2
    mov dx,y4
    mov ah,0ch
    mov al,14d         ;2nd half
    int 10h                        
    inc y4
    cmp y4,bx
    je Vyellow1
    jmp YboxUp1 
    
    Vyellow1:
   
     inc y2
     mov y4,1d
     dec y3 
     dec y3 
     mov bx,y3
     cmp y2,165d
     jl YboxUp1 
     jmp YboxUp2      
     YboxUp2:
    mov cx ,y2
    mov dx,y4
    mov ah,0ch       ;3rd half
    mov al,14d
    int 10h            
    inc y4
    cmp y4,bx
    je Vyellow2
    jmp YboxUp2 
    
    Vyellow2:
     inc y2
     mov y4,1d
     inc y3 
     inc y3 
     mov bx,y3
     cmp y2,176d
     jl YboxUp2 
     mov y3,1d
     jmp YboxUp3
     
     YboxUp3:
    mov cx,y2
    mov dx,y3
    mov ah,0ch
    mov al,14d
    int 10h 
    inc y3
    cmp y3,85d
    je Vyellow3
    jmp YboxUp3 
    
    Vyellow3:
    inc y2
    mov ax,1d   ;5th half
    mov y3,ax
    cmp y2,201d
    jne YboxUp3 
    mov y4,85d
    jmp Yboxleft   
    Yboxleft:
        mov cx ,yl
        mov dx ,y4
        mov ah,0ch
        mov al,14d
        int 10h
        inc y4
        cmp y4,199d                            ;left half
        jne Yboxleft
        jmp Vleft
         
     Vleft:
     inc yl
     inc yl1
     mov bx,yl1
     mov y4,bx
     cmp yl1 ,95d
     jl Yboxleft  
     mov y3,133d
     mov yl,133d
     mov yl1,86d
     mov y4,86d
     jmp Yboxleft1
     
    Yboxleft1:
    
      mov cx,y3
      mov dx,y4
      mov ah,0ch
      mov al,14d
      int 10h
      inc y3
      inc y4
      cmp y4,95d
      jne Yboxleft1
      jmp Vleft1
      
      Vleft1:
      inc yl
      inc yl
      inc yl1
      mov bx,yl
      mov y3,bx            
      mov bx,yl1
      mov y4,bx  
      cmp y4,95d
      jl Yboxleft1  
      jmp Yboxleft3
      
      Yboxleft3:
    
      mov cx,y3
      mov dx,y4
      mov ah,0ch
      mov al,14d
      int 10h
      inc y4
      dec y3
      cmp y4,120d
      jne Yboxleft3
      jmp Vleft3
      
      Vleft3:
      dec yl
    
      inc yl1
      inc yl1
      mov bx,yl
      mov y3,bx 
                 
      mov bx,yl1
      mov y4,bx 
      
      cmp y4,120d
      
      jl Yboxleft3
      
      mov y3,137d
      mov y4,94d  
      mov  yl,137d
      mov yl1,94d
      mov bx,tem 
      
      jmp YboxleftF
      
      YboxleftF:
      
      mov cx,y3
      mov dx,y4
      mov ah,0ch
      mov al,14d
      int 10h
      
      inc y4
  
     
      cmp y4,bx
      jl YboxleftF
      jmp VleftF
      
      VleftF: 
      inc yl
      
      mov bx,yl
      mov y3,bx 
                 
      mov bx,yl1
      mov y4,bx 
    
      
      dec tem
    
      mov bx,tem
      
      cmp yl,151d  
      jl YboxleftF 
      mov bx,yr1
      mov r2,bx
      
      mov bx,tem1
      
      jmp Yrightbox
      
      
      Yrightbox:
      
      mov cx,r3
      mov dx,r2
      mov ah,0ch
      mov al,14d
      int 10h
      
      inc r2
      dec r3
  
     
      cmp r2,bx
      jl Yrightbox          ;yellow color --right part 
      jmp Vright
      
      Vright:
      dec yr
      dec yr
      inc yr1
      
      mov bx ,yr  
      mov r3,bx
      mov bx,yr1
      mov r2,bx  
      mov bx,tem1
      
      cmp yr1,90d
      jl Yrightbox  
      
      dec tem1
   
      mov bx,tem1
      cmp yr1,96d
      
      jl  Yrightbox  
     
       mov r3,180
       mov yr,179 
       mov tem,179d
       mov r2,96d 
       mov tem1,95d
     
      jmp   Yrightbox1  
      
      Yrightbox1:
       
       
      mov cx,r3
      mov dx,r2
      mov ah,0ch
      mov al,14d
      int 10h
      
      inc r3
    ; inc r2
      cmp r3,200d
      jne Yrightbox1
      jmp Vright1
      
      Vright1:
      inc yr
      inc yr1
     ; inc yr1
      mov bx,yr
      mov r3,bx 
                 
      mov bx,yr1
      mov r2,bx 
      
      cmp yr1,115d
      jl Yrightbox1  
     ; mov yr1,96d
      jmp v
      
      v:   
      inc tem
      inc tem1
      inc tem1
      mov bx,tem
      mov yr,bx
      mov r3,bx
      
      mov bx,tem1
      mov yr1,bx
      mov r2,bx
      
      cmp yr1,115d
      jl  Yrightbox1
       mov cx,181
       mov dx,95
       mov ah,0ch
       mov al ,14d
       int 10h  
       
       mov yr,200d
       mov yr1,85d 
       mov r1,85d
     
       jmp  YrightboxF 
      
 
      
      YrightboxF:
      
       mov cx,yr
       mov dx,r1
       mov ah,0ch
       mov al ,14d
       int 10h
       
       inc r1
       
       cmp r1,199d
       jne YrightboxF
       jmp Final1 
       
       Final1:
       inc yr1
       dec yr
       mov bx,yr1
       mov r1,bx 
      
       cmp yr1,95d
       jl YrightboxF 
       
       mov r3,165d
       mov yr,165d 
       mov tem,165d
       mov r2,102d 
       mov tem1,102d
       mov yr1,102d
     
      jmp   FFF  
      
     
      
       
       
       FFF:
       
       
       
      mov cx,r3
      mov dx,r2
      mov ah,0ch
      mov al,14d
      int 10h
      inc r2
      cmp r2,199d
      jne FFF
      jmp Vright11
      
      Vright11:
      inc yr
      inc yr1
    
      mov bx,yr
      mov r3,bx 
                 
      mov bx,yr1
      mov r2,bx 
      
      cmp yr1,125d
      jl FFF 
      jmp v1
      
      v1:   
      inc tem
      inc tem
      inc tem1
      mov bx,tem
      mov yr,bx
      mov r3,bx                                 
      mov bx,tem1
      mov yr1,bx
      mov r2,bx
      cmp yr,190d
      jl  FFF         
       mov r3,164d
       mov yr,164d 
       mov tem,164d
       mov r2,103d 
       mov tem1,103d
       mov yr1,103d
       jmp FFF1
       
       FFF1:
    
      mov cx,r3
      mov dx,r2
      mov ah,0ch
      mov al,14d
      int 10h
      
   
      inc r2
      cmp r2,199d
     
      jne FFF1
      jmp Vright12
      
      Vright12:
      dec yr
      inc yr1
    
      mov bx,yr
      mov r3,bx            
      mov bx,yr1
      mov r2,bx 
      cmp yr1,120d
      jl FFF1 
      jmp v2
      v2:   
      dec tem
      dec tem
      inc tem1
      mov bx,tem
      mov yr,bx
      mov r3,bx                                
      mov bx,tem1
      mov yr1,bx
      mov r2,bx
      cmp yr1,120d
      jl  FFF1
      jmp exit3                              
    exit3:
    ret
    endp Yellowbox                   
end main
          