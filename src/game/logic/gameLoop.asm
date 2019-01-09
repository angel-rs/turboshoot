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

  mov rdi, .getGameInput                    ; create a thread for reading user input
  call thread_create

  jmp timerThread

  .getGameInput:
    ; -- if gameFinishedFlag == 1: kill thread
      cmp byte[gameFinishedFlag], 1
      je .killInputThread                   ; kill thread process

    call getGameInput

      ; -- forced delay
      mov eax, 0
      mov ebx, 30000000                        ; 30ms/frame
      call sleep

    jmp .getGameInput

    .killInputThread:
      mov eax, 0
      mov ebx, 30000000                        ; 30ms/frame
      call sleep

      call killThread

  timerThread:
    cmp byte[timerValue], 9                ; if timer == 10
    je removeExtra0InTimer                  ;     remove extra 0 from console

    cmp byte[timerValue], 0                 ; if timer == 0:
    je onGameTimerReach0                    ;     kill the thread
    jmp continue

    continue:
      call gameTimer

      ; -- sleep one second
        mov eax, 1
        mov ebx, 0
        call sleep

      jmp timerThread

; checkUntilGameFinishes:
;   cmp byte[gameTimer], 0
;   je gameFinished
;
;   ; ; -- forced delay
;     mov eax, 0
;     mov ebx, 35000000                        ; 30ms/frame
;     call sleep
;
;   jmp checkUntilGameFinishes

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
