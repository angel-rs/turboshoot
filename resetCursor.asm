;-------------------------------------------------------------------------
; ---> Función resetCursor
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy
; DESCRIPCIÓN: Resetea el cursor a la posición 0,0 de la terminal

resetCursor:
  mov ah, 0
  mov al, 0

  call gotoxy

  ret
