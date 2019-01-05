;-------------------------------------------------------------------------
; ---> Función gameLoop
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN: loop del juego

gameLoop:
  call resetCursor

  call printGameBoard

  ;call getGameInput
  call printGameCounter
  ;
  ; mov eax, 0
  ; mov ebx, gameBoard
  ;
  ; mov word[i], 0
  ; mov word[j], 0
  ;
  ;
  ; i_loop:
  ;   mov word[j], 0
  ;
  ;   j_loop:
  ;     mov edx, 1
  ;     call getInput
  ;
  ;     mov dx , word[bufferIn]
  ;     ;eax will contain the array index and each element is 2 bytes(1 word) long
  ;     mov  word[ebx + 2 * eax], dx
  ;     inc eax    ;Incrementing array index by one....
  ;     inc word[j]
  ;     mov cx, word[j]
  ;     cmp cx, word[n]
  ;     jb j_loop
  ;
  ; inc word[i]
  ; mov cx, word[i]
  ; cmp cx, word[m]
  ; jb i_loop
  ;
  ;   ;Reading each element of the matrix.(Storing the elements in row major order).......
  ; mov eax, 0
  ; mov ebx, gameBoard


  ; -- esto es para imprimir la matriz..
  ; mov word[i], 0
  ; mov word[j], 0
  ;
  ; i_loop:
  ;   mov word[j], 0
  ;   j_loop:
  ;     ;eax will contain the array index and each element is 2 bytes(1 word) long
  ;     mov  dx, word[ebx + 2 * eax]
  ;     ;mov word[num] , dx
  ;     ;call print_num
  ;     ;Printing a space after each element.....
  ;     pusha
  ;     mov eax, 4
  ;     mov ebx, 1
  ;     mov ecx, ' '
  ;     mov edx, 1
  ;     int 80h
  ;     popa
  ;     inc eax
  ;     inc word[j]
  ;     mov cx, word[j]
  ;     cmp cx, word[n]
  ;     jb j_loop
  ;   pusha
  ;   mov eax, 4
  ;   mov ebx, 1
  ;   mov ecx, 10
  ;   mov edx, 1
  ;   int 80h
  ;   popa
  ;   inc word[i]
  ;   mov cx, word[i]
  ;   cmp cx, word[m]
  ;   jb i_loop
  ;
  ; ret
