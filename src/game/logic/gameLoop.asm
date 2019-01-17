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
  call printGUI

  mov rdi, __getGameInput                    ; create a thread for reading user input
  call thread_create

  jmp timerThread

  __getGameInput:
    ; -- if timer == 0: kill thread
      cmp byte[endGameFlag], 1
      je __killThread                            ; kill thread process

    call getGameInput

    ; -- RECHECK: remember that reading the keyboard input halts the code execution
    ; if timer == 0: kill thread
      cmp byte[endGameFlag], 1
      je __killThread

      ; -- forced delay
      mov eax, 0
      mov ebx, 30000000                        ; 30ms/frame
      call sleep

    jmp __getGameInput

    __killThread:
      call clear
      mov byte[endGameFlag], 1
      call killThread

  timerThread:
    cmp byte[gamePauseFlag], 1             ; if game is paused
    je .waitForGameToBeResumed             ;      wait for resume

    cmp byte[timerValue], 9                ; if timer == 10
    je removeExtra0InTimer                  ;     remove extra 0 from console

    cmp byte[timerValue], 0                 ; if timer == 0:
    je onGameTimerReach0                    ;     kill the thread
    jmp continue

    .waitForGameToBeResumed:
      ; delay
      mov eax, 0
      mov ebx, 30000000
      call sleep

      cmp byte[gamePauseFlag], 0          ; if game was resumed
      je timerThread

      cmp byte[endGameFlag], 1            ; if the user wants to quit the game
      je .endGame
      jmp .waitForGameToBeResumed

      .endGame:
        call clear
        call resetCursor
        call printGameBox
        call restoreDefaults
        mov eax, 0
        mov ebx, 30000000
        call sleep
        call mainMenu

    continue:
      call gameTimer

      ; -- sleep one second
        mov eax, 1
        mov ebx, 0
        call sleep

      jmp timerThread

removeExtra0InTimer:
  ;  -- position cursor
    mov ah, 41
    mov al, 24
    call gotoxy

  ; ; -- remove extra 0
    mov ecx, emptySpace
    mov edx, emptySpace.length
    call print
  jmp continue
