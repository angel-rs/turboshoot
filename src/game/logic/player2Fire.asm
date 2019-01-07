;-------------------------------------------------------------------------
; ---> Función player2Fire
; ULTIMA ACTUALIZACIÓN: 07/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

player2Fire:                                    ; Every time player 2 Presses O, creates a thread for the bullet
  cmp byte[player2RemainingBullets], 0          ; if    remainingBullets: 0
  je .ignorePlayer2Fire                         ;       ignore input
  cmp byte[player2ShotBulletFlag], 1
  je .ignorePlayer2Fire
  dec byte[player2RemainingBullets]             ; else: decrease bullets
  call printPlayer2RemainingBullets             ;       and print remaining bullets
  mov byte[player2ShotBulletFlag], 1            ;       toggle flag
  mov al, byte[bullet2StartPositionY]           ;       store bullet2StartPositionY in temp2
  mov byte[temp2], al

  ; -- create bullet thread
    mov rdi, .player2BulletThread
    call thread_create

  ; -- if bullets == 9: remove extra 0 from the UI
    cmp byte[player2RemainingBullets], 9
    je .removeExtra0InPlayer2BulletInfo

  .ignorePlayer2Fire:
    nop

  jmp finishGetGameInput

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
  call eraseBullet2

  ; --------- checking if wall collision ---------------------
  cmp byte[bullet2StartPositionX], 6      ; if  wallCollisioned
  je killPlayer2BulletThread              ;     kill thread
  ; ----------------------------------------------------------

  dec byte[bullet2StartPositionX]         ; update bullet position

  ; -------- checking if collision with enemy bullet --------
  call .checkIfBullet2Collision
  ; ----------------------------------------------------------

  ; ------------- checking if collision with enemy -----------
  call .checkIfEnemyCollisionInYAxis
  ; ----------------------------------------------------------

  call printPlayer2Bullet

  mov eax, 0
  mov ebx, 30000000                        ; 30ms/frame
  call sleep

  jmp .player2BulletThread

.checkIfEnemyCollisionInYAxis:
  mov ah, [bullet2StartPositionY]
  mov al, [player1CurrentYPosition]

  cmp ah, al
  je .checkIfEnemyCollisionInXAxis
  ret
.checkIfEnemyCollisionInXAxis:
  mov ah, [bullet2StartPositionX]
  mov al, [player1CurrentXPosition]

  cmp ah, al
  je .increasePlayer2Score
  ret

  .increasePlayer2Score:
    inc byte[player2Score]
    call printPlayer2Score
    mov ah, [bullet2StartPositionX]
    mov al, [bullet2StartPositionY]
    call _bulletCollision2

  ret

.checkIfBullet2Collision:
  cmp byte[player1ShotBulletFlag], 1
  je .checkIfBullet2CollisionInYAxis

  ret
.checkIfBullet2CollisionInYAxis:
  mov ah, [bullet2StartPositionY]
  mov al, [bullet1StartPositionY]

  cmp ah, al
  je .checkIfBullet2CollisionInXAxis

  ret
.checkIfBullet2CollisionInXAxis:
  mov ah, [bullet2StartPositionX]
  mov al, [bullet1StartPositionX]

  cmp ah, al
  je _bulletCollision2               ; bullets collided, end thread

  ret

_bulletCollision2:
  call bulletCollision2
  jmp killPlayer2BulletThread
  ret

eraseBullet2:
  call resetCursor

  ; -- position cursor
    mov ah, [bullet2StartPositionX]
    mov al, [bullet2StartPositionY]
    call gotoxy

  ; -- erase it with a emptySpace
    mov ecx, emptySpace
    mov edx, emptySpace.length
    call print

  ret

killPlayer2BulletThread:
  ;restore flag value
  mov byte[player2ShotBulletFlag], 0

  ;restore the bullet start position values
  mov ah, [player2CurrentXPosition]
  mov al, [player2CurrentYPosition]
  inc ah
  inc ah

  mov byte[bullet2StartPositionX], ah
  mov byte[bullet2StartPositionY], al

  call killThread
  ret
