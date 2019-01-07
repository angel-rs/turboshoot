;-------------------------------------------------------------------------
; ---> Función printPlayer1RemainingBullets
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Imprime la cantidad de balas restantes al jugador 1

printPlayer1RemainingBullets:
  call resetCursor

  ; -- Position cursor
    mov al, 24
    mov ah, 5
    call gotoxy

  ; -- Print amount of remaining bullets
    mov eax, 0
    mov al, byte[player1RemainingBullets]
    call printDecimalInteger

  ret
