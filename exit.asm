;-------------------------------------------------------------------------
; ---> Función exit
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Sale del programa

exit:
  mov eax, SYS_EXIT        ; invoke SYS_EXIT
  mov ebx, STDIN           ; Return a code of zero

  call systemInterruption
