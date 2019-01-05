;-------------------------------------------------------------------------
; ---> Función convertIntToString
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: EAX = integer value to convert,
;         ESI = pointer to buffer to store the string in (must have room for at least 10 bytes)
; RETORNA: EAX = pointer to the first character of the generated string
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: loop del juego

convertIntToString:
  add esi, 9
  mov byte [esi], 0

  mov ebx, 10

  .next_digit:
    xor edx, edx           ; Clear edx prior to dividing edx:eax by ebx
    div ebx                ; eax /= 10
    add dl, '0'            ; Convert the remainder to ASCII 
    dec esi                ; store characters in reverse order
    mov [esi] ,dl
    test eax, eax
    jnz .next_digit        ; Repeat until eax==0
    mov eax, esi

  ret
