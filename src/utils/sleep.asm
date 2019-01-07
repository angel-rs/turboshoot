;-------------------------------------------------------------------------
; ---> Función sleep
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: detiene la ejecución del programa por la cantidad de
; segundos que se encuentren en eax y nano segundos que se encuentren en ebx

sleep:
  push rax
  push rbx

  mov dword [tv_sec], eax
  mov dword [tv_usec], ebx
  mov eax, SYS_NANOSLEEP
  mov ebx, timeval

  call systemInterruption

  pop rbx
  pop rax

  ret
