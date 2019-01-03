;-------------------------------------------------------------------------
; ---> Función getInput
; ULTIMA ACTUALIZACIÓN: 03/01/2019
; RECIBE: longitud de la entrada en edx
; RETORNA: bufferIn
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Lee un caracter y lo almacena en bufferIn
; NOTA: debe recibir la longitud de la entrada en edx

getInput:
  mov eax, SYS_READ
  mov ebx, STDIN
  mov ecx, bufferIn

  call systemInterruption

  ret
