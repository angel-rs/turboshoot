;-------------------------------------------------------------------------
; ---> Función gameTimer
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: sleep, systemInterruption
; DESCRIPCIÓN: Actualiza el timer de la partida

gameTimer:
  call printGameTimer

  call .sleepOneSecond

  dec byte[timerValue]                    ; decrease 1 second

  cmp byte[timerValue], 9                 ; if timer == 9: remove extra 0 from console
  je .removeExtra0InTimer

  cmp byte[timerValue], 0                ; if timer == 0:
  je .onCounterReach0                    ;   toggle the gameFinished Flag
  jmp gameTimer                          ; else: continue counting...

.removeExtra0InTimer:
  call resetCursor

  ; -- position cursor
    mov ah, 41
    mov al, 24
    call gotoxy

  ; -- remove extra 0
    mov ecx, emptySpace
    mov edx, emptySpace.length
    call print

  ret

.onCounterReach0:
  inc byte[gameFinishedFlag]        ; make toggleGameFinishedFlag be 1
  call killThread                   ; kill thread process

.sleepOneSecond:
  push rax

  mov eax, 1
  call sleep

  pop rax

  ret
