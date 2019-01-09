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

  ; -- forced delay - give a couple of seconds to the thread to kill itself
    mov eax, 0
    mov ebx, 30000000
    call sleep

  cmp byte[endGameFlag], 1
  je gameFinished                              ; Here we check who won; print the winning screen, etc
  jmp onGameTimerReach0
