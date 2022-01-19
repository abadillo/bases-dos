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

------- ------- ---- ---- -- -- IMPORTANTE --- -- - -- - -- -- - -- - - -- 

select pg_terminate_backend(pid) from pg_stat_activity where datname='aii';




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







