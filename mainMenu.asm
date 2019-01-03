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
    ; -> Imprime 'menu'
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

    ; -> Imprime 'Salir'
      mov ah, 33
      mov al, 14
      call gotoxy

      mov ecx, menuOption4
      mov edx, menuOption4.length
      call print

  ret
