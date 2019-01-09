;-------------------------------------------------------------------------
; ---> Función onGameTimerReach0
; ULTIMA ACTUALIZACIÓN: 09/01/2018
; RECIBE: Posición donde imprimir la explósion en X->ah, Y->al
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN: Acción a realizar cuando el contador del juego llega a 0

onGameTimerReach0:
  call printGameTimer
  call killThread                   ; kill thread process
