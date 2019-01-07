;-------------------------------------------------------------------------
; ---> Función printGUI
; ULTIMA ACTUALIZACIÓN: 07/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN:

printGUI:
  call printPlayer1
  call printPlayer2
  call printPlayer1Score
  call printPlayer2Score
  call printPlayer1RemainingBullets
  call printPlayer2RemainingBullets

  ; -- printing score messages for player 1
    ; -- Position cursor
      mov al, 24
      mov ah, 8
      call gotoxy
    ; -- Print message
      mov ecx, player1ScoreMessage
      mov edx, player1ScoreMessage.length
      call print
  ; -- printing bullet icon for player 2
    ; -- Position cursor
      mov al, 24
      mov ah, 4
      call gotoxy
    ; -- Print bullet 'icon'
      mov ecx, remainingBulletsInfo
      mov edx, remainingBulletsInfo.length
      call print

  ; -- printing score messages for player 2
    ; -- Position cursor
      mov al, 24
      mov ah, 58
      call gotoxy
    ; -- Print message
      mov ecx, player2ScoreMessage
      mov edx, player1ScoreMessage.length
      call print
  ; -- printing bullet icon for player 2
    ; -- Position cursor
      mov al, 24
      mov ah, 54
      call gotoxy
    ; -- Print bullet 'icon'
      mov ecx, remainingBulletsInfo
      mov edx, remainingBulletsInfo.length
      call print

  ret
