;-------------------------------------------------------------------------
; ---> Función gameFinished
; ULTIMA ACTUALIZACIÓN: 07/01/2018
; RECIBE: Posición donde imprimir la explósion en X->ah, Y->al
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN:

gameFinished:
  call clear
  call resetCursor

  call restoreDefaults            ; reset defaults: values like bullets, the timer, score, etc... (In case they want to play again)

  ; -- checking who won
    mov ah, byte[player1Score]
    mov al, byte[player2Score]

    cmp ah, al                      ; if ah > al... player1 Wins
    jg player1Wins

  ; ---
    mov ah, byte[player1Score]
    mov al, byte[player2Score]

    cmp ah, al                      ; if ah < al... player2 Wins
    jl player2Wins

  ; ---
    mov ah, byte[player1Score]
    mov al, byte[player2Score]

    cmp ah, al                      ; if same score... Draw
    je draw
