section .data
    digite db 'Digite um número de 1 a 9:', 0xA
    tamanho_digite equ $-digite
    
    inicio_disco db 'Mova o disco '
    tamanho_inicio_disco equ $-inicio_disco
    
    de db ' de '
    tamanho_de equ $-de
    
    para db ' para '
    tamanho_para equ $-para
    
    disco db ' '
    tamanho_disco equ $-disco
    
    inicio db ' '
    tamanho_inicio equ $-inicio
    
    fim db ' ', 0xA
    tamanho_fim equ $-fim
    
    concluido db 'Concluido!'
    tamanho_concluido equ $-concluido
    
section .bss
    entrada resb 1
section .text
    global _start
_start:

    call imprimir
    mov ecx, digite
    mov edx, tamanho_digite
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, entrada
    mov edx, 1
    int 0x80
    
    mov eax, [entrada]
    sub eax, 0x30
    
    push eax
    push dword 1
    push dword 2
    push dword 3
    
    call torre_de_hanoi
    call saida
torre_de_hanoi:

    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 20]
    
    cmp eax, 0
    je remover_ebp
    
    sub eax, 1
    
    push eax
    push dword [ebp + 16]
    push dword [ebp + 8]
    push dword [ebp + 12]
    
    call torre_de_hanoi
    
    push dword [ebp + 20]
    push dword [ebp + 8]
    push dword [ebp + 16]
    
    call printar
    
    mov eax, [ebp + 20]
    sub eax, 1
    
    push eax
    push dword [ebp + 12]
    push dword [ebp + 16]
    push dword [ebp + 8]
    
    call torre_de_hanoi
    
remover_ebp:
    
    mov esp, ebp
    pop ebp
    ret

printar:
    
    push ebp
    mov ebp, esp
    
    call imprimir
    mov ecx, inicio_disco
    mov edx, tamanho_inicio_disco
    int 0x80
    
    mov eax, [ebp + 16]
    add al, 0x30
    mov [disco], al
    
    call imprimir
    mov ecx, disco
    mov edx, tamanho_disco
    int 0x80
    
    call imprimir
    mov ecx, de
    mov edx, tamanho_de
    int 0x80
    
    mov eax, [ebp + 8]
    add al, 0x40
    mov [inicio], al
    
    call imprimir
    mov ecx, inicio
    mov edx, tamanho_inicio
    int 0x80
    
    call imprimir
    mov ecx, para
    mov edx, tamanho_para
    int 0x80
    
    mov eax, [ebp + 12]
    add al, 0x40
    mov [fim], al
    
    call imprimir
    mov ecx, fim
    mov edx, tamanho_fim
    int 0x80
    
    call remover_ebp
    
    ret
    
imprimir:
    mov eax, 4
    mov ebx, 1
    ret
    
saida:
    call imprimir
    mov ecx, concluido
    mov edx, tamanho_concluido
    int 0x80
    
    mov eax, 1
    mov ebx, 0
    int 0x80
