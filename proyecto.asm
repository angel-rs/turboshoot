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

; == INCLUDES ==
%include "systemInterruption.asm"
%include "readStdinTermios.asm"
%include "writeStdinTermios.asm"
%include "pressEnterPrompt.asm"
%include "setDimensions.asm"
%include "ansiCursorHide.asm"
%include "ansiCursorShow.asm"
%include "canonicalOn.asm"
%include "canonicalOff.asm"
%include "printGameBox.asm"
%include "getKeyStroke.asm"
%include "resetCursor.asm"
%include "mainMenu.asm"
%include "gameIntro.asm"
%include "echoOn.asm"
%include "echoOff.asm"
%include "gotoxy.asm"
%include "sleep.asm"
%include "clear.asm"
%include "print.asm"
%include "dwtoa.asm"
%include "exit.asm"

%include "__dev__hang.asm"
%include "__dev__test.asm"

; = MACROS =
%macro execute 4
  mov eax, %1
  mov ebx, %2
  mov ecx, %3
  mov edx, %4
  call systemInterruption
%endmacro

; ============================ Text Section ============================
section .text
  global _start

; ============================= BSS Section ============================
section .bss
  bufferIn resb 2
  bufferOut resb 2
  TERMIOS resb 36

; ============================ Data Section ============================
section .data
  SYS_EXIT equ 1
  SYS_READ equ 3
  SYS_WRITE equ 4
  SYS_NANOSLEEP equ 162

  STDIN equ 0
  STDOUT equ 1

  ICANON      equ 1<<1
  ECHO        equ 1<<3

  ANSIHIDE db 27, '[?25l'
  ANSIHIDE.LENGTH equ $-ANSIHIDE

  ANSISHOW db 27, '[?25h'
  ANSISHOW.LENGTH equ $-ANSISHOW

  PosTerm  db 27, "[01;01H"               ; <ESC>[<Y>;<X>H
  POSLEN equ $-PosTerm                    ; Length of term position string

  ; This table gives us pairs of ASCII digits from 0-80. Rather than
  ; calculate ASCII digits to insert in the terminal control string,
  ; we look them up in the table and read back two digits at once to
  ; a 16-bit register like DX, which we then poke into the terminal
  ; control string PosTerm at the appropriate place. See gotoxy.
  ; If you intend to work on a larger console than 80 X 80, you must
  ; add additional ASCII digit encoding to the end of Digits. Keep in
  ; mind that the code shown here will only work up to 99 X 99.

  Digits  db "0001020304050607080910111213141516171819"
          db "2021222324252627282930313233343536373839"
          db "4041424344454647484950515253545556575859"
          db "606162636465666768697071727374757677787980"

  timeval:
    tv_sec  dd 0
    tv_usec dd 0

  boxLine1 db 13, `\e[32;1m\  ############################################################################# \e[m\ `
  boxLine1.length equ $-boxLine1
  boxLine2 db 13, `\e[32;1m\  ##                                                                         ## \e[m\ `
  boxLine2.length equ $-boxLine2

  terminal_max_x equ 24               ; Última coordenada en el eje X
  terminal_max_y equ 80               ; Última coordenada en el eje Y

  titleLine1 db 10, 10, 10, 10, 10, 10, 10, 10, `\e[31;1m\          _                 _\e[m\ \e[0;1m\                  _                    _     \e[m\ `
  titleLine1.length equ $-titleLine1
  titleLine2 db 10, 13, `\e[31;1m\         | |_  _   _  _ __ | |__    ___\e[m\ \e[0;1m\   ___ | |__    ___    ___  | |_   \e[m\ `
  titleLine2.length equ $-titleLine2
  titleLine3 db 10, 13, `\e[31;1m\         | __|| | | || .__|| ._ \\  / _ \\\e[m\ \e[0;1m\ / __|| ._ \\  / _ \\  / _ \\ | __|  \e[m\ `
  titleLine3.length equ $-titleLine3
  titleLine4 db 10, 13, `\e[31;1m\         | |_ | |_| || |   | |_) || (_) |\e[m\ \e[0;1m\\\__ \\| | | || (_) || (_) || |_   \e[m\ `
  titleLine4.length equ $-titleLine4
  titleLine5 db 10, 13, `\e[31;1m\          \\__| \\__,_||_|   |_.__/  \\___/\e[m\ \e[0;1m\ |___/|_| |_| \\___/  \\___/  \\__|  \e[m\ `
  titleLine5.length equ $-titleLine5
  titleLine6 db 10, 10, 10, 13, `          \e[0;1m\웃      ►\e[m\                                         \e[31;1m\◄       웃\e[m\  `
  titleLine6.length equ $-titleLine6

  continuePrompt db "Presione 'Enter' para continuar... "
  continuePrompt.length equ $-continuePrompt

  menuOption1 db "MENU: "
  menuOption1.length equ $-menuOption1
  menuOption2 db "[ 1 ] Jugar "
  menuOption2.length equ $-menuOption2
  menuOption3 db "[ 2 ] Instrucciones "
  menuOption3.length equ $-menuOption3
  menuOption4 db "[ 3 ] Salir "
  menuOption4.length equ $-menuOption4

  player1 db `\e[0;1m\웃\e[m\ `
  player1.length equ $-player1

  bullet1 db `\e[0;1m\►\e[m\ `
  bullet1.length equ $-bullet1

  player2 db `\e[31m\웃\e[m\ `
  player2.length equ $-player2

  bullet2 db `\e[31m\◄\e[m\ `
  bullet2.length equ $-bullet2

  clearTerminal db "                                                                                "
	clearTerminal.length equ $-clearTerminal

GetStrlen:
  push    ebx

  xor     ecx, ecx
  not     ecx

  xor     eax, eax
  cld
  repne   scasb
  mov     byte [edi - 1], 10
  not     ecx
  pop     ebx
  lea     edx, [ecx - 1]

  ret

PrintNum:
  push    bufferOut
  push    esi

  call    dwtoa

  mov     edi, bufferOut

  call    GetStrlen

  inc     edx
  mov     ecx, bufferOut
  mov     eax, SYS_WRITE
  mov     ebx, STDOUT
  int     80H
  ret

; ---- Turboshoot
_start:
  call echoOff
  call canonicalOff
  call ansiCursorHide
  call setDimensions

  call clear

  ; call getKeyStroke
  ;
  ; mov ecx, bufferIn
  ;
  ; cmp ecx, '0'              ; if ecx === 'a'
  ; je esIgual                ;   esIgual()
  ; jmp esDiferente           ; else esDiferente()
  ;
  ;   esIgual:
  ;     call clear
  ;
  ;   esDiferente:
  ;     call pressEnterPrompt

  ;movzx   esi, byte[bufferIn]

  ;push    esi
  ;call    PrintNum

  call gameIntro
  call mainMenu

  call echoOn
  call canonicalOn

  ;call __dev__test
  ;call __dev__hang

  call exit

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
