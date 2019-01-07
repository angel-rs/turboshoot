;-------------------------------------------------------------------------
; ---> Función timerThread
; ULTIMA ACTUALIZACIÓN: 07/01/2018
; RECIBE: Posición donde imprimir la explósion en X->ah, Y->al
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN:

timerThread:
  ; IN ONE OF THESE TWO LINES BREAKS THE CODE
  ; cmp byte[timerValue], 9                 ; if timer == 9: remove extra 0 from console
  ; je .removeExtra0InTimer

  cmp byte[timerValue], 0
  je .onCounterReach0

  call gameTimer

  ; -- sleep one second
    mov eax, 1
    mov ebx, 500
    call sleep

  jmp timerThread

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
