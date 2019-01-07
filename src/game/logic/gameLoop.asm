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

  ; create thread for counter
    mov rdi, .timerThread
    call thread_create

  ; create a thread for reading user input
    mov rdi, .getGameInput
    call thread_create

  jmp checkUntilGameFinishes

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
      call killThread
      ret

  .timerThread:
    ; IN ONE OF THESE TWO LINES BREAKS THE CODE
    ; cmp byte[timerValue], 9                 ; if timer == 9: remove extra 0 from console
    ; je .removeExtra0InTimer

    cmp byte[timerValue], 0
    je .onCounterReach0
    ; mov al, [timerValue]
    ; mov ah, [ZERO]
    ; cmp al, ah                           ; if timer == 9: remove extra 0 from console
    ; je .onCounterReach0

    call gameTimer

    ; -- sleep one second
      mov eax, 1
      mov ebx, 500
      call sleep

    jmp .timerThread

    .onCounterReach0:
      call printGameTimer
      call killThread                   ; kill thread process

    .removeExtra0InTimer:
      ;  -- position cursor
        mov ah, 41
        mov al, 24
        call gotoxy

      ; -- remove extra 0
        mov ecx, emptySpace
        mov edx, emptySpace.length
        call print
        ret

checkUntilGameFinishes:
  mov dh, byte[gameTimer]
  cmp dh, 0
  je gameFinished

  ; -- forced delay
    mov eax, 0
    mov ebx, 35000000                        ; 30ms/frame
    call sleep

  jmp checkUntilGameFinishes
