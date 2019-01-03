;-------------------------------------------------------------------------
; ---> Función canonicalOn
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: readStdinTermios, writeStdinTermios
; DESCRIPCIÓN: Enciende el modo canonico de la terminal

canonicalOn:
  call readStdinTermios

  or dword [TERMIOS + 12], ICANON     ; set canonical bit in local mode flags

  call writeStdinTermios

  ret
