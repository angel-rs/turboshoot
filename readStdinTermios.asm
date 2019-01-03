;-------------------------------------------------------------------------
; ---> Función readStdinTermios
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Lee los parametros de configuración de la terminal y
; los almacena en TERMIOS

readStdinTermios:
  mov eax, 36h
  mov ebx, STDIN
  mov ecx, 5401h
  mov edx, TERMIOS

  call systemInterruption

  ret
