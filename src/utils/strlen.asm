;-------------------------------------------------------------------------
; ---> Función strlen
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: string en edi
; RETORNA: la longitud del string recibido en eax
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN: Retorna la longitud del string suministrado en edi
; y lo almacena en eax

strlen:
  push ebx
  push ecx

  mov   ebx, edi
  xor   al, al
  mov   ecx, 0xffffffff

  repne scasb               ; REPeat while Not Equal [edi] != al

  sub   edi, ebx            ; length = offset of (edi - ebx)
  mov   eax, edi

  pop ebx
  pop ecx

  ret
