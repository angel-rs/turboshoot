;-------------------------------------------------------------------------
; ---> Función writeStdinTermios
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Re-escribe la configuración de la terminal

writeStdinTermios:
  mov eax, 36h
  mov ebx, STDIN
  mov ecx, 5402h
  mov edx, TERMIOS

  call systemInterruption

  ret
