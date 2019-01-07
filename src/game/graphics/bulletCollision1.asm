;-------------------------------------------------------------------------
; ---> Función bulletCollision1
; ULTIMA ACTUALIZACIÓN: 07/01/2018
; RECIBE: Posición donde imprimir la explósion en X->ah, Y->al
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA:
; DESCRIPCIÓN:

bulletCollision1:
  ; -- position cursor
    call gotoxy

  ; -- remove player
    mov ecx, emptySpace
    mov edx, emptySpace.length
    call print

  ; -- print explosion
    mov ecx, explosion
    mov edx, explosion.length
    call print

  ; -- delay
    mov eax, 0
    mov ebx, 350000000
    call sleep

  ; -- print player again
    call printPlayer2

  ret
