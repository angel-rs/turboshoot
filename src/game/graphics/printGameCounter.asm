;-------------------------------------------------------------------------
; ---> Función printGameCounter
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

printGameCounter:
  call resetCursor

  ; -- position cursor
    mov al, 24
    mov ah, 40
    call gotoxy

  ; -- print current value of timer
    mov eax, 0
    mov al, byte[timerValue]
    call printDecimalInteger

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
