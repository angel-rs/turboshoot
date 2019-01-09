;-------------------------------------------------------------------------
; ---> Función printPlayer2Bullet
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Posicion del jugador, X -> al, Y -> ah
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

printPlayer2Bullet:
  call resetCursor
  call gotoxy

  mov ah, [bullet2StartPositionX]
  mov al, [temp2]
  call gotoxy

  mov ecx, bullet2
  mov edx, bullet2.length
  call print

  ret
