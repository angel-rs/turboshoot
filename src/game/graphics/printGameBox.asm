;-------------------------------------------------------------------------
; ---> Función printGameBox
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Dirección del string a mostrar en ECX y longitud del string en EDX
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Dibuja la caja del juego
;

printGameBox:
  call clear
  call resetCursor

  ; -- Imprimir barras laterales
    mov cl, 24                 ; guardar 22 en cl
    printLoop:
      push cx                   ;PRESERVE CX BEFORE IT CHANGES.

      mov ah, 0
      mov al, cl                ; ir moviendonos en Y con el contador
      call gotoxy

      mov ecx, boxLine2
      mov edx, boxLine2.length
      call print                ;RESTORE CX FOR PREVIOUS VALUE.

      pop cx

      dec cl                    ; decrease the counter
      cmp cl, 2
      jne printLoop             ; salta si cl no es 2

  ; -- Imprimir primeras dos lineas superiores
    mov ah, 0
    mov al, 3
    call gotoxy

    mov ecx, boxLine1
    mov edx, boxLine1.length
    call print

    mov ah, 0
    mov al, 4
    call gotoxy

    mov ecx, boxLine1
    mov edx, boxLine1.length
    call print

  ; -- Imprimir primeras dos lineas inferiores
    mov ah, 0
    mov al, 23
    call gotoxy

    mov ecx, boxLine1
    mov edx, boxLine1.length
    call print

    mov ah, 0
    mov al, 24
    call gotoxy

    mov ecx, boxLine1
    mov edx, boxLine1.length
    call print

  ret
