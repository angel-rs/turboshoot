;-------------------------------------------------------------------------
; ---> Función printPlayer1Score
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Imprime el puntaje del jugador 1 en consola

printPlayer1Score:
  call resetCursor

  ; -- Position cursor
    mov al, 24
    mov ah, 26
    call gotoxy

  ; -- Print score
    mov eax, 0
    mov al, byte[player1Score]
    call printDecimalInteger

  ret
