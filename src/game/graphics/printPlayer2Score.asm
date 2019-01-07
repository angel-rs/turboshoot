;-------------------------------------------------------------------------
; ---> Función printPlayer2Score
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Imprime el puntaje del jugador 2 en consola

printPlayer2Score:
  call resetCursor

  ; -- Position cursor
    mov al, 24
    mov ah, 76
    call gotoxy

  ; -- Print score
    mov eax, 0
    mov al, byte[player2Score]
    call printDecimalInteger

  ret
