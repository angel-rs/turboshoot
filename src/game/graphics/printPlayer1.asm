;-------------------------------------------------------------------------
; ---> Función printPlayer1
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: Posicion X,Y del personaje en al y ah correspondientemente
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy
; DESCRIPCIÓN:

printPlayer1:
  push rax
  push rcx
  push rdx

  call resetCursor

  mov ah, [player1CurrentXPosition]
  mov al, [player1CurrentYPosition]

  call gotoxy

  mov ecx, player1
  mov edx, player1.length
  call print

  pop rdx
  pop rcx
  pop rax

  ret