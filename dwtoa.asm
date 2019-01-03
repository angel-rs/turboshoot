;-------------------------------------------------------------------------
; ---> Función dwtoa
; ULTIMA ACTUALIZACIÓN: 02/01/2019
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: print
; DESCRIPCIÓN: Muestra el cursor de la terminal

dwtoa:
  ;~ number to convert = [ebp+8]
  ;~ pointer to buffer that receives number = [ebp+12]
  push    ebp
  mov     ebp, esp

  push    ebx
  push    esi
  push    edi

  mov     eax, [ebp + 8]
  mov     edi, [ebp + 12]

  test    eax, eax
  jnz     .sign

  .zero:
      mov     word [edi], 30H
      jmp     .done

  .sign:
      jns     .pos
      mov     byte [edi], "-"
      neg     eax
      add     edi, 1

  .pos:
      mov     ecx, 3435973837
      mov     esi, edi

  .doit:
      mov     ebx, eax
      mul     ecx
      shr     edx, 3
      mov     eax, edx
      lea     edx, [edx * 4 + edx]
      add     edx, edx
      sub     ebx, edx
      add     bl, "0"
      mov     [edi], bl
      add     edi, 1
      cmp     eax, 0
      jg      .doit

      mov     byte [edi], 0

  .fixit:
      sub     edi, 1
      mov     al, [esi]
      mov     ah, [edi]
      mov     [edi], al
      mov     [esi], ah
      add     esi, 1
      cmp     esi, edi
      jl      .fixit

  .done:
      pop     edi
      pop     esi
      pop     ebx

      mov     esp, ebp
      pop     ebp
      ret     4 * 2
