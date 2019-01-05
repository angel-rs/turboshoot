ICANON      equ 1<<1
ECHO        equ 1<<3

sys_exit    equ 1
sys_read    equ 3
sys_write   equ 4
stdin       equ 0
stdout      equ 1


global _start

SECTION     .bss
lpBufIn     resb    2
lpBufOut    resb    2
termios     resb 36

section .text
_start:
    call    echo_off
    call    canonical_off

    .GetCode:
        call    GetKeyCode
        movzx   esi, byte[lpBufIn]

        push    esi
        call    PrintNum
        pop     esi
        cmp     esi, 81
        jne     .GetCode

;       va a terminar el programa...

        call    echo_on
        call    canonical_on

        mov     eax, sys_exit
        xor     ebx, ebx
        int     80H

;~ #########################################
GetKeyCode:
    mov     eax, sys_read
    mov     ebx, stdin
    mov     ecx, lpBufIn
    mov     edx, 1
    int     80h
    ret

;~ #########################################
canonical_off:
        call read_stdin_termios

        ; clear canonical bit in local mode flags
        mov eax, ICANON
        not eax
        and [termios+12], eax

        call write_stdin_termios
        ret

;~ #########################################
echo_off:
        call read_stdin_termios

        ; clear echo bit in local mode flags
        mov eax, ECHO
        not eax
        and [termios+12], eax

        call write_stdin_termios
        ret

;~ #########################################
canonical_on:
        call read_stdin_termios

        ; set canonical bit in local mode flags
        or dword [termios+12], ICANON

        call write_stdin_termios
        ret

;~ #########################################
echo_on:
        call read_stdin_termios

        ; set echo bit in local mode flags
        or dword [termios+12], ECHO

        call write_stdin_termios
        ret

;~ #########################################
read_stdin_termios:
        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5401h
        mov edx, termios
        int 80h
        ret

;~ #########################################
write_stdin_termios:
        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5402h
        mov edx, termios
        int 80h
        ret

PrintNum:
    push    lpBufOut
    push    esi
    call    dwtoa

    mov     edi, lpBufOut
    call    GetStrlen
    inc     edx
    mov     ecx, lpBufOut
    mov     eax, sys_write
    mov     ebx, stdout
    int     80H
    ret

;~ #########################################
GetStrlen:
    push    ebx
    xor     ecx, ecx
    not     ecx
    xor     eax, eax
    cld
    repne   scasb
    mov     byte [edi - 1], 10
    not     ecx
    pop     ebx
    lea     edx, [ecx - 1]
    ret

;~ #########################################
dwtoa:
;~ number to convert = [ebp+8]
;~ pointer to buffer that receives number = [ebp+12]
    push    ebp
    mov     ebp, esp

    push    ebx
    push    esi
    push    edi

    mov     eax, [ebp + 8]
    mov     edi, [ebp + 12]

    test    eax, eax
    jnz     .sign

.zero:
    mov     word [edi], 30H
    jmp     .done

.sign:
    jns     .pos
    mov     byte [edi], "-"
    neg     eax
    add     edi, 1

.pos:
    mov     ecx, 3435973837
    mov     esi, edi

.doit:
    mov     ebx, eax
    mul     ecx
    shr     edx, 3
    mov     eax, edx
    lea     edx, [edx * 4 + edx]
    add     edx, edx
    sub     ebx, edx
    add     bl, "0"
    mov     [edi], bl
    add     edi, 1
    cmp     eax, 0
    jg      .doit

    mov     byte [edi], 0

.fixit:
    sub     edi, 1
    mov     al, [esi]
    mov     ah, [edi]
    mov     [edi], al
    mov     [esi], ah
    add     esi, 1
    cmp     esi, edi
    jl      .fixit

.done:
    pop     edi
    pop     esi
    pop     ebx

    mov     esp, ebp
    pop     ebp
    ret     4 * 2
