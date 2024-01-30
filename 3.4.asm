%include "io.inc"
; работает только для чисел <=255

section .data
y dd 0
y1 dd 0
y2 dd 0
x dd 0
a dd 0

section .text
global main
main:
    mov ebp, esp
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    xor ecx, ecx
    
    GET_UDEC 1, [x]
    GET_UDEC 1, [a]

    mov eax, [x]
    cmp eax, [a]
    
    ;x>a
    jg x_big_a
    
    ;x<=a
    mov eax, [a]
    mov [y1], eax
    
    jmp to_y2
    
x_big_a:
    mov bx, 4
    div bx 
    mov [y1], edx
    
to_y2:
    xor edx, edx
    mov eax, [x]
    mov ebx, [a]
    mov ecx, [x]
    div ebx
    cmp eax, 3
    
    ; x/a>3
    jg x_div_a_big_3 
    ;x/a<=3
    mov [y2], ecx
    jmp to_y
 
x_div_a_big_3:
    xchg eax, ecx
    mul bl
    mov [y2], eax
to_y:
    mov eax, [y1]
    mov ebx, [y2]
    add  eax, ebx
    mov [y], eax
    
    PRINT_UDEC 1, [y]
    
    xor eax, eax
    ret