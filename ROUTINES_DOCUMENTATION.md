<p align="center">
  <img src="./src/turboshoot.png" width="200" style="display:block; margin-left: auto; margin-right: auto;">
</p>

### Ejemplo de uso de las rutinas empleadas en el proyecto

#### SLEEP
Detiene la ejecución durante la cantidad de segudos que se encuentre en el registro **eax** y de nano segundos que se encuentren en **ebx**

```
  mov eax, 1        ; 1 segundo
  mov ebx, 100      ; 100 nanosegundos
  call sleep        ; llamada a la rutina | detendrá la ejecución por 1s y 100ns
 ```

 #### GOTOXY
 Posiciona el cursor en las coordenadas X, Y suministradas en los registros **al** y **ah** respectivamente

```
  mov al, 0         ; X = 0
  mov ah, 0         ; Y = 0
  call gotoxy       ; llamada a la rutina
```

#### PRINT
Imprime en pantalla el string almacenado en **ecx**, el tamaño de dicho string se debe hallar en **edx**

```
  mov ecx, "hola"   ; mensaje a imprimir
  mov edx, 4        ; longitud del mensaje
  call print        ; llamada a la rutina
```

#### PRINTDECIMALINTEGER
Imprime en pantalla un entero
Ejemplo de uso:

```
print a byte variable
        mov     eax, 0
        mov     al, byte[someVar]
        call    printDecimalInteger

print a word variable
        mov     eax
        mov     ax, word[otherVar]
        call    printDecimalInteger

print a double-word variable
        mov     eax, dword[thirdVar]
        call    printDecimalInteger

print register edx in decimal
        mov     eax, edx
        call    printDecimalInteger
```

#### THREAD_CREATE
Crea hilo de proceso

```
  mov rdi, threadfn         ; recibe en rdi, la rutina a ejecutar en el hilo
  call thread_create        ; llamado a la rutina
```
