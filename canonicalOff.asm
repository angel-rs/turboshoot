;-------------------------------------------------------------------------
; ---> Función canonicalOff
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: readStdinTermios, writeStdinTermios
; DESCRIPCIÓN: Apaga el modo canonico de la terminal

canonicalOff:
  call readStdinTermios

  mov eax, ICANON             ; clear canonical bit in local mode flags
  not eax
  and [TERMIOS + 12], eax

  call writeStdinTermios

  ret
