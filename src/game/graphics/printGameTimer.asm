;-------------------------------------------------------------------------
; ---> Función printGameTimer
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy, systemInterruption, printDecimalInteger, sleep
; DESCRIPCIÓN: Imprime el contador de la partida

printGameTimer:
  call resetCursor

  ; -- position cursor
    mov ah, 40
    mov al, 24
    call gotoxy

  ; -- print current value of timer
    mov eax, 0
    mov al, byte[timerValue]
    call printDecimalInteger

  ret
