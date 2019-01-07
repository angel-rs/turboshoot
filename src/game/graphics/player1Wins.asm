;-------------------------------------------------------------------------
; ---> Función player1Wins
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print, pressEnterToContinue
; DESCRIPCIÓN: Muestra introducción del juego

player1Wins:
  call clear

  call printGameBox

  ; -- position cursor
  mov al, 12
  mov ah, 35
  call gotoxy

  ; -- print winning message
  mov ecx, player1WinsMessage
  mov edx, player1WinsMessage.length
  call print

  ; --- sleep 2 seg
  mov eax, 2
  call sleep

  call pressEnterToContinue

  call mainMenu