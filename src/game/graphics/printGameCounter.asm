;-------------------------------------------------------------------------
; ---> Función printGameCounter
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: loop del juego

printGameCounter:
  call resetCursor

  ; -- position cursor
    mov al, 24
    mov ah, 40
    call gotoxy

  ; -- convert integer to a printable string (ascii)
    mov eax, [timerValue]
    lea esi, [buffer]
    call convertIntToString                ; now the string values is in eax
    ;mov timerValueMessage, eax

  ; -- print current value of timer
    ;sub eax, 
    mov ebx, eax
    call getLengthAndPrint              ; print it

  ; --- sleep 1 seg
    call .sleepOneSecond

  ; --- decrement timer
    dec byte[timerValue]

  ; -- if timer reaches 0, go to menu
    cmp byte [timerValue], 0
    je mainMenu
    jmp printGameCounter

    .sleepOneSecond:
      push eax

      mov eax, 1
      call sleep

      pop eax

      ret
