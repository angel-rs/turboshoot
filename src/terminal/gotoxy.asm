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
  push rax                              ; Save caller's registers
  push rcx
  push rdx
  push rbx
  push rbp
  push rsi
  push rdi

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

  pop rdi
  pop rsi
  pop rbp
  pop rbx
  pop rdx
  pop rcx
  pop rax                           ; restore all registers

  ret
