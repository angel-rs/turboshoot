;-------------------------------------------------------------------------
; ---> Función restoreDefaults
; ULTIMA ACTUALIZACIÓN: 07/01/2018
; RECIBE: Posición donde imprimir la explósion en X->ah, Y->al
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN:

restoreDefaults:
  ; -- reset everything back to default
    mov byte[temp], 0
    mov byte[temp2], 0

    mov byte[timerValue], 60
    mov byte[gameFinishedFlag], 0

    mov byte[player1CurrentXPosition], 20
    mov byte[player1CurrentYPosition], 13
    mov byte[bullet1StartPositionX], 22
    mov byte[bullet1StartPositionY], 13
    mov byte[player1RemainingBullets], 10
    mov byte[player1ShotBulletFlag], 0
    mov byte[player1MovementsInSameAxis], 0
    mov byte[player1Score], 0

    mov byte[player2CurrentXPosition], 60
    mov byte[player2CurrentYPosition], 13
    mov byte[bullet2StartPositionX], 58
    mov byte[bullet2StartPositionY], 13
    mov byte[player2RemainingBullets], 10
    mov byte[player2ShotBulletFlag], 0
    mov byte[player2MovementsInSameAxis], 0
    mov byte[player2Score], 0

  ret
