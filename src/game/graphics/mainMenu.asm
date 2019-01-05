;-------------------------------------------------------------------------
; ---> Función mainMenu
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print
; DESCRIPCIÓN: Muestra el menú principal del juego

mainMenu:
  call printGameBox

  ; -> Imprime opciones del menú
  printMenu:
    ; -> Imprime 'Menu'
      mov ah, 39
      mov al, 10
      call gotoxy

      mov ecx, menuOption1
      mov edx, menuOption1.length
      call print

    ; -> Imprime 'Jugar'
      mov ah, 33
      mov al, 12
      call gotoxy

      mov ecx, menuOption2
      mov edx, menuOption2.length
      call print

    ; -> Imprime 'Instrucciones'
      mov ah, 33
      mov al, 13
      call gotoxy

      mov ecx, menuOption3
      mov edx, menuOption3.length
      call print

    ; -> Imprime 'Opciones'
      mov ah, 33
      mov al, 14
      call gotoxy

      mov ecx, menuOption4
      mov edx, menuOption4.length
      call print

    ; -> Imprime 'Salir'
      mov ah, 33
      mov al, 15
      call gotoxy

      mov ecx, menuOption5
      mov edx, menuOption5.length
      call print

  mov edx, 2                          ; longitud de la entrada a leer
  call getInput                       ; obtener input y es almacenado en bufferIn

  cmp byte[bufferIn], '1'
  je play

  cmp byte[bufferIn], '2'
  je instructions

  cmp byte[bufferIn], '3'
  je options

  cmp byte[bufferIn], '4'
  je _exit

  jmp mainMenu                          ; Si la entrada no es valida, vuelve a llamar a la rutina

  play:
    call gameLoop

  instructions:
    call clear
    call resetCursor

    mov ecx, gameInstructions
    mov edx, gameInstructions.length
    call print

    call pressEnterToGoBack
    jmp mainMenu

  options:
    call clear
    call resetCursor

    ; mov ecx, gameOptions
    ; mov edx, gameOptions.length
    ; call print

    call pressEnterToGoBack
    jmp mainMenu

  _exit:
    call clear

    mov al, 12
    mov ah, 39
    call gotoxy

    mov ecx, byeMessage
    mov edx, byeMessage.length
    call print

    mov eax, 2        ; 1 segundo
    call sleep        ; llamada a la rutina

    call exit

  ret
