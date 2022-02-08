---- DESEMPEÑO AII ----
---- CREACIÓN DE LAS TABLAS T1 ----
---- COPIAS DEL ER A TABLAS T1 (CAMBIIOS EN LOS PARAMETROS) ----
DROP TABLE IF EXISTS T1_LUGAR CASCADE;
DROP TABLE IF EXISTS T1_CLIENTE CASCADE;
DROP TABLE IF EXISTS T1_CLAS_TEMA CASCADE;
DROP TABLE IF EXISTS T1_AREA_INTERES CASCADE;
DROP TABLE IF EXISTS T1_OFICINA_PRINCIPAL CASCADE; 
DROP TABLE IF EXISTS T1_ADQUISICION CASCADE;
DROP TABLE IF EXISTS T1_PIEZA_INTELIGENCIA CASCADE;


CREATE TABLE T1_LUGAR(

    id integer NOT NULL,
    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar integer 
);


CREATE TABLE T1_CLIENTE (

    id integer NOT NULL,
    nombre_empresa varchar(100) NOT NULL,
    pagina_web varchar(100) NOT NULL,    
    fk_lugar_pais integer NOT NULL
);

CREATE TABLE T1_CLAS_TEMA (

    id integer NOT NULL,
    nombre varchar(255) NOT NULL,
    descripcion varchar(500) NOT NULL,
    topico varchar(50) NOT NULL -- 'paises, individuos, eventos, empresas' 
	
);

CREATE TABLE T1_AREA_INTERES (

    fk_clas_tema integer NOT NULL,
    fk_cliente integer NOT NULL
);

CREATE TABLE T1_OFICINA_PRINCIPAL (

    id integer NOT NULL,
    nombre varchar(50) NOT NULL,
    fk_lugar_ciudad integer NOT NULL
);

CREATE TABLE T1_PIEZA_INTELIGENCIA (

    id integer NOT NULL,
	fecha_c timestamp
);

CREATE TABLE T1_ADQUISICION (

    id integer NOT NULL	   
);

---- CREACIÓN DE LAS TABLAS T2 ----
---- COPIA DE LAS TABLAS T1 A LAS TABLAS T2 (TRANSFORMACIÓN) CON FECHA CREACION ----


DROP TABLE IF EXISTS T2_LUGAR CASCADE;
DROP TABLE IF EXISTS T2_CLIENTE CASCADE;
DROP TABLE IF EXISTS T2_CLAS_TEMA CASCADE;
DROP TABLE IF EXISTS T2_AREA_INTERES CASCADE;
DROP TABLE IF EXISTS T2_OFICINA_PRINCIPAL CASCADE; 
DROP TABLE IF EXISTS T2_ADQUISICION CASCADE;
DROP TABLE IF EXISTS T2_PIEZA_INTELIGENCIA CASCADE;


CREATE TABLE T2_LUGAR(

    id integer NOT NULL,
    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar integer ,
	fecha_c timestamp
);


CREATE TABLE T2_CLIENTE (

    id integer NOT NULL,
    nombre_empresa varchar(100) NOT NULL,
    pagina_web varchar(100) NOT NULL,    
    fecha_c timestamp,
    fk_lugar_pais integer NOT NULL
);

CREATE TABLE T2_CLAS_TEMA (

    id integer NOT NULL,
    nombre varchar(255) NOT NULL,
    descripcion varchar(500) NOT NULL,
    topico varchar(50) NOT NULL, -- 'paises, individuos, eventos, empresas' 
	fecha_c timestamp	   
);

CREATE TABLE T2_AREA_INTERES (

    fk_clas_tema integer NOT NULL,
    fk_cliente integer NOT NULL,
	fecha_c timestamp
);

CREATE TABLE T2_OFICINA_PRINCIPAL (

    id integer NOT NULL,
    nombre varchar(50) NOT NULL,
 	fecha_c timestamp,
    fk_lugar_ciudad integer NOT NULL
);

CREATE TABLE T2_PIEZA_INTELIGENCIA (

    id integer NOT NULL,
	fecha_c timestamp,
	fk_clas_tema integer NOT NULL
);

CREATE TABLE T2_ADQUISICION (

    id integer NOT NULL,	
	fecha_c timestamp    
);

---- PRODUCTIVIDAD_EFICACIA ----
---- CREACIÓN DE LAS TABLAS T1 ----
---- COPIAS DEL ER A TABLAS T1 (CAMBIIOS EN LOS PARAMETROS) ----

CREATE TABLE T1_LUGAR(

    id integer NOT NULL,
    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar integer 
);

CREATE TABLE T1_PERSONAL_INTELIGENCIA (

    id integer NOT NULL,
    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50) ,
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,
    fk_lugar_ciudad integer NOT NULL
);

CREATE TABLE OFICINA_PRINCIPAL (

    id integer NOT NULL,
    nombre varchar(50) NOT NULL
);

CREATE TABLE T1_INFORMANTE_ALT (

    id integer NOT NULL,
	
	nombre_clave varchar(100) unique NOT NULL,	
    -- agente de campo encargado del informante
    fk_personal_inteligencia_encargado integer NOT NULL,
    fk_fecha_inicio_encargado timestamp NOT NULL,
    fk_estacion_encargado integer NOT NULL,
    fk_oficina_principal_encargado integer NOT NULL
);



