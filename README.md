# Install_Oracle-Database-XE_Debian

Esto es un repositorio con el cual se facilita la instalación de Oracle Database 21c Express Edition en sistemas operativos basados en Debian.

## Instalación

```bash
git clone https://github.com/f1rul4yx/Install_Oracle-Database-XE_Debian.git
cd Install_Oracle-Database-XE_Debian
bash launch.sh
```

Cuando aparezca lo mismo que en la siguiente imagen se debe escribir la contraseña para el administrador de oracle.
![Imagen del apartado donde se indica la contraseña del usuario administrador de oracle](img/tutorial/password_oracle.png)

## Acceso a Oracle como administrador

- `sqlplus sys as sysdba`

## Configuración inicial para permitir la creación de usuarios en Oracle

- `STARTUP;`
- `ALTER SESSION SET "_ORACLE_SCRIPT"=true;`

## Pasos para crear un usuario y asignar permisos

- Crear usuario ---> `CREATE USER <<user>> IDENTIFIED BY <<password>>;`
- Permisos de todo ---> `GRANT ALL PRIVILEGES TO <<user>>;`

## Pasos para iniciar el servicio automáticamente

- `sudo crontab -e`
- Añadir la línea ---> `@reboot sudo systemctl restart oracle-xe-21c.service`

## Ejecución de configuración automática

- Hay algunas configuraciones que se deben de hacer cada vez que se inicia sesión por lo que una solución para evitar eso es crear un archivo `~/.login.sql` con una configuración como la siguiente:

```
-- Habilita la salida de mensajes desde procedimientos PL/SQL utilizando DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON

-- Establece el ancho de línea para la salida en pantalla, útil para evitar que se divida la información en varias líneas
SET LINESIZE 150

-- Establece el número de líneas por página en la salida, para controlar la paginación al mostrar muchos registros
SET PAGESIZE 100
```

- Para conseguir ejecutar este fichero es necesario indicarlo al iniciar la sesión `sqlplus <<usuario>>/<<contraseña>> @<<ruta_absoluta_.login.sql>>`
