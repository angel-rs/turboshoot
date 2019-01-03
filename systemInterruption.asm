;-------------------------------------------------------------------------
; ---> Función systemInterruption
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: Nada
; DESCRIPCIÓN: Llama la interrupción del sistema al sistema operativo

systemInterruption:
  int 0x80
  ret
