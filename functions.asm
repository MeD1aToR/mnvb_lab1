%macro  sys_call   0
    %ifdef  MAC        
        push    edx
        push    ecx
        push    ebx
        push    eax
    %endif
        int     0x80

    %ifdef  MAC
        add     esp, 16
    %endif                
%endm

sread:

    push    eax
    push    ebx

    mov     ebx, 0
    mov     eax, 3
    sys_call
    
    pop     ebx
    pop     eax
    ret

slen:
    push    ebx
    mov     ebx, eax
 
    nextchar:
        cmp     byte [eax], 0
        jz      finished
        inc     eax
        jmp     nextchar
     
    finished:
        sub     eax, ebx
        pop     ebx
    
    ret
 
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
 
    mov     edx, eax
    pop     eax
 
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    sys_call
 
    pop     ebx
    pop     ecx
    pop     edx
    ret
 
sprintLF:
    call    sprint
 
    push    eax
    mov     eax, 0AH
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret

quit:
    mov     eax, msg_quit
    call    sprintLF
    mov     ebx, 0
    mov     eax, 1
    sys_call
    ret
