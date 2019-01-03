;-------------------------------------------------------------------------
; ---> Función print
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Dirección del string a mostrar en ECX y longitud del string en EDX
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Muestra un string en consola a traves del llamado a SYS_WRITE
; del sistema operativo

print:
  mov eax, SYS_WRITE               ; Specify SYS_WRITE call
  mov ebx, SYS_EXIT                ; Specify File Descriptor 1: SYS_EXIT
  call systemInterruption

  ret
