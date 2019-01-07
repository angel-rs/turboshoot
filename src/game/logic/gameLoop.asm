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

  ; create thread for counter
  mov rdi, .timerThread
  call thread_create

  ; create thread for printing game status
  mov rdi, .printingThread
  call thread_create

  ; create a thread for reading user input
  mov rdi, .getGameInput
  call thread_create

  call __dev__hang

  .getGameInput:
    call getGameInput
    jmp .getGameInput

  .printingThread:
    call printPlayer1
    call printPlayer2
    call printPlayer1Score
    call printPlayer2Score
    call printPlayer1BulletInfo
    call printPlayer2BulletInfo
    call printGameTimer

    ; ~ 120 fps
    mov eax, 0                ; 0 seconds
    mov ebx, 8330000          ; 8.33 miliseconds
    call sleep                ; halt execution

    jmp .printingThread

  .timerThread:
    call gameTimer                ; this runs eternally
