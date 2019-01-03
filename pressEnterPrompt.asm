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

  loopUntilPressEnter:
    push cx

    ; Mostrar el prompt
    mov ecx, continuePrompt             ; Carga el string continuePrompt en ecx
    mov edx, continuePrompt.length      ; Carga la longitude de continuePrompt en edx
    call print

    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, bufferIn       ; save user input in buffer
    mov edx, 1            ; length 1

    call systemInterruption

    mov ecx, bufferIn
    mov edx, 1
    call print

    cmp ecx, '10'
    jne loopUntilPressEnter      ; Si no es igual, volver al bucle

  ret
