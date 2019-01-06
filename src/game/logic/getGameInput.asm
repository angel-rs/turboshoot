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
    ; cmp byte[bufferIn], 'o'
    ; je .player2Fire

  .player1MoveUp:
    cmp byte[player1CurrentYPosition], 4        ; if: close to upside invisible wall
    jle .skip                                   ;     ignore input and skip
    dec byte[player1CurrentYPosition]           ; else: decrese Y coordinate
    ret

  .player1MoveLeft:
    cmp byte[player1CurrentXPosition], 5        ; if: close to leftside invisible wall
    jle .skip                                   ;     ignore input and skip
    dec byte[player1CurrentXPosition]           ; else: decrease X coordinate
    ret

  .player1MoveDown:
    cmp byte[player1CurrentYPosition], 21       ; if: close to bottomside invisible wall
    jge .skip                                   ;     ignore input and skip
    inc byte[player1CurrentYPosition]           ; else: increase Y coordinate
    ret

  .player1MoveRight:
    cmp byte[player1CurrentXPosition], 76       ; if: close to rightside invisible wall
    jge .skip                                   ;     ignore input and skip
    inc byte[player1CurrentXPosition]           ; else: increase X coordinate
    ret



  .player2MoveUp:
    cmp byte[player2CurrentYPosition], 4        ; if: close to upside invisible wall
    jle .skip                                   ;     ignore input and skip
    dec byte[player2CurrentYPosition]
    ret

  .player2MoveLeft:
    cmp byte[player2CurrentXPosition], 5        ; if: close to leftside invisible wall
    jle .skip
    dec byte[player2CurrentXPosition]
    ret

  .player2MoveDown:
    cmp byte[player2CurrentYPosition], 21       ; if: close to bottomside invisible wall
    jge .skip
    inc byte[player2CurrentYPosition]
    ret

  .player2MoveRight:
    cmp byte[player2CurrentXPosition], 76       ; if: close to rightside invisible wall
    jge .skip
    inc byte[player2CurrentXPosition]
    ret

  .skip:
    ret

  ret
