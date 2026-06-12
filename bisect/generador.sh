#!/bin/zsh
CANTIDAD=20
COMMIT_ERRONEO=$(( RANDOM % ($CANTIDAD+1) ))
echo "principio del archivo" > archivo.txt
git add archivo.txt
git commit -m "Comienzo de la prueba"
HASH_INICIAL=$(git log -1 --pretty=format:"%H")

randomStr=""
for i in {1..$CANTIDAD}
  do
	if [[ $i == $COMMIT_ERRONEO ]];
	then
	  randomStr=" -- introduce el error -- "
  	else
	  randomStr=""
	fi
	echo $i $randomStr >> archivo.txt
	git add archivo.txt
	git commit -m "codigo nro ${i} ${randomStr}"
  done

echo Proceso finalizado
echo Se debe trabajar entre los commits $HASH_INICIAL y HEAD
echo
echo Por ejemplo:
echo git bisect start
echo git bisect bad HEAD
echo git bisect good $HASH_INCIAL
