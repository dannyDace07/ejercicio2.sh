#!/bin/bash

nuevo_usuario=$1
nuevo_grupo=$2

#con id se busca el usuario en el sistema y el dev/null es para redirigir la salida 
if id "$nuevo_usuario" > /dev/null 2>&1; then
    echo "el usuario "$nuevo_usuario" ya existe"
else
    sudo useradd "$nuevo_usuario"
    echo "se ha creado el usuario "$nuevo_usuario""
fi

#con getent group se consigue información de los grupos que hay en el sistema desde el archivo /etc/group
if getent group "$nuevo_grupo" > /dev/null 2>&1; then
    echo "el grupo "$nuevo_grupo" ya existe"
else 
    sudo groupadd "$nuevo_grupo" 
    echo "se ha creado el grupo "$nuevo_grupo""
fi

#con usermod y -aG se hace un append del USER y el nuevo_usuario a el nuevo_grupo
sudo usermod -aG "$nuevo_grupo" "$USER" "$nuevo_usuario" > /dev/null 2>&1
#sin el /dev/null al correr el script habrian salido las opciones de usermod
echo "se han agregado el usuario default y el nuevo usuario "$nuevo_usuario" a el nuevo grupo "$nuevo_grupo""

ejercicio=$3
sudo chgrp "$nuevo_grupo" $ejercicio  # Cambiar el grupo del script al nuevo grupo
sudo chmod g+x $ejercicio       