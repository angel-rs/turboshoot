;-------------------------------------------------------------------------
; ---> Función printGameBoard
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Imprime 'gameBoard' en la terminal

printGameBoard:

  ; -- position the cursor
  mov al, 4
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow1
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 5
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow2
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 6
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow3
  call getLengthAndPrint

  ; -- position the cursor
  mov al, 7
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow4
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 8
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow5
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 9
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow6
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 10
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow7
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 11
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow8
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 12
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow9
  call getLengthAndPrint

  ; -- position the cursor
  mov al, 13
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow10
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 14
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow11
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 15
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow12
  call getLengthAndPrint

  ; -- position the cursor
  mov al, 16
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow13
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 17
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow14
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 18
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow15
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 19
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow16
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 20
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow17
  call getLengthAndPrint


  ; -- position the cursor
  mov al, 21
  mov ah, 5
  call gotoxy
  ; -- print row
  mov ebx, gameBoardRow18
  call getLengthAndPrint

  ret
