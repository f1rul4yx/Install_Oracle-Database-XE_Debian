#!/bin/bash

# Author: Diego Vargas (f1rul4yx)

# Colors
negrita="\033[1m"
subrayado="\033[4m"
negro="\033[30m"
rojo="\033[31m"
verde="\033[32m"
amarillo="\033[33m"
azul="\033[34m"
magenta="\033[35m"
cian="\033[36m"
blanco="\033[37m"
reset="\033[0m"

clear
echo -en "[${verde}+${reset}] ¿Quieres desinstalar Oracle? (s/n): "
read respuesta_desinstalar

case "$respuesta_desinstalar" in
	[Ss]*)
		### Desinstalación de Oracle

		# 1. Detener el servicio de Oracle XE
		sudo /etc/init.d/oracle-xe-21c stop

		# 2. Desinstalar el paquete Debian
		sudo /etc/init.d/oracle-xe-21c delete
		sudo dpkg --remove oracle-database-xe-21c

		# 3. Eliminar archivos residuales
		sudo rm -rf /opt/oracle
		sudo rm -rf /etc/oratab
		sudo rm -rf /etc/init.d/oracle-xe-21c
		sudo rm -rf /etc/sysconfig/oracle-xe-21c.conf
		sudo rm -rf /u01

		sudo rm -rf /run/systemd/generator.late/oracle-xe-21c.service
		sudo rm -rf /tmp/hsperfdata_oracle
		sudo rm -rf /tmp/.oracle
		sudo rm -rf /var/tmp/.oracle
		sudo rm -rf /var/lib/dpkg/info/oracle-database-xe-21c.postrm
		sudo rm -rf /var/lib/dpkg/info/oracle-database-xe-21c.list

		# 4. Limpiar el archivo /etc/hosts
		# sudo nano /etc/hosts (Elimina la línea que tenga tu ip y nombre del equipo)
		echo -e "\n[${verde}+${reset}] Abre otra terminal y elimina la línea que tenga tu ip y nombre del equipo en el archivo /etc/hosts\n\nPulsa ENTER para continuar..."
		read

		# 5. Limpiar el archivo ~/.bashrc
		# nano ~/.bashrc (Elimina las líneas que tengan alias de oracle, son las configuradas en el apartado "Asignación de alias para usar oracle")
		# source ~/.bashrc
		echo -e "\n[${verde}+${reset}] Abre otra terminal y elimina las líneas que tengan alias de oracle en el archivo ~/.bashrc, son las configuradas en el apartado 'Asignación de alias para usar oracle' del script.\n\nPulsa ENTER para continuar..."
		read

		# 6. Eliminar bibliotecas y herramientas adicionales
		sudo apt purge rlwrap libaio1 unixodbc -y
		sudo apt autoremove --purge -y

		# 7. Verificar que todo esté desinstalado
		# ps aux | grep oracle
		# find / -name '*oracle*' 2>/dev/null
		echo -e "\n[${verde}+${reset}] Abre otra terminal y ejecuta los siguientes comandos para verificar los archivos residuales que quedan de oracle en el equipo:\n\n- ps aux | grep oracle\n- find / -name '*oracle*' 2>/dev/null\n\nPulsa ENTER para continuar..."
		read
		;;
	*)
		echo -e "\n[${amarillo}-${reset}] No se desinstalara Oracle."
		;;
esac


echo -en "\n[${verde}+${reset}] ¿Quieres instalar Oracle? (s/n): "
read respuesta_instalar

case "$respuesta_instalar" in
	[Ss]*)
		### Instalación de dependencias

		sudo apt update
		sudo apt install rlwrap libaio1 unixodbc -y
		sudo apt install wget -y


		### Descarga del archivo .deb

		wget https://files.diegovargas.es/deb/oracle-database-xe-21c_1.0-2_amd64.deb


		### Instalación y configuración de oracle y configuración del hosts

		sudo dpkg --install oracle-database-xe-21c_1.0-2_amd64.deb
		echo "$(hostname -I | awk '{print $1}') $(hostname)" | sudo tee -a /etc/hosts
		sudo /etc/init.d/oracle-xe-21c configure


		### Asignación de alias para usar oracle

		echo 'export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE' >> ~/.bashrc
		echo 'export ORACLE_SID=XE' >> ~/.bashrc
		echo 'export NLS_LANG=SPANISH_SPAIN.AL32UTF8' >> ~/.bashrc
		echo 'export ORACLE_BASE=/opt/oracle' >> ~/.bashrc
		echo 'export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
		echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> ~/.bashrc
		echo "alias sqlplus='rlwrap sqlplus'" >> ~/.bashrc
		source ~/.bashrc
		;;
	*)
		echo -e "\n[${amarillo}-${reset}] No se instalara Oracle."
		;;
esac
