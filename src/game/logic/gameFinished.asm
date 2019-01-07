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
  mov al, 0
  mov ah, 0
  call gotoxy
  mov ecx, player1
  mov edx, player1.length
  call print

  call __dev__hang


  ; -- reset everything back to default
    call restoreDefaults

  ; -- check who won
    mov ah, [player1Score]
    mov al, [player2Score]

    cmp ah, al
    je .draw

    cmp ah, al
    jg player1Wins

    cmp al, ah
    jg player2Wins

    .draw:
      jmp draw

  ret
