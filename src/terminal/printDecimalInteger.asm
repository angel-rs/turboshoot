;-------------------------------------------------------------------------
; ---> Función printDecimalInteger
; ULTIMA ACTUALIZACIÓN: 05/01/2018
; RECIBE: eax, numero a imprimir
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

printDecimalInteger:
  ;;; saves all the registers so that they are not changed by the function
  section .bss
    .decstr resb 10
    .ct1 resd 1  ; to keep track of the size of the string

  section .text

    push rax
    push rcx
    push rdx
    push rbx
    push rbp
    push rsi
    push rdi

    mov dword[.ct1], 0   ; assume initially 0
    mov edi, .decstr     ; edi points to decstring
    add edi, 9           ; moved to the last element of string
    xor edx, edx         ; clear edx for 64-bit division

    .whileNotZero:
      mov ebx, 10          ; get ready to divide by 10
      div ebx             ; divide by 10
      add edx, '0'         ; converts to ascii char
      mov byte[edi], dl    ; put it in sring
      dec edi             ; mov to next char in string
      inc dword[.ct1]     ; increment char counter
      xor edx, edx         ; clear edx
      cmp eax, 0           ; is remainder of division 0?
      jne .whileNotZero   ; no, keep on looping

      inc edi             ; conversion, finish, bring edi
      mov ecx, edi        ; back to beg of string. make ecx
      mov edx, [.ct1]     ; point to it, and edx gets # chars
      mov eax, SYS_WRITE  ; and print!
      mov ebx, STDOUT
      int 0x80

    pop rdi
    pop rsi
    pop rbp
    pop rbx
    pop rdx
    pop rcx
    pop rax                          ; restore all registers

  ret
