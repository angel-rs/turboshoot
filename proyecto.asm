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

section .text
  global _start

; ---> Data section
section .data
  ; -- Misc Values
    sys_exit equ 1
    sys_read equ 3
    sys_write equ 4

    stdin equ 0
    stdout equ 1

    input.size equ 1024

    o: db "1",10
    o.length equ $-o

    emptyCharacter: db " ",10
    emptyCharacter.length equ $-emptyCharacter

    continuePrompt db "Presione 'Enter' para continuar",10
    continuePrompt.length equ $-continuePrompt

    clearTerminal: db 27, "[2J"
  	clearTerminal.length equ $-clearTerminal

    PosTerm:  db 27, "[01;01H"               ; <ESC>[<Y>;<X>H
    POSLEN:   equ $-PosTerm                 ; Length of term position string

    ; This table gives us pairs of ASCII digits from 0-80. Rather than
    ; calculate ASCII digits to insert in the terminal control string,
    ; we look them up in the table and read back two digits at once to
    ; a 16-bit register like DX, which we then poke into the terminal
    ; control string PosTerm at the appropriate place. See gotoxy.
    ; If you intend to work on a larger console than 80 X 80, you must
    ; add additional ASCII digit encoding to the end of Digits. Keep in
    ; mind that the code shown here will only work up to 99 X 99.
      Digits: db "0001020304050607080910111213141516171819"
              db "2021222324252627282930313233343536373839"
              db "4041424344454647484950515253545556575859"
              db "606162636465666768697071727374757677787980"

  ; -- Menu values
    menuOptions db "MENU:",13,10
                db "1. Jugar",13,10
                db "2. Instrucciones",13,10
                db "3. Salir",13,10
    menuOptionsLength equ $ - menuOptions

; ---> Reservando espacio para variables sin inicializar
;section .bss
  ;input resb input.size	                  ; max of 1024 characters

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
  mov edx, clearTerminal.length    ; Pass the length of terminal control string
  call print                      ; Send control string to console

  pop edx                         ; Restore pertinent registers
  pop ecx
  pop ebx
  pop eax

  ret

;-------------------------------------------------------------------------
; ---> Función gotoxy: Posiciona el cursor en una posición x, y dada
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: X en AH, Y en AL
; RETORNA: Nada
; MODIFICA: secuencia de string (PosTerm) de la terminal
; LLAMA: Kernel sys_write
; DESCRIPCIÓN: Prepares a terminal control string for the X,Y coordinates
;   passed in AL and AH and calls sys_write to position the
;   console cursor to that X,Y position. Writing text to the
;   console after calling gotoxy will begin display of text
;   at that X,Y position. to generate X, Y hex values, reference to:
;   http://hextodecimal.com/index.php?hex=05

gotoxy:
  pushad                              ; Save caller's registers
  xor ebx, ebx                        ; Zero EBX
  xor ecx, ecx                        ; Ditto ECX

  ; Poke the Y digits:
  mov bl, al                          ; Put Y value into scale term EBX
  mov cx, word [Digits + ebx * 2]     ; Fetch decimal digits to CX
  mov word [PosTerm + 2], cx	        ; Poke digits into control string

  ; Poke the X digits:
  mov bl, ah                          ; Put X value into scale term EBX
  mov cx, word [Digits + ebx * 2]     ; Fetch decimal digits to CX
  mov word [PosTerm + 5], cx          ; Poke digits into control string

  ; Send control sequence to stdout:
  mov ecx, PosTerm                     ; Pass address of the control string
  mov edx, POSLEN                      ; Pass the length of the control string
  call print                           ; Send control string to the console

  popad                                ; Restore caller's registers
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
  push eax                         ; Save pertinent registers
  push ebx

  mov eax, sys_write               ; Specify sys_write call
  mov ebx, sys_exit                ; Specify File Descriptor 1: sys_exit
  int 80h                          ; Make the kernel call

  pop ebx                          ; Restore pertinent registers
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

  mov ax, 1717h                   ; X,Y = 1,23 as a single hex value in AX
  call gotoxy                     ; Position the cursor

  mov ecx, menuOptions            ; Pass offset of terminal control string
  mov edx, menuOptionsLength      ; Pass the length of terminal control string
  call print                      ; Send control string to console

  pop edx                         ; Restore pertinent registers
  pop ecx
  pop ebx
  pop eax

  ret

pressEnterPrompt:
  ; Posicionar el cursor
  mov ax, 0117h                        ; X,Y = 1,23 as a single hex value in AX
  call gotoxy

  ; Mostrar el prompt
  mov ecx, continuePrompt             ; Carga el string continuePrompt en ecx
  mov edx, continuePrompt.length      ; Carga la longitude de continuePrompt en edx
  call print

  ; Esperar a que presione 'Enter'
  mov eax, sys_read                   ; Code for sys_read
  mov ebx, stdin                      ; Specify File Descriptor 0: Stdin
  int 0x80                            ; Llamar al kernel

  ret


;-------------------------------------------------------------------------
; ---> Función getInput
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; CALLS: *
; DESCRIPCIÓN: Lee por teclado y almacena el dato en input

; getInput:
;   mov eax, 3        ; input
;   mov ebx, 0        ; | stdin
;   mov ecx, input    ; | stores variable in input
;   mov edx, 1        ; | length of input
;   int 80h           ; \ system call
;   ret

;-------------------------------------------------------------------------
; ---> Función _start
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; CALLS: *
; DESCRIPCIÓN: Lógica de turboshoot

_start:

  mov ax, 1405h ; X,Y = 20,05
  call gotoxy

  ; mov ecx, o
  ; mov edx, o.length
  ; call print

  call pressEnterPrompt

  ; mov ax, 1445h ; X,Y = 20,05
  ; call gotoxy
  ;
  ; mov ecx, emptyCharacter
  ; mov edx, emptyCharacter.length
  ; call print

  ; ; Position the cursor for the "Press Enter" prompt:
  ; mov ax, 1702h         ; X,Y = 1,23 as a single hex value in AX
  ; call gotoxy           ; Position the cursor
  ;
  ; mov ecx, o
  ; mov edx, o.length
  ; call print
  ; ;call printMenu

  ; Finalizar programa
  call exit

;-------------------------------------------------------------------------
; ---> Función exit
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; CALLS: Nada
; DESCRIPCIÓN: Sale del programa

exit:
  mov eax, sys_exit        ; invoke sys_exit
  mov ebx, stdin                ; Return a code of zero
  int 0x80                 ; kernel call

; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> DEV FUNCTIONS <<<<<<<<<<<<<<<<<<<<<<<<<<
;-------------------------------------------------------------------------
; ---> Función __dev__hang
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; CALLS: Nada
; DESCRIPCIÓN: 'Ginda' el programa

__dev__hang:
  jmp $

;-------------------------------------------------------------------------
; ---> Función __dev__hang
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; CALLS: Nada
; DESCRIPCIÓN: probar código de fuentes extenernas facilmente: insertandolo
;   en esta función y llamandola en cualquier parte, preferiblemente en
;   _start

__dev__test_func:
  ret
