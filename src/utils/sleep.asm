;-------------------------------------------------------------------------
; ---> Función sleep
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: detiene la ejecución del programa por la cantidad de
; segundos que se encuentren en eax

sleep:
  push eax
  push ebx

  mov dword [tv_sec], eax
  mov dword [tv_usec], 0
  mov eax, SYS_NANOSLEEP
  mov ebx, timeval

  call systemInterruption

  pop ebx
  pop eax

  ret
