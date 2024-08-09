section .data
    prompt1 db 'Введите первое число: ', 0
    prompt2 db 'Введите второе число: ', 0
    prompt3 db 'Введите операцию (+, -, *, /): ', 0
    resultMessage db 'Результат: ', 0
    num1 db 0
    num2 db 0
    operation db 0
    result db 0

section .bss
    input resb 16

section .text
    global _start

_start:
    ; Ввод первого числа
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, 24
    int 0x80

    call read_input
    sub byte [input], '0'      ; Преобразуем символ в число
    mov [num1], al

    ; Ввод второго числа
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 24
    int 0x80

    call read_input
    sub byte [input], '0'      ; Преобразуем символ в число
    mov [num2], al

    ; Ввод операции
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt3
    mov edx, 35
    int 0x80

    call read_input
    mov [operation], al

    ; Выполнение операции
    mov al, [num1]
    mov bl, [num2]
    cmp [operation], '+'
    je addition
    cmp [operation], '-'
    je subtraction
    cmp [operation], '*'
    je multiplication
    cmp [operation], '/'
    je division

    jmp _exit

addition:
    add al, bl
    jmp print_result

subtraction:
    sub al, bl
    jmp print_result

multiplication:
    mul bl
    jmp print_result

division:
    xor ah, ah          ; Готовим для деления
    div bl
    jmp print_result

print_result:
    mov [result], al
    mov eax, 4
    mov ebx, 1
    mov ecx, resultMessage
    mov edx, 15
    int 0x80

    ; Вывод результата
    add [result], '0'   ; Преобразуем число в символ
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

_exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

read_input:
    ; Функция для чтения ввода
    mov eax, 3
    mov ebx, 0
    lea ecx, [input]
    mov edx, 16
    int 0x80
    ret
