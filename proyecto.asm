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


; ============================ Text Section ============================
section .text
  global _start

; ============================= BSS Section ============================
section .bss
  buffer: resb 64 ; reserve 64 bytes

; ============================ Data Section ============================
section .data
  answer db `\e[31m\     hola    \e[m\     hola2`,10,0
  answer.length equ $-answer

  SYS_EXIT equ 1
  SYS_READ equ 3
  SYS_WRITE equ 4
  SYS_NANOSLEEP equ 162

  STDIN equ 0
  STDOUT equ 1

  terminal_max_x equ 24               ; Última coordenada en el eje X
  terminal_max_y equ 80               ; Última coordenada en el eje Y

  titleLine1 db 10, 10, 10, 10, 10, 10, 10, 10, `\e[31m\          _                 _\e[m\                  _                    _     `
  titleLine1.length equ $-titleLine1
  titleLine2 db 10, 13, `\e[31m\         | |_  _   _  _ __ | |__    ___\e[m\   ___ | |__    ___    ___  | |_   `
  titleLine2.length equ $-titleLine2
  titleLine3 db 10, 13, `\e[31m\         | __|| | | || .__|| ._ \\  / _ \\\e[m\ / __|| ._ \\  / _ \\  / _ \\ | __|  `
  titleLine3.length equ $-titleLine3
  titleLine4 db 10, 13, `\e[31m\         | |_ | |_| || |   | |_) || (_) |\e[m\\\__ \\| | | || (_) || (_) || |_   `
  titleLine4.length equ $-titleLine4
  titleLine5 db 10, 13, `\e[31m\          \\__| \\__,_||_|   |_.__/  \\___/\e[m\ |___/|_| |_| \\___/  \\___/  \\__|  `
  titleLine5.length equ $-titleLine5

  emptyCharacter db " ",10
  emptyCharacter.length equ $-emptyCharacter

  continuePrompt db "Presione 'Enter' para continuar... "
  continuePrompt.length equ $-continuePrompt

  clearTerminal db 27, "[2J"
	clearTerminal.length equ $-clearTerminal

  PosTerm  db 27, "[01;01H"               ; <ESC>[<Y>;<X>H
  POSLEN equ $-PosTerm                 ; Length of term position string

  menuOptions db "MENU:",13,10
              db "1. Jugar",13,10
              db "2. Instrucciones",13,10
              db "3. Salir",13,10
  menuOptionsLength equ $ - menuOptions

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

  timeval:
    tv_sec  dd 0
    tv_usec dd 0

; ============================= Functions ==============================

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

;-------------------------------------------------------------------------
; ---> Función setDimensions
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy
; DESCRIPCIÓN: Establece las dimensiones de la consola

setDimensions:
  mov ah, terminal_max_x
  mov al, terminal_max_y
  call gotoxy

  ret

;-------------------------------------------------------------------------
; ---> Función clear
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: Kernel SYS_WRITE
; DESCRIPCIÓN: Envía la instrucción para limpiar toda la consola

clear:
  mov ecx, clearTerminal          ; Pass offset of terminal control string
  mov edx, clearTerminal.length   ; Pass the length of terminal control string
  call print                      ; Send control string to console

  ret

;-------------------------------------------------------------------------
; ---> Función gotoxy: Posiciona el cursor en una posición x, y dada
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: X en AH, Y en AL
; RETORNA: Nada
; MODIFICA: secuencia de string (PosTerm) de la terminal
; LLAMA: Kernel SYS_WRITE
; DESCRIPCIÓN: Prepares a terminal control string for the X,Y coordinates
; passed in AL and AH and LLAMA SYS_WRITE to position the
; console cursor to that X,Y position. Writing text to the
; console after calling gotoxy will begin display of text
; at that X,Y position. to generate X, Y hex values, reference to:
; http://hextodecimal.com/index.php?hex=05

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

  ; Send control sequence to STDOUT:
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
; LLAMA: Kernel SYS_WRITE
; DESCRIPCIÓN: Muestra un string en consola a traves del llamado a SYS_WRITE
; del sistema operativo

print:
  mov eax, SYS_WRITE               ; Specify SYS_WRITE call
  mov ebx, SYS_EXIT                ; Specify File Descriptor 1: SYS_EXIT
  call systemInterruption

  ret

;-------------------------------------------------------------------------
; ---> Función printMenu
; ULTIMA ACTUALIZACIÓN: 28/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print
; DESCRIPCIÓN: Muestra el menú del juego

printMenu:
  mov ax, 1717h                   ; X,Y = 1,23 as a single hex value in AX
  call gotoxy                     ; Position the cursor

  mov ecx, menuOptions            ; Pass offset of terminal control string
  mov edx, menuOptionsLength      ; Pass the length of terminal control string
  call print                      ; Send control string to console

  ret

;-------------------------------------------------------------------------
; ---> Función pressEnterPrompt
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy, print, systemInterruption
; DESCRIPCIÓN: Hace que el usuario tenga que presionar 'Enter'

pressEnterPrompt:
  call resetCursor

  ; operacion aritmetica
  mov bl, terminal_max_y              ; guardando en bl la cantidad de columnas de la terminal
  mov bh, continuePrompt.length       ; guardando la longitud del mensaje a mostrar en bh
  sub bl, bh                          ; le resta a la cantidad de columnas, la longitud del mensaje y lo guarda en bl

  ; Posicionar el cursor
  mov al, terminal_max_y
  mov ah, bl                          ; posicion en X a mostrar el mensaje
  call gotoxy

  ; Mostrar el prompt
  mov ecx, continuePrompt             ; Carga el string continuePrompt en ecx
  mov edx, continuePrompt.length      ; Carga la longitude de continuePrompt en edx
  call print

  ; Esperar a que presione 'Enter'
  call getCharacterInput

  ret

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
  mov dword [tv_sec], eax
  mov dword [tv_usec], 0
  mov eax, SYS_NANOSLEEP
  mov ebx, timeval

  call systemInterruption

  ret

;-------------------------------------------------------------------------
; ---> Función gameIntro
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print, pressEnterPrompt
; DESCRIPCIÓN: Muestra introducción del juego

gameIntro:
  call resetCursor

  ; -> Imprimir titulo del juego 1 linea por segundo
    mov ecx, titleLine1                 ; Carga el string en ecx
    mov edx, titleLine1.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 1 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine2                 ; Carga el string en ecx
    mov edx, titleLine2.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 2 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine3                 ; Carga el string en ecx
    mov edx, titleLine3.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 3 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine4                 ; Carga el string en ecx
    mov edx, titleLine4.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 4 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

    mov ecx, titleLine5                 ; Carga el string en ecx
    mov edx, titleLine3.length          ; Carga la longitud del string en edx
    call print                          ; Imprime linea 5 del titulo

    mov eax, 1                          ; Carga 1 en eax
    call sleep                          ; Llama a sleep

  call pressEnterPrompt                 ; Espera a que el usuario presione 'Enter'
  ret

;-------------------------------------------------------------------------
; ---> Función resetCursor
; ULTIMA ACTUALIZACIÓN: 01/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy
; DESCRIPCIÓN: Resetea el cursor a la posición 0,0 de la terminal

resetCursor:
  mov ah, 00h
  mov al, 00h
  call gotoxy

  ret

;-------------------------------------------------------------------------
; ---> Función getCharacterInput
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Lee por teclado y almacena el caracter en buffer

getCharacterInput:
  ; reading input
  mov eax, SYS_READ
  mov ebx, STDIN
  mov ecx, buffer       ; save user input in buffer
  mov edx, 1            ; length 1

  call systemInterruption

  ; printing input
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  mov ecx, buffer
  mov edx, 1

  call systemInterruption

  ret

;-------------------------------------------------------------------------
; ---> Función _start
; ULTIMA ACTUALIZACIÓN: 10/01/2019
; DESCRIPCIÓN: Inicio del programa turboshoot

_start:
  call clear
  call setDimensions
  ;call getCharacterInput
  call gameIntro

;  call __dev__test
  call __dev__hang

  call exit

;-------------------------------------------------------------------------
; ---> Función exit
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: Sale del programa

exit:
  mov eax, SYS_EXIT        ; invoke SYS_EXIT
  mov ebx, STDIN           ; Return a code of zero
  call systemInterruption

; ============================ DEV FUNCTIONS ============================
;-------------------------------------------------------------------------
; ---> Función __dev__hang
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: Nada
; DESCRIPCIÓN: 'Ginda' el programa

__dev__hang:
  jmp $

;-------------------------------------------------------------------------
; ---> Función __dev_rtest
; ULTIMA ACTUALIZACIÓN: 29/12/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: Nada
; DESCRIPCIÓN: probar código de fuentes extenernas facilmente: insertandolo
;   en esta función y llamandola en cualquier parte, preferiblemente en
;   _start

__dev__test:
  mov     ecx, answer
  mov     edx, answer.length
  call    print

  ret

; =================================================================================
;                                DEMOS DE USO
; =================================================================================
;     SLEEP
; mov eax, 1     ; cargar en eax la cantidad de segundos a dormir
; call sleep     ; llamar al procedimiento
;
;     GOTOXY
; mov ah, 0     ; cargar en ah la coordenada X
; mov al, 0     ; cargar en al la coordenada Y
; call gotoxy    ; llmar al procedimiento
;
;     PRINT
; mov ecx, clearTerminal          ; Cargar en ecx el string a imprimir
; mov edx, clearTerminal.length   ; Cargar en edx la longitud del string a imprimir
; call print                      ; Send control string to console
;
;
