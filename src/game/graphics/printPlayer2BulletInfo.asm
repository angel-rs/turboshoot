;-------------------------------------------------------------------------
; ---> Función printPlayer2BulletInfo
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Imprime la cantidad de balas restantes al jugador 2

printPlayer2BulletInfo:
  call resetCursor

  ; -- Position cursor
    mov al, 24
    mov ah, 54
    call gotoxy

  ; -- Print bullet 'icon'
    mov ecx, remainingBulletsInfo
    mov edx, remainingBulletsInfo.length
    call print

  ; -- Position cursor
    mov al, 24
    mov ah, 55
    call gotoxy

  ; -- Print amount of remaining bullets
    mov eax, 0
    mov al, byte[player2RemainingBullets]
    call printDecimalInteger

  ret
