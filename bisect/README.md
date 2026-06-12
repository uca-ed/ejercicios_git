# Git Bisect

## Introducción

En ocasiones, durante el desarrollo de software aparece en determinado momento un caso o una lógica que no funciona como esperamos, o incluso un bug no detectado en tests, que sabemos que antes funcionaba de acuerdo a lo esperado.

Como se desconoce el momento en el que se introdujo en el código tal comportamiento, necesitamos explorar la historia del repositorio para encontrar el problema. 

Por lo general, sabemos que la situación apareció en un determinado momento de la historia de la aplicación, por lo que se puede saber que en un tag, release, o commit determinado, el comportamiento de la app es el esperado. 

Entonces, debemos buscar entre ese tag/commit/release y el momento actual del branch (HEAD) cuándo se introdujo ese problema.

Este trabajo consiste en tomar cada commit y ejecutarle las pruebas necesarias para saber si el comportamiento de ese caso de uso es el esperado o erróneo; El primer commit que presente el error, es el que lo introdujo.

Ahora bien, podríamos tener cientos de commits para analizar, lo que haría que fuese una tarea ardua.

## Comando git bisect

`git bisect` es un comando que nos permite considerar el historial de una rama de git como un arreglo, y en vez de recorrerlo linealmente, ejecuta búsqueda binaria sobre el mismo. 

Los commits tienen un orden cronológico, lo que es el orden que tienen los elementos del arreglo. Nosotros buscamos el primer commit con comportamiento incorrecto (Bad), y los anteriores tendrán comportamiento correcto (Good). Por ejemplo:

Commit inicial G---G---G---G---G---B---B---B---B---B---B---B HEAD

En esa búsqueda binaria, cada vez que se analice un elemento, se lo considerará commit bueno o malo. Si es bueno, el próximo paso es buscar en la mitad "superior" de la porción de arreglo que se busca. En caso contrario, la mitad inferior. 

De este modo, se encontrará en tiempo log<sub>2</sub>(n) al commit con inconvenientes.

## Prueba del comando

Para probar el comando proponemos en esta carpeta el uso del script `generador.sh` que inicializará el archivo archivo.txt y creará el número `CANTIDAD` de commits, agregando números al mismo. 

Con un número al azar, marcará uno de esos commits como erróneos y a partir de ese momento, todos los commits tendrán el error. La intención es encontrar el commit que sea el primero en contener ese error.

### Paso 1

Ejecutar `generador.sh`. Generador va a realizar un commit de preparación y los commits siguientes  para preparar el repositorio local.

Aquí suponemos que detectamos el error, y ya el script nos propuso un commit inicial para basarnos.

Para comenzar la sesión de bisect:

```bash
git bisect start
```

Nos pide setear commit "bueno" y "malo" para calcular el arreglo:

```bash
git bisect bad HEAD
git bisect good < Hash que nos menciona el script generador.sh >
```

Ya con este comando, se realizó el primer movimiento al centro del arreglo.


### Pasos iterativos

Ejectuamos 

```bash
make test
```

Si el test dice que hay un error, significa que el commit tiene el error. Podemos también verificar que  haya líneas con "error" en `archivo.txt`.

Si hay error, ejecutamos 

```bash
git bisect bad
```

Si no hay error:

```bash
git bisect good
```


### Finalización

Podemos utilizar `git bisect reset` para terminar la sesión. Esto nos llevará a HEAD del branch.


### Demo

En este link hay una grabación de una corrida del procedimiento propuesto: https://asciinema.org/a/Ir8h8WEM6vbKaRps
