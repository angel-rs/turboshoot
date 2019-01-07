;-------------------------------------------------------------------------
; ---> Función getGameInput
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: ...

getGameInput:
  ; --- Getting the input
    mov edx, 2                          ; longitud de la entrada a leer
    call getInput                       ; obtener input y es almacenado en bufferIn

  ; --- Comparing user input
    cmp byte[bufferIn], 'w'
    je .player1MoveUp
    cmp byte[bufferIn], 'a'
    je .player1MoveLeft
    cmp byte[bufferIn], 's'
    je .player1MoveDown
    cmp byte[bufferIn], 'd'
    je .player1MoveRight
    cmp byte[bufferIn], 'q'
    je player1Fire

    cmp byte[bufferIn], 'i'
    je .player2MoveUp
    cmp byte[bufferIn], 'j'
    je .player2MoveLeft
    cmp byte[bufferIn], 'k'
    je .player2MoveDown
    cmp byte[bufferIn], 'l'
    je .player2MoveRight
    cmp byte[bufferIn], 'o'
    je player2Fire

  .player1MoveUp:
    cmp byte[player1CurrentYPosition], 4        ; if:   close to upside invisible wall
    jle finishGetGameInput                      ;       ignore input
    call erasePlayer1                           ; else: remove player 1
    dec byte[player1CurrentYPosition]           ;       and decrease Y coordinate
    dec byte[bullet1StartPositionY]             ;       same to bullet1StartPositionY
    call printPlayer1
    jmp finishGetGameInput

  .player1MoveLeft:
    cmp byte[player1CurrentXPosition], 6        ; if:   close to leftside invisible wall
    jle finishGetGameInput                      ;       ignore input
    call erasePlayer1                           ; else: remove player 1
    dec byte[player1CurrentXPosition]           ;       then decrease X coordinate
    dec byte[bullet1StartPositionX]             ;       same to bullet1StartPositionX
    call printPlayer1
    jmp finishGetGameInput

  .player1MoveDown:
    cmp byte[player1CurrentYPosition], 21       ; if:   close to bottomside invisible wall
    jge finishGetGameInput                      ;       ignore input
    call erasePlayer1                           ; else: remove player 1
    inc byte[player1CurrentYPosition]           ;       and increase Y coordinate
    inc byte[bullet1StartPositionY]             ;       same to bullet1StartPositionY
    call printPlayer1
    jmp finishGetGameInput

  .player1MoveRight:
    cmp byte[player1CurrentXPosition], 75       ; if:   close to rightside invisible wall
    jge finishGetGameInput                      ;       ignore input
    call erasePlayer1                           ; else: remove player 1
    inc byte[player1CurrentXPosition]           ;       and increase X coordinate
    inc byte[bullet1StartPositionX]             ;       same to bullet1StartPositionX
    call printPlayer1
    jmp finishGetGameInput



  .player2MoveUp:
    cmp byte[player2CurrentYPosition], 4        ; if:   close to upside invisible wall
    jle finishGetGameInput                      ;       ignore input
    call erasePlayer2                           ; else: remove player 2
    dec byte[player2CurrentYPosition]           ;       and decrease Y coordinate
    dec byte[bullet2StartPositionY]             ;       same to player2CurrentPositionY
    call printPlayer2
    jmp finishGetGameInput

  .player2MoveLeft:
    cmp byte[player2CurrentXPosition], 6        ; if:   close to leftside invisible wall
    jle finishGetGameInput                      ;       ignore input
    call erasePlayer2                           ; else: remove player 2
    dec byte[player2CurrentXPosition]           ;       and decrease X coordinate
    dec byte[bullet2StartPositionX]             ;       same to player2CurrentPositionX
    call printPlayer2
    jmp finishGetGameInput

  .player2MoveDown:
    cmp byte[player2CurrentYPosition], 21       ; if:   close to bottomside invisible wall
    jge finishGetGameInput                      ;       ignore input
    call erasePlayer2                           ; else: remove player 2
    inc byte[player2CurrentYPosition]           ;       and increase Y coordinate
    inc byte[bullet2StartPositionY]             ;       same to bullet1StartPositionY
    call printPlayer2
    jmp finishGetGameInput

  .player2MoveRight:
    cmp byte[player2CurrentXPosition], 75       ; if:   close to rightside invisible wall
    jge finishGetGameInput                      ;       ignore input
    call erasePlayer2                           ; else: remove player 2
    inc byte[player2CurrentXPosition]           ;       and increase X coordinate
    inc byte[bullet1StartPositionX]             ;       same to bullet1StartPositionX
    call printPlayer2
    jmp finishGetGameInput

  finishGetGameInput:
    nop

  ret
