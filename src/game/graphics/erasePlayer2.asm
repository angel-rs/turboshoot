;-------------------------------------------------------------------------
; ---> Función erasePlayer2
; ULTIMA ACTUALIZACIÓN: 06/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Borra del tablero al jugador 2

erasePlayer2:
  call resetCursor

  ; -- position cursor
  mov ah, [player2CurrentXPosition]
  mov al, [player2CurrentYPosition]
  call gotoxy

  ; -- remove player
  mov ecx, emptySpace
  mov edx, emptySpace.length
  call print

  ret
