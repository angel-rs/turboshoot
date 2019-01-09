;-------------------------------------------------------------------------
; ---> Función player2Wins
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print, pressEnterToContinue
; DESCRIPCIÓN: Muestra introducción del juego

player2Wins:
  call clear
  call printGameBox

  ; -- position cursor
    mov al, 12
    mov ah, 35
    call gotoxy

  ; -- print winning message
    mov ecx, player2WinsMessage
    mov edx, player2WinsMessage.length
    call print

  ; --- sleep 2 seg
    mov eax, 1
    call sleep

  call restoreDefaults            ; reset defaults: values like bullets, the timer, score, etc... (In case they want to play again)

  call pressEnterToContinue

  call mainMenu
