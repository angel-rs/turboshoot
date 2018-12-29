;-----------------------------------;
; Estructura del Computador         ;
; Escuela de Ing. Informática       ;
;                                   ;
; Inicio del proyecto: 21/12/2018   ;
; Finalización del proyecto: ?      ;
;                                   ;
; Profesora: Oriana Renaud          ;
; Integrantes:                      ;
; -> Albornoz Gabriela              ;
; -> Rodríguez Angel                ;
; -> Medrano Raúl                   ;
;-----------------------------------;

; ---> Project environment variables declarations

; ---> Data section
section	.text
  global _start     ;must be declared for linker (ld)

section	.data
  msg1 db 'Hello, world!', 0xa  ;string to be printed
  msg2 db 'World, Hello!', 0xa
  len equ $ - msg1     ;length of the string

;  ---> Function declarations
funcHelloWorld:
  mov	edx, len     ;message length
  mov	ecx, msg1    ;message to write
  mov	ebx, 1       ;file descriptor (stdout)
  mov	eax, 4       ;system call number (sys_write)
  int	0x80        ;call kernel

  mov	eax, 1       ;system call number (sys_exit)
  int	0x80        ;call kernel

otherFunc:
  mov	edx, len     ;message length
  mov	ecx, msg2     ;message to write
  mov	ebx, 1       ;file descriptor (stdout)
  mov	eax, 4       ;system call number (sys_write)
  int	0x80        ;call kernel

  mov	eax, 1       ;system call number (sys_exit)
  int	0x80        ;call kernel

; ---> Program start
_start:	            ;tells linker entry point
   call funcHelloWorld
   call otherFunc
