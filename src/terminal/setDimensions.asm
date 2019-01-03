;-------------------------------------------------------------------------
; ---> Función setDimensions
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy
; DESCRIPCIÓN: Establece las dimensiones de la consola

setDimensions:
  mov ah, terminal_max_x
  mov al, terminal_max_y
  call gotoxy

  ret
