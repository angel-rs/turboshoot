;-------------------------------------------------------------------------
; ---> Función player2Fire
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

player2Fire:                ; Every time player 1 Presses Q, creates a thread for the bullet

  cmp byte[player2RemainingBullets], 0          ; if remainingBullets: 0
  je .ignorePlayer2Fire                         ;     ignore input
  dec byte[player2RemainingBullets]             ; else: decrease bullets

  ; -- if bullets == 0: remove extra 0
    cmp byte[player2RemainingBullets], 9
    je .removeExtra0InPlayer2BulletInfo

  ; mov rdi, .player1BulletThread
  ; call thread_create

  .ignorePlayer2Fire:
    nop

  ret

.removeExtra0InPlayer2BulletInfo:
  call resetCursor

  ; -- position cursor
    mov al, 24
    mov ah, 56
    call gotoxy

  ; -- remove extra 0
    mov ecx, emptySpace
    mov edx, emptySpace.length
    call print

  ret

.player2BulletThread:
  ret
