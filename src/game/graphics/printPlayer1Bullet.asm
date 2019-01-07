;-------------------------------------------------------------------------
; ---> Función printPlayer1Bullet
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Posicion del jugador, X -> al, Y -> ah
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

printPlayer1Bullet:
  push rcx
  push rdx

  call resetCursor
  call gotoxy

  mov ah, [player1CurrentXPosition]
  mov al, [player1CurrentYPosition]

  call gotoxy

  mov ecx, bullet1
  mov edx, bullet1.length
  call print

  pop rcx
  pop rdx

  ret
