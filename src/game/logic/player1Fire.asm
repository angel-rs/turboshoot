;-------------------------------------------------------------------------
; ---> Función player1Fire
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

player1Fire:
  push eax

  mov ah, [player1CurrentXPosition]
  mov al, [player1CurrentYPosition]
  call printPlayer1Bullet

  pop eax

  ret
