;-------------------------------------------------------------------------
; ---> Función echoOn
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: readStdinTermios, writeStdinTermios
; DESCRIPCIÓN: Enciende el modo ECHO de la terminal

echoOn:
  call readStdinTermios

  or dword [TERMIOS+12], ECHO ; set echo bit in local mode flags

  call writeStdinTermios

  ret
