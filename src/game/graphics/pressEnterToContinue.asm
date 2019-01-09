;-------------------------------------------------------------------------
; ---> Función pressEnterToContinue
; ULTIMA ACTUALIZACIÓN: 03/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: gotoxy, print, systemInterruption
; DESCRIPCIÓN: Hace que el usuario tenga que presionar 'Enter'
; Ascii code de la tecla: 10

pressEnterToContinue:
  call resetCursor

  ; operacion aritmetica para obtener ubicacion del mensaje en X
    mov bl, terminal_max_y                           ; guardando en bl la cantidad de columnas de la terminal
    mov bh, pressEnterToContinueMessage.length       ; guardando la longitud del mensaje a mostrar en bh
    sub bl, bh                                       ; le resta a la cantidad de columnas, la longitud del mensaje y lo guarda en bl

  ; Posicionar el cursor
    mov al, terminal_max_y
    mov ah, bl                                       ; posicion en X a mostrar el mensaje
    call gotoxy

  ; Mostrar el prompt
    mov ecx, pressEnterToContinueMessage             ; Carga el string pressEnterToContinueMessage en ecx
    mov edx, pressEnterToContinueMessage.length      ; Carga la longitude de pressEnterToContinueMessage en edx
    call print

  ; Leer entrada por teclado
    mov edx, 2
    call getInput

  ; Analiza la entrada
    cmp byte[bufferIn], 10              ; 10 is ascii code for 'Enter'
    jne pressEnterToContinue            ; Si no presiono 'Enter', vuelve a llamar esta rutina

  ret
