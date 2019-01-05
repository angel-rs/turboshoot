;-------------------------------------------------------------------------
; ---> Función getGameInput
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: ...

getGameInput:
  mov edx, 2                          ; longitud de la entrada a leer
  call getInput                       ; obtener input y es almacenado en bufferIn

  cmp byte[bufferIn], 'w'
  je whatthefuck

  jmp getGameInput

  whatthefuck:
    mov ecx, player1
    mov edx, player1.length
    call print
    call __dev__hang

  ret
