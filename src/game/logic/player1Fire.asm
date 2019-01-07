;-------------------------------------------------------------------------
; ---> Función player1Fire
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

player1Fire:                ; Every time player 1 Presses Q, creates a thread for the bullet
  cmp byte[player1RemainingBullets], 0          ; if remainingBullets: 0
  je .ignorePlayer1Fire                         ;     ignore input
  dec byte[player1RemainingBullets]             ; else: decrease bullets

  ; -- if bullets == 9: remove extra 0 from the UI
    cmp byte[player1RemainingBullets], 9
    je .removeExtra0InPlayer1BulletInfo


  ; mov rdi, .player1BulletThread
  ; call thread_create

  .ignorePlayer1Fire:
    nop

  ret

.removeExtra0InPlayer1BulletInfo:
  call resetCursor

  ; -- position cursor
    mov al, 24
    mov ah, 6
    call gotoxy

  ; -- remove extra 0
    mov ecx, emptySpace
    mov edx, emptySpace.length
    call print

  ret

.player1BulletThread:
  ret
