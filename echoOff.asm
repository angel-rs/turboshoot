;-------------------------------------------------------------------------
; ---> Función echoOff
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: readStdinTermios, writeStdinTermios
; DESCRIPCIÓN: Hace que la terminal no imprima lo que introduce el usuario

echoOff:
  call readStdinTermios

  mov eax, ECHO           ; clear echo bit in local mode flags
  not eax
  and [TERMIOS + 12], eax

  call writeStdinTermios
  ret
