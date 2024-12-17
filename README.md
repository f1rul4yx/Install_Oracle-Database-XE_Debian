# Install_Oracle-Database-XE_Debian

Esto es un repositorio con el cual se facilita la instalación de Oracle Database 21c Express Edition en sistemas operativos basados en Debian.

## Instalación

```bash
git clone https://github.com/f1rul4yx/Install_Oracle-Database-XE_Debian.git
cd Install_Oracle-Database-XE_Debian
bash launch.sh
```

Cuando aparezca lo mismo que en la siguiente imagen ten paciencia porque tarda más o menos 30 minutos.
![Imagen del proceso de conversión de .rpm a .deb](img/tutorial/deb-conversion_oracle.png)

Cuando aparezca lo mismo que en la siguiente imagen se debe escribir la contraseña para el administrador de oracle.
![Imagen del apartado donde se indica la contraseña del usuario administrador de oracle](img/tutorial/password_oracle.png)

## Acceso a Oracle como administrador

- `sqlplus sys as sysdba`

## Configuración inicial para permitir la creación de usuarios en Oracle

- `ALTER SESSION SET "_ORACLE_SCRIPT"=true;`

## Pasos para crear un usuario y asignar permisos

- Crear usuario ---> `CREATE USER <<user>> IDENTIFIED BY <<password>> DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP PROFILE DEFAULT;`

- Permisos de conexión ---> `GRANT CONNECT, RESOURCE TO <<user>>;`

- Desbloquear cuenta ---> `ALTER USER <<user>> ACCOUNT UNLOCK;`

- Ampliar cuota del usuario ---> `ALTER USER <<user>> QUOTA UNLIMITED ON USERS;`

## Notas

- Cada vez que se encienda el equipo se tiene que iniciar el servicio ---> `sudo /etc/init.d/oracle-xe-21c start`
