;-------------------------------------------------------------------------
; ---> Función getKeyStroke
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Obtiene el codigo ascii del caracter introducido y lo
; almacena en bufferIn

getKeyStroke:
  mov eax, SYS_READ
  mov ebx, STDIN
  mov ecx, bufferIn
  mov edx, 1

  call systemInterruption

  ret
