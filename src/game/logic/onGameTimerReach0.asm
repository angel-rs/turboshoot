;-------------------------------------------------------------------------
; ---> Función onGameTimerReach0
; ULTIMA ACTUALIZACIÓN: 09/01/2018
; RECIBE: Posición donde imprimir la explósion en X->ah, Y->al
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN: Acción a realizar cuando el contador del juego llega a 0

onGameTimerReach0:
  ; -- this is executed by the main process, not a thread
  call printGameTimer                           ; Print the timer for a last time (the 0 value)
  jmp gameFinished                              ; Here we check who won; print the winning screen, etc
