---- DESEMPEÑO AII ----

------------------------------------------------------------------------------------
---- CREACIÓN DE LAS TABLAS T2 -----------------------------------------------------
---- COPIA DE LAS TABLAS T1 A LAS TABLAS T2 (TRANSFORMACIÓN) CON FECHA CREACION ----
------------------------------------------------------------------------------------

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
	fecha_c timestamp,
    fk_lugar integer,
	CONSTRAINT LUGAR_PK PRIMARY KEY (id),
    CONSTRAINT LUGAR_LUGAR_FK FOREIGN KEY (fk_lugar) REFERENCES T2_LUGAR (id)
);


CREATE TABLE T2_CLIENTE (

    id integer NOT NULL,
    nombre_empresa varchar(100) NOT NULL,
    pagina_web varchar(100) NOT NULL,  
	fecha_c timestamp,
    fk_lugar_pais integer NOT NULL,
	CONSTRAINT CLIENTE_PK PRIMARY KEY (id),
    CONSTRAINT CLIENTE_LUGAR_FK FOREIGN KEY (fk_lugar_pais) REFERENCES T2_LUGAR (id)
);

CREATE TABLE T2_CLAS_TEMA (

    id integer NOT NULL,
	fecha_c timestamp,
    nombre varchar(255) NOT NULL,
    descripcion varchar(500) NOT NULL,
	CONSTRAINT AREA_INTERES_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES T2_CLAS_TEMA (id),
    CONSTRAINT AREA_INTERES_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES T2_CLIENTE (id),
    CONSTRAINT AREA_INTERES_PK PRIMARY KEY (fk_clas_tema, fk_cliente)
);

CREATE TABLE T2_AREA_INTERES (
	
	fecha_c timestamp,
    fk_clas_tema integer NOT NULL,
    fk_cliente integer NOT NULL,
	CONSTRAINT TEMAS_ESP_PK PRIMARY KEY (fk_personal_inteligencia, fk_clas_tema),
    CONSTRAINT TEMAS_ESP_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES T2_CLAS_TEMA (id),
    CONSTRAINT TEMAS_ESP_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES T2_PERSONAL_INTELIGENCIA (id)
);


CREATE TABLE T2_PIEZA_INTELIGENCIA (

    id integer NOT NULL,
	fecha_c timestamp,
	fk_clas_tema integer NOT NULL,
	
    CONSTRAINT PIEZA_INTELIGENCIA_PK PRIMARY KEY (id),
	CONSTRAINT PIEZA_INTELIGENCIA_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES T2_CLAS_TEMA (id)
);

CREATE TABLE T2_ADQUISICION (

    id integer NOT NULL,  
	fecha_c timestamp,
	fk_cliente integer NOT NULL,
    fk_pieza_inteligencia integer NOT NULL,
	
	CONSTRAINT ADQUISICION_PK PRIMARY KEY (id, fk_cliente, fk_pieza_inteligencia),

    CONSTRAINT ADQUISICION_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES T2_CLIENTE (id),
    CONSTRAINT ADQUISICION_PIEZA_INTELIGENCIA_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES T2_PIEZA_INTELIGENCIA (id)
	
);

------------------------------------------------------------------------------------
---- PRODUCTIVIDAD_EFICACIA --------------------------------------------------------
---- CREACIÓN DE LAS TABLAS T1 -----------------------------------------------------
---- COPIAS DEL ER A TABLAS T1 (CAMBIIOS EN LOS PARAMETROS) ------------------------

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

CREATE TABLE T1_OFICINA_PRINCIPAL (

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


CREATE TABLE T1_CRUDO_ALT (

    id integer NOT NULL,

    
    fk_informante integer,

    --estacion a donde pertence
    fk_estacion_pertenece integer NOT NULL,
    fk_oficina_principal_pertenece integer NOT NULL,

    --agente encargado
    fk_estacion_agente integer NOT NULL,
    fk_oficina_principal_agente integer NOT NULL,
    fk_fecha_inicio_agente timestamp NOT NULL,
    fk_personal_inteligencia_agente integer NOT NULL,
);

CREATE TABLE T1_PIEZA_INTELIGENCIA_ALT (

    id integer NOT NULL,  

    --fks hist_cargo
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL,
    fk_clas_tema integer NOT NULL,
);


CREATE TABLE T1_CRUDO_PIEZA_ALT (
    fk_pieza_inteligencia integer NOT NULL,
    fk_crudo integer NOT NULL,

);


------------------------------------------------------------------------------------
---- PRODUCTIVIDAD_EFICACIA --------------------------------------------------------
---- CREACIÓN DE LAS TABLAS T1 -----------------------------------------------------
---- COPIAS DEL ER A TABLAS T1 (CAMBIIOS EN LOS PARAMETROS) ------------------------

CREATE TABLE T2_LUGAR(

    id integer NOT NULL,
    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar integer,
	fecha_c timestamp
);

CREATE TABLE T2_PERSONAL_INTELIGENCIA (

    id integer NOT NULL,
    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50) ,
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,
    fk_lugar_ciudad integer NOT NULL,
	fecha_c timestamp
);

CREATE TABLE T2_OFICINA_PRINCIPAL (

    id integer NOT NULL,
    nombre varchar(50) NOT NULL,
	fecha_c timestamp
);

CREATE TABLE T2_INFORMANTE(

    id integer NOT NULL,	
	nombre_clave varchar(100) unique NOT NULL,	
    -- agente de campo encargado del informante
    fk_personal_inteligencia_encargado integer NOT NULL,
    fk_fecha_inicio_encargado timestamp NOT NULL,
    fk_estacion_encargado integer NOT NULL,
    fk_oficina_principal_encargado integer NOT NULL,
	fecha_c timestamp
);


CREATE TABLE T2_CRUDO(

    id integer NOT NULL,

    
    fk_informante integer,

    --estacion a donde pertence
    fk_estacion_pertenece integer NOT NULL,
    fk_oficina_principal_pertenece integer NOT NULL,

    --agente encargado
    fk_estacion_agente integer NOT NULL,
    fk_oficina_principal_agente integer NOT NULL,
    fk_fecha_inicio_agente timestamp NOT NULL,
    fk_personal_inteligencia_agente integer NOT NULL,
	fecha_c timestamp
);

CREATE TABLE T2_PIEZA_INTELIGENCIA(

    id integer NOT NULL,  

    --fks hist_cargo
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL,
    fk_clas_tema integer NOT NULL,
	fecha_c timestamp
);


CREATE TABLE T2_CRUDO_PIEZA(
    fk_pieza_inteligencia integer NOT NULL,
    fk_crudo integer NOT NULL,
	fecha_c timestamp

);
