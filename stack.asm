stack_push:
    cmp dword [stack_i], stack_len
    jz stack_overflow
    
    mov ebx, [stack_i]
    mov al, [ecx]
    mov [stack+ebx], al
    inc dword [stack_i]
    ret
stack_overflow:
    mov edx, 1
    ret

stack_pop:
    cmp dword [stack_i], 0
    jz stack_empty

    dec dword [stack_i]
    mov ebx, [stack_i]
    mov al, [stack+ebx]
    mov [ecx], al
    ret
stack_empty:
    mov edx, 2
    ret

mirror_str:
    call    str_in_stack
    cmp     edx, 1
    jz      print_error_overflow
    
    call    str_out_stack
    cmp     edx, 2
    jz      print_error_empty
    
    mov     eax, msg_result
    call    sprint
 
    mov     eax, str_input
    call    sprintLF   
    
    ret
    
print_error_overflow:
    mov     eax, msg_err_overflow
    call    sprintLF
    ret
    
print_error_empty:
    mov     eax, msg_err_empty
    call    sprintLF
    ret 

str_in_stack:
    mov     ecx, str_input
    eachByte_in:
    cmp     byte [ecx], 0
    jz      finish_in
    
    call    stack_push
    inc     ecx
    jmp     eachByte_in  

    finish_in:
    ret

str_out_stack:
    mov     ecx, str_input
    eachByte_out:
    cmp     dword [stack_i], 0
    jz      finish_out
    
    call    stack_pop
    inc     ecx
    jmp     eachByte_out
    
    finish_out:
    ret
