;-------------------------------------------------------------------------
; ---> Función ansiCursorShow
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print
; DESCRIPCIÓN: Muestra el cursor de la terminal

ansiCursorShow:
  push ecx
  push edx

  mov ecx, ANSISHOW
  mov edx, ANSISHOW.LENGTH
  call print

  pop edx
  pop ecx

  ret
