;-------------------------------------------------------------------------
; ---> Función ansiCursorHide
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print
; DESCRIPCIÓN: esconde el cursor de la terminal

ansiCursorHide:
  push rcx
  push rdx

  mov ecx, ANSIHIDE
  mov edx, ANSIHIDE.LENGTH
  call print

  pop rdx
  pop rcx

  ret
