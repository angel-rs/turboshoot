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
  ;call printGameCounter          ; needs to be run in parallel

  mov eax, SYS_CLONE ; vfork
  call systemInterruption



    ; call printPlayer1
    ; call printPlayer2
    ; call printPlayer1Score
    ; call printPlayer2Score
    ;
  ; call getGameInput               ; loops till eternity
  ;
  ; jmp gameLoop
