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

  dec byte[timerValue]                    ; decrease 1 second

  ret
