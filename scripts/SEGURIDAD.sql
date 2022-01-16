-- DBA (privilegios referidos a auditorías, backups, diseño físico, otorgamiento de provilegios, etc…); 
-- Desarrollador (privilegios de creación y mantenimiento de objetos) 
-- Usuario Final cuyo único provilegio de sistema es el inicio de sesion
 
-------------------------////////////////-----------------------------

-- select pg_terminate_backend(pid) from pg_stat_activity where datname='aii';

-- DROP DATABASE aii;
-- DROP 
-- drop user dba01, dev01, emp01;
-- drop user admin01;
-- select current_user;
-------------------------////////////////-----------------------------


----------///////////- CREACION DE LA BASE DE DATOS CON USUARIOS ADMINISTRADORES Y DESARROLLADORES  -///////////----------


-- EJECUTAR COMO SUPERUSUARIO postgres
CREATE USER admin01 WITH ENCRYPTED PASSWORD 'deb_shared_553*%#@899012' SUPERUSER;



-- EJECUTAR COMO SUPERUSUARIO admin01 o postgres
CREATE USER dba01 WITH 
	ENCRYPTED PASSWORD 'dba01_aii'
	CREATEDB
	CREATEROLE
	REPLICATION
	CONNECTION LIMIT -1	
;


-- CONECTAR A LA BASE DE DATOS Y .. 


-- EJECUTAR COMO DBA
CREATE DATABASE aii;
 

-- EJECUTAR COMO DBA
CREATE USER dev01 WITH 
	ENCRYPTED PASSWORD 'dev01_aii'
	CONNECTION LIMIT -1	
;


-- EJECUTAR COMO SUPERUSUARIO admin01 USAGE ES PARA VER LOS OBJECTOS DEL ESQUEMA. CREATE ES PARA CREAR OBJETOS EN EL ESQUEMA 
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;

GRANT USAGE ON SCHEMA public TO PUBLIC;

GRANT CREATE ON SCHEMA public TO dev01;
GRANT ALL ON ALL TABLES IN SCHEMA public TO dev01 ;


GRANT EXECUTE ON FUNCTION pg_read_binary_file(text,bigint,bigint,boolean) TO dev01;
GRANT EXECUTE ON FUNCTION pg_read_binary_file(text,bigint,bigint) TO dev01; 
GRANT EXECUTE ON FUNCTION pg_read_binary_file(text) TO dev01;


----------///////////- CREACION DE ROLES Y USUARIOS FINALES -///////////----------


-- drop role rol_empleado_jefe, rol_analista, rol_agente_campo

-- EJECUTAR COMO DBA
CREATE ROLE ROL_EMPLEADO_JEFE;
CREATE ROLE ROL_ANALISTA;
CREATE ROLE ROL_AGENTE_CAMPO;
--CREATE ROLE ROL_EMPLEADO_JEFE;


-- EJECUTAR COMO DBA
CREATE USER emp01 WITH ENCRYPTED PASSWORD 'emp01_aii' CONNECTION LIMIT 5;
CREATE USER emp02 WITH ENCRYPTED PASSWORD 'emp02_aii' CONNECTION LIMIT 5;
CREATE USER emp03 WITH ENCRYPTED PASSWORD 'emp03_aii' CONNECTION LIMIT 5;
CREATE USER emp04 WITH ENCRYPTED PASSWORD 'emp04_aii' CONNECTION LIMIT 5;

CREATE USER age01 WITH ENCRYPTED PASSWORD 'age01_aii' CONNECTION LIMIT 5;
CREATE USER age02 WITH ENCRYPTED PASSWORD 'age02_aii' CONNECTION LIMIT 5;
CREATE USER age03 WITH ENCRYPTED PASSWORD 'age03_aii' CONNECTION LIMIT 5;
CREATE USER age04 WITH ENCRYPTED PASSWORD 'age04_aii' CONNECTION LIMIT 5;

CREATE USER ana01 WITH ENCRYPTED PASSWORD 'ana01_aii' CONNECTION LIMIT 5;
CREATE USER ana02 WITH ENCRYPTED PASSWORD 'ana02_aii' CONNECTION LIMIT 5;
CREATE USER ana03 WITH ENCRYPTED PASSWORD 'ana03_aii' CONNECTION LIMIT 5;
CREATE USER ana04 WITH ENCRYPTED PASSWORD 'ana04_aii' CONNECTION LIMIT 5;


-- EJECUTAR COMO DBA
GRANT ROL_EMPLEADO_JEFE TO emp01, emp02, emp03, emp04;
GRANT ROL_ANALISTA TO ana01, ana02, ana03, ana04;
GRANT ROL_AGENTE_CAMPO TO age01, age02, age03, age04;









----------///////////- ASIGNACION DE PRIVILEGIOS SOBRE OBJETO A LOS ROLES Y USUARIOS FINALES -///////////----------



-- EJECUTAR COMO DEV
--GRANT SELECT ON EMPLEADO_JEFE TO ROL_EMPLEADO_JEFE;









----------///////////- 

-- PROBAR CON DISTINTOS USUARIOS.



-- SOLO EL USUARIO admin01 y dev01 PUEDE CREAR TABLAS
--create table empleado_jefe (id integer);
--
---- SOLO EL USUARIO 
--select * from empleado_jefe ;












