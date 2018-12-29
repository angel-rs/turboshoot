;-----------------------------------;
; Estructura del Computador         ;
; Escuela de Ing. Informática       ;
;                                   ;
; Fecha inicio: 21/12/2018          ;
; Fecha finalización: ?             ;
;                                   ;
; Profesora: Oriana Renaud          ;
; Integrantes:                      ;
; -> Albornoz Gabriela              ;
; -> Rodríguez Angel                ;
; -> Medrano Raúl                   ;
;-----------------------------------;

; ---> Data section
section	.text
  global _start     ;must be declared for linker (ld)

section	.data
  ; -- Misc Values
    clearTerminal: db 27, "[2J"
  	clearTerminalLength	equ $-clearTerminal

  ; -- Menu values
    menuOptions db "MENU:",13,10
                db "1. Jugar",13,10
                db "2. Instrucciones",13,10
                db "3. Salir",13,10
    menuOptionsLength     equ $ - menuOptions

;  ---> FUNCTION DECLARATIONS

;-------------------------------------------------------------------------
; ---> Función clear
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: Kernel sys_write
; DESCRIPCIÓN: Envía la instrucción para limpiar toda la consola

clear:
  push eax	                     ; Save pertinent registers
  push ebx
  push ecx
  push edx

  mov ecx, clearTerminal          ; Pass offset of terminal control string
  mov edx, clearTerminalLength    ; Pass the length of terminal control string
  call print                      ; Send control string to console

  pop edx                         ; Restore pertinent registers
  pop ecx
  pop ebx
  pop eax

  ret

;-------------------------------------------------------------------------
; ---> Función print
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Dirección del string a mostrar en ECX y longitud del string en EDX
; RETORNA: Nada
; MODIFICA: Nada
; CALLS: Kernel sys_write
; DESCRIPCIÓN: Muestra un string en consola a traves del llamado a sys_write
;  del sistema operativo

print:
  push eax       ; Save pertinent registers
  push ebx

  mov eax, 4     ; Specify sys_write call
  mov ebx, 1     ; Specify File Descriptor 1: Stdout
  int 80H        ; Make the kernel call

  pop ebx        ; Restore pertinent registers
  pop eax

  ret

;-------------------------------------------------------------------------
; ---> Función printMenu
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; CALLS: función print
; DESCRIPCIÓN: Muestra el menú del juego

printMenu:
  push eax	                      ; Save pertinent registers
  push ebx
  push ecx
  push edx

  mov ecx, menuOptions            ; Pass offset of terminal control string
  mov edx, menuOptionsLength      ; Pass the length of terminal control string
  call print                      ; Send control string to console

  pop edx                         ; Restore pertinent registers
  pop ecx
  pop ebx
  pop eax

  ret

_start:
  call printMenu

  ; Finalizar programa
  mov eax, 1
  int 0x80



























; TODO:

; getInput:
; 	mov eax, 3        ; input
; 	mov ebx, 0        ; | stdin
; 	mov ecx, input    ; | stores variable in input
; 	mov edx, 1        ; | length of input
; 	int 80h           ; \ system call
; 	ret

; --------------> F.A.Q <------------
; ¿Qué es 13,10 en los datos en la sección de data?
; ---> El interprete los interpreta por su significado en ASCII:
;   10: salto de linea
;   13: retorno de carro
