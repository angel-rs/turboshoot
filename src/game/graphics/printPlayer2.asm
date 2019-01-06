;-------------------------------------------------------------------------
; ---> Función printPlayer2
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Posicion X,Y del personaje en al y ah correspondientemente
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy
; DESCRIPCIÓN:

printPlayer2:
  call resetCursor

  mov ah, [player2CurrentXPosition]
  mov al, [player2CurrentYPosition]

  call gotoxy

  mov ecx, player2
  mov edx, player2.length
  call print

  ret
