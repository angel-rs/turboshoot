;-------------------------------------------------------------------------
; ---> Función gameIntro
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print, pressEnterPrompt
; DESCRIPCIÓN: Muestra introducción del juego

gameIntro:
  call resetCursor

  ; -> Imprimir titulo del juego 1 linea por segundo
    mov ecx, titleLine1                 ; Carga el string en ecx
    mov edx, titleLine1.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 1 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine2                 ; Carga el string en ecx
    mov edx, titleLine2.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 2 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine3                 ; Carga el string en ecx
    mov edx, titleLine3.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 3 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine4                 ; Carga el string en ecx
    mov edx, titleLine4.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 4 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine5                 ; Carga el string en ecx
    mov edx, titleLine5.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 5 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine6                 ; Carga el string en ecx
    mov edx, titleLine6.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 5 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

  call pressEnterPrompt                 ; Espera a que el usuario presione 'Enter'
  ret
