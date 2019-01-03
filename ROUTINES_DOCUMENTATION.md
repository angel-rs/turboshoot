<p align="center">
  <img src="turboshoot.png" width="200" style="display:block; margin-left: auto; margin-right: auto;">
</p>

### Ejemplo de uso de las rutinas empleadas en el proyecto

#### SLEEP
Detiene la ejecución durante la cantidad de segudos que se encuentre en el registro **eax**

```
  mov eax, 1        ; 1 segundo
  call sleep        ; llamada a la rutina
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
