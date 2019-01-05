;-------------------------------------------------------------------------
; ---> Función getLengthAndPrint
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Dirección del string a mostrar en EBX
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Muestra un string en consola a traves del llamado a SYS_WRITE
; del sistema operativo del cual no se tiene la longitud

getLengthAndPrint:

  mov edi, ebx
  call strlen
  mov edx, eax        ; almacena la longitud del string en edx

  call print

  ret
