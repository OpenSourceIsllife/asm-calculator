section .data
    hello_msg db 'Hello World!', 0

section .text
    global _start

_start:
    mov eax, 4          ; Системный вызов для вывода
    mov ebx, 1          ; Файловый дескриптор stdout
    mov ecx, hello_msg  ; Адрес строки для вывода
    mov edx, 13         ; Длина строки
    int 0x80            ; Вызов ядра

    ; Системный вызов для завершения программы
    mov eax, 1
    xor ebx, ebx
    int 0x80
