;-------------------------------------------------------------------------
; ---> Función exit
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Sale del programa

exit:
  call clear

  call echoOn
  call canonicalOn

  mov eax, SYS_EXIT        ; invoke SYS_EXIT
  mov ebx, STDIN           ; Return a code of zero

  call systemInterruption
