;-------------------------------------------------------------------------
; ---> Función forkProcess
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: string en edi
; RETORNA: la longitud del string recibido en eax
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN: Retorna la longitud del string suministrado en edi
; y lo almacena en eax

forkProcess:
  mov ax, SYS_FORK
  call systemInterruption

  ret
