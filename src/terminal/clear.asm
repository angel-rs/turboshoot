;-------------------------------------------------------------------------
; ---> Función clear
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: Kernel SYS_WRITE
; DESCRIPCIÓN: Envía la instrucción para limpiar toda la consola

clear:
  mov ah, 0
  mov al, 0
  call gotoxy

  mov cl, 24                       ; guardar 24 en cl
  cleanLineLoop:
    push cx                        ;PRESERVE CX BEFORE IT CHANGES.

    mov ah, 0
    mov al, cl                     ; ir moviendonos en Y con el contador
    call gotoxy

    mov ecx, clearTerminal
    mov edx, clearTerminal.length
    call print

    pop cx

    dec cl                        ; cl--
    jnz cleanLineLoop             ; salta si cl no es 0

  ret
