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

; ============================ INCLUDES ============================
%include "./src/game/logic/gameLoop.asm"
%include "./src/game/logic/gameCounter.asm"
%include "./src/game/logic/getGameInput.asm"
%include "./src/game/logic/player1Fire.asm"

%include "./src/game/graphics/mainMenu.asm"
%include "./src/game/graphics/gameIntro.asm"
%include "./src/game/graphics/player1Wins.asm"
%include "./src/game/graphics/player2Wins.asm"
%include "./src/game/graphics/printGameBox.asm"
%include "./src/game/graphics/printPlayer1.asm"
%include "./src/game/graphics/printPlayer2.asm"
%include "./src/game/graphics/printPlayer1Score.asm"
%include "./src/game/graphics/printPlayer2Score.asm"
%include "./src/game/graphics/printGameCounter.asm"
%include "./src/game/graphics/pressEnterToGoBack.asm"
%include "./src/game/graphics/printPlayer1Bullet.asm"
%include "./src/game/graphics/printPlayer2Bullet.asm"
%include "./src/game/graphics/pressEnterToContinue.asm"

%include "./src/terminal/readStdinTermios.asm"
%include "./src/terminal/writeStdinTermios.asm"
%include "./src/terminal/getLengthAndPrint.asm"
%include "./src/terminal/printDecimalInteger.asm"
%include "./src/terminal/setDimensions.asm"
%include "./src/terminal/ansiCursorHide.asm"
%include "./src/terminal/ansiCursorShow.asm"
%include "./src/terminal/canonicalOn.asm"
%include "./src/terminal/canonicalOff.asm"
%include "./src/terminal/getInput.asm"
%include "./src/terminal/resetCursor.asm"
%include "./src/terminal/echoOn.asm"
%include "./src/terminal/echoOff.asm"
%include "./src/terminal/gotoxy.asm"
%include "./src/terminal/clear.asm"
%include "./src/terminal/print.asm"

%include "./src/utils/systemInterruption.asm"
%include "./src/utils/convertIntToString.asm"
%include "./src/utils/strlen.asm"
%include "./src/utils/sleep.asm"
%include "./src/utils/atoi.asm"
%include "./src/utils/exit.asm"

; dwtoa is not yet in a folder cause i don't even know how to explain what it does
%include "dwtoa.asm"

%include "./__dev__/__dev__hang.asm"
%include "./__dev__/__dev__test.asm"

; ============================ MACROS ============================
; %macro execute 4
;   mov eax, %1
;   mov ebx, %2
;   mov ecx, %3
;   mov edx, %4
;
;   call systemInterruption
; %endmacro

; ============================ Text Section ============================
section .text
  global _start

; ============================= BSS Section ============================
section .bss
  buffer resb 10
  bufferIn resb 2
  bufferOut resb 2
  TERMIOS resb 36

  temp resb 2

; ============================ Data Section ============================
section .data
  SYS_EXIT equ 1
  SYS_FORK equ 2
  SYS_READ equ 3
  SYS_WRITE equ 4
  SYS_CLONE equ 120
  SYS_NANOSLEEP equ 162

  STDIN equ 0
  STDOUT equ 1

  ICANON equ 1 << 1
  ECHO equ 1 << 3

  const10 dd 10

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

  pressEnterToContinueMessage db "Presione 'Enter' para continuar... "
  pressEnterToContinueMessage.length equ $-pressEnterToContinueMessage

  pressEnterToGoBackMessage db "Presione 'Enter' para volver... "
  pressEnterToGoBackMessage.length equ $-pressEnterToGoBackMessage

  menuOption1 db "MENU: "
  menuOption1.length equ $-menuOption1
  menuOption2 db "[ 1 ] Jugar "
  menuOption2.length equ $-menuOption2
  menuOption3 db "[ 2 ] Instrucciones "
  menuOption3.length equ $-menuOption3
  menuOption4 db "[ 3 ] Opciones "
  menuOption4.length equ $-menuOption4
  menuOption5 db "[ 4 ] Salir "
  menuOption5.length equ $-menuOption5

  player1WinsMessage db `\e[0;1m\웃 Player 1 Wins! \e[m\ `
  player1WinsMessage.length equ $-player1WinsMessage

  player2WinsMessage db `\e[31;1m\웃 Player 2 Wins! \e[m\ `
  player2WinsMessage.length equ $-player2WinsMessage

  gameInstructions db `\e[31;1m\Turbo\e[m\ \e[0;1m\shoot\e[m\ © es un videojuego ASCII en donde el objetivo es ... `
  gameInstructions.length equ $-gameInstructions

  byeMessage db `\e[0;1m\Bye! \e[m\ `
  byeMessage.length equ $-byeMessage

  timerValue db 60
  timerValueMessage db "60", 0

  player1 db `\e[0;1m\웃\e[m\ `, 0
  player1.length equ $-player1
  player1CurrentXPosition db 20
  player1CurrentYPosition db 13
  bullet1 db `\e[0;1m\►\e[m\ `, 0
  bullet1.length equ $-bullet1
  bullet1CurrentPosition db 0
  player1Score db 0
  player1ScoreMessage db `\e[0;1m\Player 1 Score:\e[m\ `
  player1ScoreMessage.length equ $-player1ScoreMessage
  player1RemainingBullets db 10

  player2 db `\e[31;1m\웃\e[m\ `, 0
  player2.length equ $-player2
  player2CurrentXPosition db 60
  player2CurrentYPosition db 13
  bullet2 db `\e[31;1m\◄\e[m\ `, 0
  bullet2.length equ $-bullet2
  bullet2CurrentPosition db 0
  player2Score db 0
  player2ScoreMessage db `\e[0;1m\Player 2 Score:\e[m\ `
  player2ScoreMessage.length equ $-player2ScoreMessage
  player2RemainingBullets db 10

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


  ret

; ---- Turboshoot
_start:
  call echoOff
  call canonicalOff
  call ansiCursorHide
  call setDimensions

  call clear

  ;call gameIntro
  call mainMenu

  ;call __dev__test
  ;call __dev__hang

  call exit
