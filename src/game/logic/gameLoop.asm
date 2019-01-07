;-------------------------------------------------------------------------
; ---> Función gameLoop
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: loop del juego

gameLoop:
  call clear
  call printGameBox
  call .printGui

  ; create thread for counter
  mov rdi, .timerThread
  call thread_create

  ; create a thread for reading user input
  mov rdi, .getGameInput
  call thread_create
                                  ; --- main process is here
  call __dev__hang

  .getGameInput:
    call getGameInput

      ; -- forced delay
      mov eax, 0
      mov ebx, 30000000                        ; 30ms/frame
      call sleep

    jmp .getGameInput

  .timerThread:
    call gameTimer                ; this runs eternally

  .printGui:
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
