;-------------------------------------------------------------------------
; ---> Función player1Fire
; ULTIMA ACTUALIZACIÓN: 04/01/2018
; RECIBE: Nada
; RETORNA: Nada
; MODIFICA: Nada
; LLAMA: systemInterruption
; DESCRIPCIÓN:

player1Fire:                                    ; Every time player 1 Presses Q, creates a thread for the bullet
  cmp byte[player1RemainingBullets], 0          ; if    remainingBullets: 0
  je .ignorePlayer1Fire                         ;       ignore input
  cmp byte[player1ShotBulletFlag], 1            ; if    already shot one bullet
  je .ignorePlayer1Fire                         ;       ignore input
  dec byte[player1RemainingBullets]             ; else: decrease bullets
  call printPlayer1RemainingBullets             ;       and print remaining bullets
  mov byte[player1ShotBulletFlag], 1            ;       toggle flag
  mov al, byte[bullet1StartPositionY]           ;       store bullet1StartPositionY in temp
  mov ah, byte[bullet1StartPositionX]           ;       store bullet1StartPositionX in temp3
  mov byte[temp], al
  mov byte[temp3], ah

  ; -- create bullet thread
    mov rdi, .player1BulletThread
    call thread_create

  ; -- if bullets == 9: remove extra 0 from the UI
    cmp byte[player1RemainingBullets], 9
    je .removeExtra0InPlayer1BulletInfo

  .ignorePlayer1Fire:
    nop

  jmp finishGetGameInput

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
  call eraseBullet1

  ; --------- checking if wall collision ---------------------
  cmp byte[temp3], 75                     ; if  wallCollisioned
  je killPlayer1BulletThread              ;     kill thread
  ; ----------------------------------------------------------

  inc byte[temp3]         ; update bullet position

  ; -------- checking if collision with enemy bullet --------
  ; call .checkIfBullet1Collision
  ; ----------------------------------------------------------

  ; ------------- checking if collision with enemy -----------
  call .checkIfEnemyCollisionInYAxis
  ; ----------------------------------------------------------

  call printPlayer1Bullet

  mov eax, 0
  mov ebx, 30000000                        ; 30ms/frame
  call sleep

  jmp .player1BulletThread

.checkIfEnemyCollisionInYAxis:
  mov ah, [temp]
  mov al, [player2CurrentYPosition]

  cmp ah, al
  je .checkIfEnemyCollisionInXAxis
  ret
.checkIfEnemyCollisionInXAxis:
  mov ah, [temp3]
  mov al, [player2CurrentXPosition]

  cmp ah, al
  je .Player1CollisionWithEnemy
  ret

  .Player1CollisionWithEnemy:
    inc byte[player1Score]
    call printPlayer1Score                              ; print the updated score

    mov ah, [player2CurrentXPosition]
    mov al, [player2CurrentYPosition]
    call _bulletCollision

  ret

.checkIfBullet1Collision:
  cmp byte[player2ShotBulletFlag], 1
  je .checkIfBullet1CollisionInYAxis

  ret
.checkIfBullet1CollisionInYAxis:
  mov ah, [temp2]
  mov al, [temp]

  cmp ah, al
  je .checkIfBullet1CollisionInXAxis

  ret
.checkIfBullet1CollisionInXAxis:
  mov ah, [temp4]
  mov al, [temp3]

  cmp ah, al
  je _bulletCollision               ; bullets collided, end thread

  ret

_bulletCollision:
  call bulletCollision1
  jmp killPlayer1BulletThread
  ret

eraseBullet1:
  call resetCursor

  ; -- position cursor
    mov ah, [temp3]
    mov al, [temp]
    call gotoxy

  ; -- erase it with a emptySpace
    mov ecx, emptySpace
    mov edx, emptySpace.length
    call print

  ret

killPlayer1BulletThread:
  ;restore flag value
  mov byte[player1ShotBulletFlag], 0

  ;restore the bullet start position values
  mov ah, [bullet1StartPositionX]
  mov al, [bullet1StartPositionY]
  inc ah
  inc ah

  mov byte[temp3], ah
  mov byte[temp], al

  call killThread
  ret
