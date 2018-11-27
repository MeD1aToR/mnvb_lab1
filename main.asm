%include        'functions.asm'
%include        'stack.asm'

 
SECTION .data

msg_enter           db      '=== МНБВ Лаб. №1 ===', 0h
msg_add             db      0Ah, 'Введите строку: ', 0h
msg_result          db      'Результат: ', 0h
msg_err_overflow    db      'Ошибка: Стек переполнен!', 0h
msg_err_empty       db      'Ошибка: Стек пуст!', 0h
msg_quit            db      '====================', 0h
 
SECTION .bss

str_input:        resb   32
str_input_len:    equ    $ - str_input
stack:            resb   10
stack_len:        equ    $ - stack
stack_i:          resd   1
 
SECTION .text
global  _start
 
_start:
 
  mov dword [stack_i], 0
  mov     eax, msg_enter
  call    sprintLF

  add_str:
  mov     eax, msg_add
  call    sprintLF
  
  mov     edx, str_input_len
  mov     ecx, str_input
  call    sread
  
  mov     edx, 0
  call    mirror_str

  cmp     edx, 0
  jz      add_str

  call    quit








