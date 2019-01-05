;-------------------------------------------------------------------------
; ---> Función atoi
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Nada
; RETORNA: Numeeo en eax
; MODIFICA: Nada
; LLAMA: Nada
; DESCRIPCIÓN: Convierte un numero de string a un entero y lo almacena en eax

atoi:
  mov eax, 0              ; Set initial total to 0

  .convert:
    movzx esi, byte [edi]   ; Get the current character
    test esi, esi           ; Check foe \0
    je .error

    cmp esi, 48             ; Anything less than 0 is invalid
    jl .error

    cmp esi, 57             ; Anything greater than 9 is invalid
    jg .error

    sub esi, 48             ; Convert from ASCII to decimal
    imul eax, 10            ; Multiply total by 10
    add eax, esi            ; Add current digit to total

    inc edi                 ; Get the address of the next character
    jmp .convert

  .error:
    mov eax, -1             ; return -1 on error

  .done:
    ret
