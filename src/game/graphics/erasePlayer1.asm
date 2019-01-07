;-------------------------------------------------------------------------
; ---> Función erasePlayer1
; ULTIMA ACTUALIZACIÓN: 06/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Borra del tablero al jugador 1

erasePlayer1:
  call resetCursor

  ; -- position cursor
  mov ah, [player1CurrentXPosition]
  mov al, [player1CurrentYPosition]
  call gotoxy

  ; -- remove player
  mov ecx, emptySpace
  mov edx, emptySpace.length
  call print

  ret
