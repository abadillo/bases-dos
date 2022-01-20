

-------------------------------------- EJECUTAR COMO ADMINISTRADOR -------------------------------------------------


GRANT EXECUTE ON FUNCTION pg_read_binary_file(text,bigint,bigint,boolean) TO dev01, ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION pg_read_binary_file(text,bigint,bigint) TO dev01, ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION pg_read_binary_file(text) TO dev01, ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;


-- EJECUTAR COMO SUPERUSUARIO admin01 USAGE ES PARA VER LOS OBJECTOS DEL ESQUEMA. CREATE ES PARA CREAR OBJETOS EN EL ESQUEMA 
REVOKE ALL PRIVILEGES ON SCHEMA public FROM PUBLIC, ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC, ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;

REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC, ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;
REVOKE ALL PRIVILEGES ON ALL PROCEDURES IN SCHEMA public FROM PUBLIC, ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;
    

GRANT ALL PRIVILEGES ON SCHEMA public TO dev01;
GRANT ALL ON ALL TABLES IN SCHEMA public TO dev01;

GRANT USAGE ON SCHEMA public TO ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;

----------///////////- ------------------------------------------------------------ ///////////----------
----------//////////////////- CREACION DE TABLAS   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- ------------------------------------------------------------ ///////////----------



-- CREATE Y DROP TYPES

DROP TYPE IF EXISTS nivel_educativo_ty CASCADE;
DROP TYPE IF EXISTS alias_ty CASCADE;
DROP TYPE IF EXISTS identificacion_ty CASCADE;
DROP TYPE IF EXISTS licencia_ty CASCADE;
DROP TYPE IF EXISTS telefono_ty CASCADE;
DROP TYPE IF EXISTS familiar_ty CASCADE;
DROP TYPE IF EXISTS contacto_ty CASCADE;


CREATE TYPE nivel_educativo_ty as (

    pregrado_titulo varchar(50),
    postgrado_tipo varchar(50),
    postgrado_titulo varchar(50)
);

CREATE TYPE alias_ty as (

    primer_nombre varchar(50),
    segundo_nombre varchar(50),
    primer_apellido varchar(50),
    segundo_apellido varchar(50),
    foto bytea,
    fecha_nacimiento timestamp,
    pais varchar(50),
    documento_identidad numeric(10),
    color_ojos varchar(50),
    direccion varchar(255),
    ultimo_uso timestamp
);

CREATE TYPE identificacion_ty as (

	documento_identidad varchar(50),
	pais varchar(50)
);

CREATE TYPE licencia_ty as (

	numero varchar(50),
	pais varchar(50)
);

CREATE TYPE telefono_ty as (

	codigo numeric(10),
	numero numeric(15)
);

CREATE TYPE familiar_ty as (

    primer_nombre varchar(50),
    segundo_nombre varchar(50),
    primer_apellido varchar(50),
    segundo_apellido varchar(50),
    fecha_nacimiento timestamp,
    parentesco varchar(50),
    telefono telefono_ty
);

CREATE TYPE contacto_ty as (

    primer_nombre varchar(50),
	segundo_nombre varchar(50),
	primer_apellido varchar(50),
	segundo_apellido varchar(50),
    direccion varchar(255),

    telefono telefono_ty
);


-- DROP Y CREATE TABLEs

-- FALTAN LAS ULTIMAS TABLAS ALT


DROP TABLE IF EXISTS LUGAR CASCADE;
DROP TABLE IF EXISTS CLIENTE CASCADE;
DROP TABLE IF EXISTS EMPLEADO_JEFE CASCADE;
DROP TABLE IF EXISTS OFICINA_PRINCIPAL CASCADE;
DROP TABLE IF EXISTS ESTACION CASCADE;
DROP TABLE IF EXISTS CUENTA CASCADE;
DROP TABLE IF EXISTS PERSONAL_INTELIGENCIA CASCADE;
DROP TABLE IF EXISTS INTENTO_NO_AUTORIZADO CASCADE;
DROP TABLE IF EXISTS CLAS_TEMA CASCADE;
DROP TABLE IF EXISTS AREA_INTERES CASCADE;
DROP TABLE IF EXISTS TEMAS_ESP CASCADE;
DROP TABLE IF EXISTS HIST_CARGO CASCADE;
DROP TABLE IF EXISTS INFORMANTE CASCADE;
DROP TABLE IF EXISTS TRANSACCION_PAGO CASCADE;
DROP TABLE IF EXISTS CRUDO CASCADE;
DROP TABLE IF EXISTS ANALISTA_CRUDO CASCADE;
DROP TABLE IF EXISTS PIEZA_INTELIGENCIA CASCADE;
DROP TABLE IF EXISTS CRUDO_PIEZA CASCADE;
DROP TABLE IF EXISTS ADQUISICION CASCADE;


CREATE TABLE LUGAR (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar integer ,

    CONSTRAINT LUGAR_PK PRIMARY KEY (id),
    CONSTRAINT LUGAR_LUGAR_FK FOREIGN KEY (fk_lugar) REFERENCES LUGAR (id),
    CONSTRAINT LUGAR_CH_tipo CHECK ( tipo IN ('ciudad', 'pais') ),
    CONSTRAINT LUGAR_CH_region CHECK ( region IN ('europa', 'africa', 'america_sur', 'america_norte', 'asia', 'oceania') )
);


CREATE TABLE CLIENTE (

    id serial NOT NULL,

    nombre_empresa varchar(100) NOT NULL,
    pagina_web varchar(100) NOT NULL,
    exclusivo boolean NOT NULL,
    telefonos telefono_ty[3] NOT NULL,
    contactos contacto_ty[3] NOT NULL,
    fk_lugar_pais integer NOT NULL,
    
    CONSTRAINT CLIENTE_PK PRIMARY KEY (id),
    CONSTRAINT CLIENTE_LUGAR_FK FOREIGN KEY (fk_lugar_pais) REFERENCES LUGAR (id)
);



CREATE TABLE EMPLEADO_JEFE (

    id serial NOT NULL,

    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50) ,
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,
    telefono telefono_ty,
    tipo varchar(50) NOT NULL, -- 'director_area, jefe, director_ejecutivo'
    fk_empleado_jefe integer,

    CONSTRAINT EMPLEADO_JEFE_PK PRIMARY KEY (id),
    CONSTRAINT EMPLEADO_JEFE_FK FOREIGN KEY (fk_empleado_jefe) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT EMPLEADO_JEFE_CH_tipo CHECK ( tipo IN ('director_area', 'jefe', 'director_ejecutivo') )
);

CREATE TABLE OFICINA_PRINCIPAL (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    sede boolean NOT NULL,
    fk_director_area integer ,
    fk_director_ejecutivo integer ,
    fk_lugar_ciudad integer NOT NULL ,

    CONSTRAINT OFICINA_PRINCIPAL_PK PRIMARY KEY (id),
    CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe FOREIGN KEY (fk_director_area) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe_2 FOREIGN KEY (fk_director_ejecutivo) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT OFICINA_PRINCIPAL_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id)
);



CREATE TABLE ESTACION (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    fk_oficina_principal integer NOT NULL,
    fk_empleado_jefe integer NOT NULL,
    fk_lugar_ciudad integer NOT NULL,

    CONSTRAINT ESTACION_PK PRIMARY KEY (id, fk_oficina_principal),
    CONSTRAINT ESTACION_OFICINA_PRINCIPAL_FK FOREIGN KEY (fk_oficina_principal) REFERENCES OFICINA_PRINCIPAL (id),
    CONSTRAINT ESTACION_fk_empleado_jefe FOREIGN KEY (fk_empleado_jefe) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT ESTACION_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id)
    
);

CREATE TABLE CUENTA (
    año date NOT NULL,
    presupuesto numeric(20) NOT NULL,
    fk_estacion integer NOT NULL,
    fk_oficina_principal integer NOT NULL,

    CONSTRAINT CUENTA_PK PRIMARY KEY (año, fk_estacion, fk_oficina_principal),
    CONSTRAINT CUENTA_ESTACION_FK FOREIGN KEY (fk_estacion, fk_oficina_principal) REFERENCES ESTACION (id, fk_oficina_principal)
);

CREATE TABLE PERSONAL_INTELIGENCIA (

    id serial NOT NULL,

    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50) ,
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,
    fecha_nacimiento date NOT NULL,
    altura_cm numeric(5) NOT NULL,
    peso_kg numeric(5) NOT NULL,
    color_ojos varchar(20) NOT NULL,
    vision varchar(20) NOT NULL,
    class_seguridad varchar(50) NOT NULL,
--
--
--    --LOBS
    fotografia bytea NOT NULL,
    huella_retina bytea NOT NULL,
    huella_digital bytea NOT NULL,
       
--    --TDAs
    telefono telefono_ty NOT NULL,
    licencia_manejo licencia_ty,
--    
--    --varray
    idiomas varchar(50)[6] NOT NULL,
    familiares familiar_ty[2] NOT NULL,
    identificaciones identificacion_ty[5] NOT NULL,
--    
--    --nested tables
    nivel_educativo nivel_educativo_ty[] NOT NULL,
    aliases alias_ty[],
    
--    --foreign keys 
--    --fk_estacion integer NOT NULL,
--    --fk_oficina_principal integer NOT NULL,
    fk_lugar_ciudad integer NOT NULL,


    CONSTRAINT PERSONAL_INTELIGENCIA_PK PRIMARY KEY (id),

    --CONSTRAINT PERSONAL_INTELIGENCIA_ESTACION_FK FOREIGN KEY (fk_estacion, fk_oficina_principal ) REFERENCES ESTACION (id, fk_oficina_principal),
    CONSTRAINT PERSONAL_INTELIGENCIA_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id),

    CONSTRAINT PERSONAL_INTELIGENCIA_CH_class_seguridad CHECK ( class_seguridad IN ('top_secret', 'confidencial', 'no_clasificado') )
    
);


CREATE TABLE INTENTO_NO_AUTORIZADO (

    id serial NOT NULL,

    fecha_hora timestamp NOT NULL,
    
    id_pieza integer NOT NULL,
    id_empleado integer NOT NULL,
    
    fk_personal_inteligencia integer NOT NULL ,

    CONSTRAINT INTENTO_NO_AUTORIZADO_PK PRIMARY KEY (id, fk_personal_inteligencia),
    CONSTRAINT INTENTO_NO_AUTORIZADO_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES PERSONAL_INTELIGENCIA (id)
);


CREATE TABLE CLAS_TEMA (

    id serial NOT NULL,

    nombre varchar(255) NOT NULL,
    descripcion varchar(500) NOT NULL,
    topico varchar(50) NOT NULL, -- 'paises, individuos, eventos, empresas' 

    CONSTRAINT CLAS_TEMA_PK PRIMARY KEY (id),

    CONSTRAINT CLAS_TEMA_CH_topico CHECK ( topico IN ('paises', 'individuos', 'eventos', 'empresas') )    
);

CREATE TABLE AREA_INTERES (

    fk_clas_tema integer NOT NULL,
    fk_cliente integer NOT NULL,

    CONSTRAINT AREA_INTERES_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),
    CONSTRAINT AREA_INTERES_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES CLIENTE (id),
    CONSTRAINT AREA_INTERES_PK PRIMARY KEY (fk_clas_tema, fk_cliente)
);

CREATE TABLE TEMAS_ESP (

    fk_personal_inteligencia integer NOT NULL,
    fk_clas_tema integer NOT NULL,

    CONSTRAINT TEMAS_ESP_PK PRIMARY KEY (fk_personal_inteligencia, fk_clas_tema),

    CONSTRAINT TEMAS_ESP_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),
    CONSTRAINT TEMAS_ESP_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES PERSONAL_INTELIGENCIA (id)
);

CREATE TABLE HIST_CARGO (
    
    fecha_inicio timestamp NOT NULL,
    fecha_fin timestamp,
    cargo varchar(20) NOT NULL, -- 'analista agente'
    fk_personal_inteligencia integer NOT NULL,
    fk_estacion integer NOT NULL,
    fk_oficina_principal integer NOT NULL,

    CONSTRAINT HIST_CARGO_PK PRIMARY KEY (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT HIST_CARGO_ESTACION_FK FOREIGN KEY (fk_estacion, fk_oficina_principal) REFERENCES ESTACION (id, fk_oficina_principal),
    CONSTRAINT HIST_CARGO_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES PERSONAL_INTELIGENCIA (id),

    CONSTRAINT HIST_CARGO_CH_cargo CHECK ( cargo IN ('analista', 'agente') )    
);


CREATE TABLE INFORMANTE (

    id serial NOT NULL,

    nombre_clave varchar(100) unique NOT NULL,
    

    -- agente de campo encargado del informante
    fk_personal_inteligencia_encargado integer NOT NULL,    
    fk_fecha_inicio_encargado timestamp NOT NULL,
    fk_estacion_encargado integer NOT NULL,
    fk_oficina_principal_encargado integer NOT NULL,


    -- personal_inteligencia o empleado confidente. Con arco 
    fk_empleado_jefe_confidente integer,
    
    fk_personal_inteligencia_confidente integer,
    fk_fecha_inicio_confidente timestamp,
    fk_estacion_confidente integer,
    fk_oficina_principal_confidente integer,

    
    CONSTRAINT INFORMANTE_PK PRIMARY KEY (id),

    CONSTRAINT AR_confidente CHECK ( 
        ((fk_fecha_inicio_confidente IS NOT NULL) AND (fk_personal_inteligencia_confidente IS NOT NULL) AND (fk_estacion_confidente IS NOT NULL) AND 
        (fk_oficina_principal_confidente IS NOT NULL) AND (fk_empleado_jefe_confidente IS NULL)) 
        
        OR 
       
        ((fk_empleado_jefe_confidente IS NOT NULL) AND (fk_fecha_inicio_confidente IS NULL) AND (fk_personal_inteligencia_confidente IS NULL) AND (fk_estacion_confidente IS NULL) AND 
        (fk_oficina_principal_confidente IS NULL))  
    ),

    CONSTRAINT INFORMANTE_fk_empleado_jefe FOREIGN KEY (fk_empleado_jefe_confidente) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT INFORMANTE_HIST_CARGO_encargado FOREIGN KEY (fk_fecha_inicio_encargado, fk_personal_inteligencia_encargado, fk_estacion_encargado, fk_oficina_principal_encargado) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),
    CONSTRAINT INFORMANTE_HIST_CARGO_confidente FOREIGN KEY (fk_fecha_inicio_confidente, fk_personal_inteligencia_confidente, fk_estacion_confidente, fk_oficina_principal_confidente) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal)

);


CREATE TABLE CRUDO (

    id serial NOT NULL,

    contenido bytea NOT NULL, 
    tipo_contenido varchar(50) NOT NULL, -- 'texto, imagen, sonido, video' 
    resumen varchar(1000) NOT NULL,
    fuente varchar(20) NOT NULL, -- 'abierta, secreta, tecnica'
    valor_apreciacion numeric(20),
    nivel_confiabilidad_inicial numeric(5) NOT NULL,
    nivel_confiabilidad_final numeric(5),
    fecha_obtencion timestamp NOT NULL,
    fecha_verificacion_final timestamp,
    cant_analistas_verifican numeric(5) NOT NULL,

    fk_clas_tema integer NOT NULL,
    fk_informante integer,

    --estacion a donde pertence
    fk_estacion_pertenece integer NOT NULL,
    fk_oficina_principal_pertenece integer NOT NULL,

    --agente encargado
    fk_estacion_agente integer NOT NULL,
    fk_oficina_principal_agente integer NOT NULL,
    fk_fecha_inicio_agente timestamp NOT NULL,
    fk_personal_inteligencia_agente integer NOT NULL,

    CONSTRAINT CRUDO_PK PRIMARY KEY (id),

    CONSTRAINT CRUDO_ESTACION_FK FOREIGN KEY (fk_estacion_pertenece, fk_oficina_principal_pertenece) REFERENCES ESTACION (id, fk_oficina_principal),

    CONSTRAINT CRUDO_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_agente, fk_personal_inteligencia_agente, fk_estacion_agente, fk_oficina_principal_agente) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT CRUDO_INFORMANTE_FK FOREIGN KEY (fk_informante) REFERENCES INFORMANTE (id),
    CONSTRAINT CRUDO_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),

    CONSTRAINT CRUDO_CH_tipo_contenido CHECK ( tipo_contenido IN ('texto', 'imagen', 'sonido', 'video') ),
    CONSTRAINT CRUDO_CH_fuente CHECK ( fuente IN ('abierta', 'secreta', 'tecnica') )  ,
    
    CONSTRAINT CRUDO_CH_nivel_confiabilidad_inicial CHECK ( nivel_confiabilidad_inicial >= 0 AND nivel_confiabilidad_inicial <= 100 ),
    CONSTRAINT CRUDO_CH_nivel_confiabilidad_final CHECK ( nivel_confiabilidad_final >= 0 AND nivel_confiabilidad_final <= 100 )    

);


CREATE TABLE TRANSACCION_PAGO (

    id serial NOT NULL,

    fecha_hora timestamp NOT NULL,
    monto_pago numeric(20) NOT NULL,
    
    fk_crudo integer,
    fk_informante integer NOT NULL,

    CONSTRAINT TRANSACCION_PAGO_PK PRIMARY KEY (id, fk_informante),
    CONSTRAINT TRANSACCION_PAGO_CRUDO_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO (id),
    CONSTRAINT TRANSACCION_PAGO_INFORMANTE_FK FOREIGN KEY (fk_informante) REFERENCES INFORMANTE (id)
);

CREATE TABLE ANALISTA_CRUDO (


    fecha_hora timestamp NOT NULL,
    nivel_confiabilidad numeric(5) NOT NULL,

    fk_crudo integer NOT NULL,

    -- fks de hist_cargo
    fk_fecha_inicio_analista timestamp NOT NULL,
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_estacion_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL ,

    CONSTRAINT ANALISTA_CRUDO_PK PRIMARY KEY (fk_crudo, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista),

    CONSTRAINT ANALISTA_CRUDO_CRUDO_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO (id),
    CONSTRAINT ANALISTA_CRUDO_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT ANALISTA_CRUDO_CH_nivel_confiabilidad CHECK ( nivel_confiabilidad >= 0 AND nivel_confiabilidad <= 100 )    

);


CREATE TABLE PIEZA_INTELIGENCIA (

    id serial NOT NULL,

    fecha_creacion timestamp,
    nivel_confiabilidad numeric(5), 
    precio_base numeric(20),

    descripcion varchar(500),

    class_seguridad varchar(50) NOT NULL,
    
    --fks hist_cargo
    fk_fecha_inicio_analista timestamp NOT NULL,
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_estacion_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL,

    fk_clas_tema integer NOT NULL,

    CONSTRAINT PIEZA_INTELIGENCIA_PK PRIMARY KEY (id),
    
    CONSTRAINT PIEZA_INTELIGENCIA_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT PIEZA_INTELIGENCIA_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),
    
    CONSTRAINT PIEZA_INTELIGENCIA_CH_class_seguridad CHECK ( class_seguridad IN ('top_secret', 'confidencial', 'no_clasificado') ),
    CONSTRAINT PIEZA_INTELIGENCIA_CH_nivel_confiabilidad CHECK ( nivel_confiabilidad >= 0 AND nivel_confiabilidad <= 100 )    
);


CREATE TABLE CRUDO_PIEZA (
    fk_pieza_inteligencia integer NOT NULL,
    fk_crudo integer NOT NULL,

    CONSTRAINT CRUDO_PIEZA_PK PRIMARY KEY (fk_pieza_inteligencia, fk_crudo),
    CONSTRAINT CRUDO_PIEZA_PIEZA_INTELIGENCIA_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES PIEZA_INTELIGENCIA (id),
    CONSTRAINT CRUDO_PIEZA_CRUDO_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO (id)
);



CREATE TABLE ADQUISICION (

    id serial NOT NULL,

    fecha_hora_venta timestamp NOT NULL,
    precio_vendido numeric(20) NOT NULL,

    fk_cliente integer NOT NULL,
    fk_pieza_inteligencia integer NOT NULL,
    
    CONSTRAINT ADQUISICION_PK PRIMARY KEY (id, fk_cliente, fk_pieza_inteligencia),

    CONSTRAINT ADQUISICION_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES CLIENTE (id),
    CONSTRAINT ADQUISICION_PIEZA_INTELIGENCIA_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES PIEZA_INTELIGENCIA (id)
);



-------------------------------------////////////////- CREACION DE TABLAS SECRETAS -/////////////////////------------------------------------------

DROP TABLE IF EXISTS INFORMANTE_ALT CASCADE;
DROP TABLE IF EXISTS TRANSACCION_PAGO_ALT CASCADE;
DROP TABLE IF EXISTS CRUDO_ALT CASCADE;
DROP TABLE IF EXISTS ANALISTA_CRUDO_ALT CASCADE;
DROP TABLE IF EXISTS PIEZA_INTELIGENCIA_ALT CASCADE;
DROP TABLE IF EXISTS CRUDO_PIEZA_ALT CASCADE;
DROP TABLE IF EXISTS ADQUISICION_ALT CASCADE;


CREATE TABLE INFORMANTE_ALT (

    id integer NOT NULL,

    -- agente de campo encargado del informante
    fk_personal_inteligencia_encargado integer NOT NULL,
    fk_fecha_inicio_encargado timestamp NOT NULL,
    fk_estacion_encargado integer NOT NULL,
    fk_oficina_principal_encargado integer NOT NULL,

    CONSTRAINT INFORMANTE_ALT_PK PRIMARY KEY (id)
     
);


CREATE TABLE CRUDO_ALT (

    id integer NOT NULL,

    fuente varchar(20) NOT NULL, -- 'abierta, secreta, tecnica'
    fecha_obtencion timestamp NOT NULL,
  
    fk_clas_tema integer NOT NULL,
    fk_informante integer,

    --estacion a donde pertence
    fk_estacion_pertenece integer NOT NULL,
    fk_oficina_principal_pertenece integer NOT NULL,

    --agente encargado
    fk_estacion_agente integer NOT NULL,
    fk_oficina_principal_agente integer NOT NULL,
    fk_fecha_inicio_agente timestamp NOT NULL,
    fk_personal_inteligencia_agente integer NOT NULL,

    CONSTRAINT CRUDO_ALT_PK PRIMARY KEY (id)

    -- CONSTRAINT CRUDO_ALT_INFORMANTE_ALT_FK FOREIGN KEY (fk_informante) REFERENCES INFORMANTE_ALT (id),

    -- CONSTRAINT CRUDO_ALT_CH_fuente CHECK ( fuente IN ('abierta', 'secreta', 'tecnica') ) 
);



CREATE TABLE TRANSACCION_PAGO_ALT (

    id integer NOT NULL,

    fecha_hora timestamp NOT NULL,
    monto_pago numeric(20) NOT NULL,

    fk_crudo integer,
    fk_informante integer NOT NULL,

    CONSTRAINT TRANSACCION_PAGO_ALT_PK PRIMARY KEY (id, fk_informante)
    -- CONSTRAINT TRANSACCION_PAGO_ALT_CRUDO_ALT_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO_ALT (id),
    -- CONSTRAINT TRANSACCION_PAGO_ALT_INFORMANTE_ALT_FK FOREIGN KEY (fk_informante) REFERENCES INFORMANTE_ALT (id)
);

CREATE TABLE ANALISTA_CRUDO_ALT (

    fecha_hora timestamp NOT NULL,

    fk_crudo integer NOT NULL,

    -- fks de hist_cargo
    fk_fecha_inicio_analista timestamp NOT NULL,
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_estacion_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL ,

    CONSTRAINT ANALISTA_CRUDO_ALT_PK PRIMARY KEY (fk_crudo, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista)

    -- CONSTRAINT ANALISTA_CRUDO_CRUDO_ALT_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO_ALT (id),
   
);


CREATE TABLE PIEZA_INTELIGENCIA_ALT (

    id integer NOT NULL,

    fecha_creacion timestamp,
    precio_base numeric(20),
  

    --fks hist_cargo
    fk_fecha_inicio_analista timestamp NOT NULL,
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_estacion_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL,

    fk_clas_tema integer NOT NULL,

    CONSTRAINT PIEZA_INTELIGENCIA_ALT_PK PRIMARY KEY (id)

     
);


CREATE TABLE CRUDO_PIEZA_ALT (
    fk_pieza_inteligencia integer NOT NULL,
    fk_crudo integer NOT NULL,

    CONSTRAINT CRUDO_PIEZA_ALT_PK PRIMARY KEY (fk_pieza_inteligencia, fk_crudo)
    -- CONSTRAINT CRUDO_PIEZA_ALT_PIEZA_INTELIGENCIA_ALT_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES PIEZA_INTELIGENCIA_ALT (id),
    -- CONSTRAINT CRUDO_PIEZA_ALT_CRUDO_ALT_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO_ALT (id)
);



CREATE TABLE ADQUISICION_ALT (

    id integer NOT NULL,

    fecha_hora_venta timestamp NOT NULL,
    precio_vendido numeric(20) NOT NULL,

    fk_cliente integer NOT NULL,
    fk_pieza_inteligencia integer NOT NULL,

    CONSTRAINT ADQUISICION_ALT_PK PRIMARY KEY (id, fk_cliente, fk_pieza_inteligencia)

    -- CONSTRAINT ADQUISICION_ALT_PIEZA_INTELIGENCIA_ALT_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES PIEZA_INTELIGENCIA_ALT (id)
);







----------///////////- ------------------------------------------------------------ ///////////----------
----------//////////////////- CREACION DE INDICES   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- ------------------------------------------------------------ ///////////----------


CREATE INDEX crudo_fecha_obtencion_mas_reciente ON CRUDO ( fecha_obtencion DESC );

CREATE INDEX crudo_fecha_verificacion_final_mas_reciente ON CRUDO ( fecha_verificacion_final DESC );





----------///////////- ------------------------------------------------------------ ///////////----------
----------//////////////////- CREACION DE VISTAS   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- ------------------------------------------------------------ ///////////----------


-- DE DIRECTOR EJECUTIVO

CREATE OR REPLACE VIEW VISTA_DIRECTORES_AREA AS
    SELECT * FROM EMPLEADO_JEFE WHERE tipo = 'director_area';

CREATE OR REPLACE VIEW VISTA_OFICINAS AS
    SELECT * FROM OFICINA_PRINCIPAL;

CREATE OR REPLACE VIEW VISTA_CUENTA_AII AS 
	SELECT * FROM CUENTA;


-- DE DIRECTOR AREA

-- OFICINA Dublin id 1
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_DUBLIN AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 1 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_DUBLIN AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 1 AND c.fk_estacion = e.id;


-- OFICINA Amsterdam id 2
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_AMSTERDAM AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 2 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_AMSTERDAM AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 2 AND c.fk_estacion = e.id;


-- OFICINA Nuuk id 3
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_NUUK AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 3 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_NUUK AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 3 AND c.fk_estacion = e.id;


-- OFICINA Buenos_Aires id 4
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_BUENOS_AIRES AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 4 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_BUENOS_AIRES AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 4 AND c.fk_estacion = e.id;


-- OFICINA Taipei id 5
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_TAIPEI AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 5 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_TAIPEI AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 5 AND c.fk_estacion = e.id;


-- OFICINA Kuala_Lumpur id 6
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_KUALA_LUMPUR AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 6 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_KUALA_LUMPUR AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 6 AND c.fk_estacion = e.id;


-- OFICINA Kampala id 7
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_KAMPALA AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 7 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_KAMPALA AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 7 AND c.fk_estacion = e.id;


-- OFICINA Harare id 8
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_HARARE AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 8 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_HARARE AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 8 AND c.fk_estacion = e.id;


-- OFICINA Sidney id 9
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_SIDNEY AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 9 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_SIDNEY AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 9 AND c.fk_estacion = e.id;


-- OFICINA Ginebra id 10
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_GINEBRA AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 10 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_GINEBRA AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 10 AND c.fk_estacion = e.id;








----------///////////- ---------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- CREACION DE TRIGGERS Y FUNCIONES NECESARIOS PARA LA INSERCION DE LOS DATOS   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- ---------------------------------------------------------------------------------------------------------- ///////////----------





------------------------------------------------------------------------
------ TRIGGER PARA LA COPIA DE ADQUISICION----- BUENO

CREATE OR REPLACE FUNCTION TRIGGER_COPIA_ADQUISICION()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE

--	adquisicion_reg adquisicion%rowtype;

	adquisicion_reg_alt adquisicion_alt%rowtype;

BEGIN

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_COPIA_ADQUISICION ( % ) ------', NOW();

	SELECT * INTO adquisicion_reg_alt
	FROM adquisicion_alt	
	WHERE id = old.id;

	--select * from adquisicion

	IF (adquisicion_reg_alt IS NULL) THEN

		--		SELECT * INTO adquisicion_reg
		--		FROM adquisicion
		--		WHERE fk_pieza = (SELECT id FROM pieza_inteligencia WHERE fk_pieza = id)
		--		AND fk_cliente = (SELECT id FROM cliente WHERE fk_cliente = id);
		--		
		RAISE INFO 'DATOS DE ADQUISICION A COPIAR %', old;

		INSERT INTO adquisicion_alt(
			id,
			fecha_hora_venta,
			precio_vendido,

			fk_cliente,
			fk_pieza_inteligencia	

		) VALUES (
			old.id,
			old.fecha_hora_venta,
			old.precio_vendido,

			old.fk_cliente,
			old.fk_pieza_inteligencia		
		);

		RAISE INFO 'REGISTRO EN LA TABLA ADQUISICION_ALT EXITOSO';

	ELSE

		RAISE INFO 'LA ADQUISICION YA ESTA REGISTRADO';

	END IF;

	RETURN old;


END
$$;
----DROP PROCEDURE TRIGGER_COPIA_ADQUISICION(integer)

CREATE TRIGGER TRIGGER_COPIA_ADQUISICION
BEFORE DELETE ON ADQUISICION
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_ADQUISICION();





------------------------------------------------------------------------
-----CREACION DE FUNCION TRIGGER PARA CRUDO_PIEZA---   BUENO
CREATE OR REPLACE FUNCTION TRIGGER_COPIA_CRUDO_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE

	crudo_pieza_alt_reg crudo_pieza_alt%rowtype;

BEGIN


	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_COPIA_CRUDO_PIEZA ( % ) ------', NOW();

	SELECT * INTO crudo_pieza_alt_reg FROM crudo_pieza_alt
	WHERE fk_pieza_inteligencia= old.fk_pieza_inteligencia
	AND fk_crudo = old.fk_crudo;

	IF (crudo_pieza_alt_reg IS NULL) THEN

		RAISE INFO 'INFORMACION A INSERTAR EN LA TABLA CRUDO_PIEZA %', old;

	---INSERT EN LA TABLA ALT DE CRUDP_PIEZA (COPIA DE INFORMACION)

		INSERT INTO crudo_pieza_alt (

			fk_pieza_inteligencia,
			fk_crudo

		) VALUES (

			old.fk_pieza_inteligencia,
			old.fk_crudo
		);		

	ELSE

		RAISE INFO 'CRUDO_PIEZA YA INSERTADO';

	END IF;

	RETURN old;

END
$$;

----------------CREACION DEL TRIGGER --------------------
CREATE TRIGGER TRIGGER_COPIA_CRUDO_PIEZA
BEFORE DELETE ON crudo_pieza
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_CRUDO_PIEZA();
----DROP TRIGGER TRIGGER_CEUDO_PIEZA ON crudo_pieza




------------------------------------------------------------------------
----- FUNCION DEL TRIGGER PRINCIPAL DE ELIMINACION DE PIEZA POR VENTA EXCLUSIVA -----
CREATE OR REPLACE FUNCTION TRIGGER_COPIA_INFO_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 

--	copia_historico hist_cargo%rowtype;
	pieza_inteligencia_alt_reg PIEZA_INTELIGENCIA_ALT%ROWTYPE;

BEGIN

----SELECT PARA EXTRAER LA INFO DE LA TABLA PIEZA_INTELIGENCIA
	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_COPIA_CRUDO_PIEZA ( % ) ------', NOW();

	RAISE INFO 'INFORMACION DE LA PIEZA A COPIAR Fecha creacion: %, precio: %', old.fecha_creacion, old.precio_base;


	SELECT * INTO pieza_inteligencia_alt_reg FROM pieza_inteligencia_alt WHERE id = old.id;

	IF (pieza_inteligencia_alt_reg IS NULL) THEN
	----INSERT EN LA TABLA ALT DE PIEZA (COPIA DE INFORMACION)

		INSERT INTO pieza_inteligencia_alt (
		id,
		fecha_creacion,
		precio_base,
		fk_fecha_inicio_analista,
		fk_personal_inteligencia_analista,
		fk_estacion_analista,
		fk_oficina_principal_analista, 
		fk_clas_tema)
		values (
		old.id,
		old.fecha_creacion,
		old.precio_base, 
		old.fk_fecha_inicio_analista,
		old.fk_personal_inteligencia_analista,
		old.fk_estacion_analista,
		old.fk_oficina_principal_analista,
		old.fk_clas_tema	
		);

		RAISE INFO 'COPIADO LA INFORMACION EN LA TABLA ALTERNATIVA DE PIEZA';


	ELSE 
		RAISE INFO 'YA ESTA COPIADA LA PIEZA';

	END IF;

	RETURN old;

END
$$;
----------------CREACION DEL TRIGGER --------------------

CREATE TRIGGER TRIGGER_COPIA_INFO_PIEZA
BEFORE DELETE ON pieza_inteligencia
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_INFO_PIEZA();

----DROP TRIGGER trigger_copia_pieza ON pieza_inteligencia;





------------------------------------------------------------------------
------CREACION DE PROCEDIMIENTO PARA LA COPIA DE DATOS DEL INFORMANTE
CREATE OR REPLACE PROCEDURE PROCEDIMIENTO_COPIA_INFORMANTE (id_informante integer)
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 

	informante_reg informante%rowtype;
	informante_alt_reg informante_alt%ROWTYPE;

BEGIN


	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO PROCEDIMIENTO_COPIA_INFORMANTE ( % ) ------', NOW(); 
	--- INFORMACION DE LA TABLA DE INFORMANTE_ALT	
	SELECT * INTO informante_alt_reg FROM informante_alt
	WHERE id = id_informante;

	--- INFORMACION DE LA TABLA DE INFORMANTE	
	SELECT * INTO informante_reg FROM informante
	WHERE id = id_informante;

	RAISE INFO 'DATOS DEL INFORMANTE A COPIAR : %', informante_reg;

	---- INSERT EN LA TABLA ALTERNATIVA DE INFORMANTE(COPIA DE INFORMACION)

	IF (informante_alt_reg IS NULL) THEN

		INSERT INTO informante_alt(
		id,
		fk_personal_inteligencia_encargado,
		fk_fecha_inicio_encargado,
		fk_estacion_encargado,
		fk_oficina_principal_encargado	
		) VALUES (
		informante_reg.id,
		informante_reg.fk_personal_inteligencia_encargado,
		informante_reg.fk_fecha_inicio_encargado,
		informante_reg.fk_estacion_encargado,
		informante_reg.fk_oficina_principal_encargado		
		);

		RAISE INFO 'DATOS DEL INFORMANTE ESTAN COPIADOS EN LA TABLA ALTERNATIVA';

	ELSE

		RAISE INFO 'El informante ya esta copiado';

	END IF;



END
$$;


CREATE OR REPLACE FUNCTION TRIGGER_COPIA_INFORMANTE()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
BEGIN

----SELECT PARA EXTRAER LA INFO DE LA TABLA PIEZA_INTELIGENCIA

	CALL PROCEDIMIENTO_COPIA_INFORMANTE(old.id);

	RETURN old;

END
$$;


CREATE TRIGGER TRIGGER_COPIA_INFORMANTE
BEFORE DELETE ON INFORMANTE
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_INFORMANTE();

------DROP PROCEDURE PROCEDIMIENTO_COPIA_INFORMANTE(integer, timestamp)





------------------------------------------------------------------------
-----FUNCION DEL TRIGGER PARA TRANSACCION_PAGO----
CREATE OR REPLACE FUNCTION TRIGGER_COPIAR_TRANSACCION_PAGO()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE

	transaccion_alt_reg transaccion_pago_alt%rowtype;

BEGIN
	---SELECT PARA LA INFORMACION DE LA TABLA TRANSACCION

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_COPIAR_TRANSACCION_PAGO ( % ) ------', NOW(); 

	-- CALL PROCEDIMIENTO_COPIA_INFORMANTE(old.fk_informante);

	SELECT * INTO transaccion_alt_reg FROM transaccion_pago_alt
	WHERE fk_crudo = old.fk_crudo 
	AND fk_informante = old.fk_informante
	AND id = old.id;

	RAISE INFO 'INFORMACION DE LA TRANSSACION A COPIAR: %', old;

	IF (transaccion_alt_reg IS NULL) THEN

	--- INSERT EN LA TABLA ALT DE TRANSACCION (COPIA DE INFORMACION)
		INSERT INTO transaccion_pago_alt(
			id,
			fecha_hora,
			monto_pago,

			fk_crudo,
			fk_informante	
		) VALUES(
			old.id,
			old.fecha_hora,
			old.monto_pago,

			old.fk_crudo,
			old.fk_informante
		);

		RAISE INFO 'COPIADO LA INFORMACION EN LA TABLA ALTERNATIVA DE PIEZA';

	ELSE 
		RAISE INFO 'YA ESTA COPIADA LA TRANSACCION_PAGO';

	END IF;


	RETURN old;

END
$$;
----------------CREACION DEL TRIGGER --------------------


CREATE TRIGGER TRIGGER_COPIAR_TRANSACCION_PAGO
BEFORE DELETE ON transaccion_pago
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIAR_TRANSACCION_PAGO();
--- 
--DROP TRIGGER TRIGGER_COPIAR_TRANSACCION_PAGO ON transaccion_pago;






------------------------------------------------------------------------
----- FUNCION DEL TRIGGER PARA COPIAR EL CRUDO-----
CREATE OR REPLACE FUNCTION TRIGGER_COPIA_CRUDO()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE

	crudo_alt_reg crudo_alt%rowtype;

BEGIN

--SELECT PARA EXTRAR LA INFO DEL CRUDO
	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_COPIA_CRUDO ( % ) ------', NOW();  

	SELECT * INTO crudo_alt_reg FROM crudo_alt
	WHERE id = old.id;

	

	IF (crudo_alt_reg IS NULL) THEN
	---- INSERT EN LA TABLA ALT DE HISTORICO(COPIA DE INFORMACION)

		----INSERT EN LA TABLA ALT DE CRUDO (COPIA DE INFORMACION)
		INSERT INTO crudo_alt (
			id,
			fuente, 
			fecha_obtencion,

			fk_clas_tema,
			fk_informante,

			fk_estacion_pertenece, 
			fk_oficina_principal_pertenece,

			fk_estacion_agente,
			fk_oficina_principal_agente,
			fk_fecha_inicio_agente,
			fk_personal_inteligencia_agente
		) VALUES (
			old.id,
			old.fuente, 
			old.fecha_obtencion,

			old.fk_clas_tema,
			old.fk_informante,

			old.fk_estacion_pertenece, 
			old.fk_oficina_principal_pertenece,

			old.fk_estacion_agente,
			old.fk_oficina_principal_agente,
			old.fk_fecha_inicio_agente,
			old.fk_personal_inteligencia_agente    
		);

		RAISE INFO 'COPIADO LA INFORMACION EN LA TABLA ALTERNATIVA DE CRUDO';

	ELSE
		RAISE INFO 'Ya está copiado el registro de crudo';
		--	  RAISE EXCEPTION 'HUBO UN ERROR EN COPIAR INFORMANTE O HISTORICO CARGO';
		--	  RETURN NULL;
	END IF;

	return old;

END
$$;




------------------CREACION DEL TRIGGER --------------------
CREATE TRIGGER TRIGGER_COPIA_CRUDO
BEFORE DELETE ON CRUDO
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_CRUDO();
--DROP TRIGGER TRIGGER_COPIA_CRUDO ON CRUDO;
--DROP FUNCTION TRIGGER_COPIA_CRUDO();
----
--




------------------------------------------------------------------------
------TRIGGER PARA LA COPIA DE ADQUISICION----- BUENO

CREATE OR REPLACE FUNCTION TRIGGER_COPIA_ANALISTA_CRUDO()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE

--	adquisicion_reg adquisicion%rowtype;

	analista_crudo_alt_reg analista_crudo_alt%rowtype;

BEGIN

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_COPIA_ANALISTA_CRUDO ( % ) ------', NOW();

	SELECT * INTO analista_crudo_alt_reg
	FROM analista_crudo_alt	
	WHERE fk_crudo = old.fk_crudo AND
	fk_fecha_inicio_analista = old.fk_fecha_inicio_analista AND
	fk_personal_inteligencia_analista = old.fk_personal_inteligencia_analista AND
	fk_estacion_analista = old.fk_estacion_analista AND
	fk_oficina_principal_analista = old.fk_oficina_principal_analista;

	--select * from adquisicion

	IF (analista_crudo_alt_reg IS NULL) THEN
		

		INSERT INTO analista_crudo_alt(
			fecha_hora ,
			fk_crudo,
			fk_fecha_inicio_analista,
			fk_personal_inteligencia_analista ,
			fk_estacion_analista ,
			fk_oficina_principal_analista 

		) VALUES (
			old.fecha_hora,
			old.fk_crudo,
			old.fk_fecha_inicio_analista,
			old.fk_personal_inteligencia_analista ,
			old.fk_estacion_analista ,
			old.fk_oficina_principal_analista 		
		);

		RAISE INFO 'REGISTRO EN LA TABLA ANALISTA_CRUDO EXITOSO';

	ELSE

		RAISE INFO 'REGISTRO ANALISTA_CRUDO YA ESTA REGISTRADO';

	END IF;

	RETURN old;


END
$$;
----DROP PROCEDURE TRIGGER_COPIA_ADQUISICION(integer)

CREATE TRIGGER TRIGGER_COPIA_ANALISTA_CRUDO
BEFORE DELETE ON ANALISTA_CRUDO
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_ANALISTA_CRUDO();






----------///////////- ---------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- CREACION DE TRIGGERS Y FUNCIONES NECESARIOS PARA LA INSERCION DE LOS DATOS   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- ---------------------------------------------------------------------------------------------------------- ///////////----------



-------------------------- FUNCIONES NECESARIAS PARA EL PARA EL INSERT -----------------------------

CREATE OR REPLACE PROCEDURE ELIMINACION_REGISTROS_VENTA_EXCLUSIVA ( id_pieza IN integer ) 
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$

DECLARE 

	id_crudos_asociados integer[] ;	

BEGIN 

	id_crudos_asociados := ARRAY( 
		SELECT fk_crudo FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza
	);

	RAISE INFO 'IDs de crudos de la pieza %: %', id_pieza, id_crudos_asociados;

	DELETE FROM ADQUISICION WHERE fk_pieza_inteligencia = id_pieza;

	DELETE FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza;

	DELETE FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;

	DELETE FROM TRANSACCION_PAGO WHERE fk_crudo = ANY(id_crudos_asociados);

	DELETE FROM ANALISTA_CRUDO WHERE fk_crudo = ANY(id_crudos_asociados);

	DELETE FROM CRUDO WHERE id = ANY(id_crudos_asociados);


END $$;


--------------------------/////////////// FUNCION PARA INSERT EN COLUMNA BYTEA //////////////////---------------------- 


CREATE OR REPLACE FUNCTION FORMATO_ARCHIVO_A_BYTEA ( ruta_archivo IN text ) 
RETURNS bytea 
LANGUAGE plpgsql
SECURITY DEFINER AS $$ 
DECLARE 

--  ruta text := 'C:\Users\Mickel\BD2\bases-dos\scripts\';
--	ruta text := '/mnt/postgres/';
--  ruta text := 'C:\Users\Mickel\BD2\bases-dos\scripts\';

	ruta text := 'temp_files/';
	
BEGIN 

	RETURN (ruta || ruta_archivo); 

	-- RETURN pg_read_binary_file(ruta || ruta_archivo); 
	
END $$;


-- INSERT INTO crudo (contenido, tipo_contenido, resumen, fuente, valor_apreciacion, nivel_confiabilidad_inicial, nivel_confiabilidad_final, fecha_obtencion, fecha_verificacion_final, cant_analistas_verifican, fk_clas_tema, fk_informante, fk_estacion_pertenece, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente) VALUES
-- (FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Problemas politicos en Vitnam I', 'secreta', 500, 85, 85 , '2034-01-08 01:00:00', '2034-01-06 01:00:00', 2, 1, 1, 1, 1, 1, 1, '2034-01-05 01:00:00', 1);

-- SELECT FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg');

-- SHOW  data_directory;
--SELECT  * from crudo c ;



----------------------- FUNCIONES REPORTES E INSERT  -------------------------------

DROP FUNCTION IF EXISTS RESTA_7_DIAS CASCADE;

CREATE OR REPLACE FUNCTION RESTA_7_DIAS ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '7 days';
	
END $$;


DROP FUNCTION IF EXISTS RESTA_6_MESES CASCADE;

CREATE OR REPLACE FUNCTION RESTA_6_MESES ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '6 month';
	
END $$;



DROP FUNCTION IF EXISTS RESTA_1_YEAR CASCADE;

CREATE OR REPLACE FUNCTION RESTA_1_YEAR ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '1 years';
	
END $$;


DROP FUNCTION IF EXISTS RESTA_1_YEAR_DATE CASCADE;

CREATE OR REPLACE FUNCTION RESTA_1_YEAR_DATE ( fecha IN date ) 
RETURNS date
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '1 years';
	
END $$;



DROP FUNCTION IF EXISTS RESTA_3_MESES CASCADE;

CREATE OR REPLACE FUNCTION RESTA_3_MESES ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '3 month';
	
END $$;


DROP FUNCTION IF EXISTS RESTA_3_MESES_DATE CASCADE;

CREATE OR REPLACE FUNCTION RESTA_3_MESES_DATE ( fecha IN date ) 
RETURNS date
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '3 month';
	
END $$;


-------------------------//////////ACTUALIZAR TODAS LAS FECHAS - RESTA 14 años  /////////////-------------------------


DROP FUNCTION IF EXISTS RESTA_14_FECHA CASCADE;

CREATE OR REPLACE FUNCTION RESTA_14_FECHA ( fecha IN date ) 
RETURNS date
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '14 years';
	
END $$;

------- .... -------

DROP FUNCTION IF EXISTS RESTA_14_FECHA_HORA CASCADE;

CREATE OR REPLACE FUNCTION RESTA_14_FECHA_HORA ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '14 years';
	
END $$;












----------///////////- ---------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- INSERCION DE DATOS   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- ---------------------------------------------------------------------------------------------------------- ///////////----------





--ALTER TABLE INFORMANTE DISABLE TRIGGER ALL;

TRUNCATE TABLE LUGAR RESTART IDENTITY CASCADE;
TRUNCATE TABLE CLIENTE RESTART IDENTITY CASCADE;
TRUNCATE TABLE EMPLEADO_JEFE RESTART IDENTITY CASCADE;
TRUNCATE TABLE OFICINA_PRINCIPAL RESTART IDENTITY CASCADE;
TRUNCATE TABLE ESTACION RESTART IDENTITY CASCADE;
TRUNCATE TABLE CUENTA RESTART IDENTITY CASCADE;
TRUNCATE TABLE PERSONAL_INTELIGENCIA RESTART IDENTITY CASCADE;
TRUNCATE TABLE INTENTO_NO_AUTORIZADO RESTART IDENTITY CASCADE;
TRUNCATE TABLE CLAS_TEMA RESTART IDENTITY CASCADE;
TRUNCATE TABLE AREA_INTERES RESTART IDENTITY CASCADE;
TRUNCATE TABLE TEMAS_ESP RESTART IDENTITY CASCADE;
TRUNCATE TABLE HIST_CARGO RESTART IDENTITY CASCADE;
TRUNCATE TABLE INFORMANTE RESTART IDENTITY CASCADE;
TRUNCATE TABLE TRANSACCION_PAGO RESTART IDENTITY CASCADE;
TRUNCATE TABLE CRUDO RESTART IDENTITY CASCADE;
TRUNCATE TABLE ANALISTA_CRUDO RESTART IDENTITY CASCADE;
TRUNCATE TABLE PIEZA_INTELIGENCIA RESTART IDENTITY CASCADE;
TRUNCATE TABLE CRUDO_PIEZA RESTART IDENTITY CASCADE;
TRUNCATE TABLE ADQUISICION RESTART IDENTITY CASCADE;

TRUNCATE TABLE INFORMANTE_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE TRANSACCION_PAGO_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE CRUDO_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE ANALISTA_CRUDO_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE PIEZA_INTELIGENCIA_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE CRUDO_PIEZA_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE ADQUISICION_ALT RESTART IDENTITY CASCADE;

      

-------------------------------/////////////////////------------------------------

-- LUGAR

INSERT INTO lugar (nombre, tipo, region, fk_lugar) VALUES
('Irlanda', 'pais','europa', null),
('Holanda', 'pais','europa', null),
('Groenlandia', 'pais','america_norte', null),
('Argentina', 'pais','america_sur', null),
('Taiwán', 'pais','asia', null),
('Malasia', 'pais','asia', null),
('Uganda', 'pais','africa', null),
('Zimbabue', 'pais','africa', null),
('Australia', 'pais','oceania', null),
('Dublin', 'ciudad',null, 1),
('Cork', 'ciudad',null, 1),
('Galway', 'ciudad',null, 1),
('Amsterdam', 'ciudad',null, 2),
('Roterdam', 'ciudad',null, 2),
('Haarlam', 'ciudad',null, 2),
('Nuuk', 'ciudad',null, 3),
('Qaqortoq', 'ciudad',null, 3),
('Sisimiut ', 'ciudad',null, 3),
('Buenos Aires', 'ciudad',null, 4),
('Ciudad de Cordoba', 'ciudad',null, 4),
('Rosario', 'ciudad',null, 4),
('Taipei', 'ciudad',null, 5),
('Tainan', 'ciudad',null, 5),
('Kaohsiung', 'ciudad',null, 5),
('Kuala Lumpur', 'ciudad',null, 6),
('Malaca', 'ciudad',null, 6),
('Pulau Pinang', 'ciudad',null, 6),
('Kampala', 'ciudad',null, 7),
('Entebbe', 'ciudad',null, 7),
('Kasese', 'ciudad',null, 7),
('Harare', 'ciudad',null, 8),
('Bulawayo', 'ciudad',null, 8),
('Chitungwiza', 'ciudad',null, 8),
('Sidney', 'ciudad',null, 9),
('Perth', 'ciudad',null, 9),
('Gold Coast', 'ciudad',null, 9),
('Suiza', 'pais','europa', null),
('Ginebra', 'ciudad',null, 37);



-- EMPLEADO_JEFE

INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_ejecutivo', null),
('Elian', 'Maximo', 'Carter', 'Silva', ROW(412,6699623), 'director_area', 1),
('Fabiano', 'Tarsicio', 'Santamaria', 'Jaquez', ROW(412,3948307), 'director_area', 1),
('Esperanza', 'Ana', 'Corona', 'Granados', ROW(412,1189159), 'director_area', 1),
('Octavia', 'Eduviges', 'Mena', 'Alcantara', ROW(412,3974651), 'director_area', 1),
('Anthony', 'Amilcar', 'Tafoya', 'Buenrostro', ROW(414,1319978), 'director_area', 1),
('Fidel', 'Juan', 'Regalado', 'Machuca', ROW(416,7319514), 'director_area', 1),
('Luna', 'Judith', 'Castrejon', 'Narvaez', ROW(412,6345573), 'director_area', 1),
('Klement', null, 'Montiel', 'Salguero', ROW(414,3977631), 'director_area', 1),
('Daniel', null, 'Price', 'Gallardo', ROW(414,3609837), 'director_area', 1),
('Silvester', null, 'Morris', 'Serrato', ROW(412,5343364), 'jefe', 2),
('Pamela', null, 'Guevara', 'Zapata', ROW(424,2908908), 'jefe', 2),
('Feliciano', 'Jaime', 'Hurtado', 'Baca', ROW(424,2109538), 'jefe', 2),
('Eloisa', 'Petronila', 'Nolasco', 'White', ROW(414,6830298), 'jefe', 3),
('Cayetano', 'Paulo', 'Guillen', 'Miramontes', ROW(412,4866865), 'jefe', 3),
('Constantino', 'Adolfo', 'Bustos', 'Lima', ROW(412,2392031), 'jefe', 3),
('Antonio', 'Tulio', 'Pinto', 'Cordero', ROW(416,3952857), 'jefe', 4),
('Dulcinea', 'Consuelo', 'Pizarro', 'Santiago', ROW(416,7676921), 'jefe', 4),
('Marsello', 'Alan', 'Carpio', 'Thomas', ROW(414,7291221), 'jefe', 4),
('Antonio', 'Diego', 'Recinos', 'Santacruz', ROW(414,4392478), 'jefe', 5),
('Greta', null, 'Valdivia', 'Cruz', ROW(416,1080469), 'jefe', 5),
('Marcela', null, 'Galdamez', 'Rogers', ROW(412,6909353), 'jefe', 5),
('Pamela', 'Veronica', 'Torres', 'Diaz', ROW(414,1416359), 'jefe', 6),
('Cayetano', 'Fulgencio', 'Marquez', 'Infante', ROW(424,9630352), 'jefe', 6),
('Jhoan', 'Dante', 'Lucero', 'Orona', ROW(424,6170815), 'jefe', 6),
('Elidio', 'Jonathan', 'Puentes', 'Ozuna', ROW(416,7058298), 'jefe', 7),
('Gloria', 'Eneida', 'Duque', 'Uribe', ROW(412,4224557), 'jefe', 7),
('Jennifer', 'Valentina', 'Vigil', 'Aviles', ROW(424,9270841), 'jefe', 7),
('Celeste', 'Soledad', 'Chacon', 'Machado', ROW(412,1229016), 'jefe', 8),
('Vivaldo', null, 'Rosas', 'Jackson', ROW(412,5018092), 'jefe', 8),
('Mirella', null, 'Machuca', 'Magallon', ROW(416,3371835), 'jefe', 8),
('Calixtrato', null, 'Quintanilla', 'Estrada', ROW(414,3049959), 'jefe', 9),
('Libertad', 'Eliana', 'Garces', 'Casanova', ROW(414,8123924), 'jefe', 9),
('Emperatriz', 'Myriam', 'Angulo', 'Valdivia', ROW(4148,999846), 'jefe', 9),
('Hugo', 'Adan', 'Serrato', 'Barrios', ROW(416,1450123), 'jefe', 10),
('Rosalia', 'Pilar', 'Valles', 'Montes', ROW(414,1292334), 'jefe', 10),
('Claudio', 'Lincoln', 'Sullivan', 'Tafoya', ROW(412,1948734), 'jefe', 10),
('Nicolas', 'Abelardo', 'Tafoya', 'Peralta', ROW(414,1277631), 'director_area', 1);



-- OFICINA_PRINCIPAL

INSERT INTO oficina_principal (nombre, sede, fk_director_area, fk_director_ejecutivo, fk_lugar_ciudad) VALUES

('Ofi. Dublin', false, 2, null, 10),
('Ofi. Amsterdam', false, 3, null, 13),
('Ofi. Nuuk', false, 4, null, 16),
('Ofi. Buenos Aires', false, 5, null, 19),
('Ofi. Taipei', false, 6, null, 22),
('Ofi. Kuala Lumpur', false, 7, null, 25),
('Ofi. Kampala', false, 8, null, 28),
('Ofi. Harare', false, 9, null, 31),
('Ofi. Sidney', false, 10, null, 34),
('Ofi. Ginebra', true, 38, 1, 38);



--ESTACION
INSERT INTO estacion (nombre, fk_oficina_principal, fk_empleado_jefe, fk_lugar_ciudad) VALUES
('Est. Dublin', 1, 11, 10),
('Est. Cork', 1, 12, 11),
('Est. Galway', 1, 13, 12),
('Est. Amsterdam', 2, 14, 13),
('Est. Roterdam', 2, 15, 14),
('Est. Haarlam', 2, 16, 15),
('Est. Nuuk', 3, 17, 16),
('Est. Qaqortoq', 3, 18, 17),
('Est. Sisimiut', 3, 19, 18),
('Est. Buenos Aires', 4, 20, 19),
('Est. Ciudad de Cordoba', 4, 21, 20),
('Est. Rosario', 4, 22, 21),
('Est. Taipei', 5, 23, 22),
('Est. Tainan', 5, 24, 23),
('Est. Kaohsiung', 5, 25, 24),
('Est. Kuala Lumpur', 6, 26, 25),
('Est. Malaca', 6, 27, 26),
('Est. Pulau Pinang', 6, 28, 27),
('Est. Kampala', 7, 29, 28),
('Est. Entebbe', 7, 30, 29),
('Est. Kasese', 7, 31, 30),
('Est. Harare', 8, 32, 31),
('Est. Bulawayo', 8, 33, 32),
('Est. Chitungwiza', 8, 34, 33),
('Est. Sidney', 9, 35, 34),
('Est. Perth', 9, 36, 35),
('Est. Gold Coast', 9, 37, 36);


--CUENTA
INSERT INTO cuenta (año, presupuesto, fk_estacion, fk_oficina_principal) VALUES
('2034/01/01',  10000, 1, 1),
('2035/01/01',  10500, 1, 1),
('2036/01/01',  11000, 1, 1),
('2034/01/01',  12000, 2, 1),
('2035/01/01',  13000, 2, 1),
('2036/01/01',  10000, 2, 1),
('2034/01/01',  10500, 3, 1),
('2035/01/01',  11000, 3, 1),
('2036/01/01',  11500, 3, 1),
('2034/01/01',  10000, 4, 2),
('2035/01/01',  10500, 4, 2),
('2036/01/01',  11000, 4, 2),
('2034/01/01',  10000, 5, 2),
('2035/01/01',  10500, 5, 2),
('2036/01/01',  11000, 5, 2),
('2034/01/01',  12000, 6, 2),
('2035/01/01',  13000, 6, 2),
('2036/01/01',  10000, 6, 2),
('2034/01/01',  10500, 7, 3),
('2035/01/01',  11000, 7, 3),
('2036/01/01',  11500, 7, 3),
('2034/01/01',  10000, 8, 3),
('2035/01/01',  10500, 8, 3),
('2036/01/01',  11000, 8, 3),
('2034/01/01',  10000, 9, 3),
('2035/01/01',  10500, 9, 3),
('2036/01/01',  11000, 9, 3),
('2034/01/01',  12000, 10, 4),
('2035/01/01',  13000, 10, 4),
('2036/01/01',  10000, 10, 4),
('2034/01/01',  10500, 11, 4),
('2035/01/01',  11000, 11, 4),
('2036/01/01',  11500, 11, 4),
('2034/01/01',  10000, 12, 4),
('2035/01/01',  10500, 12, 4),
('2036/01/01',  11000, 12, 4),
('2034/01/01',  10000, 13, 5),
('2035/01/01',  10500, 13, 5),
('2036/01/01',  11000, 13, 5),
('2034/01/01',  12000, 14, 5),
('2035/01/01',  13000, 14, 5),
('2036/01/01',  10000, 14, 5),
('2034/01/01',  10500, 15, 5),
('2035/01/01',  11000, 15, 5),
('2036/01/01',  11500, 15, 5),
('2034/01/01',  10000, 16, 6),
('2035/01/01',  10500, 16, 6),
('2036/01/01',  11000, 16, 6),
('2034/01/01',  10000, 17, 6),
('2035/01/01',  10500, 17, 6),
('2036/01/01',  11000, 17, 6),
('2034/01/01',  12000, 18, 6),
('2035/01/01',  13000, 18, 6),
('2036/01/01',  10000, 18, 6),
('2034/01/01',  10500, 19, 7),
('2035/01/01',  11000, 19, 7),
('2036/01/01',  11500, 19, 7),
('2034/01/01',  10000, 20, 7),
('2035/01/01',  10500, 20, 7),
('2036/01/01',  11000, 20, 7),
('2034/01/01',  10000, 21, 7),
('2035/01/01',  10500, 21, 7),
('2036/01/01',  11000, 21, 7),
('2034/01/01',  12000, 22, 8),
('2035/01/01',  13000, 22, 8),
('2036/01/01',  10000, 22, 8),
('2034/01/01',  10500, 23, 8),
('2035/01/01',  11000, 23, 8),
('2036/01/01',  11500, 23, 8),
('2034/01/01',  10000, 24, 8),
('2035/01/01',  10500, 24, 8),
('2036/01/01',  11000, 24, 8),
('2034/01/01',  10000, 25, 9),
('2035/01/01',  10500, 25, 9),
('2036/01/01',  11000, 25, 9),
('2034/01/01',  12000, 26, 9),
('2035/01/01',  13000, 26, 9),
('2036/01/01',  10000, 26, 9),
('2034/01/01',  10500, 27, 9),
('2035/01/01',  11000, 27, 9),
('2036/01/01',  11500, 27, 9);

----CLASIFICACIÓN_TEMA

INSERT INTO clas_tema(nombre, descripcion, topico) VALUES
('Armamento', 'El conjunto de armas de cualquier tipo, que esta a disposicion de grupos militares', 'paises'),
('Antecedente Penal', 'El registro oficial de las sanciones impuestas a una persona en virtud de sentencia firme', 'individuos'),
('Estrategia de Marketing', 'Proceso que puede ayudar a utilizar todos los recursos disponibles para incrementar las ventas', 'eventos'),
('Formulas Quimicas', 'Estas son las formulas secretas para crear los productos y tener un punto clave en la empresa', 'empresas'),
('Software', 'Conjuntos de programas en pleno desarrollo para la mejora de la empresa ', 'empresas'),
('Estrategia de Ventas', 'Los planes que puede llevar a cabo una empresa para vender sus productos o servicios con la intención de obtener un beneficio', 'paises'),
('Estrategia Salud', 'Son actuaciones sobre problemas de salud que requieren un abordaje integral, que tenga en cuenta todos los aspectos relacionados con la asistencia sanitaria', 'paises'),
('Estrategia Económica', 'Estrategia para impulsar la economia prosperidad y el desempeño del pais.', 'paises'),
('Politica Exterior', 'El conjunto de decisiones, politicas y acciones que confomar un pais, para poder representar los intereses nacionales de este', 'paises');



----CLIENTE
INSERT INTO cliente (nombre_empresa, pagina_web, exclusivo, telefonos, contactos, fk_lugar_pais) VALUES
('mexicaso', 'mexicaso.org.ve' ,true, ARRAY[CAST((58,4126909353) as telefono_ty), CAST((58,4165420879)as telefono_ty)],  ARRAY[ ROW('Eloisa', 'Petronila', 'Nolasco', 'White', '91 Sage Ave. Colorado Springs, CO 80911',  ROW(58,4121705701)), ROW('Nicolas', 'Abelardo', 'Tafoya', 'Peralta', '8370 Euclid Lane Harrisburg, PA 17109', ROW(58,4127728311))]::contacto_ty[], 4),
('exibera', 'exibera.com' ,true, ARRAY[CAST((58,4141416359) as telefono_ty), CAST((58,4124647938)as telefono_ty)],  ARRAY[ ROW('Cayetano', 'Paulo', 'Guillen', 'Miramontes', '260 Griffin Ave. Saint Joseph, MI 49085',  ROW(58,4147468253)), ROW('Aidana', 'Consuelo', 'Hidalgo', 'Rodrigues', '421A El Dorado St. Pittsburgh, PA 15206', ROW(58,4145897204))]::contacto_ty[], 1),
('ecuario', 'ecuario.org.ve' ,false, ARRAY[CAST((58,4249630352) as telefono_ty), CAST((58,4125063079)as telefono_ty)],  ARRAY[ ROW('Constantino', 'Adolfo', 'Bustos', 'Lima', '7630 Race Drive Chippewa Falls, WI 54729',  ROW(58,4148881705)), ROW('Juan', 'Gregorio', 'Madrid', 'Larios', '9248 S. Myers Dr. Barrington, IL 60010', ROW(58,4125199193))]::contacto_ty[], 2),
('wavian', 'wavian.com' ,false, ARRAY[CAST((58,4246170813) as telefono_ty), CAST((58,4243008369)as telefono_ty)],  ARRAY[ ROW('Antonio', 'Tulio', 'Pinto', 'Cordero', '67 Purple Finch St. Battle Ground, WA 98604',  ROW(58,4124534802)), ROW('Ivan', 'Vivaldo', 'Monge', 'Orozco', '8 Wood St. Lawndale, CA 90260', ROW(58,4147759286))]::contacto_ty[], 3),
('zuerteto', 'zuerteto.org.ve' ,true, ARRAY[CAST((58,4167058294) as telefono_ty), CAST((58,4164227118)as telefono_ty)],  ARRAY[ ROW('Dulcinea', 'Consuelo', 'Pizarro', 'Santiago', '2 Arnold Rd. Clementon, NJ 08021',  ROW(58,4149820142)), ROW('Andres', 'Caligula', 'Salguero', 'Cantu', '387 Corona Ave. Council Bluffs, IA 51501', ROW(58,4127896106))]::contacto_ty[], 5),
('namelix', 'namelix.com' ,true, ARRAY[CAST((58,4124224557) as telefono_ty), CAST((58,4149275489)as telefono_ty)],  ARRAY[ ROW('Marsello', 'Alan', 'Carpio', 'Thomas', '5 Summerhouse Dr. Winston Salem, NC 27103',  ROW(58,4167928205)), ROW('Mia', 'Caridad', 'Avalos', 'Castaneda', '7014 Beacon Road Stratford, CT 06614', ROW(58,416559594))]::contacto_ty[], 6),
('maxure', 'maxure.org.ve' ,false, ARRAY[CAST((58,4249270841) as telefono_ty), CAST((58,4161697839)as telefono_ty)],  ARRAY[ ROW('Antonio', 'Diego', 'Recinos', 'Santacruz', '14 Pulaski Street Dalton, GA 30721',  ROW(58,4125874357)), ROW('Camilo', 'Breno', 'Larios', 'Irizarry', '250 East Brewery Ave. Hattiesburg, MS 39401', ROW(58,4167713892))]::contacto_ty[], 7),
('critine', 'critine.com' ,false, ARRAY[CAST((58,4121948734) as telefono_ty), CAST((58,4142669811)as telefono_ty)],  ARRAY[ ROW('Greta', 'Rosaura', 'Valdivia', 'Cruz', '7044C Bellevue Avenue Sylvania, OH 43560',  ROW(58,4128117935)), ROW('Foster', 'Hercules', 'Palma', 'Palomino', '405 Division St. Long Beach, NY 11561', ROW(58,4142206919))]::contacto_ty[], 8),
('strise', 'strise.org.ve' ,true, ARRAY[CAST((58,4128375628) as telefono_ty), CAST((58,4129566333)as telefono_ty)],  ARRAY[ ROW('Marcela', 'Amelia', 'Galdamez', 'Rogers', '8561 Woodsman St. Soddy Daisy, TN 37379',  ROW(58,4125871125)), ROW('Ophelia', 'Genesis', 'Roman', 'Reza', '8680 Vermont Avenue Fayetteville, NC 28303', ROW(58,4129331604))]::contacto_ty[], 9),
('finess', 'finess.com' ,true, ARRAY[CAST((58,4145172324) as telefono_ty), CAST((58,4148423998)as telefono_ty)],  ARRAY[ ROW('Pamela', 'Veronica', 'Torres', 'Diaz', '7003 North Pin Oak Drive Southfield, MI 48076',  ROW(58,4167261669)), ROW('Gladys', 'Guadalupe', 'Nelson', 'Collazo', '6 Nichols St. Sidney, OH 45365', ROW(58,412210943))]::contacto_ty[], 1),
('spirate', 'spirate.org.ve' ,false, ARRAY[CAST((58,4143941547) as telefono_ty), CAST((58,4148656594)as telefono_ty)],  ARRAY[ ROW('Cayetano', 'Fulgencio', 'Marquez', 'Infante', '8864 West Grant Ave. Gastonia, NC 28052',  ROW(58,4123559954)), ROW('Dulce', 'Aleyda', 'Jacobo', 'Farias', '9630 Sage Avenue Virginia Beach, VA 23451', ROW(58,4142338258))]::contacto_ty[], 2),
('tratone', 'tratone.com' ,false, ARRAY[CAST((58,4127166191) as telefono_ty), CAST((58,4167339412)as telefono_ty)],  ARRAY[ ROW('Jhoan', 'Dante', 'Lucero', 'Orona', '1 Tunnel Dr. Havertown, PA 19083',  ROW(58,4124168039)), ROW('Ramon', 'Cesar', 'Soliz', 'Alvarenga', '9700 Fremont Street Oak Lawn, IL 60453', ROW(58,4166551066))]::contacto_ty[], 3),
('restra', 'restra.org.ve' ,true, ARRAY[CAST((58,4128656384) as telefono_ty), CAST((58,4141393239)as telefono_ty)],  ARRAY[ ROW('Elidio', 'Jonathan', 'Puentes', 'Ozuna', '87 Aspen Street Seattle, WA 98144',  ROW(58,4167372066)), ROW('Margarito', 'Leopoldo', 'Araujo', 'Villarreal', '722 Young Ave. Green Bay, WI 54302', ROW(58,4247562597))]::contacto_ty[], 4),
('stedwork', 'stedwork.com' ,true, ARRAY[CAST((58,4144533212) as telefono_ty), CAST((58,4167169159)as telefono_ty)],  ARRAY[ ROW('Gloria', 'Eneida', 'Duque', 'Uribe', '77 East Saxton Circle Royal Oak, MI 48067',  ROW(58,4166612681)), ROW('Vitalicio', 'Calixtrato', 'Medina', 'Sanabria', '226 Dogwood Ave. Loxahatchee, FL 33470', ROW(58,4241393767))]::contacto_ty[], 5),
('rampact', 'rampact.org.ve' ,false, ARRAY[CAST((58,4162219883) as telefono_ty), CAST((58,4149417666)as telefono_ty)],  ARRAY[ ROW('Jennifer', 'Valentina', 'Vigil', 'Aviles', '947 Harvey Rd. Erlanger, KY 41018',  ROW(58,4248900652)), ROW('Elba', 'Amparo', 'Bejarano', 'Barboza', '37 Foster Avenue Powhatan, VA 23139', ROW(58,4129348253))]::contacto_ty[], 6),
('disconse', 'disconse.com' ,false, ARRAY[CAST((58,4141415929) as telefono_ty), CAST((58,4122793317)as telefono_ty)],  ARRAY[ ROW('Claudio', 'Lincoln', 'Sullivan', 'Tafoya', '936 Amerige Ave. Manchester, NH 03102',  ROW(58,4148438619)), ROW('Damaris', 'Corania', 'Benavides', 'Cook', '339 Devon Dr. Old Bridge, NJ 08857', ROW(58,4242480061))]::contacto_ty[], 7),
('restricp', 'restricp.org.ve' ,true, ARRAY[CAST((58,4242584943) as telefono_ty), CAST((58,4244832665)as telefono_ty)],  ARRAY[ ROW('Fabian', 'Melchor', 'Deltoro', 'Lucero', '8963 Buckingham Street Roslindale, MA 02131',  ROW(58,4243181758)), ROW('Victor', 'Leon', 'Sorto', 'Velasquez', '67 Inverness Ave. East Stroudsburg, PA 18301', ROW(58,4167211111))]::contacto_ty[], 8),
('devflair', 'devflair.com' ,true, ARRAY[CAST((58,4167026825) as telefono_ty), CAST((58,4166388369)as telefono_ty)],  ARRAY[ ROW('Daniela', 'Aidana', 'Avelar', 'Recinos', '23 Monroe St. Maryville, TN 37803',  ROW(58,4167709376)), ROW('Silvio', 'Maximiliano', 'Granados', 'Cordova', '9 South Hilltop Road Bethel Park, PA 15102', ROW(58,4166783921))]::contacto_ty[], 9),
('inconce', 'inconce.org.ve' ,false, ARRAY[CAST((58,4247453786) as telefono_ty), CAST((58,4143307715)as telefono_ty)],  ARRAY[ ROW('Pilar', 'Inocencia', 'Antonio', 'Cepeda', '9241 Blackburn St. Oak Creek, WI 53154',  ROW(58,4243443197)), ROW('Ayala', 'Adria', 'Arriaga', 'Cota', '114 Lookout Court Egg Harbor Township, NJ 08234', ROW(58,4144959888))]::contacto_ty[], 4),
('sloquest', 'sloquest.com' ,false, ARRAY[CAST((58,4162833863) as telefono_ty), CAST((58,4144556851)as telefono_ty)],  ARRAY[ ROW('Flor', 'Esperanza', 'Peterson', 'Sarmiento', '49 W. Lees Creek Ave. Pickerington, OH 43147',  ROW(58,4165511783)), ROW('Perla', 'Gloria', 'Lima', 'Valentin', '78 Clay St. Uniondale, NY 11553', ROW(58,4124743278))]::contacto_ty[], 6);






-- personal_inteligencia
INSERT INTO personal_inteligencia (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, altura_cm, peso_kg, color_ojos, vision, class_seguridad, fotografia, huella_retina, huella_digital, telefono, licencia_manejo, idiomas, familiares, identificaciones, nivel_educativo, aliases, fk_lugar_ciudad) VALUES
('Florentina','Mariluz','Landa','Heredia','1993-03-05',189,66,'verde claro','20/25','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4145866510) ,ROW('75518194','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Araceli',null,'Alcantara','Candelaria','1960-06-01','tío',ROW(58,4145335249) ), ROW('Calixtrato','Vicente','Quintanilla','Estrada','1960-06-01','hermano',ROW(58,4142583859) )]::familiar_ty[], ARRAY[ ROW('31656053','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Economía','Máster','Finanzas')]::nivel_educativo_ty[],null,'10'),
('Constancia',null,'Oviedo','Aguilera','2000-10-30',181,79,'marrón oscuro','20/63','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2129022789) ,ROW('97109426','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cecilio',null,'Maravilla','Soria','1950-05-20','hermano',ROW(58,2345984196) ), ROW('Ramon','Cesar','Soliz','Alvarenga','1950-05-20','madre',ROW(58,2341591625) )]::familiar_ty[], ARRAY[ ROW('73480307','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Enfermería','null','null') ]::nivel_educativo_ty[],null,'10'),
('Libertad','Virginia','Casas','Cornejo','1998-11-21',160,79,'verde oscuro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4143613707) ,ROW('96567423','Irlanda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Jesus','Juliano','Gallegos','Curiel','1949-10-23','padre',ROW(58,2129442380) ), ROW('Fabian','Benjamin','Jara','Arguello','1949-10-23','hermano',ROW(58,2127035299) )]::familiar_ty[], ARRAY[ ROW('89872007','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'10'),
('Teodora','Abigail','Nolasco','Armendariz','1997-12-15',159,81,'azul claro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2819188487) ,ROW('34181131','Uganda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Fermin',null,'Figueroa','Cordova','1973-11-14','madre',ROW(58,2817690358) ), ROW('Hugo',null,'Serrato','Barrios','1973-11-14','abuelo',ROW(58,2811839796) )]::familiar_ty[], ARRAY[ ROW('34656827','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'10'),
('Valentin','Kevin','Machuca','Tello','1993-08-25',152,70,'verde oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4121120302) ,ROW('83939097','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Bibiana',null,'Monge','Ruano','1962-10-16','padre',ROW(58,4121292914) ), ROW('Brandon','Constantino','Razo','Casillas','1962-10-16','abuelo',ROW(58,4126797513) )]::familiar_ty[], ARRAY[ ROW('85007606','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','Máster','Ingeniería de Datos Masivos')]::nivel_educativo_ty[],null,'11'),
('Cesarino',null,'Zuniga','Anderson','1983-09-15',153,87,'verde claro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4246887111) ,ROW('92394600','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('William',null,'Tellez','Cedillo','1953-04-17','abuelo',ROW(58,2618046167) ), ROW('Margarito','Leopoldo','Araujo','Villarreal','1953-04-17','hermano',ROW(58,2618879740) )]::familiar_ty[], ARRAY[ ROW('10298770','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Ciencias Sociales ','null','null') ]::nivel_educativo_ty[],null,'11'),
('Bruno','Magnus','Quiroga','Ornelas','1998-12-03',172,94,'azul oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4128853127) ,ROW('92063010','Irlanda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cecilio','Owen','Alexander','Adams','1950-10-03','madre',ROW(58,4126782925) ), ROW('Juan','Felix','Najera','Echevarria','1950-10-03','abuelo',ROW(58,4128488674) )]::familiar_ty[], ARRAY[ ROW('73772983','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'11'),
('Jane','Amanda','Tenorio','Roberts','1999-09-14',180,69,'azul claro','20/20','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2348900127) ,ROW('17637177','Uganda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Felicio',null,'Meneses','Ward','1975-10-18','hermano',ROW(58,2345115466) ), ROW('Luis',null,'Oliva','Arias','1975-10-18','primo',ROW(58,2345387649) )]::familiar_ty[], ARRAY[ ROW('90044381','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null')]::nivel_educativo_ty[],null,'11'),
('Bienvenido','Vivaldo','Martines','Luis','1994-05-26',184,79,'azul oscuro','20/20','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2127226245) ,ROW('23562931','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Gracia',null,'Sanchez','Simon','1963-06-08','madre',ROW(58,2125614539) ), ROW('Anthony','Amilcar','Tafoya','Buenrostro','1963-06-08','primo',ROW(58,2129456655) )]::familiar_ty[], ARRAY[ ROW('82240519','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Comunicación','Máster','Comunicación Corporativa')]::nivel_educativo_ty[],null,'12'),
('Valerio','Adan','Bahena','Deltoro','1984-05-22',175,68,'verde oscuro','20/40','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2876127251) ,ROW('14201050','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Luisa',null,'Menjivar','Velasquez','1955-08-29','primo',ROW(58,2444138606) ), ROW('Vitalicio','Calixtrato','Medina','Sanabria','1955-08-29','hermano',ROW(58,2443544775) )]::familiar_ty[], ARRAY[ ROW('34067073','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Economía','null','null') ]::nivel_educativo_ty[],null,'12'),
('Margarito','Juvenal','Nevarez','Galarza','2000-03-09',172,74,'azul claro','20/16','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2122399063) ,ROW('90384414','Irlanda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Consolacion','Maximina','Maciel','Robledo','1953-11-30','hermano',ROW(58,2121432805) ), ROW('Tito','Julian','Vallejo','Pinon','1953-11-30','primo',ROW(58,2123516189) )]::familiar_ty[], ARRAY[ ROW('66986530','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Enfermería','null','null') ]::nivel_educativo_ty[],null,'12'),
('Feliciano','Cristian','Guzman','Roman','1999-09-20',151,81,'marrón claro','20/16','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2615875263) ,ROW('82241949','Uganda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Irma',null,'Barahona','Maldonado','1976-03-18','hermano',ROW(58,2616835607) ), ROW('Klement',null,'Montiel','Salguero','1976-03-18','hermano',ROW(58,2616167116) )]::familiar_ty[], ARRAY[ ROW('53953897','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'12'),
('Santiago','Andres','Izaguirre','Giron','1992-05-02',168,76,'verde oscuro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4123525045) ,ROW('45386610','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Pablo','Emiliano','Santana','Almeida','1956-04-21','hermano',ROW(58,4121690963) ), ROW('Greta',null,'Valdivia','Cruz','1956-04-21','hermano',ROW(58,4124128200) )]::familiar_ty[], ARRAY[ ROW('21689880','Holanda'),row('44522900','Zimbabue') ]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Ingeniería Industrial','Máster','Dirección de Empresas') ]::nivel_educativo_ty[],null,'13'),
('Elidio','Pablo','Carreno','Villarreal','1996-11-17',167,80,'verde oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4243130690) ,ROW('20350915','Groenlandia'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Jorge','Silvester','Rodrigues','Baez','1959-10-09','primo',ROW(58,2817063392) ), ROW('Lincoln',null,'Alvarenga','Elizondo','1959-10-09','hermano',ROW(58,2819767615) )]::familiar_ty[], ARRAY[ ROW('72450226','Holanda')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null')]::nivel_educativo_ty[],null,'13'),
('Regulo','Pastor','Coria','Valverde','1996-11-15',166,76,'verde claro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4248476748) ,ROW('61525397','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Marco',null,'Armijo','Jimenez','1970-12-22','primo',ROW(58,4246536171) ), ROW('Emperatriz',null,'Angulo','Valdivia','1970-12-22','hermano',ROW(58,4246894005) )]::familiar_ty[], ARRAY[ ROW('79323151','Holanda')]::identificacion_ty[], ARRAY[ ROW('Psicología','Máster','Inteligencia Emocional')]::nivel_educativo_ty[],null,'13'),
('Atenea','Mariana','Escalante','Garay','1998-11-20',168,83,'marrón claro','20/160','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2345434526) ,ROW('54275139','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Camilo','Margarito','Aguayo','Giraldo','1976-03-16','abuelo',ROW(58,2435397521) ), ROW('Fabian','Melchor','Deltoro','Lucero','1976-03-16','primo',ROW(58,2439905049) )]::familiar_ty[], ARRAY[ ROW('63868170','Holanda'),row('99264338','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Comunicación','Máster','Comunicación Corporativa') ]::nivel_educativo_ty[],null,'13'),
('Silvio','Fidel','Avelar','Mojica','1992-05-29',157,94,'azul oscuro','20/16','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2125394572) ,ROW('97347032','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Julian','Cornelio','Ceja','Castro','1957-07-10','abuelo',ROW(58,2123045079) ), ROW('Marcela',null,'Galdamez','Rogers','1957-07-10','abuelo',ROW(58,2123074046) )]::familiar_ty[], ARRAY[ ROW('68391991','Holanda'),row('20282221','Zimbabue') ]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Derecho','Máster','Abogacía') ]::nivel_educativo_ty[],null,'14'),
('Cristian','Feliciano','Montero','Arango','1999-09-22',154,89,'azul oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2874198040) ,ROW('68367092','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Constantino','Ciceron','Perez','Manriquez','1960-08-31','tío',ROW(58,2341751544) ), ROW('Alba',null,'Arriola','Duenas','1960-08-31','hermano',ROW(58,2342392342) )]::familiar_ty[], ARRAY[ ROW('70300861','Holanda')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null')]::nivel_educativo_ty[],null,'14'),
('Ives','Victor','Valerio','Alejo','1997-08-10',163,71,'verde oscuro','20/40','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2872490402) ,ROW('53615903','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cesarino',null,'Delrio','Caldera','1971-06-23','tío',ROW(58,2877296617) ), ROW('Vilma',null,'Monreal','Toscano','1971-06-23','hermano',ROW(58,2877719078) )]::familiar_ty[], ARRAY[ ROW('47860793','Holanda')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null')]::nivel_educativo_ty[],null,'14'),
('Poncio',null,'Parker','Palafox','1998-12-02',180,72,'marrón claro','20/200','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4125384784) ,ROW('75223071','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Peregrino','William','Reyes','Ruiz','1977-04-02','primo',ROW(58,2812734537) ), ROW('Daniela','Aidana','Avelar','Recinos','1977-04-02','hermano',ROW(58,2813105315) )]::familiar_ty[], ARRAY[ ROW('46357458','Holanda'),row('44481119','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Ciencias Sociales ','Máster','Acción Internacional Humanitaria') ]::nivel_educativo_ty[],null,'14'),
('Breno','Marcial','Acuna','Lewis','1993-05-13',166,79,'azul claro','20/160','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4249642333) ,ROW('91677759','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Sabina','Perla','Guevara','Morris','1959-09-04','abuelo',ROW(58,4248429139) ), ROW('Pamela','Veronica','Torres','Diaz','1959-09-04','abuelo',ROW(58,4247610538) )]::familiar_ty[], ARRAY[ ROW('51910927','Holanda'),row('47471546','Australia') ]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Ingeniería Informática','Máster','Ciberseguridad') ]::nivel_educativo_ty[],null,'15'),
('Eneida','Matilde','Velasco','Estevez','2000-04-20',181,82,'azul claro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2433043182) ,ROW('18249635','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Miranda','Maximina','Alonso','Zamora','1961-03-27','padre',ROW(58,2614456079) ), ROW('Pilar',null,'Alvarado','Contreras','1961-03-27','abuelo',ROW(58,2611171690) )]::familiar_ty[], ARRAY[ ROW('68101834','Holanda')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null')]::nivel_educativo_ty[],null,'15'),
('Jayden','Emilio','Amezcua','Maya','1997-10-10',184,78,'azul oscuro','20/32','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2438683153) ,ROW('27461011','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Luciana',null,'Garibay','Contreras','1973-05-18','padre',ROW(58,2436662586) ), ROW('Luna',null,'Castrejon','Narvaez','1973-05-18','abuelo',ROW(58,2438871140) )]::familiar_ty[], ARRAY[ ROW('22626609','Holanda')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'15'),
('Alba',null,'Cortez','Alegria','2000-03-08',151,76,'marrón oscuro','20/160','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2123276384) ,ROW('56132642','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Georgina','Julia','Lazaro','Perales','1979-02-20','primo',ROW(58,2341639383) ), ROW('Pilar','Inocencia','Antonio','Cepeda','1979-02-20','hermano',ROW(58,2345663933) )]::familiar_ty[], ARRAY[ ROW('59542288','Holanda')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Derecho','Máster','Asesoría Fiscal') ]::nivel_educativo_ty[],null,'15'),
('Kevin','Matias','Edwards','Peterson','1984-12-23',180,69,'azul oscuro','20/32','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2438709942) ,ROW('46605807','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Bertrudis','Lorena','Valerio','Serna','1960-06-20','primo',ROW(58,4144917521) ), ROW('Elba','Amparo','Bejarano','Barboza','1960-06-20','abuelo',ROW(58,4141031653) )]::familiar_ty[], ARRAY[ ROW('16796400','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Economía','null','null') ]::nivel_educativo_ty[],null,'16'),
('Alana','Erika','Nevarez','Deanda','1988-02-06',186,73,'verde claro','20/100','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2875377144) ,ROW('42190247','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Ignacio','Ulises','Cartagena','Roman','1944-01-18','madre',ROW(58,2877271523) ), ROW('Vivaldo','Tarsicio','Rosas','Jackson','1944-01-18','abuelo',ROW(58,2871548914) )]::familiar_ty[], ARRAY[ ROW('93148961','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Derecho','Máster','Abogacía')]::nivel_educativo_ty[],null,'16'),
('Eladio','Silvestre','Arteaga','Camarena','1998-03-19',171,76,'verde oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2872836156) ,ROW('71948361','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Anastasia','Melina','Pelayo','Veliz','1967-09-23','madre',ROW(58,2122945886) ), ROW('Gloria','Eneida','Duque','Uribe','1967-09-23','hermano',ROW(58,2129372640) )]::familiar_ty[], ARRAY[ ROW('10774911','Groenlandia'),row('64999971','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Economía','Máster','Auditoria Financiera y Riegos') ]::nivel_educativo_ty[],null,'16'),
('Sabina','Ada','Johnson','Caballero','1992-05-03',185,66,'marrón oscuro','20/12.5','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4129451264) ,ROW('79967621','Uganda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Patricia','Victoria','Munguia','Garcia','1978-09-06','tío',ROW(58,2816108763) ), ROW('Pablo','Orosio','Avendano','Marroquin','1978-09-06','hermano',ROW(58,2814749236) )]::familiar_ty[], ARRAY[ ROW('85559692','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Ingeniería Industrial','null','null') ]::nivel_educativo_ty[],null,'16'),
('Soledad','Esmeralda','Moreno','Sullivan','1986-05-03',163,83,'azul claro','20/25','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2811159875) ,ROW('34000680','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Eliana','Dulcinea','Ocampo','Mitchell','1961-09-09','tío',ROW(58,4125762280) ), ROW('Damaris','Corania','Benavides','Cook','1961-09-09','abuelo',ROW(58,4121731002) )]::familiar_ty[], ARRAY[ ROW('56081849','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'17'),
('Judas','Faustiniano','Cerda','Villa','1988-05-07',168,70,'verde oscuro','20/80','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2433381870) ,ROW('17005825','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Orosio','Javier','Delao','Delao','1945-05-04','hermano',ROW(58,2437162307) ), ROW('Gracia','Berenice','Bocanegra','Rizo','1945-05-04','primo',ROW(58,2436035571) )]::familiar_ty[], ARRAY[ ROW('15538458','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','Máster','Ciberseguridad')]::nivel_educativo_ty[],null,'17'),
('Mariam','Mireya','Orellana','Manzano','1998-04-22',151,66,'azul oscuro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2435220229) ,ROW('44028931','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Marisol','Trinidad','Escobedo','Pinon','1970-08-26','hermano',ROW(58,4241178425) ), ROW('Jennifer','Valentina','Vigil','Aviles','1970-08-26','abuelo',ROW(58,4247437539) )]::familiar_ty[], ARRAY[ ROW('16874541','Groenlandia'),row('67012147','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Economía','Máster','Finanzas') ]::nivel_educativo_ty[],null,'17'),
('Jorge','Rafael','Ocampo','Landeros','1992-05-30',153,83,'verde claro','20/10','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2121559430) ,ROW('23277313','Uganda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Pilar','Nathaly','Olmos','Melo','1979-12-29','padre',ROW(58,2346982594) ), ROW('Andres','Orosio','Pichardo','Castanon','1979-12-29','hermano',ROW(58,2346895289) )]::familiar_ty[], ARRAY[ ROW('56423791','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Ciencias Sociales ','null','null') ]::nivel_educativo_ty[],null,'17'),
('Fiona','Adriana','Soriano','Pedraza','1988-12-02',179,91,'marrón claro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2342055319) ,ROW('70044430','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Pedro','Dante','Paez','Ramos','1963-10-06','padre',ROW(58,2123596460) ), ROW('Victor','Leon','Sorto','Velasquez','1963-10-06','primo',ROW(58,2125812506) )]::familiar_ty[], ARRAY[ ROW('15808057','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'18'),
('Inocencia','Adria','Maldonado','Mojica','1988-06-13',150,87,'azul oscuro','20/63','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2819888112) ,ROW('32723958','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Emily','Mireya','Tellez','Cabrera','1945-06-24','hermano',ROW(58,2812159587) ), ROW('Esperanza','Ana','Corona','Granados','1945-06-24','tío',ROW(58,2817969996) )]::familiar_ty[], ARRAY[ ROW('77420775','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Comunicación','Máster','Lexicografía')]::nivel_educativo_ty[],null,'18'),
('Thais','Cloe','Kelly','Santacruz','1998-06-26',154,82,'azul claro','20/40','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2816967861) ,ROW('17999862','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Mario','David','Barrientos','Montesdeoca','1975-06-22','hermano',ROW(58,2873876073) ), ROW('Claudio','Lincoln','Sullivan','Tafoya','1975-06-22','abuelo',ROW(58,2873839920) )]::familiar_ty[], ARRAY[ ROW('92497828','Groenlandia'),row('97310413','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ingeniería Informática','Máster','Ingeniería de Datos Masivos') ]::nivel_educativo_ty[],null,'18'),
('William','Lorenzo','Miranda','Rueda','1993-05-14',157,82,'verde oscuro','20/125','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4246304410) ,ROW('34655510','Uganda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Maria','Belinda','Angeles','Paniagua','1980-08-09','madre',ROW(58,2614175980) ), ROW('Leonardo','Klement','Bedolla','Bocanegra','1980-08-09','abuelo',ROW(58,2612580133) )]::familiar_ty[], ARRAY[ ROW('29689116','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'18'),
('Bernarda','Anunciacion','Preciado','Botello','2000-05-20',188,70,'marrón claro','20/40','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2817721032) ,ROW('49074622','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Romeo','Adrian','Damian','Vallejo','1962-06-17','madre',ROW(58,2447307869) ), ROW('Marina',null,'Elizondo','Nunez','1962-06-17','abuelo',ROW(58,2446714836) )]::familiar_ty[], ARRAY[ ROW('97452380','Argentina')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null')]::nivel_educativo_ty[],null,'19'),
('Bertrudis','Damaris','Mandujano','Sosa','1989-01-03',151,93,'azul oscuro','20/80','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2431175947) ,ROW('76461038','Holanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Alma','Moira','Moreno','Batista','1944-06-08','primo',ROW(58,2435756755) ), ROW('Cayetano',null,'Guillen','Miramontes','1944-06-08','abuelo',ROW(58,2434965894) )]::familiar_ty[], ARRAY[ ROW('95091182','Argentina'),row('16926723','Groenlandia') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null')]::nivel_educativo_ty[],null,'19'),
('Melina','Bonita','Cardenas','Hill','1990-08-29',164,71,'azul oscuro','20/25','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4121570489) ,ROW('84072515','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Jessica','Brenda','Garcia','Anguiano','1970-11-02','abuelo',ROW(58,4249360234) ), ROW('Ayala','Haydee','Sauceda','Mares','1970-11-02','abuelo',ROW(58,4244759443) )]::familiar_ty[], ARRAY[ ROW('22294936','Argentina')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Psicología','null','null') ]::nivel_educativo_ty[],null,'19'),
('Tito',null,'Serna','Suarez','1989-12-18',173,71,'verde claro','20/40','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2618135658) ,ROW('88656236','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Carla',null,'Larios','Mazariegos','1980-12-04','hermano',ROW(58,2434584531) ), ROW('Natividad','Fabiola','Samaniego','Castellanos','1980-12-04','hermano',ROW(58,2433593713) )]::familiar_ty[], ARRAY[ ROW('91620847','Argentina')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null')]::nivel_educativo_ty[],null,'19'),
('Emperatriz',null,'Farias','Rincon','2000-08-11',174,75,'marrón claro','20/160','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2343226301) ,ROW('30050667','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Amanda','Viviana','Delrio','Solorzano','1963-02-19','hermano',ROW(58,4144552274) ), ROW('Justiniano','Foster','Olivares','Ellis','1963-02-19','primo',ROW(58,4143866668) )]::familiar_ty[], ARRAY[ ROW('62925370','Argentina')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null')]::nivel_educativo_ty[],null,'20'),
('Faustino','Margarito','Quinones','Mena','1989-12-16',161,87,'azul claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2818687845) ,ROW('86083433','Holanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Emiliana','Constanza','Renteria','Almaguer','1944-12-12','primo',ROW(58,2813553082) ), ROW('Constantino',null,'Bustos','Lima','1944-12-12','primo',ROW(58,2819638370) )]::familiar_ty[], ARRAY[ ROW('31880045','Argentina'),row('97834556','Groenlandia') ]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null')]::nivel_educativo_ty[],null,'20'),
('Facunda','Alvara','Prado','Sarmiento','1991-01-29',153,72,'azul claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2128815730) ,ROW('56155975','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Constantino','Leon','Marte','Recinos','1973-02-13','abuelo',ROW(58,2871278225) ), ROW('Salvador','Eleazar','Madrid','Moore','1973-02-13','abuelo',ROW(58,2873542917) )]::familiar_ty[], ARRAY[ ROW('58856164','Argentina')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Psicología','null','null') ]::nivel_educativo_ty[],null,'20'),
('Dulcinea',null,'Angeles','Ordonez','1990-02-07',178,90,'verde oscuro','20/32','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2444461580) ,ROW('76990356','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Camila',null,'Garibay','Valle','1936-09-25','hermano',ROW(58,2818191517) ), ROW('Rosa','Mariana','Quiroz','Escobedo','1936-09-25','abuelo',ROW(58,2813112354) )]::familiar_ty[], ARRAY[ ROW('21082874','Argentina')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null')]::nivel_educativo_ty[],null,'20'),
('Michael',null,'Moreno','Acuna','2000-10-19',177,74,'marrón oscuro','20/200','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4129161124) ,ROW('10985338','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Maximiliano','Pastor','Candelaria','Oropeza','1966-10-10','hermano',ROW(58,4122331801) ), ROW('Alba','Celia','Salcedo','Machado','1966-10-10','madre',ROW(58,4128452043) )]::familiar_ty[], ARRAY[ ROW('78826748','Argentina')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null')]::nivel_educativo_ty[],null,'21'),
('Marcos','Alfredo','Solorio','Roldan','1990-02-05',168,86,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2346723703) ,ROW('61606618','Holanda'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Fernanda','Amelia','Ruano','Quintanilla','1946-12-07','tío',ROW(58,2346783122) ), ROW('Antonio',null,'Pinto','Cordero','1946-12-07','tío',ROW(58,2342921290) )]::familiar_ty[], ARRAY[ ROW('39940174','Argentina'),row('93675431','Groenlandia') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null')]::nivel_educativo_ty[],null,'21'),
('Matias','Orosio','Segura','Alvarenga','1991-05-26',171,69,'marrón claro','20/16','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4248510703) ,ROW('59370849','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Valentin','Fermin','Burgos','Caraballo','1976-01-07','primo',ROW(58,2437433265) ), ROW('Lucrecia','Margarita','Alonzo','Saenz','1976-01-07','primo',ROW(58,2431228910) )]::familiar_ty[], ARRAY[ ROW('86486594','Argentina')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'21'),
('Amara',null,'Saldana','Delao','1990-08-30',159,75,'azul oscuro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4145733047) ,ROW('59643306','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Jorge',null,'James','Lopez','1937-04-10','abuelo',ROW(58,2349484976) ), ROW('Myriam','Zoe','Serrano','Ochoa','1937-04-10','abuelo',ROW(58,2347321093) )]::familiar_ty[], ARRAY[ ROW('93951813','Argentina')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null')]::nivel_educativo_ty[],null,'21'),
('Nikita','Victoria','Sanabria','Monreal','2000-10-29',181,86,'azul oscuro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2123944612) ,ROW('17901622','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Poncio',null,'Alcala','Falcon','1981-02-02','tío',ROW(58,2126204462) ), ROW('Silvester',null,'Morris','Serrato','1981-02-02','primo',ROW(58,2124364221) )]::familiar_ty[], ARRAY[ ROW('62132851','Taiwán'),row('64962613','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'22'),
('Benigno',null,'Lozano','Garay','2000-04-30',159,79,'azul claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2122163297) ,ROW('45787069','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Julian',null,'Quezada','Badillo','1948-11-18','padre',ROW(58,2874376083) ), ROW('Ophelia','Genesis','Roman','Reza','1948-11-18','primo',ROW(58,2878862181) )]::familiar_ty[], ARRAY[ ROW('75801459','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'22'),
('Jonathan',null,'Caballero','Hidalgo','1986-05-04',166,68,'azul claro','20/80','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2439974589) ,ROW('43586737','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Vicente','Juliano','Bello','Osuna','1978-12-06','tío',ROW(58,2128406187) ), ROW('Ophelia','Isabella','Pabon','Zambrano','1978-12-06','abuelo',ROW(58,2125727947) )]::familiar_ty[], ARRAY[ ROW('15103034','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null')]::nivel_educativo_ty[],null,'22'),
('Jiovani','Julian','Villeda','Barahona','2000-04-29',188,75,'marrón oscuro','20/12.5','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2444886584) ,ROW('33371745','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Amada',null,'Rendon','Ochoa','1976-07-16','abuelo',ROW(58,2447538370) ), ROW('Rosalia',null,'Valles','Montes','1976-07-16','hermano',ROW(58,2447297009) )]::familiar_ty[], ARRAY[ ROW('12556461','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'22'),
('Yves','Cornelio','Avina','Camarena','1983-09-14',162,83,'azul claro','20/16','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4247327815) ,ROW('43798096','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Sebastian',null,'Cabral','Cedillo','1936-02-14','padre',ROW(58,4242563853) ), ROW('Magali',null,'Salmeron','Izquierdo','1936-02-14','tío',ROW(58,4244391590) )]::familiar_ty[], ARRAY[ ROW('57015909','Taiwán'),row('33501965','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null')]::nivel_educativo_ty[],null,'23'),
('Isabel',null,'Rueda','Carmona','2000-05-30',156,92,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4249862179) ,ROW('65512579','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cornelio',null,'Ceja','Jaimes','1949-10-09','madre',ROW(58,2438644298) ), ROW('Gladys','Guadalupe','Nelson','Collazo','1949-10-09','tío',ROW(58,2438176910) )]::familiar_ty[], ARRAY[ ROW('19988380','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'23'),
('Adria',null,'Hermosillo','Barboza','1988-12-03',184,72,'marrón claro','20/63','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2814972399) ,ROW('65842138','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Marco','Maximiliano','Valadez','Thompson','1979-04-04','padre',ROW(58,4241620132) ), ROW('Paciano','Jose','Lima','Beltran','1979-04-04','primo',ROW(58,4242674984) )]::familiar_ty[], ARRAY[ ROW('61913792','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null')]::nivel_educativo_ty[],null,'23'),
('Brenda','Fabia','Baltazar','Antonio','2000-05-31',161,73,'verde claro','20/32','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4141015396) ,ROW('76028943','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Naomi',null,'Powell','Butler','1979-05-22','abuelo',ROW(58,4143703820) ), ROW('Griselda',null,'Pedraza','Lozano','1979-05-22','abuelo',ROW(58,4144178311) )]::familiar_ty[], ARRAY[ ROW('66992678','Taiwán'),row('10755026','Australia') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null')]::nivel_educativo_ty[],null,'23'),
('Adria','Cloe','Armijo','Hall','1984-05-21',177,71,'marrón claro','20/12.5','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4126259620) ,ROW('40577438','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Marlene',null,'Maravilla','Merino','1938-07-26','madre',ROW(58,4125113606) ), ROW('Emiliana',null,'Mariscal','Lora','1938-07-26','padre',ROW(58,4123090152) )]::familiar_ty[], ARRAY[ ROW('86577438','Taiwán'),row('82197561','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null')]::nivel_educativo_ty[],null,'24'),
('Sharon',null,'Beltran','Gallardo','2000-08-10',189,72,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4125991055) ,ROW('54872264','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Liliana',null,'Cavazos','Coronado','1949-10-16','hermano',ROW(58,2818930522) ), ROW('Dulce','Aleyda','Jacobo','Farias','1949-10-16','padre',ROW(58,2817769439) )]::familiar_ty[], ARRAY[ ROW('57448642','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'24'),
('Alfredo',null,'Flores','Velazquez','1989-01-05',164,80,'marrón oscuro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2344141623) ,ROW('19430278','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Ana','Carola','Olivares','Rubio','1979-08-01','madre',ROW(58,2873401454) ), ROW('Marcelo','Vicente','Montez','Walker','1979-08-01','hermano',ROW(58,2875455927) )]::familiar_ty[], ARRAY[ ROW('68036828','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null')]::nivel_educativo_ty[],null,'24'),
('Emperatriz','Georgia','Castanon','Castillo','2000-08-09',157,80,'verde oscuro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4129293691) ,ROW('42069213','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Adrian',null,'Price','Becerra','1981-01-22','primo',ROW(58,4129613046) ), ROW('Daniel',null,'Price','Gallardo','1981-01-22','abuelo',ROW(58,4122221410) )]::familiar_ty[], ARRAY[ ROW('81705889','Taiwán'),row('69507128','Australia') ]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null')]::nivel_educativo_ty[],null,'24'),
('Sylvia',null,'Caraballo','Velarde','1996-11-16',187,95,'azul claro','20/63','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2812842710) ,ROW('65439784','Australia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Anunciacion',null,'Osuna','Barcenas','1938-06-18','hermano',ROW(58,4122962348) ), ROW('Juan','Gregorio','Madrid','Larios','1938-06-18','tío',ROW(58,4123557490) )]::familiar_ty[], ARRAY[ ROW('93470901','Malasia')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'25'),
('Clarence','Marsello','Angel','Campos','2000-07-23',168,89,'marrón claro','20/160','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4246960293) ,ROW('78503990','Holanda'),ARRAY['español','inglés','hindi','francés']::varchar(50)[], ARRAY[ ROW('Liliana','Luisa','Carrillo','Cartagena','1956-12-09','hermano',ROW(58,4248965154) ), ROW('Ava','Guadalupe','Suarez','Caballero','1956-12-09','tío',ROW(58,4241522009) )]::familiar_ty[], ARRAY[ ROW('87787395','Malasia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ciencias Sociales ','null','null') ]::nivel_educativo_ty[],null,'25'),
('Donatila','Melania','Michel','Zambrano','1994-06-22',166,82,'azul claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4249842977) ,ROW('95842887','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Santiago',null,'Lozada','Ledesma','1964-03-10','hermano',ROW(58,4241054465) ), ROW('Libertad','Eliana','Garces','Casanova','1964-03-10','tío',ROW(58,4248765720) )]::familiar_ty[], ARRAY[ ROW('32471655','Malasia')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','Máster','Acción Internacional Humanitaria')]::nivel_educativo_ty[],null,'25'),
('Erika',null,'Ordaz','Tolentino','2000-07-22',152,92,'verde claro','20/125','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4242140682) ,ROW('90860097','Zimbabue'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Emma','Audrey','Verduzco','Gallegos','1980-07-05','tío',ROW(58,2611410976) ), ROW('Flor','Esperanza','Peterson','Sarmiento','1980-07-05','abuelo',ROW(58,2613152019) )]::familiar_ty[], ARRAY[ ROW('87756498','Malasia')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Criminología','Máster','Química Orgánica') ]::nivel_educativo_ty[],null,'25'),
('Maximo',null,'Moncada','Resendez','1997-08-11',158,81,'marrón claro','20/50','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2341321695) ,ROW('70030398','Australia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Hilda',null,'Landa','Trejo','1942-09-24','hermano',ROW(58,2125700117) ), ROW('Ivan','Vivaldo','Monge','Orozco','1942-09-24','padre',ROW(58,2125735772) )]::familiar_ty[], ARRAY[ ROW('36844069','Malasia')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Criminología','null','null') ]::nivel_educativo_ty[],null,'26'),
('Juliana','Heidi','Archuleta','Sanchez','2000-08-28',189,83,'marrón oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4128726022) ,ROW('93543002','Holanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Nadia','Monica','Flores','Correa','1958-01-04','abuelo',ROW(58,2877798988) ), ROW('Victoria','Donatila','Vidal','Gastelum','1958-01-04','padre',ROW(58,2877186836) )]::familiar_ty[], ARRAY[ ROW('72295363','Malasia')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Economía','null','null') ]::nivel_educativo_ty[],null,'26'),
('Haydee','Gladys','Caldera','Fabian','1995-07-22',188,81,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4125951582) ,ROW('66629517','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Haydee',null,'Solis','Villeda','1965-12-24','hermano',ROW(58,4127342159) ), ROW('Ignacio','Chistopher','Concepcion','Teran','1965-12-24','padre',ROW(58,4129268326) )]::familiar_ty[], ARRAY[ ROW('88810717','Malasia')]::identificacion_ty[], ARRAY[ ROW('Derecho','Máster','Asesoría Fiscal')]::nivel_educativo_ty[],null,'26'),
('Carla',null,'Mojica','Campbell','2000-08-27',182,86,'verde oscuro','20/100','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2872437442) ,ROW('38383416','Zimbabue'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Ives','Jorge','Narvaez','Tolentino','1980-09-16','padre',ROW(58,2444071786) ), ROW('Nicolas','Abelardo','Tafoya','Peralta','1980-09-16','abuelo',ROW(58,2445818807) )]::familiar_ty[], ARRAY[ ROW('73155349','Malasia')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Psicología','Máster','Inteligencia Emocional') ]::nivel_educativo_ty[],null,'26'),
('Adolfo',null,'Quinonez','Garces','1997-10-11',151,70,'marrón oscuro','20/40','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2612924198) ,ROW('72294857','Australia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Atenea',null,'Amaya','Patino','1943-03-10','abuelo',ROW(58,4245126805) ), ROW('Andres','Caligula','Salguero','Cantu','1943-03-10','madre',ROW(58,4243490244) )]::familiar_ty[], ARRAY[ ROW('79684586','Malasia')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Psicología','null','null') ]::nivel_educativo_ty[],null,'27'),
('Ramona','Amelia','Viramontes','Ascencio','1996-09-22',173,76,'verde claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2129011871) ,ROW('82429267','Holanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Marcos','Venancio','Caldera','Alcantara','1959-04-26','abuelo',ROW(58,2433119934) ), ROW('Michael',null,'Montero','Mora','1959-04-26','madre',ROW(58,2437139396) )]::familiar_ty[], ARRAY[ ROW('46543023','Malasia')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null')]::nivel_educativo_ty[],null,'27'),
('Elizabeth','Eduviges','Henriquez','Hinojosa','1996-09-20',180,82,'marrón oscuro','20/63','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2127152706) ,ROW('67345679','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Caligula',null,'Estevez','Cifuentes','1970-06-29','abuelo',ROW(58,2125663308) ), ROW('Fidel','Juan','Regalado','Machuca','1970-06-29','madre',ROW(58,2126723842) )]::familiar_ty[], ARRAY[ ROW('31627114','Malasia')]::identificacion_ty[], ARRAY[ ROW('Criminología','Máster','Química Orgánica')]::nivel_educativo_ty[],null,'27'),
('Carmona',null,'Martinez','Olivarez','1996-09-21',156,73,'azul oscuro','20/80','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2439707517) ,ROW('80718477','Zimbabue'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Arturo',null,'Lovato','Hernandes','1938-03-06','madre',ROW(58,4144592848) ), ROW('Aidana','Consuelo','Hidalgo','Rodrigues','1938-03-06','primo',ROW(58,4146396575) )]::familiar_ty[], ARRAY[ ROW('24825622','Malasia')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'27'),
('Klement','Julian','Alonzo','Michel','1998-03-20',175,87,'marrón claro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2345973358) ,ROW('45514606','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Eleazar','Cesarino','Pina','Watson','1946-02-25','primo',ROW(58,2127920227) ), ROW('Gloria','Lorena','Valdez','Orozco','1946-02-25','padre',ROW(58,2128577731) )]::familiar_ty[], ARRAY[ ROW('97508067','Uganda')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'28'),
('Emilio','Jaime','Quiles','Amezcua','1983-03-26',179,73,'azul claro','20/200','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4124658197) ,ROW('15376359','Irlanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Irma','Nieves','Roque','Urias','1940-04-13','primo',ROW(58,4121393132) ), ROW('Celeste','Soledad','Chacon','Machado','1940-04-13','hermano',ROW(58,4123485281) )]::familiar_ty[], ARRAY[ ROW('44826830','Uganda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','Máster','Inteligencia Artificial')]::nivel_educativo_ty[],null,'28'),
('Rosaura','Sharon','Zelaya','Rico','1993-10-08',158,69,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4122105602) ,ROW('42964955','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Mario','Marcelo','Alexander','Roberts','1960-08-26','primo',ROW(58,4124457460) ), ROW('Cayetano','Fulgencio','Marquez','Infante','1960-08-26','primo',ROW(58,4128628948) )]::familiar_ty[], ARRAY[ ROW('57521570','Uganda'),row('88222732','Australia') ]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Comunicación','Máster','Lexicografía') ]::nivel_educativo_ty[],null,'28'),
('Luis','Marcus','Wilson','Tejeda','1993-10-09',177,68,'azul oscuro','20/100','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2874851540) ,ROW('70037582','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Italo','Florindo','Barragan','Salinas','1936-11-09','hermano',ROW(58,2442783407) ), ROW('Genesis','Ana','Davis','Vicente','1936-11-09','abuelo',ROW(58,2441541760) )]::familiar_ty[], ARRAY[ ROW('32853447','Uganda')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Criminología','null','null') ]::nivel_educativo_ty[],null,'28'),
('Ludmila','Facunda','Almonte','Frias','1998-04-23',169,89,'marrón oscuro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2612011700) ,ROW('25650571','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Felix','Petronilo','Abarca','Melo','1946-05-22','primo',ROW(58,4245545777) ), ROW('Inocencia','Carolina','Menendez','Saldana','1946-05-22','madre',ROW(58,4247120910) )]::familiar_ty[], ARRAY[ ROW('88242914','Uganda')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Ingeniería Industrial','null','null') ]::nivel_educativo_ty[],null,'29'),
('Delfina','Ligia','Carpio','Buenrostro','1984-01-23',173,91,'marrón claro','20/160','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2124075760) ,ROW('47676861','Irlanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Teodora','Libertad','Montero','Aparicio','1940-09-24','tío',ROW(58,2121211721) ), ROW('Marlene','Donatila','Rosa','Almazan','1940-09-24','hermano',ROW(58,2122363486) )]::familiar_ty[], ARRAY[ ROW('30946999','Uganda')]::identificacion_ty[], ARRAY[ ROW('Comunicación','Máster','Comunicación Intercultural')]::nivel_educativo_ty[],null,'29'),
('Eneida','America','Guerrero','Mireles','1995-01-08',168,66,'marrón oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2121632100) ,ROW('15492537','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Javier','Breno','Benitez','Zayas','1963-01-23','tío',ROW(58,2129242169) ), ROW('Jhoan','Dante','Lucero','Orona','1963-01-23','madre',ROW(58,2128078170) )]::familiar_ty[], ARRAY[ ROW('57512360','Uganda'),row('59997320','Australia') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Enfermería','Máster','Investigación de Medicamentos') ]::nivel_educativo_ty[],null,'29'),
('Constancia','Alma','Payan','Moya','1995-01-09',172,80,'azul claro','20/80','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2439959656) ,ROW('77887372','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Maricruz','Viviana','Moore','Zamora','1936-12-24','hermano',ROW(58,4148258146) ), ROW('Ignacio','Maximo','Wright','Resendez','1936-12-24','primo',ROW(58,4148917731) )]::familiar_ty[], ARRAY[ ROW('48172871','Uganda')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Psicología','null','null') ]::nivel_educativo_ty[],null,'29'),
('Imelda','Genesis','Salmeron','Baca','1998-06-27',167,81,'verde claro','20/32','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2449530602) ,ROW('67338157','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Celina','Mafalda','Smith','Alcantar','1948-02-28','tío',ROW(58,4128913319) ), ROW('Hermione','Mariluz','Manzanares','Chavez','1948-02-28','hermano',ROW(58,4121129176) )]::familiar_ty[], ARRAY[ ROW('98933002','Uganda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'30'),
('Felicia','Emiliana','Pacheco','Munoz','1986-03-28',175,70,'marrón oscuro','20/125','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4244117340) ,ROW('49703495','Irlanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Marcelo','Tulio','Paredes','Heredia','1943-12-14','padre',ROW(58,4248387995) ), ROW('Fabiano','Tarsicio','Santamaria','Jaquez','1943-12-14','abuelo',ROW(58,4249631241) )]::familiar_ty[], ARRAY[ ROW('52235413','Uganda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','Máster','Dirección de Empresas')]::nivel_educativo_ty[],null,'30'),
('Tarsicio','Carlos','Garza','Ochoa','1995-07-24',162,69,'verde claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4242640511) ,ROW('47591916','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Patricia','Maricruz','Miller','Amador','1965-03-19','padre',ROW(58,4126888534) ), ROW('Elidio','Jonathan','Puentes','Ozuna','1965-03-19','hermano',ROW(58,4123171192) )]::familiar_ty[], ARRAY[ ROW('40936348','Uganda'),row('40745243','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Ciencias Sociales ','Máster','Relaciones Internacionales') ]::nivel_educativo_ty[],null,'30'),
('Jacobo','Elian','Person','Bianco','1995-07-25',181,86,'marrón claro','20/20','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2818200361) ,ROW('15230878','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cristiano','Fabiano','Toledo','Bustos','1941-01-27','abuelo',ROW(58,4125407316) ), ROW('Eduardo','Juan','Roybal','Escamilla','1941-01-27','tío',ROW(58,4126598183) )]::familiar_ty[], ARRAY[ ROW('22623786','Uganda')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'30'),
('Diego','Cesar','Bueno','Conde','1989-02-08',177,75,'azul claro','20/50','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2347045671) ,ROW('46003066','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Hilda','Bernarda','Tamez','Cuellar','1954-08-20','abuelo',ROW(58,2349506556) ), ROW('Mirella','Zamira','Machuca','Magallon','1954-08-20','padre',ROW(58,2348108392) )]::familiar_ty[], ARRAY[ ROW('75410645','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Enfermería','Máster','Investigación de Medicamentos')]::nivel_educativo_ty[],null,'31'),
('Eleazar','Silvio','Calderon','Maciel','1984-12-22',158,74,'marrón oscuro','20/10','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2123510656) ,ROW('37037351','Irlanda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Aleyda','Donatila','Nolasco','Salgado','1938-11-18','hermano',ROW(58,2121530571) ), ROW('Pamela',null,'Guevara','Zapata','1938-11-18','madre',ROW(58,2122904772) )]::familiar_ty[], ARRAY[ ROW('36639067','Zimbabue'),row('78017599','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null')]::nivel_educativo_ty[],null,'31'),
('Facundo','Cristian','Ventura','Valladares','1989-01-04',172,68,'marrón oscuro','20/16','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2616773916) ,ROW('81242984','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Agustin','Hugo','Maldonado','Estrella','1965-09-12','madre',ROW(58,4248540911) ), ROW('Silvio','Maximiliano','Granados','Cordova','1965-09-12','madre',ROW(58,4247069608) )]::familiar_ty[], ARRAY[ ROW('48286733','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Ciencias Sociales ','null','null') ]::nivel_educativo_ty[],null,'31'),
('Venancio','Justin','Miramontes','Verduzco','1989-04-24',189,88,'marrón claro','20/40','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2618231899) ,ROW('42006385','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Octavio',null,'Villanueva','Valles','1955-07-02','abuelo',ROW(58,2612763993) ), ROW('Vicente','Agustin','Rosas','Arguello','1955-07-02','madre',ROW(58,2619623603) )]::familiar_ty[], ARRAY[ ROW('92826593','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','Máster','Relaciones Internacionales')]::nivel_educativo_ty[],null,'32'),
('Eleazar','Francisco','Abreu','Alba','1986-05-02',174,91,'verde claro','20/125','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4243858397) ,ROW('47009264','Irlanda'),ARRAY['español','inglés','hindi','francés']::varchar(50)[], ARRAY[ ROW('Lionel','Vivaldo','Martinez','Elias','1940-07-21','hermano',ROW(58,4247638175) ), ROW('Feliciano',null,'Hurtado','Baca','1940-07-21','hermano',ROW(58,4241274002) )]::familiar_ty[], ARRAY[ ROW('16130752','Zimbabue'),row('15985105','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Economía','null','null')]::nivel_educativo_ty[],null,'32'),
('Vitalicio','Benjamin','Bennett','Rios','1989-12-17',165,84,'verde claro','20/12.5','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2445192944) ,ROW('72821520','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Yovanni','Ivan','Barbosa','Orosco','1965-11-26','hermano',ROW(58,4127971069) ), ROW('Ayala','Adria','Arriaga','Cota','1965-11-26','hermano',ROW(58,4126316402) )]::familiar_ty[], ARRAY[ ROW('19300027','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'32'),
('Camilo','Marcos','Melgoza','Roa','1990-09-14',186,67,'marrón oscuro','20/32','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2441475499) ,ROW('24683243','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Julio',null,'Avelar','Conde','1955-12-31','primo',ROW(58,2443157513) ), ROW('Octavia','Eduviges','Mena','Alcantara','1955-12-31','hermano',ROW(58,2444809325) )]::familiar_ty[], ARRAY[ ROW('92757360','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Economía','Máster','Auditoria Financiera y Riegos')]::nivel_educativo_ty[],null,'33'),
('Ulises','Jhoan','Delgadillo','Vera','1988-12-01',169,89,'verde oscuro','20/100','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2879331316) ,ROW('86795048','Irlanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Valerio','Carmona','Solis','Sarabia','1942-07-22','abuelo',ROW(58,2875790429) ), ROW('Eloisa',null,'Nolasco','White','1942-07-22','hermano',ROW(58,2874376756) )]::familiar_ty[], ARRAY[ ROW('59587535','Zimbabue'),row('66240845','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null')]::nivel_educativo_ty[],null,'33'),
('Paula','Laila','Serna','Mora','1990-02-06',166,66,'verde oscuro','20/32','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4143488598) ,ROW('87257042','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Celeste','Jessica','Maravilla','Quiroga','1969-05-14','hermano',ROW(58,2124055055) ), ROW('Perla','Gloria','Lima','Valentin','1969-05-14','hermano',ROW(58,2128248567) )]::familiar_ty[], ARRAY[ ROW('86266460','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Criminología','null','null') ]::nivel_educativo_ty[],null,'33'),
('Constancia','Sheila','Olivo','Cifuentes','1990-08-28',185,69,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2617701710) ,ROW('10951253','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Javier','Valentin','Aguirre','Covarrubias','1954-01-12','padre',ROW(58,2613766481) ), ROW('Dulcinea',null,'Pizarro','Santiago','1954-01-12','padre',ROW(58,2615339812) )]::familiar_ty[], ARRAY[ ROW('67705000','Australia'),row('89817176','Uganda') ]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null')]::nivel_educativo_ty[],null,'34'),
('Sebastian',null,'Mitchell','Hill','1997-12-16',151,75,'verde claro','20/32','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2445752091) ,ROW('90175740','Irlanda'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Arturo',null,'Villa','Tejeda','1945-07-24','abuelo',ROW(58,4125122784) ), ROW('Mia','Caridad','Avalos','Castaneda','1945-07-24','hermano',ROW(58,4125195244) )]::familiar_ty[], ARRAY[ ROW('76417890','Australia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'34'),
('Gabriela',null,'Vallejo','Holguin','1983-09-16',164,71,'verde claro','20/160','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2124182379) ,ROW('48148974','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Gabriel','Caligula','Batista','Moreno','1967-09-29','abuelo',ROW(58,2128902943) ), ROW('Benicio','Victor','Morris','Gray','1967-09-29','hermano',ROW(58,2127197016) )]::familiar_ty[], ARRAY[ ROW('66763426','Australia')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null')]::nivel_educativo_ty[],null,'34'),
('Ema','Chantal','Ramirez','Mendez','1991-01-31',186,86,'marrón oscuro','20/32','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2443451374) ,ROW('97392406','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Amelia','Veronica','Huerta','Quesada','1955-01-04','madre',ROW(58,2446002152) ), ROW('Marsello',null,'Carpio','Thomas','1955-01-04','madre',ROW(58,2441977699) )]::familiar_ty[], ARRAY[ ROW('98507303','Australia'),row('21946037','Uganda') ]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ingeniería Informática','Máster','Inteligencia Artificial') ]::nivel_educativo_ty[],null,'35'),
('Heidi',null,'Luciano','Aguayo','1999-09-15',174,71,'verde oscuro','20/25','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4146509559) ,ROW('74832616','Irlanda'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Johanna',null,'Ayala','Bocanegra','1946-05-25','primo',ROW(58,2123844815) ), ROW('Camilo','Breno','Larios','Irizarry','1946-05-25','hermano',ROW(58,2125246310) )]::familiar_ty[], ARRAY[ ROW('46107042','Australia')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'35'),
('Benedicto',null,'Melgar','Arevalo','1984-05-23',175,70,'verde oscuro','20/125','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4241790394) ,ROW('50378948','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Ciceron','Regulo','Luevano','Samaniego','1967-10-01','primo',ROW(58,4248213116) ), ROW('Santiago','Angel','Magallanes','Catalan','1967-10-01','hermano',ROW(58,4249074168) )]::familiar_ty[], ARRAY[ ROW('66952979','Australia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'35'),
('Waldetrudis','Lucila','Angulo','Barajas','1991-05-25',185,79,'verde claro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4141686021) ,ROW('88039234','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Rafael','Amador','Solis','Garcia','1955-09-08','hermano',ROW(58,4148275755) ), ROW('Antonio',null,'Recinos','Santacruz','1955-09-08','hermano',ROW(58,4141386237) )]::familiar_ty[], ARRAY[ ROW('96945124','Australia'),row('40968680','Zimbabue') ]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Comunicación','Máster','Comunicación Intercultural') ]::nivel_educativo_ty[],null,'36'),
('Faustino',null,'Camarillo','Carreno','1999-09-21',163,79,'azul oscuro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4128188205) ,ROW('37643473','Irlanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Ignacio',null,'Gallardo','Corrales','1947-09-12','tío',ROW(58,4242643231) ), ROW('Foster','Hercules','Palma','Palomino','1947-09-12','abuelo',ROW(58,4244868574) )]::familiar_ty[], ARRAY[ ROW('57976029','Australia')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Ingeniería Industrial','null','null') ]::nivel_educativo_ty[],null,'36'),
('Marcelo',null,'Parada','Alcantar','1984-12-24',179,77,'azul oscuro','20/100','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2872981731) ,ROW('38336640','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Irma','Natividad','Cordova','Torrez','1971-01-05','primo',ROW(58,4121629139) ), ROW('Samuel','Tulio','Rolon','Henderson','1971-01-05','abuelo',ROW(58,4128149218) )]::familiar_ty[], ARRAY[ ROW('33377073','Australia')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null')]::nivel_educativo_ty[],null,'36');


--select ((familiares))::varchar[] from personal_inteligencia ;

--select * from personal_inteligencia ;

-- PERSONAL_INTELIGENCIA.aliases[]
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bertrudis','Viviana','Sanchez','Serna',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1993-09-21','Argentina',39794059,'marrón oscuro','Tucson, AZ 85718','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 2;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bienvenido','Vivaldo','Salmeron','Sarmiento',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2002-05-06','Taiwán',40559018,'azul oscuro','Kennesaw, GA 30144','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 4;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adrian','Vitalicio','Ward','Zambrano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1982-05-28','Argentina',72828593,'azul oscuro','93 Sunbeam Drive ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 6;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anastasia','Victor','Toro','Valentin',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2000-09-18','Malasia',76942186,'verde oscuro','Nashville, TN 37205','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 8;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Brandon','Vicente','Salguero','Santiago',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2007-01-29','Malasia',73098156,'marrón claro','Germantown, MD 20874','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 10;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adolfo','Vicente','Zaragoza','Zaragoza',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1973-02-07','Holanda',23155030,'azul claro','586 Bear Hill Court ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 12;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alba','Veronica','Vidal','Villa',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2006-08-18','Zimbabue',94219591,'verde claro','Stroudsburg, PA 18360','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 14;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alma','Vanesa','Valles','Velazquez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-07-14','Holanda',93788472,'verde oscuro','West Bloomfield, MI 48322','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 16;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Valentina','Serrano','Stewart',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1965-06-03','Uganda',94840883,'azul claro','Madison Heights, MI 48071','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 18;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aidana','Tulio','Villareal','Villatoro',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1995-05-19','Malasia',64619158,'verde oscuro','Richardson, TX 75080','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 20;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Andres','Tulio','Terrazas','Valdivia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2004-03-15','Uganda',99567426,'azul claro','West Haven, CT 06516','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 22;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Abelardo','Trinidad','Zuniga','Zuniga',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1964-12-31','Irlanda',18003181,'marrón oscuro','9161 Court Street ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 24;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bella','Tarsicio','Serrato','Sullivan',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-02-15','Uganda',97325556,'verde oscuro','Bedford, OH 44146','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 26;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Atenea','Tarsicio','Stevens','Teran',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1985-08-22','Groenlandia',55392472,'marrón oscuro','Elkridge, MD 21075','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 28;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Berta','Soledad','Sandoval','Serrato',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1990-12-04','Groenlandia',39013095,'azul claro','Longview, TX 75604','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 30;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alana','Santiago','Vidal','Villalobos',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2000-06-05','Uganda',65981559,'marrón oscuro','Milledgeville, GA 31061','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 32;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aurelio','Saida','Soliz','Tejeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1996-08-09','Taiwán',88309073,'azul oscuro','Casselberry, FL 32707','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 34;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Berenice','Rosaura','Santiago','Sifuentes',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1982-09-23','Holanda',97186591,'marrón oscuro','Thibodaux, LA 70301','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 36;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alan','Renato','Villa','Villarreal',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1999-03-19','Uganda',57484344,'azul claro','Maplewood, NJ 07040','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 38;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Ramona','Segura','Solorzano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1971-12-24','Australia',29831792,'verde claro','Tupelo, MS 38801','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 40;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Breno','Pilar','Saldana','Santiago',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-09-15','Malasia',79845444,'marrón oscuro','Glen Allen, VA 23059','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 42;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anastasia','Petronila','Torrez','Valerio',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1999-02-16','Malasia',39725738,'marrón oscuro','Meadville, PA 16335','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 44;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alejandro','Paulo','Verdugo','Vicente',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-08-18','Australia',45560993,'azul oscuro','Round Lake, IL 60073','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 46;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alfredo','Orosio','Vargas','Vera',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1973-12-12','Irlanda',20218427,'marrón oscuro','Shakopee, MN 55379','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 48;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Angel','Orosio','Tello','Valadez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2005-05-04','Zimbabue',48566663,'marrón oscuro','East Brunswick, NJ 08816','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 50;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ayala','Ophelia','Solis','Tamez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2007-03-05','Malasia',90611411,'marrón oscuro','Miami Gardens, FL 33056','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 52;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Antonio','Nathaly','Tavarez','Urena',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1968-01-12','Australia',88091838,'azul oscuro','Orchard Park, NY 14127','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 54;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Arturo','Myriam','Sullivan','Tolentino',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-07-31','Holanda',53170592,'verde oscuro','Lorton, VA 22079','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 56;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ana','Michael','Ulloa','Valle',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1996-09-25','Taiwán',62612183,'marrón claro','Woodbridge, VA 22191','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 58;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bibiana','Melina','Samaniego','Scott',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1996-01-26','Argentina',36247798,'verde claro','Lake Mary, FL 32746','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 60;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Caligula','Melchor','Saavedra','Santacruz',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1969-09-17','Uganda',46978646,'verde oscuro','Arlington, MA 02474','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 62;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Abigail','Maximo','Zelaya','Zayas',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1970-03-20','Irlanda',60979224,'verde oscuro','7399 Brickyard St. ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 64;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bernarda','Maximo','Santana','Sierra',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1986-10-17','Holanda',72588079,'verde oscuro','Mason, OH 45040','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 66;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amelia','Maximo','Valdivia','Valverde',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1990-05-03','Argentina',91050198,'verde claro','Venice, FL 34293','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 68;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aleyda','Maximiliano','Velasco','Verdugo',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1967-02-15','Australia',99242558,'marrón claro','West Springfield, MA 01089','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 70;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amanda','Mariluz','Valerio','Velarde',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1983-06-07','Groenlandia',73523260,'marrón oscuro','Zionsville, IN 46077','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 72;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Agnes','Mariana','Villeda','Walker',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1989-03-16','Taiwán',29778317,'marrón oscuro','Chillicothe, OH 45601','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 74;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benigno','Mariam','Sauceda','Simon',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-06-12','Australia',22868275,'azul oscuro','Palm Harbor, FL 34683','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 76;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Antonio','Margarita','Tamez','Trejo',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1971-06-15','Irlanda',57996320,'marrón claro','Cheshire, CT 06410','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 78;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Araceli','Marcial','Tafoya','Torrez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1972-08-11','Irlanda',47494018,'marrón oscuro','Georgetown, SC 29440','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 80;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benjamin','Marcela','Santillan','Silva',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1979-03-29','Irlanda',96303281,'marrón claro','Maumee, OH 43537','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 82;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adolfo','Mabel','Yepez','Zapata',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1974-12-30','Groenlandia',62878182,'marrón oscuro','29 Golf St. ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 84;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Lucrecia','Serna','Soria',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1968-08-05','Zimbabue',72372788,'marrón oscuro','Winston Salem, NC 27103','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 86;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aurelio','Lorena','Soriano','Tejeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1994-08-02','Argentina',51949025,'verde claro','New York, NY 10002','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 88;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adriana','Lincoln','Viramontes','Watson',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1987-06-01','Taiwán',52531353,'marrón claro','8417 South Brandywine Rd. ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 90;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amparo','Liliana','Valadez','Vallejo',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1994-03-07','Argentina',66552946,'azul oscuro','Nottingham, MD 21236','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 92;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ashley','Leopoldo','Suarez','Thompson',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1980-06-12','Groenlandia',22457934,'azul claro','Lake Villa, IL 60046','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 94;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adria','Leopoldo','Wilson','Zamora',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1980-03-31','Groenlandia',70689277,'verde claro','9638 Greenrose Road ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 96;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ava','Leonardo','Solis','Tavarez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2004-05-20','Taiwán',43195703,'marrón claro','Lawrenceville, GA 30043','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 98;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amada','Leon','Vallejo','Velasquez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-12-30','Holanda',23444439,'azul claro','Adrian, MI 49221','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 100;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anthony','Klement','Tellez','Uribe',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1966-06-15','Zimbabue',44190141,'verde claro','New Berlin, WI 53151','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 102;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Arturo','Guadalupe','Sullivan','Tobar',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1980-04-16','Holanda',50444013,'azul oscuro','1 Baker Court ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 2;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Betsabe','Liliana','Sanabria','Segovia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1995-05-17','Argentina',90303068,'marrón oscuro','1 Shirley Drive ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 4;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alan','Adan','Vigil','Villalpando',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2000-01-03','Uganda',40757806,'marrón claro','121 Lincoln Lane ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 6;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Antonella','Consuelo','Tejeda','Urias',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1966-08-26','Australia',79031778,'verde oscuro','14 N. Southampton Dr. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 8;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ayala','Gloria','Solis','Tapia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2005-10-25','Malasia',25323734,'marrón oscuro','15 SW. Gates Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 10;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bibiana','Celia','Salmeron','Sarmiento',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1999-12-14','Taiwán',80919225,'verde oscuro','235 Orchard Dr. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 12;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ayala','Eleazar','Smith','Tafoya',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-01-03','Malasia',71818044,'verde claro','3 Cedarwood Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 14;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Antonio','Vivaldo','Tamez','Umana',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1970-09-16','Australia',34265217,'azul claro','34 Cross St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 16;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ava','Maximiliano','Soliz','Taveras',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2003-08-08','Taiwán',29286791,'azul claro','367 West Cedarwood Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 18;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Caligula','Mariana','Saavedra','Santacruz',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1970-10-02','Uganda',78102467,'azul oscuro','4 Division Circle ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 20;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anastasia','Dante','Trejo','Valladares',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1998-02-18','Taiwán',44890413,'marrón oscuro','417 North Cedar St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 22;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Angela','Esperanza','Tellez','Uribe',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1965-05-26','Zimbabue',44795450,'marrón oscuro','474 Primrose Rd. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 24;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Andres','Aidana','Tenorio','Valdes',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2004-07-13','Uganda',78933613,'marrón claro','567 Brickyard St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 26;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benita','Mariluz','Santoyo','Silva',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1977-02-23','Irlanda',87519420,'azul claro','60 Leatherwood Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 28;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bruno','Vicente','Salcedo','Santamaria',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1968-01-03','Uganda',20273309,'verde claro','637 Elizabeth Dr. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 30;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alan','Nathaly','Villanueva','Villarreal',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1995-07-06','Malasia',89479928,'azul oscuro','65 Johnson Drive ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 32;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alba','Klement','Vidal','Villa',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2002-04-12','Zimbabue',27684565,'marrón oscuro','666 Princeton Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 34;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Brandon','Angel','Salinas','Sarabia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2005-04-04','Taiwán',92579393,'azul claro','67 Vermont Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 36;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aleyda','Gracia','Velasco','Vera',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1967-11-20','Irlanda',40678396,'marrón oscuro','7049 Bradford Court ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 38;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benicio','Lorena','Sauceda','Solorio',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1974-08-30','Australia',67276837,'verde oscuro','7497 Pheasant Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 40;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anunciacion','Caridad','Tafoya','Toscano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1972-06-09','Irlanda',85046113,'marrón oscuro','7810 Marshall Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 42;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aleyda','Vitalicio','Ventura','Verduzco',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1965-04-16','Australia',49398743,'azul claro','7965 Academy Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 44;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Agustin','Juan','Villeda','Villeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1993-04-14','Malasia',13945007,'verde claro','8011 Kirkland Road ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 46;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bernarda','Guadalupe','Santana','Sifuentes',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1983-04-26','Holanda',65569169,'verde claro','8201 Old Arrowhead Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 48;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Maximo','Segura','Solorzano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1969-07-22','Zimbabue',45992348,'marrón oscuro','8351 E. Young St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 50;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Arturo','Hercules','Tafoya','Tolentino',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-01-17','Holanda',25512067,'verde claro','8466 Lakeview Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 52;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Brenda','Isabella','Salgado','Santiago',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2010-09-23','Malasia',16821110,'marrón oscuro','8487 W. Foxrun Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 54;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aurelia','Calixtrato','Sorto','Tello',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1985-11-11','Argentina',65407611,'marrón oscuro','858 Franklin Drive ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 56;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anastasia','Eneida','Torres','Valerio',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2000-04-03','Malasia',50134371,'verde claro','8794 Old Cobblestone Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 58;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aurelio','Corania','Solorio','Tejeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1996-01-05','Argentina',46450821,'verde oscuro','884 Glenridge Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 60;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'America','Rosaura','Valdez','Valles',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1990-07-24','Argentina',86622561,'verde oscuro','893 South Stonybrook Dr. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 62;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ana','Veronica','Umana','Vallejo',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1994-09-06','Taiwán',18467817,'azul claro','8966 High Drive ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 64;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amanda','Tulio','Vallejo','Velasquez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1982-03-05','Groenlandia',79164693,'marrón claro','9036 Harvey Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 66;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bernarda','Michael','Santamaria','Servin',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1990-01-26','Groenlandia',83415767,'azul oscuro','917 Ketch Harbour St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 68;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bertrudis','Saida','Sandoval','Serrato',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1991-08-22','Groenlandia',53815695,'marrón claro','9205 Carson Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 70;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Klement','Serna','Sosa',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1965-09-20','Zimbabue',74305778,'marrón claro','922 North Brown Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 72;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alicia','Jaime','Valverde','Veliz',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-06-03','Irlanda',26775064,'verde claro','9414 Fawn St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 74;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Altagracia','Paulo','Valles','Velazquez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-10-27','Holanda',39666670,'azul oscuro','944 Shadow Brook Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 76;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benjamin','Felix','Santillan','Sifuentes',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1981-11-20','Irlanda',47803369,'marrón oscuro','954 Lyme Road ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 78;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Andres','Lincoln','Toledo','Valdivia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2002-05-07','Uganda',93493532,'azul oscuro','9552 Beach Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 80;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alba','Mabel','Verduzco','Viera',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2010-11-25','Zimbabue',32861153,'verde oscuro','9619 Jennings Rd. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 82;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amara','Alan','Valerio','Velarde',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1989-03-23','Groenlandia',35495666,'marrón oscuro','962 St Paul St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 84;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bella','Orosio','Serrano','Suarez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-05-23','Uganda',78836787,'azul oscuro','9822 High Noon Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 86;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Atenea','Cesar','Suarez','Thomas',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1984-04-26','Groenlandia',38144260,'marrón claro','9951 Lyme Road ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 88;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adria','Zamira','Wright','Zamora',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1977-10-31','Groenlandia',98124904,'marrón oscuro','Atlantic City, NJ 08401','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 90;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adan','Tarsicio','Zavala','Zarate',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1971-04-19','Holanda',35618221,'azul oscuro','Chattanooga, TN 37421','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 92;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Abigail','Soledad','Zepeda','Zepeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1966-05-13','Irlanda',90693292,'verde claro','Leland, NC 28451','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 94;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adria','Eduviges','Ward','Zambrano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1980-05-19','Argentina',23482544,'verde oscuro','Mc Lean, VA 22101','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 96;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adrian','Constantino','Walker','White',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1982-10-08','Argentina',77240684,'azul claro','Patchogue, NY 11772','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 98;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adolfo','Berenice','Zacarias','Zaragoza',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1974-10-04','Holanda',54104127,'marrón claro','Peachtree City, GA 30269','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 100;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adriana','Eliana','Villeda','Ward',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1987-10-13','Taiwán',77246173,'marrón oscuro','Unit 7 ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 102;

----AREA INTERES
INSERT INTO area_interes (fk_clas_tema, fk_cliente) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(1, 10),
(2, 11),
(3, 12),
(4, 13),
(5, 14),
(6, 15),
(7, 16),
(8, 17),
(9, 18),
(4, 19),
(5, 20);


-- HIST_CARGO

INSERT INTO HIST_CARGO (fecha_inicio, fecha_fin, cargo,  fk_personal_inteligencia, fk_estacion, fk_oficina_principal) VALUES 
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',1,1,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',2,1,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',3,1,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',4,1,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',5,2,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',6,2,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',7,2,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',8,2,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',9,3,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',10,3,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',11,3,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',12,3,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',13,4,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',14,4,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',15,4,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',16,4,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',17,5,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',18,5,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',19,5,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',20,5,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',21,6,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',22,6,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',23,6,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',24,6,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',25,7,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',26,7,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',27,7,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',28,7,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',29,8,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',30,8,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',31,8,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',32,8,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',33,9,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',34,9,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',35,9,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',36,9,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',37,10,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',38,10,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',39,10,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',40,10,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',41,11,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',42,11,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',43,11,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',44,11,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',45,12,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',46,12,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',47,12,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',48,12,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',49,13,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',50,13,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',51,13,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',52,13,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',53,14,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',54,14,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',55,14,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',56,14,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',57,15,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',58,15,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',59,15,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',60,15,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',61,16,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',62,16,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',63,16,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',64,16,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',65,17,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',66,17,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',67,17,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',68,17,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',69,18,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',70,18,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',71,18,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',72,18,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',73,19,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',74,19,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',75,19,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',76,19,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',77,20,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',78,20,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',79,20,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',80,20,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',81,21,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',82,21,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',83,21,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',84,21,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',85,22,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',86,22,8),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',87,22,8),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',88,23,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',89,23,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',90,23,8),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',91,24,8),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',92,24,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',93,24,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',94,25,9),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',95,25,9),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',96,25,9),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',97,26,9),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',98,26,9),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',99,26,9),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',100,27,9),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',101,27,9),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',102,27,9),
('2035-03-09 07:00:00',null,'analista',1,1,1),
('2035-03-09 07:00:00',null,'agente',2,1,1),
('2035-03-12 07:00:00',null,'analista',3,1,1),
('2035-03-12 07:00:00',null,'agente',4,1,1),
('2035-03-09 07:00:00',null,'analista',5,2,1),
('2035-03-09 07:00:00',null,'agente',6,2,1),
('2035-03-12 07:00:00',null,'analista',7,2,1),
('2035-03-12 07:00:00',null,'agente',8,2,1),
('2035-03-09 07:00:00',null,'analista',9,3,1),
('2035-03-09 07:00:00',null,'agente',10,3,1),
('2035-03-12 07:00:00',null,'analista',11,3,1),
('2035-03-12 07:00:00',null,'agente',12,3,1),
('2035-03-09 07:00:00',null,'analista',13,4,2),
('2035-03-09 07:00:00',null,'agente',14,4,2),
('2035-03-12 07:00:00',null,'analista',15,4,2),
('2035-03-12 07:00:00',null,'agente',16,4,2),
('2035-03-09 07:00:00',null,'analista',17,5,2),
('2035-03-09 07:00:00',null,'agente',18,5,2),
('2035-03-12 07:00:00',null,'analista',19,5,2),
('2035-03-12 07:00:00',null,'agente',20,5,2),
('2035-03-09 07:00:00',null,'analista',21,6,2),
('2035-03-09 07:00:00',null,'agente',22,6,2),
('2035-03-12 07:00:00',null,'analista',23,6,2),
('2035-03-12 07:00:00',null,'agente',24,6,2),
('2035-03-09 07:00:00',null,'analista',25,7,3),
('2035-03-09 07:00:00',null,'agente',26,7,3),
('2035-03-12 07:00:00',null,'analista',27,7,3),
('2035-03-12 07:00:00',null,'agente',28,7,3),
('2035-03-09 07:00:00',null,'analista',29,8,3),
('2035-03-09 07:00:00',null,'agente',30,8,3),
('2035-03-12 07:00:00',null,'analista',31,8,3),
('2035-03-12 07:00:00',null,'agente',32,8,3),
('2035-03-09 07:00:00',null,'analista',33,9,3),
('2035-03-09 07:00:00',null,'agente',34,9,3),
('2035-03-12 07:00:00',null,'analista',35,9,3),
('2035-03-12 07:00:00',null,'agente',36,9,3),
('2035-03-09 07:00:00',null,'analista',37,10,4),
('2035-03-09 07:00:00',null,'agente',38,10,4),
('2035-03-12 07:00:00',null,'analista',39,10,4),
('2035-03-12 07:00:00',null,'agente',40,10,4),
('2035-03-09 07:00:00',null,'analista',41,11,4),
('2035-03-09 07:00:00',null,'agente',42,11,4),
('2035-03-12 07:00:00',null,'analista',43,11,4),
('2035-03-12 07:00:00',null,'agente',44,11,4),
('2035-03-09 07:00:00',null,'analista',45,12,4),
('2035-03-09 07:00:00',null,'agente',46,12,4),
('2035-03-12 07:00:00',null,'analista',47,12,4),
('2035-03-12 07:00:00',null,'agente',48,12,4),
('2035-03-09 07:00:00',null,'analista',49,13,5),
('2035-03-09 07:00:00',null,'agente',50,13,5),
('2035-03-12 07:00:00',null,'analista',51,13,5),
('2035-03-12 07:00:00',null,'agente',52,13,5),
('2035-03-09 07:00:00',null,'analista',53,14,5),
('2035-03-09 07:00:00',null,'agente',54,14,5),
('2035-03-12 07:00:00',null,'analista',55,14,5),
('2035-03-12 07:00:00',null,'agente',56,14,5),
('2035-03-09 07:00:00',null,'analista',57,15,5),
('2035-03-09 07:00:00',null,'agente',58,15,5),
('2035-03-12 07:00:00',null,'analista',59,15,5),
('2035-03-12 07:00:00',null,'agente',60,15,5),
('2035-03-09 07:00:00',null,'analista',61,16,6),
('2035-03-09 07:00:00',null,'agente',62,16,6),
('2035-03-12 07:00:00',null,'analista',63,16,6),
('2035-03-12 07:00:00',null,'agente',64,16,6),
('2035-03-09 07:00:00',null,'analista',65,17,6),
('2035-03-09 07:00:00',null,'agente',66,17,6),
('2035-03-12 07:00:00',null,'analista',67,17,6),
('2035-03-12 07:00:00',null,'agente',68,17,6),
('2035-03-09 07:00:00',null,'analista',69,18,6),
('2035-03-09 07:00:00',null,'agente',70,18,6),
('2035-03-12 07:00:00',null,'analista',71,18,6),
('2035-03-12 07:00:00',null,'agente',72,18,6),
('2035-03-09 07:00:00',null,'analista',73,19,7),
('2035-03-09 07:00:00',null,'agente',74,19,7),
('2035-03-12 07:00:00',null,'analista',75,19,7),
('2035-03-12 07:00:00',null,'agente',76,19,7),
('2035-03-09 07:00:00',null,'analista',77,20,7),
('2035-03-09 07:00:00',null,'agente',78,20,7),
('2035-03-12 07:00:00',null,'analista',79,20,7),
('2035-03-12 07:00:00',null,'agente',80,20,7),
('2035-03-09 07:00:00',null,'analista',81,21,7),
('2035-03-09 07:00:00',null,'agente',82,21,7),
('2035-03-12 07:00:00',null,'analista',83,21,7),
('2035-03-12 07:00:00',null,'agente',84,21,7),
('2035-03-09 07:00:00',null,'analista',85,22,8),
('2035-03-09 07:00:00',null,'agente',86,22,8),
('2035-03-12 07:00:00',null,'analista',87,22,8),
('2035-03-12 07:00:00',null,'agente',88,23,8),
('2035-03-09 07:00:00',null,'analista',89,23,8),
('2035-03-09 07:00:00',null,'agente',90,23,8),
('2035-03-12 07:00:00',null,'analista',91,24,8),
('2035-03-12 07:00:00',null,'agente',92,24,8),
('2035-03-09 07:00:00',null,'analista',93,24,8),
('2035-03-09 07:00:00',null,'agente',94,25,9),
('2035-03-12 07:00:00',null,'analista',95,25,9),
('2035-03-12 07:00:00',null,'agente',96,25,9),
('2035-03-09 07:00:00',null,'analista',97,26,9),
('2035-03-09 07:00:00',null,'agente',98,26,9),
('2035-03-12 07:00:00',null,'analista',99,26,9),
('2035-03-12 07:00:00',null,'agente',100,27,9),
('2035-03-09 07:00:00',null,'analista',101,27,9),
('2035-03-09 07:00:00',null,'agente',102,27,9);



--select aliases from personal_inteligencia pi2 where id = 1;

---INFORMANTES

INSERT INTO informante (nombre_clave, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado, fk_empleado_jefe_confidente, fk_personal_inteligencia_confidente, fk_fecha_inicio_confidente, fk_estacion_confidente, fk_oficina_principal_confidente) VALUES
('Ameamezersali', 1, '2034-01-05 01:00:00', 1, 1, 11, null, null, null, null),
('Cuente', 3, '2034-01-06 01:00:00', 1, 1, 11, null, null, null, null),
('Tipini', 5, '2034-01-05 01:00:00', 2, 1, 12, null, null, null, null),
('Matella', 7, '2034-01-06 01:00:00', 2, 1, 12, null, null, null, null),
('Criola', 9, '2034-01-05 01:00:00', 3, 1, 13, null, null, null, null),
('Mentino', 11, '2034-01-06 01:00:00', 3, 1, 13, null, null, null, null),
('Traccion', 13, '2034-01-05 01:00:00', 4, 2, 14, null, null, null, null),
('Oversta', 15, '2034-01-06 01:00:00', 4, 2, 14, null, null, null, null),
('Inforaza', 17, '2034-01-05 01:00:00', 5, 2, null, 15, '2034-01-06 01:00:00', 4, 2),
('Endora', 19, '2034-01-06 01:00:00', 5, 2, null, 17, '2034-01-05 01:00:00', 5, 2),
('Chalida', 21, '2034-01-05 01:00:00', 6, 2, null, 19, '2034-01-06 01:00:00', 5, 2),
('Trustora', 101, '2034-01-05 01:00:00', 27, 9, null, 99, '2034-01-06 01:00:00', 26, 9),
('Impaza', 1, '2034-01-05 01:00:00', 1, 1, null, 17, '2034-01-05 01:00:00', 5, 2),
('Clari', 3, '2034-01-06 01:00:00', 1, 1, null, 15, '2034-01-06 01:00:00', 4, 2),
('Monerte', 5, '2034-01-05 01:00:00', 2, 1, null, 13, '2034-01-05 01:00:00', 4, 2),
('Accuenti', 7, '2034-01-06 01:00:00', 2, 1, null, 11, '2034-01-06 01:00:00', 3, 1),
('Advazon', 9, '2034-01-05 01:00:00', 3, 1, null, 9, '2034-01-05 01:00:00', 3, 1),
('Promante', 11, '2034-01-06 01:00:00', 3, 1, null, 7, '2034-01-06 01:00:00', 2, 1),
('Evantino', 13, '2034-01-05 01:00:00', 4, 2, null, 5, '2034-01-05 01:00:00', 2, 1),
('Advinco', 15, '2034-01-06 01:00:00', 4, 2, null, 3, '2034-01-06 01:00:00', 1, 1),
('Inforwer', 17, '2034-01-05 01:00:00', 5, 2, null, 1, '2034-01-05 01:00:00', 1, 1);


--CRUDOS

INSERT INTO crudo (contenido, tipo_contenido, resumen, fuente, valor_apreciacion, nivel_confiabilidad_inicial, nivel_confiabilidad_final, fecha_obtencion, fecha_verificacion_final, cant_analistas_verifican, fk_clas_tema, fk_informante, fk_estacion_pertenece, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente) VALUES
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen.jpg'), 'imagen', 'Problemas politicos en Vitnam I', 'secreta', 500, 85, 85 , '2034-01-05 01:00:00', '2034-12-02 17:00:00', 2, 1, 1, 1, 1, 1, 1, '2034-01-05 01:00:00', 1),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen.jpg'), 'imagen', 'Problemas politicos en Vitnam II', 'secreta', 550, 87, 10 , '2034-01-05 01:00:00', '2034-11-03 07:00:00', 2, 7, 2, 1, 1, 1, 1, '2034-01-06 01:00:00', 3),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen.jpg'), 'imagen', 'Consecuencias de problemas politicos por territorio', 'secreta', 560, 88, 90 , '2034-01-06 01:00:00', '2034-10-04 02:00:00', 2, 8, 3, 2, 1, 2, 1, '2034-01-05 01:00:00', 5),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen4.jpg'), 'imagen', 'Manifestaciones por cambio de leyes', 'secreta', 570, 85, 85 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 9, 4, 2, 1, 2, 1, '2034-01-06 01:00:00', 7),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen2.jpg'), 'imagen', 'Consecuencias de problemas politicos por petroleo en otros territorios', 'secreta', 580, 93, 90 , '2034-01-05 01:00:00', '2035-01-05 01:00:00', 2, 9, 5, 3, 1, 3, 1, '2034-01-05 01:00:00', 9),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen2.jpg'), 'imagen', 'Resultado de guerras entre paises ', 'secreta', 590, 85, 60 , '2034-01-06 01:00:00', '2034-07-07 05:00:00', 2, 8, 6, 3, 1, 3, 1, '2034-01-06 01:00:00', 11),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen2.jpg'), 'imagen', 'Consecuencias de problemas politicos ', 'secreta', 600, 90, 90 , '2034-01-06 01:00:00', '2034-11-03 07:00:00', 3, 9, 7, 4, 2, 4, 2, '2034-01-05 01:00:00', 13),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen4.jpg'), 'imagen', 'Manifestaciones por digustos de una población por el abuso de poder', 'secreta', 610, 85, 70 , '2034-01-05 01:00:00', '2034-10-04 02:00:00', 3, 9, 8, 4, 2, 4, 2, '2034-01-06 01:00:00', 15),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto2.txt'), 'texto', 'Conflictos entre paises por poder II', 'abierta', 620, 93, 90 , '2034-01-05 01:00:00', '2035-01-05 01:00:00', 2, 1, null, 5, 2, 5, 2, '2034-01-05 01:00:00', 17),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto2.txt'), 'texto', 'Conflictos entre paises por poder II', 'tecnica', 630, 88, 80 , '2034-01-06 01:00:00', '2035-01-05 01:00:00', 2, 1, null, 5, 2, 5, 2, '2034-01-06 01:00:00', 19),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto2.txt'), 'texto', 'Tension entre paises y sus consecuencias', 'secreta', 640, 90, 80 , '2034-01-05 01:00:00', '2034-02-28 07:00:00', 2, 1, 9, 6, 2, 6, 2, '2034-01-05 01:00:00', 21),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto2.txt'), 'texto', 'Resultados de los conflictos I', 'abierta', 650, 85, 85 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 8, null, 27, 9, 27, 9, '2034-01-05 01:00:00', 101),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'Resultados de los conflictos II', 'tecnica', 660, 88, 95 , '2034-01-06 01:00:00', '2035-01-05 01:00:00', 2, 8, null, 1, 1, 1, 1, '2034-01-05 01:00:00', 1),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'Resultados de conflictos entre grupo de personas', 'secreta', 670, 94, 60 , '2034-01-06 01:00:00', '2035-01-05 01:00:00', 2, 1, 10, 1, 1, 1, 1, '2034-01-06 01:00:00', 3),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'Resultados de conflictos entre grupo de personas II', 'abierta', 680, 88, 60 , '2034-01-06 01:00:00', '2034-02-28 07:00:00', 3, 8, null, 2, 1, 2, 1, '2034-01-05 01:00:00', 5),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/audio.mp3'), 'sonido', 'Agresion de grupo de personas en la via publica', 'tecnica', 690, 90, 90 , '2034-01-05 01:00:00', '2035-03-10 06:00:00', 3, 2, null, 2, 1, 2, 1, '2034-01-06 01:00:00', 7),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/audio.mp3'), 'sonido', 'Agresion de grupo de personas en la via publica', 'secreta', 700, 87, 85 , '2034-01-06 01:00:00', '2035-01-06 01:00:00', 2, 2, 11, 3, 1, 3, 1, '2034-01-05 01:00:00', 9),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/audio.mp3'), 'sonido', 'Conflictos en calle con individuos', 'abierta', 710, 95, 30 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 2, null, 3, 1, 3, 1, '2034-01-06 01:00:00', 11),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/formulas.mp4'), 'video', 'Formulas para las empresas', 'tecnica', 720, 87, 35 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 4, null, 4, 2, 4, 2, '2034-01-05 01:00:00', 13),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen3.png'), 'imagen', 'Planificacin de marketing', 'secreta', 730, 93, 66 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 3, 12, 4, 2, 4, 2, '2034-01-06 01:00:00', 15),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/planos.png'), 'imagen', 'Investigacion de planos para construcción', 'abierta', 740, 94, 45 , '2034-01-05 01:00:00', '2034-07-07 05:00:00', 2, 8, null, 5, 2, 5, 2, '2034-01-05 01:00:00', 17),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/planos.png'), 'imagen', 'Planificacion de marketing', 'tecnica', 750, 96, 90 , '2034-01-06 01:00:00', '2035-01-06 01:00:00', 2, 3, null, 5, 2, 5, 2, '2034-01-06 01:00:00', 19),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen3.png'), 'imagen', 'Organizacion de marketing', 'abierta', 760, 88, 89 , '2034-01-05 01:00:00', '2034-07-04 02:00:00', 3, 3, null, 6, 2, 6, 2, '2034-01-05 01:00:00', 21),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/planos.png'), 'imagen', 'Investigacion de planos para construcción', 'abierta', 770, 88, 88 , '2034-01-05 01:00:00', '2034-05-19 07:00:00', 3, 8, null, 1, 1, 1, 1, '2034-01-05 01:00:00', 1),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por problemas economicos', 'tecnica', 780, 90, 85 , '2034-01-05 01:00:00', '2036-01-06 01:00:00', 2, 8, null, 3, 1, 3, 1, '2034-01-06 01:00:00', 11),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por malas decisiones del directivo part I', 'secreta', 790, 98, 10 , '2034-01-05 01:00:00', '2036-01-06 01:00:00', 2, 6, 1, 4, 2, 4, 2, '2034-01-05 01:00:00', 13),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por malas decisiones del directivo part II', 'secreta', 800, 88, 90 , '2034-01-06 01:00:00', '2036-01-05 01:00:00', 2, 3, 3, 4, 2, 4, 2, '2034-01-06 01:00:00', 15),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por malas decisiones del directivo part I', 'secreta', 810, 98, 85 , '2034-01-05 01:00:00', '2036-01-06 01:00:00', 2, 8, 5, 5, 2, 5, 2, '2034-01-05 01:00:00', 17),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por malas decisiones del directivo part I', 'secreta', 820, 88, 90 , '2034-01-05 01:00:00', '2036-01-05 01:00:00', 2, 6, 7, 1, 1, 1, 1, '2034-01-05 01:00:00', 1);


-- ANALISTA_CRUDO

INSERT INTO analista_crudo (fecha_hora, nivel_confiabilidad, fk_crudo, fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista) VALUES
('2034-01-05 01:00:00', 85, 1, '2034-01-05 01:00:00',10,3,1),
('2034-12-02 17:00:00', 85, 1, '2034-01-05 01:00:00',6,2,1),
('2034-01-05 01:00:00', 90, 2, '2034-01-06 01:00:00',12,3,1),
('2034-11-03 07:00:00', 85, 2, '2034-01-05 01:00:00',6,2,1),
('2034-01-06 01:00:00', 85, 3, '2034-01-05 01:00:00',10,3,1),
('2034-10-04 02:00:00', 90, 3, '2034-01-05 01:00:00',18,5,2),
('2034-01-05 01:00:00', 90, 4, '2034-01-05 01:00:00',10,3,1),
('2035-01-06 01:00:00', 80, 4, '2034-01-05 01:00:00',14,4,2),
('2034-01-05 01:00:00', 90, 5, '2034-01-05 01:00:00',14,4,2),
('2035-01-05 01:00:00', 95, 5, '2034-01-05 01:00:00',2,1,1),
('2034-01-06 01:00:00', 85, 6, '2034-01-06 01:00:00',16,4,2),
('2034-07-07 05:00:00', 85, 6, '2034-01-05 01:00:00',18,5,2),
('2034-01-06 01:00:00', 90, 7, '2034-01-06 01:00:00',20,5,2),
('2034-01-06 01:00:00', 90, 7, '2034-01-06 01:00:00',12,3,1),
('2034-11-03 07:00:00', 90, 7, '2034-01-05 01:00:00',26,7,3),
('2034-01-05 01:00:00', 85, 8, '2034-01-05 01:00:00',102,27,9),
('2034-01-05 01:00:00', 85, 8, '2034-01-05 01:00:00',10,3,1),
('2034-10-04 02:00:00', 85, 8, '2034-01-05 01:00:00',6,2,1),
('2034-01-05 01:00:00', 90, 9, '2034-01-05 01:00:00',2,1,1),
('2035-01-05 01:00:00', 95, 9, '2034-01-05 01:00:00',6,2,1),
('2034-01-06 01:00:00', 95, 10, '2034-01-06 01:00:00',16,4,2),
('2035-01-05 01:00:00', 80, 10, '2034-01-05 01:00:00',2,1,1),
('2034-01-05 01:00:00', 90, 11, '2034-01-05 01:00:00',26,7,3),
('2034-02-28 07:00:00', 90, 11, '2034-01-05 01:00:00',30,8,3),
('2034-01-05 01:00:00', 85, 12, '2034-01-05 01:00:00',30,8,3),
('2035-01-06 01:00:00', 85, 12, '2034-01-05 01:00:00',34,9,3),
('2034-01-06 01:00:00', 90, 13, '2034-01-06 01:00:00',40,10,4),
('2035-01-05 01:00:00', 85, 13, '2034-01-05 01:00:00',42,11,4),
('2034-01-06 01:00:00', 90, 14, '2034-01-06 01:00:00',44,11,4),
('2035-01-05 01:00:00', 97, 14, '2034-01-05 01:00:00',46,12,4),
('2034-01-06 01:00:00', 90, 15, '2034-01-06 01:00:00',48,12,4),
('2034-01-05 01:00:00', 90, 15, '2034-01-05 01:00:00',50,13,5),
('2034-02-28 07:00:00', 85, 15, '2034-01-05 01:00:00',54,14,5),
('2034-01-05 01:00:00', 90, 16, '2034-01-05 01:00:00',14,4,2),
('2035-01-05 01:00:00', 90, 16, '2034-01-06 01:00:00',28,7,3),
('2035-03-10 06:00:00', 90, 16, '2034-01-05 01:00:00',42,11,4),
('2034-01-06 01:00:00', 85, 17, '2034-01-06 01:00:00',40,10,4),
('2035-01-06 01:00:00', 88, 17, '2034-01-06 01:00:00',20,5,2),
('2034-01-05 01:00:00', 90, 18, '2034-01-05 01:00:00',2,1,1),
('2035-01-06 01:00:00', 100, 18, '2034-01-06 01:00:00',8,2,1),
('2034-01-05 01:00:00', 80, 19, '2034-01-05 01:00:00',22,6,2),
('2035-01-06 01:00:00', 94, 19, '2034-01-06 01:00:00',20,5,2),
('2034-01-05 01:00:00', 90, 20, '2034-01-05 01:00:00',6,2,1),
('2035-01-06 01:00:00', 96, 20, '2034-01-05 01:00:00',2,1,1),
('2034-01-05 01:00:00', 90, 21, '2034-01-06 01:00:00',16,4,2),
('2034-07-07 05:00:00', 98, 21, '2034-01-06 01:00:00',12,3,1),
('2034-01-06 01:00:00', 95, 22, '2034-01-06 01:00:00',24,6,2),
('2035-01-06 01:00:00', 96, 22, '2034-01-06 01:00:00',40,10,4),
('2034-01-05 01:00:00', 80, 23, '2034-01-05 01:00:00',2,1,1),
('2034-01-06 01:00:00', 95, 23, '2034-01-06 01:00:00',20,5,2),
('2034-07-04 02:00:00', 90, 23, '2034-01-05 01:00:00',6,2,1),
('2034-01-05 01:00:00', 80, 24, '2034-01-05 01:00:00',30,8,3),
('2034-03-05 01:00:00', 90, 24, '2034-01-06 01:00:00',12,3,1),
('2034-05-19 07:00:00', 95, 24, '2034-01-05 01:00:00',66,17,6),
('2034-01-05 01:00:00', 95, 25, '2034-01-05 01:00:00',2,1,1),
('2036-01-06 01:00:00', 85, 25, '2034-01-05 01:00:00',14,4,2),
('2034-01-05 01:00:00', 97, 26, '2034-01-05 01:00:00',2,1,1),
('2036-01-06 01:00:00', 98, 26, '2034-01-05 01:00:00',6,2,1),
('2034-01-06 01:00:00', 85, 27, '2034-01-06 01:00:00',8,2,1),
('2036-01-05 01:00:00', 90, 27, '2034-01-05 01:00:00',18,5,2),
('2034-01-05 01:00:00', 97, 28, '2034-01-05 01:00:00',10,3,1),
('2036-01-06 01:00:00', 98, 28, '2034-01-05 01:00:00',14,4,2),
('2034-01-05 01:00:00', 89, 29, '2034-01-05 01:00:00',14,4,2),
('2036-01-05 01:00:00', 87, 29, '2034-01-05 01:00:00',10,3,1);





--TRANSACCION_PAGO

INSERT INTO TRANSACCION_PAGO (fecha_hora, monto_pago, fk_crudo, fk_informante) VALUES
(' 2034-01-08 01:00:00',250,1,1),
(' 2034-01-09 01:00:00',260,2,2),
(' 2035-01-08 01:00:00',270,3,3),
(' 2035-01-09 01:00:00',280,4,4),
(' 2035-01-10 01:00:00',290,5,5),
(' 2035-01-09 01:00:00',300,6,6),
(' 2035-01-11 01:00:00',310,7,7),
(' 2035-02-10 01:00:00',320,8,8),
(' 2035-06-05 01:00:00',320,11,9),
(' 2036-01-20 01:00:00',335,14,10),
(' 2036-03-12 01:00:00',350,17,11),
(' 2036-03-05 01:00:00',365,20,12);



-- PIEZA

INSERT INTO PIEZA_INTELIGENCIA (fecha_creacion, nivel_confiabilidad,  precio_base, class_seguridad,
                                fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista,
                                fk_oficina_principal_analista, fk_clas_tema)
                                VALUES
    ('2034-12-02 17:00:00', 90, 1000, 'no_clasificado', '2034-01-05 01:00:00', 2,1,1,1), --CHECK 1
    ('2034-11-03 07:00:00', 88, 1222, 'confidencial', '2034-01-06 01:00:00', 4,1,1,2), --CHECK 2
    ('2034-10-04 02:00:00', 78, 1234, 'no_clasificado', '2034-01-05 01:00:00', 2,1,1,3), --CHECK 3
    ('2035-02-05 03:00:00', 77, 1111, 'no_clasificado', '2034-01-06 01:00:00', 4,1,1,4), --CHECK 4
    ('2035-08-06 04:00:00', 67, 1245, 'top_secret', '2035-03-09 07:00:00', 1,1,1,5), --CHECK 5
    ('2034-07-07 05:00:00', 56, 1234, 'no_clasificado', '2034-01-05 01:00:00', 2,1,1,5), --CHECK 6
    ('2035-06-08 06:00:00', 10, 1249, 'confidencial', '2035-03-12 07:00:00', 3,1,1,6), --CHECK 7
    ('2036-05-09 07:00:00', 99, 1234, 'no_clasificado', '2035-03-09 07:00:00', 5,2,1,7), --CHECK 8
    ('2035-01-09 08:00:00', 100, 999, 'no_clasificado', '2034-01-05 01:00:00', 2,1,1,6), --CHECK 9
    ('2036-01-29 17:00:00', 90, 1000, 'no_clasificado', '2035-03-12 07:00:00', 7,2,1,1), --CHECK 10
    ('2034-02-28 07:00:00', 88, 1222, 'confidencial', '2034-01-06 01:00:00', 4,1,1,7), --CHECK 11
    ('2035-03-27 02:00:00', 78, 1234, 'confidencial', '2035-03-09 07:00:00', 9,3,1,2), --CHECK 12
    ('2035-04-26 03:00:00', 77, 1111, 'top_secret', '2035-03-09 07:00:00', 101,27,9,3), --CHECK 13
    ('2035-05-25 04:00:00', 67, 1245, 'no_clasificado', '2035-03-12 07:00:00', 99,26,9,4), --CHECK 14
    ('2035-06-24 05:00:00', 56, 1234, 'confidencial', '2035-03-09 07:00:00', 97,26,9,6), --CHECK 15
    ('2035-03-10 06:00:00', 10, 1249, 'no_clasificado', '2034-01-06 01:00:00', 4,1,1,1), --CHECK 16
    ('2036-08-22 07:00:00', 99, 1234, 'no_clasificado', '2035-03-12 07:00:00', 95,25,9,4), --CHECK 17
    ('2035-01-21 08:00:00', 100, 999, 'no_clasificado', '2034-01-06 01:00:00', 4,1,1,2), --CHECK 18
    ('2034-03-20 17:00:00', 90, 1000, 'no_clasificado', '2034-01-05 01:00:00', 102,27,9,1), --CHECK 19 
    ('2034-05-19 07:00:00', 88, 1222, 'confidencial', '2034-01-06 01:00:00', 100,27,9,2), --CHECK 20
    ('2034-07-18 02:00:00', 78, 1234, 'no_clasificado', '2034-01-05 01:00:00', 98,26,9,3), --CHECK 21
    ('2035-01-17 03:00:00', 77, 1111, 'confidencial', '2034-01-06 01:00:00', 96,25,9,4), --CHECK 22
    ('2035-03-01 04:00:00', 67, 1245, 'no_clasificado', '2034-01-05 01:00:00', 94,25,9,5), --CHECK 23
    ('2035-01-15 05:00:00', 56, 1234, 'confidencial', '2034-01-06 01:00:00', 92,24,8,6), --CHECK 24
    ('2035-02-14 06:00:00', 10, 1249, 'no_clasificado', '2034-01-05 01:00:00', 90,23,8,7), --CHECK 25
    ('2034-03-13 07:00:00', 99, 1234, 'no_clasificado', '2034-01-05 01:00:00', 86,22,8,1), --CHECK 26
    ('2035-02-18 08:00:00', 100, 999, 'no_clasificado', '2034-01-05 01:00:00', 34,9,3,2) --CHECK 27
;




-- ADQUISICION

INSERT INTO ADQUISICION (fecha_hora_venta, precio_vendido, fk_cliente, fk_pieza_inteligencia) VALUES

-- clientes exclusivos: 1, 2, 5, 6, 9, 10, 13, 14, 17, 18
-- Una pieza de inteligencia de venta exclusiva tiene al menos el 45% de recargo de su precio base.

    ('2035-12-02 17:00:00', 1544, 1, 1),
    ('2034-12-04 07:00:00', 1870, 1, 2),
    ('2034-12-05 02:00:00', 1820, 1, 3),
    ('2036-09-06 03:00:00', 1700, 2, 4),
    ('2035-08-16 04:00:00', 1850, 2, 5),
    ('2036-02-12 17:00:00', 1500, 5, 10),
    ('2034-03-28 07:00:00', 1880, 6, 11),
    ('2035-09-02 04:00:00', 1966, 10, 14),
    ('2035-12-22 17:00:00', 2030, 9, 16),
    ('2034-12-05 02:00:00', 1987, 10, 12), 

-- no exclusivos:

    ('2035-11-07 05:00:00', 2000, 3, 6),
    ('2035-07-08 06:00:00', 1400, 3, 7),
    ('2036-05-19 07:00:00', 1280, 3, 8),
    ('2036-06-09 08:00:00', 1001, 4, 9),
    ('2035-04-27 02:00:00', 1303, 7, 17),
    ('2035-07-26 03:00:00', 1122, 8, 13),
    ('2036-02-24 05:00:00', 1456, 12, 15),
    ('2034-12-04 07:00:00', 1666, 11, 6), 
    ('2036-09-06 03:00:00', 1440, 20, 15),
    ('2035-08-16 04:00:00', 1333, 4, 7), 
    ('2035-11-07 05:00:00', 2000, 7, 8),
    ('2035-07-08 06:00:00', 1111, 8, 18),
    ('2036-05-19 07:00:00', 1281, 11, 8),
    ('2036-06-09 08:00:00', 1233, 12, 19),
    ('2036-02-12 17:00:00', 1200, 15, 19),
    ('2034-03-28 07:00:00', 1770, 16, 20),
    ('2035-04-27 02:00:00', 1322, 16, 21),
    ('2035-07-26 03:00:00', 2222, 16, 13),
    ('2035-09-02 04:00:00', 1800, 19, 25),
    ('2036-02-24 05:00:00', 1777, 20, 26)
    ;




-- CRUDO-PIEZA

INSERT INTO CRUDO_PIEZA ( fk_pieza_inteligencia, fk_crudo) VALUES
    
    -- Exclusivos:
    (1, 1), 
    (1, 6),  
    (1, 20), 
    (2, 2),  
    (2, 7),  
    (2, 21), 
    (3, 3),  
    (3, 8), 
    (3, 23),  
    (4, 4),  
    (4, 9),  
    (5, 5),  
    (5, 12),  
    (10, 10),  
    (10, 13), 
    (11, 11), 
    (11, 15),  
    (12, 22), 
    (12, 19), 
    (14, 14), 
    (14, 17), 
    (16, 16), 
    (16, 18), 


    (6,24),
    (6,25),
    (6,26),
    (7,25),
    (7,27),
    (7,29),
    (8,24),
    (8,26),
    (9,29),
    (9,25),
    (9,27),
    (9,24),
    (13,24),
    (13,26),
    (13,29),
    (15,25),
    (15,26),
    (17,24),
    (17,28),
    (17,29),
    (18,26),
    (18,25),
    (19,25),
    (19,27),
    (19,28),
    (20,24),
    (20,29),
    (21,25),
    (21,28),
    (21,26),
    (21,27),
    (21,29),
    (22,26),
    (22,25),
    (22,28),
    (23,26),
    (23,29),
    (24,24),
    (24,28),
    (25,26),
    (25,25),
    (25,28),
    (26,26),
    (26,28),
    (27,25),
    (27,27),
    (27,29),
    (27,24)
    ;



-- INTENTO NO AUTORIZADO

INSERT INTO INTENTO_NO_AUTORIZADO (fecha_hora, id_pieza,  id_empleado, fk_personal_inteligencia) VALUES

    ('2034-01-01 01:00:00', 2, 11, 2),   -- Est. Dublin. Fk lugar: 10. C
    ('2034-02-07 01:00:00', 5, 12, 5),   -- Est. Cork. 11. T
    ('2034-02-02 01:00:00', 7, 13, 10),  -- Est. Galway. 12. C
    ('2034-03-01 01:00:00', 11, 14, 14), -- Est. Amsterdam 13. C
    ('2035-06-22 01:00:00', 12, 15, 18), -- Est. Roterdam 14. C
    ('2035-09-11 01:00:00', 13, 16, 24), -- Est. Haarlam 15. T
    ('2035-10-21 01:00:00', 15, 17, 26), -- Est. Nuuk 16. C
    ('2035-11-30 01:00:00', 20, 18, 30), -- Est. Qaqortoq 17. C
    ('2035-12-06 01:00:00', 22, 19, 34), -- Est. Sisimiut 18. C
    ('2036-01-13 01:00:00', 24, 20, 39)  -- Est. Buenos Aires 19. C 
;
   
   
   

---------------------------------------------------------------------------- ----------------------------------------------------
-------------------------------------- BLOQUE PARA RESTAR 14 AÑOS A TODAS LAS FECHAS ---------------------------------------------
---------------------------------------------------------------------------- ----------------------------------------------------



WITH 
	a AS (
   		UPDATE HIST_CARGO SET fecha_inicio = RESTA_14_FECHA_HORA(fecha_inicio), fecha_fin = RESTA_14_FECHA_HORA(fecha_fin)
    ), b as (
   		UPDATE CRUDO SET fecha_obtencion = RESTA_14_FECHA_HORA(fecha_obtencion), fecha_verificacion_final = RESTA_14_FECHA_HORA(fecha_verificacion_final), fk_fecha_inicio_agente = RESTA_14_FECHA_HORA(fk_fecha_inicio_agente) 
	), c as (
		UPDATE TRANSACCION_PAGO SET fecha_hora = RESTA_14_FECHA_HORA(fecha_hora) 
	), d as (
		UPDATE ANALISTA_CRUDO SET fecha_hora = RESTA_14_FECHA_HORA(fecha_hora) , fk_fecha_inicio_analista = RESTA_14_FECHA_HORA(fk_fecha_inicio_analista)
	), e as (
		UPDATE PIEZA_INTELIGENCIA SET fecha_creacion = RESTA_14_FECHA_HORA(fecha_creacion) , fk_fecha_inicio_analista = RESTA_14_FECHA_HORA(fk_fecha_inicio_analista)
	), f as (
		UPDATE ADQUISICION SET fecha_hora_venta = RESTA_14_FECHA_HORA(fecha_hora_venta)
	), g as (
		UPDATE PERSONAL_INTELIGENCIA SET fecha_nacimiento = RESTA_14_FECHA(fecha_nacimiento)
	), i as (
		UPDATE INFORMANTE SET fk_fecha_inicio_encargado = RESTA_14_FECHA_HORA(fk_fecha_inicio_encargado), fk_fecha_inicio_confidente = RESTA_14_FECHA_HORA(fk_fecha_inicio_confidente)
--	), j AS (
--   		UPDATE HIST_CARGO_ALT SET fecha_inicio = RESTA_14_FECHA_HORA(fecha_inicio), fecha_fin = RESTA_14_FECHA_HORA(fecha_fin)
    ), k as (
   		UPDATE CRUDO_ALT SET fecha_obtencion = RESTA_14_FECHA_HORA(fecha_obtencion), fk_fecha_inicio_agente = RESTA_14_FECHA_HORA(fk_fecha_inicio_agente) 
	), l as (
		UPDATE TRANSACCION_PAGO_ALT SET fecha_hora = RESTA_14_FECHA_HORA(fecha_hora) 
	), m as (
		UPDATE PIEZA_INTELIGENCIA_ALT SET fecha_creacion = RESTA_14_FECHA_HORA(fecha_creacion) , fk_fecha_inicio_analista = RESTA_14_FECHA_HORA(fk_fecha_inicio_analista)
	), n as (
		UPDATE ADQUISICION_ALT SET fecha_hora_venta = RESTA_14_FECHA_HORA(fecha_hora_venta)
	), o as (
		UPDATE CUENTA SET año = RESTA_14_FECHA(año)
	), p as (
		UPDATE INFORMANTE_ALT SET fk_fecha_inicio_encargado = RESTA_14_FECHA_HORA(fk_fecha_inicio_encargado)
	)
UPDATE INTENTO_NO_AUTORIZADO SET fecha_hora = RESTA_14_FECHA_HORA(fecha_hora);	




----------------------------------------------------------------------------------------------------------
------------------------------------- BLOQUE PARA COPIAR VENTAS EXCLUSIVAS -----------------------------
-----------------------------------------------------------------------------------------------------------


CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (11);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (2);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (3);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (12);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (5);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (14);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (1);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (16);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (10);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (4);







----------///////////- ---------------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- CREACION DE PROCEDIMIENTOS Y FUNCIONES RELACIONADOS A VALIDACIONES Y ATRIBUTOS OO   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- --------------------------------------------------------------------------------------------------------------- ///////////----------



CREATE OR REPLACE FUNCTION FU_OBTENER_EDAD(pd_fecha_ini DATE, pd_fecha_fin DATE)
RETURNS INTEGER
LANGUAGE 'plpgsql' 
AS $$
BEGIN

	RETURN FLOOR(((DATE_PART('YEAR',pd_fecha_fin)-DATE_PART('YEAR',pd_fecha_ini))* 372 + (DATE_PART('MONTH',pd_fecha_fin) - DATE_PART('MONTH',pd_fecha_ini))*31 + (DATE_PART('DAY',pd_fecha_fin)-DATE_PART('DAY',pd_fecha_ini)))/372);
	
END
$$;




--- FUNCION VALIDAR EDAD ---
CREATE OR REPLACE FUNCTION FUNCION_EDAD(fecha_nacimiento date)
RETURNS BOOLEAN
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE
	
	fecha_va integer;
		
BEGIN
	
	fecha_va = FU_OBTENER_EDAD (fecha_nacimiento, NOW()::DATE);
	
	IF (fecha_va < 26 ) THEN
	
		RAISE INFO 'NO ES LA EDAD PERMITIDA PARA SER UN PERSONAL DE INTELIGENCIA, MINIMO DEBES TENER 26 AÑOS DE EDAD';		
		-- RAISE EXCEPTION 'NO ES LA EDAD PERMITIDA PARA SER UN PERSONAL DE INTELIGENCIA, MINIMO DEBES TENER 26 AÑOS DE EDAD';		
		RETURN FALSE;
		
	ELSIF ( fecha_va > 80 ) THEN
	
		RAISE INFO 'EDAD: %', fecha_va;
		-- RAISE EXCEPTION 'NO ES POSIBLE EN EL RANGO DE EDADES';
		RETURN FALSE;
		
	ELSE 		
	
		RETURN TRUE;
		
	END IF;
END
$$;


-- IF (FUNCION_EDAD('2000-12-12') = true) THEN



CREATE OR REPLACE FUNCTION CREAR_CONTACTO (primer_nombre varchar,segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar, direccion varchar, codigo numeric, numero numeric)
RETURNS contacto_ty
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE
	
	telefono telefono_ty;
BEGIN

	IF (primer_nombre IS NULL OR primer_nombre = ' ') THEN
		RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE CONTACTO';
	END IF;
	
	IF ((primer_apellido IS NULL OR primer_apellido = ' ') AND (segundo_apellido IS NULL OR segundo_apellido = ' ')) THEN
		RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
	END IF;
	
	IF (direccion = ' ' OR direccion IS NULL) THEN
		RAISE EXCEPTION 'EL CONTACTO DEBE DIRECCION';
	END IF;
	
	telefono = CREAR_TELEFONO(codigo,numero);
	
	RETURN ROW(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, direccion, telefono)::contacto_ty;
	
END $$;
			   
-- SELECT CREAR_CONTACTO ('Gabriel','alberto,','manrique','ulacio','Av La vega, calle sur',0414,0176620);



---INSERTAR EN EL ARRAY DE ALIAS TIPO ALIAS_TY ---
CREATE OR REPLACE FUNCTION CREAR_ALIAS(primer_nombre varchar, segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar, foto bytea, fecha timestamp, pais varchar, documento numeric, color_ojos varchar, direccion varchar, ultimo_uso timestamp)
RETURNS alias_ty[]
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE
	ATRIBUTOS_ALIAS alias_ty;
	ALIASES alias_ty[];
BEGIN
	
		RAISE INFO 'EL ALIAS ES UNA IDENTIFICACIÓN FALSA DEL AGENTE DE CAMPO, PROCURE INSERTAR LA INFORMACIÓN COMPLETA';
		
	---- VALIDAR LA FECHA DEL PERSONAL DE INTELIGENCIA MAYOR DE 26 AÑOS ------
		IF (FUNCION_EDAD(fecha::DATE) IS  NULL) THEN	
	---MENOR DE 26 AÑOS
			RAISE EXCEPTION 'NO ES PERMITIDO LA EDAD DEL PERSONAL';
			RETURN NULL;		

		ELSE
	
			---MAYOR DE 26 AÑOS		
			RAISE INFO 'EDAD PERMITIDA PARA INGRESO DE PERSONAL';	
			
			---VALIDACION DEL NOMBRE COMPELTO---
			
			IF (primer_nombre IS NULL OR primer_nombre = ' ')THEN
				RAISE EXCEPTION 'ALIAS NO TIENE PRIMER NOMBRE';
			END IF;

			IF ((primer_apellido IS NULL OR primer_apellido = ' ') AND (segundo_apellido IS NULL OR segundo_apellido = ' ')) THEN
				RAISE EXCEPTION 'EL ALIAS DEBE TENER LOS DOS APELLIDOS COMPLETOS';
			END IF;
		
			---VALIDACIÓN DE FOTO IDENTIDAD---
			
			IF	(foto IS NULL ) THEN
				RAISE EXCEPTION 'EL ALIAS DEBE TENER UNA FOTO';
			END IF;
		
			---VALIDACIÓN DEL COUMENTO DE IDENTIDAD ---
			
			IF (documento IS NULL) THEN
				RAISE EXCEPTION 'ALIAS, NUMERO DE ID DE DOCUMENTO ESTA VACIO';
			END IF;

			IF (pais IS NULL OR pais = ' ') THEN
				RAISE EXCEPTION 'ALIAS,EL PAIS DEL DOCUMENTO DE INDENTIFICACION ESTA VACIO';			
			END IF;
			
			---VALIDACIÓN DEL COLOR DE OJOS ---
			
			IF (color_ojos IS NULL OR color_ojos = ' ')THEN
				RAISE EXCEPTION 'DEBE TENER COLOR DE OJOS EL ALIAS';
			END IF;
			
			---VALIDACIÓN DE DIRECCION, ES VARCHAR ---
			
			IF (direccion IS NULL OR direccion = '') THEN
				RAISE EXCEPTION 'EL ALIAS DEBE TENER UNA DIRECCION';
			END IF;
			
			ATRIBUTOS_ALIAS = ROW(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, foto, fecha, pais, documento, color_ojos, direccion, ultimo_uso)::alias_ty;			
			
			ALIASES = array_append(ALIASES,ATRIBUTOS_ALIAS);
			
		RETURN ALIASES;
		
		END IF;		

END

$$;

-- DROP FUNCTION CREAR_ALIAS(varchar, varchar, varchar, varchar,  bytea, timestamp, varchar, numeric, varchar, varchar, timestamp)

-- SELECT CREAR_ALIAS('Bertrudis','Viviana','Sanchez','Serna','personal_inteligencia_data/foto.png','1993-09-21','Argentina',39794059,'marrón oscuro','Tucson, AZ 85718','2035-04-09 07:00:00')
-- SELECT CREAR_ALIAS('Bertrudis','Viviana','Sanchez','Serna',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1993-09-21','Argentina',39794059,'marrón oscuro','Tucson, AZ 85718','2035-04-09 07:00:00')




----CREAR TELEFONOO ----

CREATE OR REPLACE FUNCTION CREAR_TELEFONO (codigo numeric(10), numero NUMERIC(15))
RETURNS telefono_ty
LANGUAGE plpgsql
SECURITY DEFINER
AS $$ 
BEGIN

	IF (codigo IS NULL OR codigo = 0) THEN
		RAISE EXCEPTION 'El codigo del telefono no puede ser nulo';
	END IF;

	IF (numero IS NULL OR numero = 0) THEN
		RAISE EXCEPTION 'El numero del telefono no puede ser nulo';
	END IF;

 	RETURN ROW(codigo,numero)::telefono_ty; 

END $$;


-- SELECT CREAR_TELEFONO(0212,20121312);
---CREAR LICENCIA ----


CREATE OR REPLACE FUNCTION CREAR_LICENCIA (numero varchar, pais varchar)
RETURNS licencia_ty
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
BEGIN
	IF (numero IS NULL OR numero = ' ') THEN
		RAISE EXCEPTION 'EL NUMERO DE LA LICENCIA ES NULO';
	END IF;
	
	IF (pais IS NULL OR pais = ' ') THEN
		RAISE EXCEPTION 'LA LICENCIA DEBE TENER UN PAIS';
	END IF;
	RETURN ROW(numero,pais)::licencia_ty;

END
$$;

-- SELECT CREAR_LICENCIA('1233992432','Uganda');

---CREAR FAMILIAR ---

CREATE OR REPLACE FUNCTION CREAR_FAMILIAR (primer_nombre varchar,segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar,fecha_nacimiento timestamp, parentesco varchar, codigo numeric, numero numeric)
RETURNS familiar_ty
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE
	fecha_va integer;
	telefono telefono_ty;
BEGIN

	fecha_va = FU_OBTENER_EDAD (fecha_nacimiento::DATE, NOW()::DATE);
		
	IF (primer_nombre IS NULL OR primer_nombre = ' ') THEN
		RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE FAMILIAR';
	END IF;
	
	IF ((primer_apellido IS NULL OR primer_apellido = ' ') AND (segundo_apellido IS NULL OR segundo_apellido = ' ')) THEN
		RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
	END IF;
	
	IF (fecha_va < 18) THEN
		RAISE INFO 'NO ES LA EDAD PERMITIDA PARA SER FAMILIAR DE UN PERSONAL DE INTELIGENCIA, MINIMO DEBE TENER 26 AÑOS DE EDAD';		
		RAISE EXCEPTION 'NO ES LA EDAD PERMITIDA PARA SER FAMILIAR DE UN PERSONAL DE INTELIGENCIA, MINIMO DEBE TENER 26 AÑOS DE EDAD';		
		
	ELSIF (fecha_va > 120) THEN
		RAISE INFO 'EDAD: %', fecha_va;
		RAISE EXCEPTION 'NO ES POSIBLE EL INGRESO DE EDAD';
	END IF;		
	
	IF (parentesco = ' ' OR parentesco IS NULL) THEN
		RAISE EXCEPTION 'EL FAMILIAR DEBE TENER UN PARENTESCO CON EL PERSONAL DE INTELIGENCIA ';
	END IF;
	
	telefono = CREAR_TELEFONO(codigo,numero);
	
	RETURN ROW(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,fecha_nacimiento, parentesco, telefono)::familiar_ty;
	
END
$$;
			   
-- SELECT CREAR_FAMILIAR ('Gabriel','alberto,','manrique','ulacio','1960-06-01','tio',0414,0176620);

---CREAR IDENTIFICACION-----

CREATE OR REPLACE FUNCTION CREAR_IDENTIFICACION (documento varchar, pais varchar)
RETURNS identificacion_ty
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
BEGIN 
	
	IF (documento IS NULL OR documento = ' ') THEN
		RAISE INFO 'NUMERO DE ID DE DOCUMENTO ESTA VACIO';
	END IF;
	
	IF (pais IS NULL OR pais = ' ') THEN
		RAISE INFO 'EL PAIS DEL DOCUMENTO DE INDENTIFICACION ESTA VACIO';			
	END IF;
	
	RETURN ROW(documento,pais)::identificacion_ty;

END
$$;

-- select CREAR_IDENTIFICACION('0213120431','Australia');
-- select ver_lugares();

--- CREAR NIVEL EDUCATIVO ----

CREATE OR REPLACE FUNCTION CREAR_NIVEL_EDUCATIVO (pregrado_titulo varchar, postgrado_tipo varchar, postgrado_titulo varchar)
RETURNS nivel_educativo_ty
LANGUAGE PLPGSQL
SECURITY DEFINER
AS 
$$
BEGIN
	IF (pregrado_titulo IS NULL OR pregrado_titulo = ' ') THEN
		RAISE EXCEPTION 'EL PERSONAL NO TIENE NIVEL DE PREGRADO';
	END IF;
	
	-- IF (postgrado_tipo IS NULL OR postgrado = ' ') THEN
	-- 	RAISE EXCEPTION 'EL PERSONAL NO TIENE TIPO DE POSTGRADO';
	-- END IF;
	
	-- IF (postgreado_titulo IS NULL OR postgreado_titulo = ' ') THEN
	-- 	RAISE EXCEPTION ' EL PERSONAL NO TIENE TITULO DE POSTGRADO';
	-- END IF;
	
	RETURN ROW(pregrado_titulo,postgrado_tipo,postgrado_titulo)::nivel_educativo_ty;
END
$$;

-- select CREAR_NIVEL_EDUCATIVO('Economía', 'Master', 'Finanzas');
-- select CREAR_NIVEL_EDUCATIVO('Ingeniería Industrial',null,null);
-- select CREAR_NIVEL_EDUCATIVO('Ingeniería Informática',null,null);



---------------//////////////----------------////////////////---------------------




CREATE OR REPLACE FUNCTION CREAR_ARRAY_IDIOMAS (idioma_1 IN varchar(50),idioma_2 IN varchar(50),idioma_3 IN varchar(50),idioma_4 IN varchar(50),idioma_5 IN varchar(50),idioma_6 IN varchar(50))
RETURNS varchar(50)[] 
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE

    idiomas_va varchar(50)[];

BEGIN

    IF (    idioma_1 IS NOT NULL AND idioma_1 != '' 
        AND idioma_2 IS NOT NULL AND idioma_2 != '' 
        AND idioma_3 IS NOT NULL AND idioma_3 != '' 
        AND idioma_4 IS NOT NULL AND idioma_4 != '' ) THEN 

        idiomas_va = array_append(idiomas_va, idioma_1);
        idiomas_va = array_append(idiomas_va, idioma_2);
        idiomas_va = array_append(idiomas_va, idioma_3);
        idiomas_va = array_append(idiomas_va, idioma_4);

    ELSE 

        RAISE EXCEPTION 'Los cuatro primeros elementos nos pueden ser nulos ni vacios';

    END IF;

    IF (    idioma_5 IS NOT NULL AND idioma_5 != '' 
        AND idioma_6 IS NOT NULL AND idioma_6 != '' ) THEN 

        idiomas_va = array_append(idiomas_va, idioma_5);
        idiomas_va = array_append(idiomas_va, idioma_6);
    END IF;

	RETURN idiomas_va;

END $$;

-- SELECT CREAR_ARRAY_IDIOMAS('español','italiano','chino','portugués',null,null);






----------///////////- ---------------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- CREACION DE PROCEDIMIENTOS Y FUNCIONES RELACIONADOS AL ROL DIRECTOR DE DIRECTOR EJECUTIVO   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- --------------------------------------------------------------------------------------------------------------- ///////////----------


--DROP FUNCTION VER_DIRECTOR_AREA;

CREATE OR REPLACE FUNCTION VER_LUGAR (id_lugar in integer)
RETURNS LUGAR
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	SELECT * FROM LUGAR WHERE id = id_lugar; 
$$;


--
--select VER_DIRECTOR_AREA(8);

--DROP FUNCTION VER_DIRECTOR_AREA;

CREATE OR REPLACE FUNCTION VER_LUGARES ()
RETURNS setof LUGAR
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	SELECT * FROM LUGAR; 
$$;




CREATE OR REPLACE PROCEDURE CREAR_LUGAR (nombre_va IN LUGAR.nombre%TYPE, tipo_va in LUGAR.tipo%TYPE, region_va in LUGAR.region%TYPE, id_lugar_sup IN LUGAR.fk_lugar%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_LUGAR ( % ) ------', NOW();
	

	INSERT INTO LUGAR (
		nombre,
		tipo,
		region,
		fk_lugar
	) VALUES (
		nombre_va,
		tipo_va,
		region_va,
		id_lugar_sup
	);

END $$;

-- call CREAR_LUGAR('Perú','pais','america_sur',null);
-- select * from ver_lugares();
-- CALL CREAR_LUGAR('prueba',20, 2);
-- SELECT * FROM lugar order by id desc; 
-- select * from lugar where id = 2;
-- select * from EMPLEADO_JEFE where id = 20;



CREATE OR REPLACE PROCEDURE ELIMINAR_LUGAR (id_lugar IN INTEGER)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	-- empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--	lugar_reg LUGAR%ROWTYPE;
	-- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';

BEGIN 


	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_LUGAR ( % ) ------', NOW();
	
	DELETE FROM LUGAR WHERE id = id_lugar; 
	
   	RAISE INFO 'LUGAR ELIMINADA CON EXITO!';
 

END $$;



-- CALL ELIMINAR_LUGAR(15)


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/

CREATE OR REPLACE PROCEDURE ACTUALIZAR_LUGAR (id_lugar IN integer,nombre_va IN LUGAR.nombre%TYPE, tipo_va in LUGAR.tipo%TYPE, region_va in LUGAR.region%TYPE, id_lugar_sup IN LUGAR.fk_lugar%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	lugar_reg LUGAR%ROWTYPE;
 
BEGIN 

	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ACTUALIZAR_LUGAR ( % ) ------', NOW();
	
	SELECT * INTO lugar_reg FROM LUGAR WHERE id = id_lugar;

	IF (lugar_reg IS NULL) THEN
		RAISE INFO 'La lugar no existe';
		RAISE EXCEPTION 'La lugar no existe';
	END IF;


	UPDATE LUGAR SET 
		nombre = nombre_va,
		tipo = tipo_va,
		region = region_va,
		fk_lugar = id_lugar_sup
	
	WHERE id = id_lugar
	RETURNING * INTO lugar_reg;
	
	-------------////////


   RAISE INFO 'LUGAR MODIFICADA CON EXITO';
   RAISE INFO 'Datos de la lugar modificada %', lugar_reg ; 

END $$;





--DROP FUNCTION VER_DIRECTOR_AREA;

CREATE OR REPLACE FUNCTION VER_DIRECTOR_AREA (id_director_area in integer)
RETURNS EMPLEADO_JEFE
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	SELECT * FROM EMPLEADO_JEFE WHERE id = id_director_area AND tipo = 'director_area' ; 
$$;
--
--
--select VER_DIRECTOR_AREA(8);

--DROP FUNCTION VER_DIRECTOR_AREA;

CREATE OR REPLACE FUNCTION VER_DIRECTORES_AREA ()
RETURNS setof EMPLEADO_JEFE
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	SELECT * FROM EMPLEADO_JEFE WHERE tipo = 'director_area' ; 
$$;
--
--
--select VER_DIRECTOR_AREA(8);




-- DROP PROCEDURE IF EXISTS CREAR_DIRECTOR_AREA CASCADE;

CREATE OR REPLACE PROCEDURE CREAR_DIRECTOR_AREA (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_DIRECTOR_AREA ( % ) ------', NOW();
	

	-------------////////
	
	INSERT INTO EMPLEADO_JEFE (
		primer_nombre,
		segundo_nombre, 
		primer_apellido, 
		segundo_apellido, 
		telefono,
		tipo,
		fk_empleado_jefe 
	
	) VALUES (
		primer_nombre_va,
		segundo_nombre_va, 
		primer_apellido_va, 
		segundo_apellido_va, 
		telefono_va,
		tipo_va,
		id_jefe 

	) RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR DE AREA CREADO CON EXITO!';
   RAISE INFO 'Datos del director de area: %', empleado_jefe_reg ; 



END $$;


-- CALL CREAR_DIRECTOR_AREA('nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



CREATE OR REPLACE PROCEDURE ELIMINAR_DIRECTOR_AREA (id_director_area IN INTEGER)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_DIRECTOR_AREA ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_director_area;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != tipo_va) THEN
		RAISE INFO 'El empleado no es un director de area';
		RAISE EXCEPTION 'El empleado no es un director de area';
	END IF;

	UPDATE oficina_principal SET fk_director_area = null WHERE fk_director_area = id_director_area;
	UPDATE empleado_jefe SET fk_empleado_jefe = null WHERE fk_empleado_jefe = id_director_area;

	DELETE FROM EMPLEADO_JEFE WHERE id = id_director_area; 
	
   RAISE INFO 'DIRECTOR DE AREA ELIMINADO CON EXITO!';
 

END $$;



-- CALL eliminar_director_area(5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



CREATE OR REPLACE PROCEDURE ACTUALIZAR_DIRECTOR_AREA (id_director_area IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';


BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ACTUALIZAR_DIRECTOR_AREA ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_director_area;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != tipo_va) THEN
		RAISE INFO 'El empleado no es un director de area';
		RAISE EXCEPTION 'El empleado no es un director de area';
	END IF;
	

	-------------////////
	
	UPDATE EMPLEADO_JEFE SET 
	
		primer_nombre = primer_nombre_va,
		segundo_nombre = segundo_nombre_va, 
		primer_apellido = primer_apellido_va,  
		segundo_apellido = segundo_apellido_va, 
		telefono = telefono_va,
		fk_empleado_jefe = id_jefe 
		
	WHERE id = id_director_area
	RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR DE AREA ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del director de area: %', empleado_jefe_reg ; 



END $$;


-- CALL actualizar_director_area (2,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- SELECT * FROM empleado_jefe ej order by id desc; 




--DROP FUNCTION VER_OFICINA;

CREATE OR REPLACE FUNCTION VER_OFICINA (id_oficina in integer)
RETURNS OFICINA_PRINCIPAL
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	SELECT * FROM OFICINA_PRINCIPAL WHERE id = id_oficina; 
$$;
--
--
--select VER_DIRECTOR_AREA(8);

--DROP FUNCTION VER_OFICINAS;

CREATE OR REPLACE FUNCTION VER_OFICINAS ()
RETURNS setof OFICINA_PRINCIPAL
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	SELECT * FROM OFICINA_PRINCIPAL; 
$$;
--
--
-- select VER_OFICINAS();



-- DROP PROCEDURE IF EXISTS CREAR_OFICINA_PRINCIPAL CASCADE;

CREATE OR REPLACE PROCEDURE CREAR_OFICINA_PRINCIPAL (nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;

	-- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_OFICINA_PRINCIPAL ( % ) ------', NOW();
	
	-------------////////
		
	INSERT INTO OFICINA_PRINCIPAL (
		nombre,
		sede,
		fk_director_area,
		fk_director_ejecutivo,
		fk_lugar_ciudad
	
	) VALUES (
		nombre_va,
		sede_va,
		id_director_area,
		id_director_ejecutivo,
		id_ciudad 

	) RETURNING * INTO oficina_reg;

   RAISE INFO 'OFICINA CREADA CON EXITO';
   RAISE INFO 'Datos de la oficina creada %', oficina_reg ; 


END $$;


-- CALL CREAR_OFICINA_PRINCIPAL('prueba',20, 2);


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_OFICINA_PRINCIPAL (id_oficina IN INTEGER)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	-- empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
	-- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_OFICINA_PRINCIPAL ( % ) ------', NOW();
	
	DELETE FROM OFICINA_PRINCIPAL WHERE id = id_oficina; 
	
   	RAISE INFO 'OFICINA ELIMINADA CON EXITO!';
 

END $$;



-- CALL ELIMINAR_OFICINA_PRINCIPAL(15);




-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ACTUALIZAR_OFICINA_PRINCIPAL (id_oficina IN integer, nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
 
BEGIN 

	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_OFICINA_PRINCIPAL ( % ) ------', NOW();
	
	-------------////////
	
	SELECT * INTO oficina_reg FROM OFICINA_PRINCIPAL WHERE id = id_oficina;

	IF (oficina_reg IS NULL) THEN
		RAISE INFO 'La oficina no existe';
		RAISE EXCEPTION 'La oficina no existe';
	END IF;


	UPDATE OFICINA_PRINCIPAL SET 
		nombre = nombre_va,
		sede = sede_va,
		fk_director_area = id_director_area,
		fk_director_ejecutivo = id_director_ejecutivo,
		fk_lugar_ciudad = id_ciudad 

	WHERE id = id_oficina
	RETURNING * INTO oficina_reg;


   RAISE INFO 'OFICINA MODIFICADA CON EXITO';
   RAISE INFO 'Datos de la oficina modificada %', oficina_reg ; 



END $$;


-- select VER_OFICINAS();
-- CALL ACTUALIZAR_OFICINA_PRINCIPAL (13,'nombre1',false, 21, 9, null);
-- select VER_DIRECTORES_AREA();





-- SELECCIONAR, CREAR, MODIFICAR y ELIMINAR OFICINAS


CREATE OR REPLACE FUNCTION VER_DIRECTOR_EJECUTIVO (id_director_ejecutivo in integer)
RETURNS EMPLEADO_JEFE
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	SELECT * FROM EMPLEADO_JEFE WHERE id = id_director_ejecutivo AND tipo = 'director_ejecutivo' ; 
$$;
--
--
--select VER_DIRECTOR_EJECUTIVO(8);

--DROP FUNCTION VER_DIRECTOR_EJECUTIVO;

CREATE OR REPLACE FUNCTION VER_DIRECTORES_EJECUTIVOS ()
RETURNS setof EMPLEADO_JEFE
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	SELECT * FROM EMPLEADO_JEFE WHERE tipo = 'director_ejecutivo' ; 
$$;
--
--
--select VER_DIRECTOR_EJECUTIVO(8);




-- DROP PROCEDURE IF EXISTS CREAR_DIRECTOR_EJECUTIVO CASCADE;


CREATE OR REPLACE PROCEDURE CREAR_DIRECTOR_EJECUTIVO (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_ejecutivo';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO CREAR_DIRECTOR_EJECUTIVO ( % ) ------', NOW();
	

	-------------////////
	
	INSERT INTO EMPLEADO_JEFE (
		primer_nombre,
		segundo_nombre, 
		primer_apellido, 
		segundo_apellido, 
		telefono,
		tipo,
		fk_empleado_jefe 
	
	) VALUES (
		primer_nombre_va,
		segundo_nombre_va, 
		primer_apellido_va, 
		segundo_apellido_va, 
		telefono_va,
		tipo_va,
		null 

	) RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR EJECUTIVO CREADO CON EXITO!';
   RAISE INFO 'Datos del director ejecutivo: %', empleado_jefe_reg ; 



END $$;


-- CALL CREAR_DIRECTOR_EJECUTIVO('nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_DIRECTOR_EJECUTIVO (id_director_ejecutivo IN INTEGER)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_ejecutivo';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO ELIMINAR_DIRECTOR_EJECUTIVO ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_director_ejecutivo;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != tipo_va) THEN
		RAISE INFO 'El empleado no es un director ejecutivo';
		RAISE EXCEPTION 'El empleado no es un director ejecutivo';
	END IF;

	UPDATE oficina_principal SET fk_director_ejecutivo = null WHERE fk_director_ejecutivo = id_director_ejecutivo;
	UPDATE empleado_jefe SET fk_empleado_jefe = null WHERE fk_empleado_jefe = id_director_ejecutivo;

	DELETE FROM EMPLEADO_JEFE WHERE id = id_director_ejecutivo; 
	
   RAISE INFO 'DIRECTOR EJECUTIVO ELIMINADO CON EXITO!';
 

END $$;



-- CALL eliminar_director_ejecutivo(5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ACTUALIZAR_DIRECTOR_EJECUTIVO (id_director_ejecutivo IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_ejecutivo';


BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO ACTUALIZAR_DIRECTOR_EJECUTIVO ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_director_ejecutivo;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != tipo_va) THEN
		RAISE INFO 'El empleado no es un director ejecutivo';
		RAISE EXCEPTION 'El empleado no es un director ejecutivo';
	END IF;
	

	-------------////////
	
	UPDATE EMPLEADO_JEFE SET 
	
		primer_nombre = primer_nombre_va,
		segundo_nombre = segundo_nombre_va, 
		primer_apellido = primer_apellido_va,  
		segundo_apellido = segundo_apellido_va, 
		telefono = telefono_va

	WHERE id = id_director_ejecutivo
	RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR EJECUTIVO ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del director ejecutivo: %', empleado_jefe_reg ; 



END $$;


-- CALL actualizar_director_ejecutivo (2,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------

CREATE OR REPLACE PROCEDURE CAMBIAR_ROL_EMPLEADO (id_empleado IN integer, id_jefe in integer, cargo in integer)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;


BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO CAMBIAR_ROL_EMPLEADO ( % ) ------', NOW();
	

    SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_empleado;

    IF (empleado_jefe_reg IS NULL) THEN
        RAISE INFO 'El empleado no existe';
        RAISE EXCEPTION 'El empleado no existe';
    END IF;


	-------------////////
	
	UPDATE EMPLEADO_JEFE SET 
	
		primer_nombre = primer_nombre_va,
		segundo_nombre = segundo_nombre_va, 
		primer_apellido = primer_apellido_va,  
		segundo_apellido = segundo_apellido_va, 
		telefono = telefono_va,
        tipo = cargo,
        fk_empleado_jefe = id_jefe
        
	WHERE id = id_empleado
	RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR EJECUTIVO ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del director ejecutivo: %', empleado_jefe_reg ; 

END $$;





--------------------------//////////////////////////-------------------------\\

-------------------------//////////////---------------------------------------------//////////////--------------------


CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_EMPLEADO_CONFIDENTE (id_empleado_acceso in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_empleado_jefe_confidente = id_empleado_acceso; 
$$;

-- SELECT * FROM VER_LISTA_INFORMANTES_EMPLEADO_CONFIDENTE(11);







----------///////////- ---------------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- CREACION DE PROCEDIMIENTOS Y FUNCIONES RELACIONADOS AL ROL DIRECTOR DE AREA   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- --------------------------------------------------------------------------------------------------------------- ///////////----------


CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso in integer, id_jefe_estacion in integer)
AS $$
DECLARE

  dir_area_reg EMPLEADO_JEFE%ROWTYPE;
  jefe_estacion_reg EMPLEADO_JEFE%ROWTYPE;
  oficina_dir_reg OFICINA_PRINCIPAL%ROWTYPE;
  estacion_reg ESTACION%ROWTYPE;

BEGIN

  SELECT * INTO dir_area_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_acceso;

  IF (dir_area_reg IS NULL OR dir_area_reg.tipo != 'director_area') THEN
    RAISE EXCEPTION 'El empleado no un director de area o no existe';
  END IF;

  SELECT * INTO jefe_estacion_reg FROM EMPLEADO_JEFE WHERE id = id_jefe_estacion AND tipo = 'jefe';
  SELECT * INTO estacion_reg FROM ESTACION WHERE fk_empleado_jefe = id_jefe_estacion;
  SELECT * INTO oficina_dir_reg FROM OFICINA_PRINCIPAL WHERE fk_director_area = id_empleado_acceso; 

  IF (estacion_reg.fk_oficina_principal != oficina_dir_reg.id AND jefe_estacion_reg.fk_empleado_jefe != id_empleado_acceso) THEN
    RAISE EXCEPTION 'No tiene acesso a esta informacion';
  END IF;
    
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


-- CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION()

-----------------------------///////////////-------------------------------


--DROP FUNCTION VER_JEFE_ESTACION;

CREATE OR REPLACE FUNCTION VER_JEFE_E (id_empleado_acceso in integer, id_jefe in integer)
RETURNS EMPLEADO_JEFE
AS $$
DECLARE 

  jefe_estacion EMPLEADO_JEFE%ROWTYPE;
  -- empleado_dir_acceso EMPLEADO_JEFE%ROWTYPE; 
  -- oficina_dir_acceso OFICINA_PRINCIPAL%ROWTYPE;

BEGIN

  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, id_jefe);

  SELECT * INTO jefe_estacion FROM EMPLEADO_JEFE WHERE id = id_jefe AND tipo = 'jefe';

  RETURN jefe_estacion;

END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;

--select * from empleado_jefe

-- SELECT VER_JEFE_E(2,20);

------


CREATE OR REPLACE FUNCTION VER_JEFES_E (id_empleado_acceso in integer)
RETURNS setof EMPLEADO_JEFE
AS $$
BEGIN
   
  RETURN QUERY (
    
    SELECT ej.* FROM EMPLEADO_JEFE ej WHERE ej.fk_empleado_jefe = id_empleado_acceso
    UNION
    SELECT ej.* FROM EMPLEADO_JEFE ej, ESTACION e WHERE 
      ej.id = e.fk_empleado_jefe AND e.fk_oficina_principal IN 
      ( SELECT id FROM OFICINA_PRINCIPAL op WHERE op.fk_director_area = id_empleado_acceso ) 
  
  );
    

END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;
--

--SELECT VER_JEFES_E(2);



----------------------------------//////////////////////-------------------------



-- DROP PROCEDURE IF EXISTS CREAR_JEFE_ESTACION CASCADE;


CREATE OR REPLACE PROCEDURE CREAR_JEFE_ESTACION (id_empleado_acceso in integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

  empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

  tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';

BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_JEFE_ESTACION ( % ) ------', NOW();
  

  -------------////////
  
  INSERT INTO EMPLEADO_JEFE (
    primer_nombre,
    segundo_nombre, 
    primer_apellido, 
    segundo_apellido, 
    telefono,
    tipo,
    fk_empleado_jefe 
  
  ) VALUES (
    primer_nombre_va,
    segundo_nombre_va, 
    primer_apellido_va, 
    segundo_apellido_va, 
    telefono_va,
    tipo_va,
    id_empleado_acceso 

  ) RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'JEFE DE ESTACION CREADO CON EXITO!';
   RAISE INFO 'Datos del jefe de estacion: %', empleado_jefe_reg ; 

END $$;


-- CALL CREAR_JEFE_ESTACION(2,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213));
-- -- SELECT * FROM empleado_jefe ej order by id desc; 
-- SELECT VER_JEFES_E(2);
-- select * from empleado_jefe;
-- CALL VER_JEFE_E(2);



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_JEFE_ESTACION (id_empleado_acceso IN INTEGER, id_jefe_estacion IN INTEGER)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE


empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--  oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
  tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';
  numero_estaciones_dep integer;

BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_JEFE_ESTACION ( % ) ------', NOW();
  
  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, id_jefe_estacion);

  -------------////////
  SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_jefe_estacion;

  IF (empleado_jefe_reg IS NULL) THEN
    RAISE INFO 'El empleado no existe';
    RAISE EXCEPTION 'El empleado no existe';
  END IF;

  IF (empleado_jefe_reg.tipo != tipo_va) THEN
    RAISE INFO 'El empleado no es un jefe de estacion';
    RAISE EXCEPTION 'El empleado no es un jefe de estacion';
  END IF;


  SELECT count(*) INTO numero_estaciones_dep FROM ESTACION WHERE fk_empleado_jefe = id_jefe_estacion;

  IF ( numero_estaciones_dep > 0 ) THEN

    RAISE EXCEPTION 'No se puede eliminar al jefe de estacion ya que ninguna estacion puede quedar sin jefe ';
  END IF;


  UPDATE ESTACION SET fk_empleado_jefe = null WHERE fk_empleado_jefe = id_jefe_estacion;
  UPDATE EMPLEADO_JEFE SET fk_empleado_jefe = null WHERE fk_empleado_jefe = id_jefe_estacion;

  DELETE FROM EMPLEADO_JEFE WHERE id = id_jefe_estacion; 
  
   RAISE INFO 'JEFE DE ESTACION ELIMINADO CON EXITO!';
 

END $$;


--SELECT VER_JEFES_E(2);
--CALL eliminar_jefe_estacion(2,44);



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ACTUALIZAR_JEFE_ESTACION (id_empleado_acceso IN integer, id_jefe_estacion IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

  empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

  tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';


BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ACTUALIZAR_JEFE_ESTACION ( % ) ------', NOW();
  
  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, id_jefe_estacion);

  
  -------------////////
  SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_jefe_estacion;

  IF (empleado_jefe_reg IS NULL) THEN
    RAISE INFO 'El empleado no existe';
    RAISE EXCEPTION 'El empleado no existe';
  END IF;

  IF (empleado_jefe_reg.tipo != tipo_va) THEN
    RAISE INFO 'El empleado no es un jefe de estacion';
    RAISE EXCEPTION 'El empleado no es un jefe de estacion';
  END IF;
  

  -------------////////
  
  UPDATE EMPLEADO_JEFE SET 
  
    primer_nombre = primer_nombre_va,
    segundo_nombre = segundo_nombre_va, 
    primer_apellido = primer_apellido_va,  
    segundo_apellido = segundo_apellido_va, 
    telefono = telefono_va,
    fk_empleado_jefe = id_empleado_acceso 
    
  WHERE id = id_jefe_estacion
  RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'JEFE DE ESTACION ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del jefe de estacion: %', empleado_jefe_reg ; 



END $$;


-- SELECT VER_JEFES_E(2);
-- CALL actualizar_jefe_estacion (1,11,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- -- SELECT * FROM empleado_jefe ej order by id desc; 




-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------

  

CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_DIR_AREA_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
AS $$
DECLARE

  dir_area_reg EMPLEADO_JEFE%ROWTYPE;  
  oficina_dir_reg OFICINA_PRINCIPAL%ROWTYPE;
  estacion_reg ESTACION%ROWTYPE;

BEGIN

  SELECT * INTO dir_area_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_acceso;


IF (dir_area_reg IS NULL OR dir_area_reg.tipo != 'director_area') THEN
    RAISE EXCEPTION 'El empleado no un director de area o no existe';
  END IF;

  SELECT * INTO estacion_reg FROM ESTACION WHERE id = id_estacion;
  SELECT * INTO oficina_dir_reg FROM OFICINA_PRINCIPAL WHERE fk_director_area = id_empleado_acceso; 

  IF (estacion_reg.fk_oficina_principal != oficina_dir_reg.id) THEN
    RAISE EXCEPTION 'No tiene acesso a esta informacion';
  END IF;
    
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;





--DROP FUNCTION VER_ESTACION;

CREATE OR REPLACE FUNCTION VER_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
RETURNS ESTACION
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE 

  estacion_reg ESTACION%ROWTYPE;
BEGIN
  CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso, id_estacion);

   SELECT * INTO estacion_reg FROM ESTACION WHERE id = id_estacion; 

  RETURN estacion_reg;
END $$;
--
--
-- select * from VER_ESTACION(2,112);

--DROP FUNCTION VER_ESTACIONES;

CREATE OR REPLACE FUNCTION VER_ESTACIONES (id_empleado_acceso in integer)
RETURNS setof ESTACION
LANGUAGE sql
SECURITY DEFINER
AS $$  
   SELECT * FROM ESTACION WHERE fk_oficina_principal IN (SELECT id FROM OFICINA_PRINCIPAL WHERE fk_director_area = id_empleado_acceso); 
$$;
--
--
-- select * FROM VER_ESTACIONES(2);
-- select * from oficina_principal where fk_director_area = 3;



-------------------------//////////////---------------------------------------------//////////////--------------------


CREATE OR REPLACE FUNCTION VER_CUENTA_ESTACION_DIR_AREA (id_empleado_acceso in integer, id_estacion in INTEGER)
RETURNS setof CUENTA
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE 
  cuenta_reg CUENTA%ROWTYPE;
BEGIN
   
  CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso, id_estacion);
    
  RETURN QUERY 
    SELECT * FROM CUENTA WHERE fk_estacion = id_estacion; 

  -- RETURN cuenta_reg;

END $$;

-- SELECT * FROM VER_CUENTA_ESTACION_DIR_AREA(3,5);
-- SELECT * FROM estacion;



-------------------------//////////////---------------------------------------------//////////////--------------------





-- DROP PROCEDURE IF EXISTS CREAR_ESTACION CASCADE;

CREATE OR REPLACE PROCEDURE CREAR_ESTACION (id_empleado_acceso IN integer, nombre_va IN ESTACION.nombre%TYPE, id_ciudad IN ESTACION.fk_lugar_ciudad%TYPE, id_jefe_estacion IN ESTACION.fk_empleado_jefe%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

  estacion_reg ESTACION%ROWTYPE;
  oficina_reg OFICINA_PRINCIPAL%ROWTYPE;

  -- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';

BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_ESTACION ( % ) ------', NOW();
  
  -------------////////
  
  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso,id_jefe_estacion);

  SELECT * INTO oficina_reg WHERE fk_director_area = id_empleado_acceso;

  INSERT INTO ESTACION (
    nombre,

    fk_oficina_principal,
    fk_empleado_jefe,
    fk_lugar_ciudad
  
  ) VALUES (

    nombre_va,
    id_jefe_estacion,
    oficina_reg.id,
    id_ciudad 

  ) RETURNING * INTO estacion_reg;

   RAISE INFO 'ESTACION CREADA CON EXITO';
   RAISE INFO 'Datos de la estacion creada %', estacion_reg ; 


END $$;


-- CALL CREAR_ESTACION('prueba',20, 2);
-- SELECT * FROM estacion order by id desc; 
-- select * from lugar where id = 2;
-- select * from EMPLEADO_JEFE where id = 20;



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_ESTACION (id_empleado_acceso IN integer, id_estacion IN INTEGER)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

  -- empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--  estacion_reg ESTACION%ROWTYPE;
  -- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';

BEGIN 

  CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso,id_estacion);

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_ESTACION ( % ) ------', NOW();
  
  DELETE FROM ESTACION WHERE id = id_estacion; 
  
     RAISE INFO 'ESTACION ELIMINADA CON EXITO!';
 

END $$;



-- CALL ELIMINAR_ESTACION(15);


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/

CREATE OR REPLACE PROCEDURE ACTUALIZAR_ESTACION (id_empleado_acceso IN integer, nombre_va IN ESTACION.nombre%TYPE, id_ciudad IN ESTACION.fk_lugar_ciudad%TYPE, id_jefe_estacion IN ESTACION.fk_empleado_jefe%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

  estacion_reg ESTACION%ROWTYPE;
  oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
 
BEGIN 

  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_ESTACION ( % ) ------', NOW();
  

  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso,id_jefe_estacion);

  SELECT * INTO oficina_reg FROM oficina_principal WHERE fk_director_area = id_empleado_acceso;

  IF (oficina_reg IS NULL) THEN
    RAISE INFO 'La oficina no existe';
    RAISE EXCEPTION 'La oficina no existe';
  END IF;


  SELECT * INTO estacion_reg FROM ESTACION WHERE id = id_estacion;

  IF (estacion_reg IS NULL) THEN
    RAISE INFO 'La estacion no existe';
    RAISE EXCEPTION 'La estacion no existe';
  END IF;


  UPDATE ESTACION SET 
    nombre = nombre_va,
    fk_oficina_principal = id_jefe_estacion,
    fk_empleado_jefe = oficina_reg.id,
    fk_lugar_ciudad = id_ciudad
  
  WHERE id = id_estacion
  RETURNING * INTO estacion_reg;
  
  -------------////////


   RAISE INFO 'ESTACION MODIFICADA CON EXITO';
   RAISE INFO 'Datos de la estacion modificada %', estacion_reg ; 



END $$;


-- select VER_ESTACIONES();
-- CALL ACTUALIZAR_ESTACION (13,'nombre1',false, 21, 9, null);
-- select * from empleado_jefe where id = 9;
-- select * from lugar where id = 20;
-- SELECT * FROM empleado_jefe ej order by id desc; 

-- select VER_DIRECTORES_AREA();


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


-- CAMBIAR ROL DE DIRECTOR AREA A JEFE 


-- SELECCIONAR, CREAR, MODIFICAR y ELIMINAR OFICINAS






------------------------////////////////---------------------------



CREATE OR REPLACE PROCEDURE ASIGNACION_PRESUPUESTO (id_empleado_acceso integer, estacion_va integer, presupuesto_va numeric)
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE   

  estacion_reg estacion%rowtype;
  oficina_reg oficina_principal%rowtype;
  jefe_reg empleado_jefe%rowtype;
  cuenta_reg CUENTA%ROWTYPE;
  
BEGIN 
  
    RAISE INFO '------ EJECUCION DEL PROCEDIMINETO PARA ASIGNAR PRESUPUESTO EN ESTACIONES ( % ) ------', NOW();
    
    ---PROCEDIMIENTO QUE VALIDA SI EL DIRECTOR DE AREA TIENE ACCESO A LA ESTACION---
    
    CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso, estacion_va);
    
    ---SE VALIDA QUE EL DIRECCTOR DE AREA PERTENESCA A LA OFICINA_PRINCIPAL---
    SELECT * INTO oficina_reg FROM oficina_principal WHERE fk_director_area = id_empleado_acceso; ---MIRAR 
    
    ---SE VALIDA SI LA OFICINA EXISTE--
    
    IF (oficina_reg IS NULL) THEN
      RAISE INFO 'La oficina no existe';
      RAISE EXCEPTION 'La oficina no existe';
    END IF;
  
    SELECT * INTO estacion_reg FROM estacion WHERE id = estacion_va;
    
    IF (estacion_reg IS NULL) THEN
      RAISE INFO 'La estacion no existe';
      RAISE EXCEPTION 'La estacion no existe';
    END IF;
    

    select * into cuenta_reg from cuenta where 
      año = NOW()::DATE
      and fk_estacion = estacion_va;


    IF (cuenta_reg IS NULL) THEN
      
      INSERT INTO cuenta (
        año,
        presupuesto,
        fk_estacion,
        fk_oficina_principal    
        
      ) VALUES (
        NOW()::DATE, 
        presupuesto_va,
        estacion_va,
        oficina_reg.id
      );  

    ELSE 

      UPDATE cuenta SET 
        presupuesto = presupuesto_va
      WHERE 
        año = NOW()::DATE and 
        fk_estacion = estacion_va;

    END IF;

END
$$;


-- CALL ASIGNACION_PRESUPUESTO(2, 2, 5000);
-- select * from cuenta where fk_estacion = 2;

-- PROCEDIMIENTO DE DIRECTOR DE AREA, 
-- ASIGNAR LOS PRESUPUESTOS DE ESTACIONES,
-- REFERENCIA:: ACTUALIZAR ESTACIÓN,
-- VALIDAR QUE EL DIRECTOR TENGA ACCESO,
-- id_empleado_acceso, ES EL ID DEL DIRECTOR DE AREA.


CREATE OR REPLACE FUNCTION VER_PRESUPUESTO_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
RETURNS setof CUENTA
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  

BEGIN
  CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso, id_estacion);

   RETURN QUERY
     SELECT * FROM CUENTA WHERE fk_estacion = id_estacion; 

END $$;

-- select * from VER_PRESUPUESTO_ESTACION(3,4);
-- select * from cuenta where fk_estacion = 4;






CREATE OR REPLACE FUNCTION VER_CLIENTE (id_cliente in integer)
RETURNS CLIENTE
LANGUAGE sql
SECURITY DEFINER
AS $$  
   SELECT * FROM CLIENTE WHERE id = id_cliente; 
$$;
--
--
--select VER_CLIENTE(8);

--DROP FUNCTION VER_CLIENTE;

CREATE OR REPLACE FUNCTION VER_CLIENTES ()
RETURNS setof CLIENTE
LANGUAGE sql
SECURITY DEFINER
AS $$  
   SELECT * FROM CLIENTE; 
$$;
--
--
--select VER_CLIENTE(8);




-- DROP PROCEDURE IF EXISTS CREAR_CLIENTE CASCADE;


CREATE OR REPLACE PROCEDURE CREAR_CLIENTE (nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, fk_lugar_pais in integer)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

  cliente_reg CLIENTE%ROWTYPE;

BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_CLIENTE ( % ) ------', NOW();
  
  -------------////////
  
  INSERT INTO CLIENTE (
    nombre_empresa,
    pagina_web, 
    exclusivo, 
    telefonos, 
    contactos,
    fk_lugar_pais
  
  ) VALUES (
    nombre_empresa_va,
    pagina_web_va, 
    exclusivo_va, 
    ARRAY [telefono_va], 
    ARRAY [contacto_va],
    fk_lugar_pais

  ) RETURNING * INTO cliente_reg;

   RAISE INFO 'CLIENTE CREADO CON EXITO!';
   RAISE INFO 'Datos del cliente: %', cliente_reg ; 



END $$;


-- CALL CREAR_CLIENTE('nombre_empresa','pagina_web', true,CREAR_TELEFONO(0212,2847213), CREAR_CONTACTO('gabriel','alberto','manrique','ulacio','calle_tal',0414,0176620), 5);
-- SELECT * FROM VER_CLIENTES(); 


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_CLIENTE (id_cliente IN INTEGER)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

  cliente_reg CLIENTE%ROWTYPE;
    --  oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
  -- tipo_va CLIENTE.tipo%TYPE := 'cliente';
    numero_registro_compra integer;
  area_interes_reg area_interes%ROWTYPE;
  
BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_CLIENTE ( % ) ------', NOW();
  

  -------------////////
  SELECT * INTO cliente_reg FROM CLIENTE WHERE id = id_cliente;

  IF (cliente_reg IS NULL) THEN
    RAISE INFO 'El cliente no existe';
    RAISE EXCEPTION 'El cliente no existe';
  END IF;

    SELECT count(*) INTO numero_registro_compra FROM ADQUISICION WHERE fk_cliente = id_cliente;

    IF (numero_registro_compra IS NOT NULL) THEN
        RAISE EXCEPTION 'No se puede borrar el cliente ya que hay registro de venta que dependen de el';
    END IF;
  
  SELECT * INTO area_interes_reg FROM area_interes
  WHERE fk_cliente = cliente_reg.id;
  
  IF (area_interes_reg IS NOT NULL) THEN
    RAISE EXCEPTION 'No se puede borrar el cliente ya que hay un registro de area interes que depende del cliente';
  END IF;
  
  DELETE FROM CLIENTE WHERE id = id_cliente; 
  
     RAISE INFO 'CLIENTE ELIMINADO CON EXITO!';
 

END $$;

-- CALL eliminar_cliente(11);
-- SELECT * FROM cliente ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ACTUALIZAR_CLIENTE (id_cliente IN integer, nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, id_lugar in integer)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

  cliente_reg CLIENTE%ROWTYPE;

BEGIN


RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ACTUALIZAR_CLIENTE ( % ) ------', NOW();
  

  -------------////////
  SELECT * INTO cliente_reg FROM cliente WHERE id = id_cliente;

  IF (cliente_reg IS NULL) THEN
    RAISE INFO 'El cliente no existe';
    RAISE EXCEPTION 'El cliente no existe';
  END IF;

  IF (contacto_va IS NULL) THEN
    RAISE INFO 'El cliente no tiene contacto';
    RAISE EXCEPTION 'El cliente no tiene contacto';
    END IF;

  -------------////////
  
  UPDATE CLIENTE SET 
  
    nombre_empresa = nombre_empresa_va,
    pagina_web = pagina_web_va, 
    exclusivo = exclusivo_va,  
    telefonos = ARRAY[telefono_va],
        contactos = ARRAY [contacto_va],
    fk_lugar_pais = id_lugar
    
  WHERE id = id_cliente
  RETURNING * INTO cliente_reg;

   RAISE INFO 'CLIENTE ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del cliente: %', cliente_reg ; 



END $$;

-- (id_cliente IN integer, nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, id_lugar in integer)
-- CALL actualizar_cliente (2,'nombre_empresa','pagina_web',false,CREAR_TELEFONO(0212,2847213),null, 5);
-- -- SELECT * FROM cliente ej order by id desc; 



--------------------//////////////////--------------------



-- DROP PROCEDURE ASIGNAR_TEMA_CLIENTE;


CREATE OR REPLACE PROCEDURE ASIGNAR_TEMA_CLIENTE (tema_id integer,cliente_id integer)
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 

  tema_reg CLAS_TEMA%ROWTYPE;
  cliente_reg CLIENTE%ROWTYPE;

  area_interes_exit AREA_INTERES%ROWTYPE;

BEGIN 
  
  SELECT * INTO tema_reg FROM CLAS_TEMA WHERE id = tema_id;
  
  ---VALIDACION SI EL TEMA ES NULO---    
  IF (tema_reg IS NULL) THEN
    
    RAISE EXCEPTION 'No existe el tema';
  END IF;


  SELECT * INTO cliente_reg FROM CLIENTE WHERE id = cliente_id;
  
  ---VALIDACION SI EL TEMA ES NULO---    
  IF (cliente_reg IS NULL) THEN
    
    RAISE EXCEPTION 'No existe el cliente';
  END IF;


  SELECT * INTO area_interes_exit FROM AREA_INTERES WHERE fk_clas_tema = tema_id and fk_cliente = cliente_id;
    
  ---VALIDACION SI EL TEMA ES NULO---    
  IF (area_interes_exit IS NOT NULL) THEN
    
    RAISE EXCEPTION 'Ya el tema fue asignado';
  END IF;


  INSERT INTO AREA_INTERES (
    fk_clas_tema,
    fk_cliente        
  ) VALUES (
    tema_id, 
    cliente_id          
  );
  

  RAISE INFO 'SE INSERTO EN EL CLIENTE CON EL ID: % Y EL NOMBRE: %, EL TEMA CON ID: % Y NOMBRE: %', cliente_reg.id, cliente_reg.nombre_empresa, tema_reg.id, tema_reg.nombre;   
    
END
$$;

-- call ASIGNAR_TEMA_CLIENTE (2, 10);
-- select * from AREA_INTERES;


----------///////////- ---------------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- CREACION DE PROCEDIMIENTOS Y FUNCIONES RELACIONADOS AL ROL JEFE DE ESTACION   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- --------------------------------------------------------------------------------------------------------------- ///////////----------



CREATE OR REPLACE PROCEDURE CREAR_TEMA (nombre_va varchar, descripcion_va varchar, topico_va varchar)
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$

BEGIN
	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_LUGAR ( % ) ------', NOW();
	
	INSERT INTO clas_tema (
		nombre,
		descripcion,
		topico
	)	VALUES (
		nombre_va,
		descripcion_va,
		topico_va		
		);

END;
$$;


CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA ( id_empleado_acceso in integer, id_personal_inteligencia in integer)
AS $$
DECLARE

	-- jefe_estacion_reg EMPLEADO_JEFE%ROWTYPE;
	hist_cargo_reg HIST_CARGO%ROWTYPE;
	-- estacion_reg ESTACION%ROWTYPE;

BEGIN

	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fecha_fin IS NULL AND fk_personal_inteligencia = id_personal_inteligencia AND fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso);

	IF (hist_cargo_reg IS NULL) THEN
		RAISE EXCEPTION 'No tiene acesso a esta informacion';
	END IF;
		

END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


-- CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(15,17);
-- SELECT * FROM HIST_CARGO where fk_personal_inteligencia = 17;
-- SELECT * FROM VER_ESTACION(3,5);



-----------------------------////////////////////////-----------------------------------




CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_EMPLEADO_ESTACION ( id_empleado_acceso in integer, id_estacion in integer)
AS $$
DECLARE

	estacion_reg ESTACION%ROWTYPE;
    jefe_estacion_reg EMPLEADO_JEFE%ROWTYPE;

BEGIN

	SELECT * INTO jefe_estacion_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_acceso AND tipo = 'jefe';
	
	IF (jefe_estacion_reg IS NULL) THEN
		RAISE EXCEPTION 'El jefe no existe o no es un jefe';
	END IF;

	SELECT * INTO estacion_reg FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso AND id = id_estacion;

	IF (estacion_reg IS NULL) THEN
		RAISE EXCEPTION 'No tiene acesso a esta informacion';
	END IF;
		

END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;




-----------------------------////////////////////////-----------------------------------



CREATE OR REPLACE PROCEDURE CREAR_PERSONAL_INTELIGENCIA (

    primer_nombre_va IN PERSONAL_INTELIGENCIA.primer_nombre%TYPE, 
    segundo_nombre_va IN PERSONAL_INTELIGENCIA.segundo_nombre%TYPE, 
    primer_apellido_va IN PERSONAL_INTELIGENCIA.primer_apellido%TYPE, 
    segundo_apellido_va IN PERSONAL_INTELIGENCIA.segundo_apellido%TYPE, 
    fecha_nacimiento_va IN PERSONAL_INTELIGENCIA.fecha_nacimiento%TYPE, 
    altura_cm_va IN PERSONAL_INTELIGENCIA.altura_cm%TYPE, 
    peso_kg_va IN PERSONAL_INTELIGENCIA.peso_kg%TYPE, 
    color_ojos_va IN PERSONAL_INTELIGENCIA.color_ojos%TYPE, 
    vision_va IN PERSONAL_INTELIGENCIA.vision%TYPE, 
    class_seguridad_va IN PERSONAL_INTELIGENCIA.class_seguridad%TYPE, 

    fotografia_va IN PERSONAL_INTELIGENCIA.fotografia%TYPE, 
    huella_retina_va IN PERSONAL_INTELIGENCIA.huella_retina%TYPE, 
    huella_digital_va IN PERSONAL_INTELIGENCIA.huella_digital%TYPE, 

    telefono_va IN PERSONAL_INTELIGENCIA.telefono%TYPE, 
    licencia_manejo_va IN PERSONAL_INTELIGENCIA.licencia_manejo%TYPE,

    idiomas_va IN PERSONAL_INTELIGENCIA.idiomas%TYPE, 
    familiar_1_va IN familiar_ty, 
    familiar_2_va IN familiar_ty, 
    
    identificacion_1_va IN identificacion_ty, 
    
    nivel_educativo_1_va IN nivel_educativo_ty, 

    id_ciudad IN PERSONAL_INTELIGENCIA.fk_lugar_ciudad%TYPE
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

    personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_PERSONAL_INTELIGENCIA ( % ) ------', NOW();
	

	-------------////////
	
	INSERT INTO PERSONAL_INTELIGENCIA (
		
        primer_nombre,
        segundo_nombre,
        primer_apellido,
        segundo_apellido,
        fecha_nacimiento,
        altura_cm,
        peso_kg,
        color_ojos,
        vision,
        class_seguridad,
        fotografia,
        huella_retina,
        huella_digital,
        telefono,
        licencia_manejo,
        idiomas,
        familiares,
        identificaciones,
        nivel_educativo,

        fk_lugar_ciudad
	
	) VALUES (
		primer_nombre_va,
        segundo_nombre_va,
        primer_apellido_va,
        segundo_apellido_va,
        fecha_nacimiento_va,
        altura_cm_va,
        peso_kg_va,
        color_ojos_va,
        vision_va,
        class_seguridad_va,

        fotografia_va,
        huella_retina_va,
        huella_digital_va,

        telefono_va,
        licencia_manejo_va,

        idiomas_va,
        ARRAY [ familiar_1_va, familiar_2_va ],
       
        ARRAY [ identificacion_1_va ],
    
        ARRAY [ nivel_educativo_1_va ],
        id_ciudad

	) RETURNING * INTO personal_inteligencia_reg;

   RAISE INFO 'PERSONAL DE INTELIGENCIA CREADO CON EXITO!';
--    RAISE INFO 'Datos del personal de inteligencia: %', personal_inteligencia_reg ; 

END $$;


-- CALL CREAR_PERSONAL_INTELIGENCIA (
--     'nombre1',
--     'nombre2',
--     'apellido1',
--     'apellido2',
-- 	'1995-03-09',
--     165, 
--     70,
--     'negro',
--     '20/20',
--     'no_clasificado',
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),
--     CREAR_TELEFONO(0212,2847268),
--     CREAR_LICENCIA('021390213','Argentina'),
--     CREAR_ARRAY_IDIOMAS('español','italiano','chino','portugués',null,null),
--     CREAR_FAMILIAR ('Gabriel','alberto,','manrique','ulacio','1960-06-01','tio',0414,0176620),
--     CREAR_FAMILIAR ('familiarn2','familiarn2,','familiara2','familiara2','1980-07-01','primo',0416,7876620),
--     CREAR_IDENTIFICACION('0213120431','Australia'),
--     CREAR_NIVEL_EDUCATIVO('Economía', 'Master', 'Finanzas'),
-- 	20
-- );


--------------------------------------------///////////////////////--------------------------------------



CREATE OR REPLACE PROCEDURE ACTUALIZAR_PERSONAL_INTELIGENCIA (
	id_empleado_acceso in integer,
	id_personal_inteligencia in integer,

    primer_nombre_va IN PERSONAL_INTELIGENCIA.primer_nombre%TYPE, 
    segundo_nombre_va IN PERSONAL_INTELIGENCIA.segundo_nombre%TYPE, 
    primer_apellido_va IN PERSONAL_INTELIGENCIA.primer_apellido%TYPE, 
    segundo_apellido_va IN PERSONAL_INTELIGENCIA.segundo_apellido%TYPE, 
    fecha_nacimiento_va IN PERSONAL_INTELIGENCIA.fecha_nacimiento%TYPE, 
    altura_cm_va IN PERSONAL_INTELIGENCIA.altura_cm%TYPE, 
    peso_kg_va IN PERSONAL_INTELIGENCIA.peso_kg%TYPE, 
    color_ojos_va IN PERSONAL_INTELIGENCIA.color_ojos%TYPE, 
    vision_va IN PERSONAL_INTELIGENCIA.vision%TYPE, 
    class_seguridad_va IN PERSONAL_INTELIGENCIA.class_seguridad%TYPE, 

    fotografia_va IN PERSONAL_INTELIGENCIA.fotografia%TYPE, 
    huella_retina_va IN PERSONAL_INTELIGENCIA.huella_retina%TYPE, 
    huella_digital_va IN PERSONAL_INTELIGENCIA.huella_digital%TYPE, 

    telefono_va IN PERSONAL_INTELIGENCIA.telefono%TYPE, 
    licencia_manejo_va IN PERSONAL_INTELIGENCIA.licencia_manejo%TYPE,

    idiomas_va IN PERSONAL_INTELIGENCIA.idiomas%TYPE, 
    familiar_1_va IN familiar_ty, 
    familiar_2_va IN familiar_ty, 
    
    identificacion_1_va IN identificacion_ty, 
    
    nivel_educativo_1_va IN nivel_educativo_ty, 

    id_ciudad IN PERSONAL_INTELIGENCIA.fk_lugar_ciudad%TYPE
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

    personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;

	hist_cargo_reg hist_cargo%ROWTYPE;	
	-- empleado_jefe_reg empleado_jefe%ROWTYPE;
	

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_PERSONAL_INTELIGENCIA ( % ) ------', NOW();
	

	
	SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia;
	
	---VALIDACION SI EL TEMA ES NULO---		
	IF (personal_inteligencia_reg IS NULL) THEN
		
		RAISE EXCEPTION 'No existe el canalista';
	END IF;


	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fecha_fin IS NULL AND fk_personal_inteligencia = id_personal_inteligencia LIMIT 1;

	IF (hist_cargo_reg IS NOT NULL) THEN	
		
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, id_personal_inteligencia);


	END IF;

	-------------////////
	
	UPDATE PERSONAL_INTELIGENCIA SET
		
        primer_nombre = primer_nombre_va,
        segundo_nombre = segundo_nombre_va,
        primer_apellido = primer_apellido_va,
        segundo_apellido = segundo_apellido_va,
        fecha_nacimiento = fecha_nacimiento_va,
        altura_cm = altura_cm_va,
        peso_kg = peso_kg_va,
        color_ojos = color_ojos_va,
        vision = vision_va,
        class_seguridad = class_seguridad_va,
        fotografia = fotografia_va,
        huella_retina = huella_retina_va,
        huella_digital = huella_digital_va,
        telefono = telefono_va,
        licencia_manejo = licencia_manejo_va,
        idiomas = idiomas_va,
        familiares = ARRAY [ familiar_1_va, familiar_2_va ],
        identificaciones = ARRAY [identificacion_1_va ],
        nivel_educativo = ARRAY [nivel_educativo_1_va ],
        fk_lugar_ciudad = id_ciudad
	
	WHERE id = id_personal_inteligencia;
	-- RETURNING * INTO personal_inteligencia_reg;

   RAISE INFO 'PERSONAL DE INTELIGENCIA CREADO CON EXITO!';
--    RAISE INFO 'Datos del personal de inteligencia: %', personal_inteligencia_reg ; 

END $$;


-- CALL ACTUALIZAR_PERSONAL_INTELIGENCIA (
-- 	16,
-- 	21,
--     'nombrez',
--     'nombrez',
--     'apellidoz',
--     'apellidoz',
-- 	'1995-03-09',
--     170, 
--     80,
--     'negro',
--     '20/20',
--     'no_clasificado',
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),
--     CREAR_TELEFONO(0212,2847268),
--     CREAR_LICENCIA('021390213','Argentina'),
--     CREAR_ARRAY_IDIOMAS('español','italiano','chino','portugués',null,null),
--     CREAR_FAMILIAR ('Gabriel','alberto,','manrique','ulacio','1960-06-01','tio',0414,0176620),
--     CREAR_FAMILIAR ('familiarn2','familiarn2,','familiara2','familiara2','1980-07-01','primo',0416,7876620),
--     CREAR_IDENTIFICACION('0213120431','Australia'),
--     CREAR_NIVEL_EDUCATIVO('Economía', 'Master', 'Finanzas'),
-- 	20
-- );


-- SELECT * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(16);

-- select * from personal_inteligencia;

-- -- 
-- select CREAR_NIVEL_EDUCATIVO('Economía', 'Master', 'Finanzas');
-- select CREAR_IDENTIFICACION('0213120431','Australia');
-- SELECT CREAR_FAMILIAR ('Gabriel','alberto,','manrique','ulacio','1960-06-01','tio',0414,0176620);
-- SELECT CREAR_LICENCIA('1233992432','Uganda');
-- SELECT CREAR_TELEFONO(0212,20121312);


CREATE OR REPLACE PROCEDURE ELIMINAR_PERSONAL_INTELIGENCIA (id_empleado_acceso IN INTEGER, id_personal_inteligencia IN INTEGER)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;
    empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	numero_hist_cargo_dep integer;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_PERSONAL_INTELIGENCIA ( % ) ------', NOW();
	
	-------------////////

    SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia;

	IF (personal_inteligencia_reg IS NULL) THEN
		RAISE INFO 'El personal de inteligencia no existe';
		RAISE EXCEPTION 'El personal de inteligencia no existe';
	END IF;

    -------------////////

	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_empleado_acceso;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != 'jefe') THEN
		RAISE INFO 'El empleado no es un jefe de estacion';
		RAISE EXCEPTION 'El empleado no es un jefe de estacion';
	END IF;


	SELECT count(*) INTO numero_hist_cargo_dep FROM HIST_CARGO WHERE id_personal_inteligencia = fk_personal_inteligencia;

	IF ( numero_hist_cargo_dep > 0 ) THEN

		RAISE EXCEPTION 'No se puede eliminar al personal de inteligencia ya algunos registros dependen de el';
	END IF;


	DELETE FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia; 
	
    RAISE INFO 'PERSONAL DE INTELIGENCIA ELIMINADO CON EXITO!';
 

END $$;





------------------------------------------------------------//////////////////////////////------------------------------------------------------------






CREATE OR REPLACE PROCEDURE ASIGNAR_TEMA_ANALISTA (id_empleado_acceso integer, tema_id integer, analista_id integer)
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 

	-- estacion_reg estacion%ROWTYPE;
	hist_cargo_reg hist_cargo%ROWTYPE;	
	empleado_jefe_reg empleado_jefe%ROWTYPE;
	
	tema_reg CLAS_TEMA%ROWTYPE;

	personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;

	temas_esp_exit TEMAS_ESP%ROWTYPE;
	

BEGIN 

	-- CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, personal_inteligencia);

	
	SELECT * INTO tema_reg FROM CLAS_TEMA WHERE id = tema_id;
	
	---VALIDACION SI EL TEMA ES NULO---		
	IF (tema_reg IS NULL) THEN
		
		RAISE EXCEPTION 'No existe el tema';
	END IF;


	SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = analista_id;
	
	---VALIDACION SI EL TEMA ES NULO---		
	IF (personal_inteligencia_reg IS NULL) THEN
		
		RAISE EXCEPTION 'No existe el canalista';
	END IF;


	SELECT * INTO temas_esp_exit FROM TEMAS_ESP WHERE fk_clas_tema = tema_id and fk_personal_inteligencia = analista_id;
		
	---VALIDACION SI EL TEMA ES NULO---		
	IF (temas_esp_exit IS NOT NULL) THEN
		
		RAISE EXCEPTION 'Ya el tema fue asignado';
	END IF;
		
	

	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fecha_fin IS NULL AND fk_personal_inteligencia = analista_id LIMIT 1;

	IF (hist_cargo_reg IS NOT NULL) THEN	
		
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, analista_id);

	END IF;


	INSERT INTO TEMAS_ESP (
		fk_personal_inteligencia,
		fk_clas_tema
	) VALUES (
		analista_id,
		tema_id				
	);
							
	RAISE INFO 'SE INSERTO EN EL PERSONAL DE INTELIGENCIA CON EL ID: %, EL TEMA CON ID: % Y NOMBRE: %', analista_id, tema_id, tema_reg.nombre;
	
END
$$;

-- call ASIGNAR_TEMA_ANALISTA(16,2,21);
-- select * from TEMAS_ESP where fk_personal_inteligencia = 21 



-------------------------//////////////---------------------------------------------//////////////--------------------




CREATE OR REPLACE FUNCTION VER_TODOS_PERSONAL_INTELIGENCIA_SIN_CARGO ()
RETURNS setof PERSONAL_INTELIGENCIA
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM PERSONAL_INTELIGENCIA WHERE id NOT IN (SELECT fk_personal_inteligencia FROM HIST_CARGO); 
$$;


CREATE OR REPLACE FUNCTION VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO (id_empleado_acceso in integer)
RETURNS setof PERSONAL_INTELIGENCIA
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM PERSONAL_INTELIGENCIA WHERE id IN (SELECT fk_personal_inteligencia FROM HIST_CARGO WHERE fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso)); 
$$;



CREATE OR REPLACE FUNCTION VER_PERSONAL_INTELIGENCIA_SIN_CARGO (id_personal_inteligencia in integer)
RETURNS PERSONAL_INTELIGENCIA
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia AND id NOT IN (SELECT fk_personal_inteligencia FROM HIST_CARGO); 
$$;


CREATE OR REPLACE FUNCTION VER_PERSONAL_INTELIGENCIA_CON_CARGO (id_empleado_acceso in integer, id_personal_inteligencia in integer)
RETURNS PERSONAL_INTELIGENCIA
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia AND id IN (SELECT fk_personal_inteligencia FROM HIST_CARGO WHERE fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso)); 
$$;






------------------------------------------------///////////////////////-----------------------------------------------

CREATE OR REPLACE FUNCTION VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia in integer)
RETURNS setof HIST_CARGO
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso); 
$$;


-- SELECT * FROM VER_TODOS_PERSONAL_INTELIGENCIA_SIN_CARGO();
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20,37);
-- SELECT * FROM VER_PERSONAL_INTELIGENCIA_SIN_CARGO(109);



-------------------------//////////////---------------------------------------------//////////////--------------------


CREATE OR REPLACE FUNCTION VER_CUENTA_ESTACION_JEFE_ESTACION (id_empleado_acceso in integer, id_estacion in INTEGER)
RETURNS setof CUENTA
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM CUENTA WHERE fk_estacion = id_estacion AND fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso); 
$$;

-- SELECT * FROM VER_CUENTA_ESTACION(12,4);
-- SELECT * FROM estacion;




-------------------------------------/////////////////////--------------------------------------------




-- DROP PROCEDURE IF EXISTS CERRAR_HIST_CARGO CASCADE;

CREATE OR REPLACE PROCEDURE CERRAR_HIST_CARGO (id_empleado_acceso in integer, id_personal_inteligencia IN integer)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

   hist_cargo_actual_reg HIST_CARGO%ROWTYPE;
   
   fecha_hoy_va timestamp;
  
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERRAR_HIST_CARGO ( % ) ------', NOW();
	
	-------------///////////--------------	


	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fecha_fin IS NULL AND fk_personal_inteligencia = id_personal_inteligencia;

	IF (hist_cargo_actual_reg IS NOT NULL) THEN	
		
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, analista_id);

	END IF;
    
	fecha_hoy_va = NOW();

	UPDATE HIST_CARGO SET fecha_fin = fecha_hoy_va WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL;
		
	RAISE INFO 'CARGO CERRADO CON EXITO!';
 	

END $$;


-- SELECT * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(20);
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20, 37);
-- CALL CERRAR_HIST_CARGO(20,37);



-------------------------//////////////---------------------------------------------//////////////--------------------




-- DROP PROCEDURE IF EXISTS ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO CASCADE;

CREATE OR REPLACE PROCEDURE ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO (id_empleado_acceso in integer, id_personal_inteligencia IN integer, id_estacion in integer, cargo_va IN HIST_CARGO.cargo%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

    hist_cargo_actual_reg HIST_CARGO%ROWTYPE;
    hist_cargo_nuevo_reg HIST_CARGO%ROWTYPE;

    estacion_nueva_reg ESTACION%ROWTYPE;
    estacion_vieja_reg ESTACION%ROWTYPE;

    fecha_hoy_va timestamp;
  
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERRAR_HIST_CARGO ( % ) ------', NOW();
	
	-------------///////////--------------	

    SELECT * INTO estacion_nueva_reg FROM ESTACION WHERE id = id_estacion; 
   	RAISE INFO 'Datos de la estacion nueva: %', estacion_nueva_reg;

    IF (estacion_nueva_reg IS NULL) THEN
        RAISE EXCEPTION 'La estacion nueva no existe';
    END IF;


   	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia ORDER BY fecha_inicio DESC LIMIT 1; 
   	RAISE INFO 'Datos de hist_cargo actual: %', hist_cargo_actual_reg;

   
   	IF (hist_cargo_actual_reg.fk_personal_inteligencia IS NOT NULL) THEN
   		
        IF (hist_cargo_actual_reg.fecha_fin IS NULL) THEN
            RAISE EXCEPTION 'Debe cerrar el cargo antes de poder hacer una tranferencia de estacion';   
        END IF;

        SELECT * INTO estacion_vieja_reg FROM ESTACION WHERE id = hist_cargo_actual_reg.fk_estacion; 
   	    RAISE INFO 'Datos de la estacion vieja: %', estacion_vieja_reg;

        IF (estacion_vieja_reg IS NULL) THEN
            RAISE EXCEPTION 'La estacion vieja no existe';
        END IF;

        IF (estacion_vieja_reg.id = estacion_nueva_reg.id) THEN
            RAISE EXCEPTION 'No se puede cambiar a la misma estacion';
        END IF;

    END IF;   	

    

    IF (id_empleado_acceso != estacion_nueva_reg.fk_empleado_jefe AND (estacion_vieja_reg IS NOT NULL AND id_empleado_acceso != estacion_vieja_reg.fk_empleado_jefe)) THEN
        RAISE EXCEPTION 'El jefe tiene que ser dueño de la estacion nueva, o en caso de ser una tranferencia, dueño de la vieja o de la nueva';
    END IF;  

    
    --------

	fecha_hoy_va = NOW();


	INSERT INTO HIST_CARGO (
		fecha_inicio,
		cargo,
		fk_personal_inteligencia,
		fk_estacion,
		fk_oficina_principal
	) VALUES (
		fecha_hoy_va,
		cargo_va,
		id_personal_inteligencia,
		estacion_nueva_reg.id,
		estacion_nueva_reg.fk_oficina_principal
	);


	RAISE INFO 'PERSONAL DE INTELIGENCIA FUE ASIGNADO EXITOSAMENTE A LA ESTACION!';
 	

END $$;


-- SELECT * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(20);
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20, 37);
-- CALL CERRAR_HIST_CARGO(20,37);

-- select * FROM VER_TODOS_PERSONAL_INTELIGENCIA_SIN_CARGO();
-- select * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(20);
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20,37);

-- CALL cerrar_hist_cargo(20, 109); 
-- CALL ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO(20,109,10,'analista');

-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20,109);

-- select * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(21);
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(21,109);
-- CALL cerrar_hist_cargo(21, 109); 

-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20,109);


---------------------------------------------////////////////////-----------------------------


-- DROP PROCEDURE IF EXISTS CAMBIAR_ROL CASCADE;

CREATE OR REPLACE PROCEDURE CAMBIAR_ROL_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia IN integer, cargo_va IN HIST_CARGO.cargo%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

   hist_cargo_actual_reg HIST_CARGO%ROWTYPE;
   
   fecha_hoy_va timestamp;
  
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CAMBIAR_ROL ( % ) ------', NOW();
	
	-------------///////////--------------	
   
   	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo actual: %', hist_cargo_actual_reg;

    
   --------

   	IF (hist_cargo_actual_reg IS NULL) THEN
   		RAISE INFO 'El personal de inteligencia que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El personal de inteligencia que ingresó no existe o ya no trabaja en AII';
   	
	ELSE 
		
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, id_personal_inteligencia);

	END IF;


	IF (hist_cargo_actual_reg.cargo = cargo_va) THEN
		RAISE INFO 'Ya el personal de inteligencia es un %', cargo_va;
		RAISE EXCEPTION 'Ya el personal de inteligencia es un %', cargo_va;
	END IF;


	IF (cargo_va != 'analista' AND cargo_va != 'agente') THEN
	RAISE INFO 'El cargo que ingresó no existe';
	RAISE EXCEPTION 'El cargo que ingresó no existe';
	END IF;
	
   
	fecha_hoy_va = NOW();


	UPDATE HIST_CARGO SET fecha_fin = fecha_hoy_va WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL;
		
	INSERT INTO HIST_CARGO (
		fecha_inicio,
		cargo,
		fk_personal_inteligencia,
		fk_estacion,
		fk_oficina_principal
	) VALUES (
		fecha_hoy_va,
		cargo_va,
		hist_cargo_actual_reg.fk_personal_inteligencia,
		hist_cargo_actual_reg.fk_estacion,
		hist_cargo_actual_reg.fk_oficina_principal
	);

	RAISE INFO 'CAMBIO DE CARGO EXITOSO!';
 	

END $$;


-- CALL CAMBIAR_ROL_PERSONAL_INTELIGENCIA(14,13,'agente');

-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(14,13);

-- select * from hist_cargo where fk_personal_inteligencia = 1;










------------------------------------------------------//////////////////////--------------------------------


-- DROP PROCEDURE IF EXISTS CAMBIAR_ROL CASCADE;

-- DROP FUNCTION IF EXISTS ELIMINACION_REGISTROS_VENTA_EXCLUSIVA CASCADE;

CREATE OR REPLACE PROCEDURE ELIMINACION_REGISTROS_INFORMANTE ( id_personal_inteligencia IN integer ) 
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
DECLARE 

	id_crudos_asociados integer[] ;	
	-- id_informantes_asociados integer[] ;
	id_piezas_asociadas integer[];	

BEGIN 

	id_crudos_asociados := ARRAY( 
		SELECT id FROM CRUDO WHERE fk_personal_inteligencia_agente = id_personal_inteligencia AND fuente = 'secreta' OR fk_informante IS NOT NULL
	);

	DELETE FROM TRANSACCION_PAGO WHERE fk_informante IN (SELECT id FROM INFORMANTE WHERE fk_personal_inteligencia_encargado = id_personal_inteligencia);
--
	DELETE FROM ANALISTA_CRUDO WHERE fk_crudo = ANY(id_crudos_asociados);

	id_piezas_asociadas := ARRAY(
		SELECT fk_pieza_inteligencia FROM CRUDO_PIEZA WHERE fk_crudo = ANY(id_crudos_asociados)
	);


	DELETE FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = ANY(id_piezas_asociadas);

	DELETE FROM ADQUISICION WHERE fk_pieza_inteligencia = ANY(id_piezas_asociadas);

	DELETE FROM PIEZA_INTELIGENCIA WHERE id = ANY(id_piezas_asociadas);

	DELETE FROM CRUDO WHERE id = ANY(id_crudos_asociados);
--
	DELETE FROM INFORMANTE WHERE fk_personal_inteligencia_encargado = id_personal_inteligencia;

END $$;



-- CALL NUMERO_REGISTROS();   
-- SELECT fk_personal_inteligencia_encargado, count(*) FROM INFORMANTE GROUP BY fk_personal_inteligencia_encargado; 

-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE(13); 

-- select * from transaccion_pago tp  where fk_informante  = 7;
-- select * from crudo where fk_informante  = 7;
-- SELECT * FROM INFORMACION_INFORMANTES(7);

-- nombre_clave,agente_encargado,id_estacion,nombre_estacion,crudos,piezas,crudos_alt,piezas_alt,total_crudos,total_piezas,crudos_usados,eficacia
-- Traccion,13,4,Est. Amsterdam,1,8,0,0,1,8,1,100.0000

-- CALL ELIMINACION_REGISTROS_INFORMANTE(7);
-- SELECT * FROM INFORMACION_INFORMANTES(7);

-- select * from informante where 

-- select * from transaccion_pago tp  where fk_informante  = 19;
-- select * from crudo where fk_informante  = 19;
-- SELECT * FROM INFORMACION_INFORMANTES(19);


-- CALL ELIMINACION_REGISTROS_INFORMANTE(13);

-----------------------------//////////////////------------------------




CREATE OR REPLACE PROCEDURE DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia IN integer)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

   hist_cargo_actual_reg HIST_CARGO%ROWTYPE;
   
  
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA ( % ) ------', NOW();
	
	-------------///////////--------------	
	

   	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo actual: %', hist_cargo_actual_reg;

   --------

   	IF (hist_cargo_actual_reg IS NOT NULL) THEN
   			
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, id_personal_inteligencia);
		CALL CERRAR_HIST_CARGO(id_empleado_acceso,id_personal_inteligencia);

	END IF;

   
	CALL ELIMINACION_REGISTROS_INFORMANTE(id_personal_inteligencia);


	RAISE INFO 'DESPIDO / RENUNCIA EXITOSA!';
 	

END $$;






----------///////////- ---------------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- CREACION DE PROCEDIMIENTOS Y FUNCIONES RELACIONADOS AL ROL PERSONAL DE INTELIGENCIA Pt1   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- --------------------------------------------------------------------------------------------------------------- ///////////----------


--------------------------///////////////////////-----------------------------


-- Demostración de la implementación de los requerimientos del sistema de bases de datos 
-- transaccional referidos al proceso de venta de piezas – actividades de recolección y 
-- verificación de hechos crudos y manejo de informantes, incluyendo la seguridad correspondiente 
-- (roles, cuentas con privilegios para poder ejecutar los programas y reportes).


-- Verificación_Hechos_Crudos (3) - elegir analistas, definir rango de tiempo para cargar 
-- confiabilidades, pedir nivel a asignar por analista, guardar y calcular promedio, actualizar 
-- el hecho crudo con la fecha final y el promedio calculado. Aplicando todas las validaciones
-- necesarias sobre cada paso…


-- La información recolectada por los agentes de campo se indexa (fecha más reciente) y almacena
-- como hechos crudos y se puede buscar por tópicos principales (países, individuos, eventos,
-- empresas), cada uno de los cuales está dividido en temas de interés. La AII no vende hechos crudos
-- (la información traída por los agentes) sino piezas de inteligencia verificadas por varias fuentes (al
-- menos 2 analistas de diferentes estaciones deben participar en la verificación de los hechos crudos
-- que conforman la pieza de inteligencia). Cuando un agente reporta un hecho crudo también indica
-- su nivel de confiabilidad de 0 a 100 con respecto a la exactitud o veracidad del mismo. Los analistas,
-- luego de su verificación pueden avalar ese nivel, aumentarlo o bajarlo. Sólo hechos crudos con un
-- nivel superior a 85 pueden formar parte de una pieza de inteligencia. Cada pieza de inteligencia
-- debe tener registrado su nivel de confiabilidad (se calcula como el promedio del nivel de
-- confiabilidad verificada de los hechos crudos que la conforman). El analista responsable5 por la
-- construcción de la pieza la certifica fijándole un precio aproximado, el cual será exacto luego de la
-- negociación en la cual es vendida – debe haber registro del precio final alcanzado. Sólo los analistas
-- fijan el precio base de las piezas de inteligencia. Una pieza de inteligencia registrada no puede ser
-- alterada.




CREATE OR REPLACE FUNCTION VER_LISTA_CRUDOS_ESTACION (id_estacion in integer)
RETURNS setof CRUDO
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM CRUDO WHERE fk_estacion_pertenece = id_estacion; 
$$;

-- SELECT * FROM VER_LISTA_CRUDOS_ESTACION(4);


CREATE OR REPLACE FUNCTION VER_LISTA_CRUDOS_PERSONAL (id_personal_inteligencia in integer)
RETURNS setof CRUDO
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM CRUDO WHERE fk_personal_inteligencia_agente = id_personal_inteligencia; 
$$;

-- SELECT * FROM VER_LISTA_CRUDOS_PERSONAL(16);




CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_personal_inteligencia_confidente = id_personal_inteligencia; 
$$;

-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE(11);

-- SELECT * from informante;


-------------------------/////////////////////-----------------------



CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_personal_inteligencia_encargado = id_personal_inteligencia; 
$$;


--------------------------///////////////////////-----------------------------


-- DROP PROCEDURE IF EXISTS REGISTRO_INFORMANTE CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_INFORMANTE (nombre_clave_va IN INFORMANTE.nombre_clave%TYPE, id_agente_campo IN integer, id_empleado_jefe_confidente IN integer, id_personal_inteligencia_confidente IN integer)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

    agente_campo_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
	hist_cargo_agente_encargado_reg HIST_CARGO%ROWTYPE;

	personal_confidente_reg PERSONAL_INTELIGENCIA%ROWTYPE;
	hist_cargo_personal_confidente_reg HIST_CARGO%ROWTYPE;

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	informante_reg INFORMANTE%ROWTYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_INFORMANTE ( % ) ------', NOW();
	
	-------------/////////// VALIDACIONES DE LLAVES


	IF (id_empleado_jefe_confidente IS NULL AND id_personal_inteligencia_confidente IS NULL) THEN
		RAISE INFO 'Debe ingresar a alguna persona de la AII como confidente de la informacion de este informante';
  		RAISE EXCEPTION 'Debe ingresar a alguna persona de la AII como confidente de la informacion de este informante';
	END IF;

	IF (id_empleado_jefe_confidente IS NOT NULL AND id_personal_inteligencia_confidente IS NOT NULL) THEN
		RAISE INFO 'No puede ingresar dos confidentes de información';
  		RAISE EXCEPTION 'No puede ingresar dos confidentes de información';
	END IF;

	IF (id_agente_campo = id_personal_inteligencia_confidente) THEN
		RAISE INFO 'El agente de campo encargado y el personal de inteligencia confidente no pueden ser el mismo';
  		RAISE EXCEPTION 'El agente de campo encargado y el personal de inteligencia confidente no pueden ser el mismo';
	END IF;


	-------------/////////// VALIDACIONES DE NOMBRE CLAVE

	IF (nombre_clave_va IS NULL OR nombre_clave_va = '') THEN
   		RAISE INFO 'Debe ingresar un nombre clave para el informante';
  		RAISE EXCEPTION 'Debe ingresar un nombre clave para el informante';
   	END IF;   	

	SELECT * INTO informante_reg FROM INFORMANTE WHERE nombre_clave = nombre_clave_va;

--	RAISE INFO 'DATOS DE INFORMANTE %:', informante_reg;
	
	IF (informante_reg.id IS NOT NULL) THEN
	
		RAISE INFO 'El nombre clave que ingresó ya se encuentra en uso';
  		RAISE EXCEPTION 'El nombre clave que ingresó ya se encuentra en uso';
	END IF;
	
	
	
	-------------////  BUSQUEDA DEL AGENTE ENCARGADO

    SELECT * INTO agente_campo_encargado_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_agente_campo;
    RAISE INFO 'datos del agente de campo encargado: %', agente_campo_encargado_reg;
   
   	SELECT * INTO hist_cargo_agente_encargado_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_agente_campo AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo del agente encargado: %', hist_cargo_agente_encargado_reg;

	
	IF (hist_cargo_agente_encargado_reg IS NULL) THEN
   		RAISE INFO 'El agente de campo que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El agente de campo que ingresó no existe o ya no trabaja en AII';
   	END IF;   	
  	
	IF (hist_cargo_agente_encargado_reg.cargo != 'agente') THEN
		RAISE INFO 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
		RAISE EXCEPTION 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
	END IF;


	-------------////////

	IF (id_personal_inteligencia_confidente IS NOT NULL) THEN

		-------------////  BUSQUEDA DEL PERSONAL CONFIDENTE

		SELECT * INTO personal_confidente_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia_confidente;
		RAISE INFO 'datos del personal de inteligencia confidente: %', personal_confidente_reg;
	
		SELECT * INTO hist_cargo_personal_confidente_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia_confidente AND fecha_fin IS NULL; 
		RAISE INFO 'datos de hist_cargo del personal de inteligencia confidente: %', hist_cargo_personal_confidente_reg;
	
		
		IF (hist_cargo_personal_confidente_reg IS NULL) THEN
	   		RAISE INFO 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
	  		RAISE EXCEPTION 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
   		END IF;   	
	
	
		INSERT INTO INFORMANTE (
			nombre_clave,

			fk_personal_inteligencia_encargado,
			fk_fecha_inicio_encargado,
			fk_estacion_encargado,
			fk_oficina_principal_encargado,
			
			fk_personal_inteligencia_confidente,
			fk_fecha_inicio_confidente,
			fk_estacion_confidente,
			fk_oficina_principal_confidente
		
		) VALUES (
   			nombre_clave_va,

			hist_cargo_agente_encargado_reg.fk_personal_inteligencia,
			hist_cargo_agente_encargado_reg.fecha_inicio,
			hist_cargo_agente_encargado_reg.fk_estacion,
			hist_cargo_agente_encargado_reg.fk_oficina_principal,
			
			hist_cargo_personal_confidente_reg.fk_personal_inteligencia,
			hist_cargo_personal_confidente_reg.fecha_inicio,
			hist_cargo_personal_confidente_reg.fk_estacion,
			hist_cargo_personal_confidente_reg.fk_oficina_principal

    	) RETURNING * INTO informante_reg;

	ELSE

		-------------////  BUSQUEDA DEL EMPLEADO_JEFE CONFIDENTE

		SELECT * INTO empleado_jefe_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_jefe_confidente;
		RAISE INFO 'datos del empleado jefe confidente: %', empleado_jefe_reg;
   
   
		INSERT INTO INFORMANTE (
			nombre_clave,

			fk_personal_inteligencia_encargado,
			fk_fecha_inicio_encargado,
			fk_estacion_encargado,
			fk_oficina_principal_encargado,
			
			fk_empleado_jefe_confidente
		
		) VALUES (
   			nombre_clave_va,

			hist_cargo_agente_encargado_reg.fk_personal_inteligencia,
			hist_cargo_agente_encargado_reg.fecha_inicio,
			hist_cargo_agente_encargado_reg.fk_estacion,
			hist_cargo_agente_encargado_reg.fk_oficina_principal,
			
			empleado_jefe_reg.id

    	) RETURNING * INTO informante_reg;


	END IF;
    


   RAISE INFO 'INFORMANTE CREADO CON EXITO!';
   RAISE INFO 'Datos del informante: %', informante_reg ; 



END $$;



-- CALL REGISTRO_INFORMANTE( 'aja prueba 2', 2, 1, null );


--------------------------///////////////////////-----------------------------


-- DROP PROCEDURE IF EXISTS REGISTRO_CRUDO_SIN_INFORMANTE CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_CRUDO_SIN_INFORMANTE (id_agente_campo IN integer, id_tema IN integer, contenido_va IN CRUDO.contenido%TYPE, tipo_contenido_va IN CRUDO.tipo_contenido%TYPE, resumen_va IN CRUDO.resumen%TYPE, fuente_va IN CRUDO.fuente%TYPE, valor_apreciacion_va IN CRUDO.valor_apreciacion%TYPE, nivel_confiabilidad_inicial_va IN CRUDO.nivel_confiabilidad_inicial%TYPE, cant_analistas_verifican_va IN CRUDO.cant_analistas_verifican%TYPE )
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

    agente_campo_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
	hist_cargo_agente_encargado_reg HIST_CARGO%ROWTYPE;

	-- informante_reg INFORMANTE%ROWTYPE;
	-- tema_reg CLAS_TEMA%ROWTYPE;
	crudo_reg CRUDO%ROWTYPE;

	fecha_obtencion_va CRUDO.fecha_obtencion%TYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_CRUDO_SIN_INFORMANTE ( % ) ------', NOW();
	
	-------------/////////// VALIDACIONES DE LLAVES


	IF (fuente_va != 'abierta' AND fuente_va != 'tecnica') THEN
		RAISE INFO 'Para el registro de crudos con fuente secreta, por favor use el programa "REGISTRO_CRUDO_CON_INFORMANTE" ';
  		RAISE EXCEPTION 'Para el registro de crudos con fuente secreta, por favor use el programa "REGISTRO_CRUDO_CON_INFORMANTE" ';
	END IF;


	SELECT * INTO agente_campo_encargado_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_agente_campo;
	RAISE INFO 'datos del agente de campo encargado: %', agente_campo_encargado_reg;

	SELECT * INTO hist_cargo_agente_encargado_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_agente_campo AND fecha_fin IS NULL; 
	RAISE INFO 'datos de hist_cargo del agente encargado: %', hist_cargo_agente_encargado_reg;

	IF (hist_cargo_agente_encargado_reg IS NULL) THEN
		RAISE INFO 'El agente de campo que ingresó no existe o ya no trabaja en AII';
		RAISE EXCEPTION 'El agente de campo que ingresó no existe o ya no trabaja en AII';
	END IF;   	
	
	IF (hist_cargo_agente_encargado_reg.cargo != 'agente') THEN
		RAISE INFO 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
		RAISE EXCEPTION 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
	END IF;


	fecha_obtencion_va = NOW();
   
   
	INSERT INTO CRUDO (
		contenido,
		tipo_contenido,
		resumen,
		fuente, 
		valor_apreciacion,
		nivel_confiabilidad_inicial,
		fecha_obtencion,
		cant_analistas_verifican,

		fk_clas_tema,

		--estacion a donde pertence
		fk_estacion_pertenece,
		fk_oficina_principal_pertenece,

		--agente encargado
		fk_estacion_agente,
		fk_oficina_principal_agente,
		fk_fecha_inicio_agente,
		fk_personal_inteligencia_agente
	
	) VALUES (
		
		contenido_va,
		tipo_contenido_va,
		resumen_va,
		fuente_va, 
		valor_apreciacion_va,
		nivel_confiabilidad_inicial_va,
		fecha_obtencion_va,
		cant_analistas_verifican_va,

		id_tema,


		--estacion a donde pertence
		hist_cargo_agente_encargado_reg.fk_estacion,
		hist_cargo_agente_encargado_reg.fk_oficina_principal,

		--agente encargado
		hist_cargo_agente_encargado_reg.fk_estacion,
		hist_cargo_agente_encargado_reg.fk_oficina_principal,
		hist_cargo_agente_encargado_reg.fecha_inicio,
		hist_cargo_agente_encargado_reg.fk_personal_inteligencia

	) RETURNING * INTO crudo_reg;



   RAISE INFO 'CRUDO CREADO CON EXITO!';
   RAISE INFO 'Datos del crudo: %', crudo_reg ; 



END $$;


-- bien
-- CALL REGISTRO_CRUDO_SIN_INFORMANTE(2, 1, FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'resumen crudo prueba', 'abierta', 999, 5, 3);

-- mal
-- CALL a_INFORMANTE(2, 1, FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'resumen', 'tecnica', null, 25, 5);


--------------------------///////////////////////-----------------------------


-- DROP PROCEDURE IF EXISTS REGISTRO_CRUDO_CON_INFORMANTE CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_CRUDO_CON_INFORMANTE ( id_informante IN integer, monto_pago_va IN TRANSACCION_PAGO.monto_pago%TYPE, id_agente_campo IN integer, id_tema IN integer, contenido_va IN CRUDO.contenido%TYPE, tipo_contenido_va IN CRUDO.tipo_contenido%TYPE, resumen_va IN CRUDO.resumen%TYPE, valor_apreciacion_va IN CRUDO.valor_apreciacion%TYPE, nivel_confiabilidad_inicial_va IN CRUDO.nivel_confiabilidad_inicial%TYPE, cant_analistas_verifican_va IN CRUDO.cant_analistas_verifican%TYPE )
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

    agente_campo_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
	hist_cargo_agente_encargado_reg HIST_CARGO%ROWTYPE;

	informante_reg INFORMANTE%ROWTYPE;
	-- tema_reg CLAS_TEMA%ROWTYPE;
	crudo_reg CRUDO%ROWTYPE;
	transaccion_pago_reg TRANSACCION_PAGO%ROWTYPE;

	fuente_va CRUDO.fuente%TYPE := 'secreta';
	fecha_obtencion_va CRUDO.fecha_obtencion%TYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_CRUDO_CON_INFORMANTE ( % ) ------', NOW();
	
	-------------/////////// VALIDACIONES DE LLAVES


	IF (monto_pago_va IS NULL OR monto_pago_va <= 0) THEN
   		RAISE INFO 'El monto pagado por el crudo al informante debe ser mayor a 0$';
  		RAISE EXCEPTION 'El monto pagado por el crudo al informante debe ser mayor a 0$';
   	END IF; 


	SELECT * INTO informante_reg FROM INFORMANTE WHERE id = id_informante AND fk_personal_inteligencia_encargado = id_agente_campo;

	RAISE INFO 'DATOS DE INFORMANTE %:', informante_reg;
	
	IF (informante_reg IS NULL) THEN
		RAISE INFO 'El informante que ingresó no se encuetra registrado o no le pertenece al agente que ingresó';
  		RAISE EXCEPTION 'El informante que ingresó no se encuetra registrado o no le pertenece al agente que ingresó';
	END IF;

	
	
	-------------////  BUSQUEDA DEL AGENTE ENCARGADO

    SELECT * INTO agente_campo_encargado_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_agente_campo;
    RAISE INFO 'datos del agente de campo encargado: %', agente_campo_encargado_reg;
   
   	SELECT * INTO hist_cargo_agente_encargado_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_agente_campo AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo del agente encargado: %', hist_cargo_agente_encargado_reg;

	
	IF (hist_cargo_agente_encargado_reg IS NULL) THEN
   		RAISE INFO 'El agente de campo que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El agente de campo que ingresó no existe o ya no trabaja en AII';
   	END IF;   	
  	
	IF (hist_cargo_agente_encargado_reg.cargo != 'agente') THEN
		RAISE INFO 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
		RAISE EXCEPTION 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
	END IF;


	-------------////////

	fecha_obtencion_va = NOW();
   
   
	INSERT INTO CRUDO (
		contenido,
		tipo_contenido,
		resumen,
		fuente, 
		valor_apreciacion,
		nivel_confiabilidad_inicial,
		fecha_obtencion,
		cant_analistas_verifican,

		fk_clas_tema,
		fk_informante,

		--estacion a donde pertence
		fk_estacion_pertenece,
		fk_oficina_principal_pertenece,

		--agente encargado
		fk_estacion_agente,
		fk_oficina_principal_agente,
		fk_fecha_inicio_agente,
		fk_personal_inteligencia_agente
	
	) VALUES (
		
		contenido_va,
		tipo_contenido_va,
		resumen_va,
		fuente_va, 
		valor_apreciacion_va,
		nivel_confiabilidad_inicial_va,
		fecha_obtencion_va,
		cant_analistas_verifican_va,

		id_tema,
		id_informante,

		--estacion a donde pertence
		hist_cargo_agente_encargado_reg.fk_estacion,
		hist_cargo_agente_encargado_reg.fk_oficina_principal,

		--agente encargado
		hist_cargo_agente_encargado_reg.fk_estacion,
		hist_cargo_agente_encargado_reg.fk_oficina_principal,
		hist_cargo_agente_encargado_reg.fecha_inicio,
		hist_cargo_agente_encargado_reg.fk_personal_inteligencia

	) RETURNING * INTO crudo_reg;



   RAISE INFO 'CRUDO CREADO CON EXITO!';
   RAISE INFO 'Datos del crudo: %', crudo_reg ; 

	-------//////
      
   
	INSERT INTO TRANSACCION_PAGO (
		fecha_hora,
		monto_pago,
		fk_crudo,
		fk_informante
	
	) VALUES (
		
		fecha_obtencion_va,
		monto_pago_va,
		crudo_reg.id,
		id_informante

	) RETURNING * INTO transaccion_pago_reg;



   RAISE INFO 'TRANSACCIÓN DE PAGO DE CRUDO CREADA CON EXITO!';
   RAISE INFO 'Datos de la transacción: %', transaccion_pago_reg ; 



END $$;



-- CALL REGISTRO_CRUDO_CON_INFORMANTE(33, 100, 2, 1, FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'resumen crudo prueba', 999, 5, 3);



-- select * from informante where fk_personal_inteligencia_encargado = 2;
-- select * from crudo where fk_personal_inteligencia_agente = 2;
-- select * from transaccion_pago ORDER BY fecha_hora DESC;



---------------------------////////////////////////////-------------------------------



-------------////////.........^^^^^^^^^^^^^^^^^^^^^..........\\\\\\\\\\-------------



-- DROP FUNCTION IF EXISTS ANALISTA_VERIFICO_CRUDO CASCADE;

CREATE OR REPLACE FUNCTION ANALISTA_VERIFICO_CRUDO ( id_crudo IN integer, id_analista IN integer ) 
RETURNS boolean
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
DECLARE 

	registro record;

BEGIN 
	
	SELECT * INTO registro FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo AND fk_personal_inteligencia_analista = id_analista;
	
	IF (registro IS NULL) THEN
		RETURN false;
	END IF;

	RETURN true;
	
END $$;


-------------////////.........^^^^^^^^^^^^^^^^^^^^^..........\\\\\\\\\\-------------



-- DROP FUNCTION IF EXISTS ANALISTA_PUEDE_VERIFICA_CRUDO CASCADE;

CREATE OR REPLACE FUNCTION ANALISTA_PUEDE_VERIFICA_CRUDO ( id_crudo IN integer, id_analista IN integer ) 
RETURNS boolean
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
DECLARE 

	id_estacion_analista integer;
	id_estaciones_otros_analistas integer[];
	id_estacion_crudo integer;

BEGIN 

	-- estacion del analista
	SELECT fk_estacion INTO id_estacion_analista FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista AND fecha_fin IS NULL; 
	
	-- estacion del crudo
	SELECT fk_estacion_pertenece INTO id_estacion_crudo FROM CRUDO WHERE id = id_crudo;
	

	-- estacion de los analistas que verificaron el crudo
	id_estaciones_otros_analistas := ARRAY( 
		SELECT fk_estacion_analista FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo
	);
	
	
	IF (id_estacion_analista = id_estacion_crudo OR id_estacion_analista = ANY(id_estaciones_otros_analistas)) THEN
		RETURN false;
	END IF;

	RETURN true;
	
END $$;



--select analista_puede_verifica_crudo(5, 4);
--
--select * from analista_crudo ac where fk_crudo = 5;
--select * from hist_cargo hc where fk_personal_inteligencia = 4;

--------------------------///////////////////////-----------------------------


-- Demostración de la implementación de los requerimientos del sistema de bases de datos 
-- transaccional referidos al proceso de venta de piezas – actividades de recolección y 
-- verificación de hechos crudos y manejo de informantes, incluyendo la seguridad correspondiente 
-- (roles, cuentas con privilegios para poder ejecutar los programas y reportes).


-- Verificación_Hechos_Crudos (3) - elegir analistas, definir rango de tiempo para cargar 
-- confiabilidades, pedir nivel a asignar por analista, guardar y calcular promedio, actualizar 
-- el hecho crudo con la fecha final y el promedio calculado. Aplicando todas las validaciones
-- necesarias sobre cada paso…


-- La información recolectada por los agentes de campo se indexa (fecha más reciente) y almacena
-- como hechos crudos y se puede buscar por tópicos principales (países, individuos, eventos,
-- empresas), cada uno de los cuales está dividido en temas de interés. La AII no vende hechos crudos
-- (la información traída por los agentes) sino piezas de inteligencia verificadas por varias fuentes (al
-- menos 2 analistas de diferentes estaciones deben participar en la verificación de los hechos crudos
-- que conforman la pieza de inteligencia). Cuando un agente reporta un hecho crudo también indica
-- su nivel de confiabilidad de 0 a 100 con respecto a la exactitud o veracidad del mismo. Los analistas,
-- luego de su verificación pueden avalar ese nivel, aumentarlo o bajarlo. Sólo hechos crudos con un
-- nivel superior a 85 pueden formar parte de una pieza de inteligencia. Cada pieza de inteligencia
-- debe tener registrado su nivel de confiabilidad (se calcula como el promedio del nivel de
-- confiabilidad verificada de los hechos crudos que la conforman). El analista responsable5 por la
-- construcción de la pieza la certifica fijándole un precio aproximado, el cual será exacto luego de la
-- negociación en la cual es vendida – debe haber registro del precio final alcanzado. Sólo los analistas
-- fijan el precio base de las piezas de inteligencia. Una pieza de inteligencia registrada no puede ser
-- alterada.

--------------------------///////////////////////-----------------------------






-- DROP PROCEDURE IF EXISTS VERIFICAR_CRUDO CASCADE;


CREATE OR REPLACE PROCEDURE VERIFICAR_CRUDO ( id_analista IN integer, id_crudo IN integer, nivel_confiabilidad_va IN ANALISTA_CRUDO.nivel_confiabilidad%TYPE )
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

    analista_reg PERSONAL_INTELIGENCIA%ROWTYPE;
	hist_cargo_analista_reg HIST_CARGO%ROWTYPE;

	crudo_reg CRUDO%ROWTYPE;
	analista_crudo_reg ANALISTA_CRUDO%ROWTYPE;

	fecha_hora_va ANALISTA_CRUDO.fecha_hora%TYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO VERIFICAR_CRUDO ( % ) ------', NOW();
	
	
	IF (nivel_confiabilidad_va IS NULL OR nivel_confiabilidad_va < 0 OR nivel_confiabilidad_va > 100 ) THEN
   		RAISE INFO 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
  		RAISE EXCEPTION 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
   	END IF; 


    SELECT * INTO analista_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_analista;
    RAISE INFO 'datos del analista a verficar: %', analista_reg;
   
   	SELECT * INTO hist_cargo_analista_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo del analista: %', hist_cargo_analista_reg;

	
	IF (hist_cargo_analista_reg IS NULL) THEN
   		RAISE INFO 'El analista que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El analista que ingresó no existe o ya no trabaja en AII';
   	END IF;   	
  	
	IF (hist_cargo_analista_reg.cargo != 'analista') THEN
		RAISE INFO 'El analista que ingresó no es un analista en su cargo actual';
		RAISE EXCEPTION 'El analista que ingresó no es un analista en su cargo actual';
	END IF;

	-------------////////

	SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo; 
   	RAISE INFO 'datos de crudo a verificar: %', crudo_reg;

	
	IF (crudo_reg IS NULL) THEN
   		RAISE INFO 'El crudo que ingresó no existe';
  		RAISE EXCEPTION 'El crudo que ingresó no existe';
   	END IF;  

	-------------////////

	IF (ANALISTA_VERIFICO_CRUDO(id_crudo, id_analista) = true) THEN
   		RAISE INFO 'Ya el analista que ingresó verificó este crudo';
  		RAISE EXCEPTION 'Ya el analista que ingresó verificó este crudo';
   	END IF; 


	IF (crudo_reg.nivel_confiabilidad_final IS NOT NULL OR crudo_reg.fecha_verificacion_final IS NOT NULL OR VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo) >= crudo_reg.cant_analistas_verifican) THEN
   		RAISE INFO 'El crudo ya fue verificado, puede que falte cerrar el crudo';
  		RAISE EXCEPTION 'El crudo ya fue verificado, puede que falte cerrar el crudo';
   	END IF; 

	IF (ANALISTA_PUEDE_VERIFICA_CRUDO(id_crudo, id_analista) = false) THEN
   		RAISE INFO 'El analista no puede verificar el crudo ya que tiene que pertenecer a una estacion diferente que los otros analistas que verificaron, asi como la estacion de procedencia del crudo';
  		RAISE EXCEPTION 'El analista no puede verificar el crudo ya que tiene que pertenecer a una estacion diferente que los otros analistas que verificaron, asi como la estacion de procedencia del crudo';
   	END IF; 

	------------- ///////
	
	fecha_hora_va = NOW();

	INSERT INTO ANALISTA_CRUDO (
		fecha_hora,
		nivel_confiabilidad,
		fk_crudo,
		
		fk_fecha_inicio_analista,
		fk_personal_inteligencia_analista,
		fk_estacion_analista,
		fk_oficina_principal_analista
	
	) VALUES (
		fecha_hora_va,
		nivel_confiabilidad_va,
		id_crudo,

		hist_cargo_analista_reg.fecha_inicio,
		hist_cargo_analista_reg.fk_personal_inteligencia,
		hist_cargo_analista_reg.fk_estacion,
		hist_cargo_analista_reg.fk_oficina_principal

	) RETURNING * INTO analista_crudo_reg;


    

   RAISE INFO 'CRUDO VERIFICADO CREADO CON EXITO!';
   RAISE INFO 'Datos del registro: %', analista_crudo_reg ; 

   RAISE INFO 'Faltan % verificaciones para poder cerrar el crudo', ( crudo_reg.cant_analistas_verifican - VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo)) ;



END $$;



--CALL VERIFICAR_CRUDO( id_analista, id_crudo, nivel_confiabilidad );


--------------------------///////////////////////-----------------------------


-- DROP PROCEDURE IF EXISTS CERRAR_CRUDO CASCADE;


CREATE OR REPLACE PROCEDURE CERRAR_CRUDO ( id_crudo IN integer )
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

   	crudo_reg CRUDO%ROWTYPE;

	fecha_verificacion_final_va CRUDO.fecha_verificacion_final%TYPE;
	nivel_confiabilidad_promedio_va CRUDO.nivel_confiabilidad_final%TYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERRAR_CRUDO ( % ) ------', NOW();
	
	
	SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo; 
   	RAISE INFO 'datos de crudo a verificar: %', crudo_reg;

	IF (crudo_reg IS NULL) THEN
   		RAISE INFO 'El crudo que ingresó no existe';
  		RAISE EXCEPTION 'El crudo que ingresó no existe';
   	END IF;  
	
	-------------////////


	IF (crudo_reg.nivel_confiabilidad_final IS NOT NULL OR crudo_reg.fecha_verificacion_final IS NOT NULL) THEN
   		RAISE INFO 'El crudo ya fue verificado';
  		RAISE EXCEPTION 'El crudo ya fue verificado';
   	END IF; 


	IF ( VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo) < crudo_reg.cant_analistas_verifican ) THEN
   		RAISE INFO 'No se cumple el número mínimo de verificaciones, faltan: %', ( crudo_reg.cant_analistas_verifican - VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo)) ;
  		RAISE EXCEPTION 'No se cumple el número mínimo de verificaciones, faltan: %', ( crudo_reg.cant_analistas_verifican - VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo)) ;
   	END IF;   	

	
	SELECT MAX(fecha_hora) INTO fecha_verificacion_final_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;

	SELECT sum(nivel_confiabilidad)/count(*) INTO nivel_confiabilidad_promedio_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;

	UPDATE CRUDO SET nivel_confiabilidad_final = nivel_confiabilidad_promedio_va, fecha_verificacion_final = fecha_verificacion_final_va WHERE id = id_crudo RETURNING * INTO crudo_reg;


   RAISE INFO 'CRUDO CERRADO EXITO!';
   RAISE INFO 'Datos del crudo verificado: %', crudo_reg ; 



END $$;



--CALL VERIFICAR_CRUDO( id_analista, id_crudo, nivel_confiabilidad );

-- CALL VERIFICAR_CRUDO( 53, 31 , 85);

-- CALL CERRAR_CRUDO(31);







----------///////////- ---------------------------------------------------------------------------------------------------------------- ///////////----------
----------//////////////////- CREACION DE PROCEDIMIENTOS Y FUNCIONES RELACIONADOS AL ROL PERSONAL DE INTELIGENCIA Pt2   -- EJECUTAR COMO DEV -///////////////////////----------
----------///////////- --------------------------------------------------------------------------------------------------------------- ///////////----------





--------------------------///////////////////////-----------------------------
 

-- 4. Demostración de la implementación de los requerimientos del sistema de bases de datos transaccional 
-- referidos al proceso de venta de piezas de inteligencia – construcción de piezas de inteligencia y 
-- venta a clientes, incluyendo la seguridad correspondiente (roles, cuentas con privilegios para poder 
-- ejecutar los programas y reportes).


-- El analista responsable5 por la
-- construcción de la pieza la certifica fijándole un precio aproximado, el cual será exacto luego de la
-- negociación en la cual es vendida – debe haber registro del precio final alcanzado. Sólo los analistas
-- fijan el precio base de las piezas de inteligencia. Una pieza de inteligencia registrada no puede ser
-- alterada

-- Muchos de los clientes son muy sensibles con respecto a la absoluta exclusividad de la información
-- que compran. Ellos desean ser los únicos compradores no importando que el precio en estos casos
-- sea mucho más alto (una pieza de inteligencia de venta exclusiva tiene al menos el 45% de recargo
-- de su precio base).Para estos casos hay que asegurarse que dichas piezas de inteligencia no se
-- pueden volver a vender y también se debería saber quiénes son los clientes que exigen las ventas
-- exclusivas para otras oportunidades de negocio.


-- Registro_Venta (4) – pedir cliente, pieza, ver si es cliente exclusivo y si aplica la pieza si no cancelar. 
-- Si está bien generar el registro, y si la venta es exclusiva proceder a guardar la info y luego eliminar 
-- de las tablas originales.

--------------------------///////////////////////-----------------------------



CREATE OR REPLACE FUNCTION VER_LISTA_PIEZAS_ESTACION (id_estacion in integer)
RETURNS setof PIEZA_INTELIGENCIA
LANGUAGE sql
SECURITY DEFINER
AS $$  
 	
    SELECT * FROM PIEZA_INTELIGENCIA WHERE fk_estacion_analista = id_estacion; 
$$;

-- SELECT * FROM VER_LISTA_PIEZAS_ESTACION(4);







-- DROP PROCEDURE IF EXISTS REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA CASCADE;

CREATE OR REPLACE PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (id_analista_encargado IN integer, descripcion IN PIEZA_INTELIGENCIA.descripcion%TYPE, id_crudo_base IN integer)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	id_pieza integer;

    fecha_creacion_va PIEZA_INTELIGENCIA.fecha_creacion%TYPE;
    class_seguridad_va PIEZA_INTELIGENCIA.class_seguridad%TYPE;

    analista_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
   	hist_cargo_reg HIST_CARGO%ROWTYPE;
	crudo_base_reg CRUDO%ROWTYPE;
     
    pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA ( % ) ------', NOW();
	
	-------------///////////--------------	


    SELECT * INTO analista_encargado_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_analista_encargado;
    RAISE INFO 'datos de persona inteligencia: %', analista_encargado_reg;
   
   	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista_encargado AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo: %', hist_cargo_reg;

	SELECT * INTO crudo_base_reg FROM CRUDO WHERE id = id_crudo_base;
    RAISE INFO 'datos del crudo base: %', crudo_base_reg;
    
   --------

   	IF (hist_cargo_reg IS NULL) THEN
   		RAISE INFO 'El analista que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El analista que ingresó no existe o ya no trabaja en AII';
   	END IF;   	
  	
   
	IF (hist_cargo_reg.cargo != 'analista') THEN
		RAISE INFO 'El analista que ingresó no es un analista en su cargo actual';
		RAISE EXCEPTION 'El analista que ingresó no es un analista en su cargo actual';
	END IF;

	IF (crudo_base_reg IS NULL) THEN
   		RAISE INFO 'El crudo que ingresó no está registrado o no cumple con los requerimientos necesarios';
  		RAISE EXCEPTION 'El crudo que ingresó no está registrado o no cumple con los requerimientos necesarios';
   	END IF;   	
  
   	IF ( VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo_base) != crudo_base_reg.cant_analistas_verifican ) THEN
   		RAISE INFO 'El crudo que ingresó no ha sido verificado';
  		RAISE EXCEPTION 'El crudo que ingresó no ha sido verificado';
   	END IF;   	

	IF (ANALISTA_VERIFICO_CRUDO(id_crudo_base, id_analista_encargado) = true) THEN
   		RAISE INFO 'La pieza no puede tener ningun crudo verificado por el analista encargado';
  		RAISE EXCEPTION 'La pieza no puede tener ningun crudo verificado por el analista encargado';
   	END IF; 

	IF (hist_cargo_reg.fk_estacion != crudo_base_reg.fk_estacion_pertenece) THEN
		RAISE INFO 'El analista no pertenece a la misma estación que el crudo';
  		RAISE EXCEPTION 'El analista no pertenece a la misma estación que el crudo';
	END IF;

   	IF (crudo_base_reg.nivel_confiabilidad_final <= 85 ) THEN
   		RAISE INFO 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 )';
  		RAISE EXCEPTION 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 )';
   	END IF;   	
   
	fecha_creacion_va = NOW();
	class_seguridad_va = analista_encargado_reg.class_seguridad;
 
 	

 	-------------///////////--------------	
 

    INSERT INTO PIEZA_INTELIGENCIA (fecha_creacion,descripcion,class_seguridad,fk_fecha_inicio_analista,fk_personal_inteligencia_analista,fk_estacion_analista,fk_oficina_principal_analista,fk_clas_tema) VALUES (
   	
    	fecha_creacion_va,
    	descripcion,
    	class_seguridad_va,
   		hist_cargo_reg.fecha_inicio,
   		hist_cargo_reg.fk_personal_inteligencia,
   		hist_cargo_reg.fk_estacion,
   		hist_cargo_reg.fk_oficina_principal,
   		
    	crudo_base_reg.fk_clas_tema
    ) RETURNING id INTO id_pieza;
   
   
   SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
   
   RAISE INFO 'PIEZA CREADA CON EXITO!';
   RAISE INFO 'Datos de la pieza creada: %', pieza_reg ; 

	-------------///////////--------------	

	INSERT INTO CRUDO_PIEZA (fk_pieza_inteligencia, fk_crudo) VALUES (
   		id_pieza,
   		id_crudo_base
    );
   
   	RAISE INFO 'CRUDO DE ID = %, FUE AGREGADO A LA PIEZA ID = % EXITOSAMENTE', id_crudo_base, id_pieza;
 

END $$;


--CALL REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA( 1 , 'descripcion pieza prueba', 1 );



-----------------------------===========$$$$$$$$$$///////////////|\\\\\\\\\\\\\\\$$$$$$$$$$===========-------------------------------------------



--DROP PROCEDURE IF EXISTS AGREGAR_CRUDO_A_PIEZA CASCADE;

CREATE OR REPLACE PROCEDURE AGREGAR_CRUDO_A_PIEZA (id_crudo IN integer, id_pieza IN integer)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	crudo_pieza_reg CRUDO_PIEZA%ROWTYPE;
    
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO AGREGAR_CRUDO_A_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	


 

	INSERT INTO CRUDO_PIEZA (fk_pieza_inteligencia, fk_crudo) VALUES (
   		id_pieza,
   		id_crudo
    );
   
   	RAISE INFO 'CRUDO DE ID = %, FUE AGREGADO A LA PIEZA ID = % EXITOSAMENTE', id_crudo, id_pieza;
 

END $$;


-- COMMIT;



-----------------------------===========$$$$$$$$$$///////////////|\\\\\\\\\\\\\\\$$$$$$$$$$===========-------------------------------------------



-- DROP PROCEDURE IF EXISTS CERTIFICAR_PIEZA CASCADE;


CREATE OR REPLACE PROCEDURE CERTIFICAR_PIEZA (id_pieza IN integer, precio_base_va IN PIEZA_INTELIGENCIA.precio_base%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
	
	numero_crudos_va integer;
	nivel_confiabilidad_promedio_va PIEZA_INTELIGENCIA.nivel_confiabilidad%TYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERTIFICAR_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	


	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza AND precio_base IS NULL;
    RAISE INFO 'datos de la pieza de inteligencia %', pieza_reg;


	IF (pieza_reg IS NULL) THEN
   		RAISE INFO 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
  		RAISE EXCEPTION 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
   	END IF;   
 
	IF (precio_base_va < 1) THEN
   		RAISE INFO 'El precio base no puede negativo ni igual a 0$';
  		RAISE EXCEPTION 'El precio base no puede negativo ni igual a 0$';
   	END IF;  

   
   
   	SELECT count(*), sum(c.nivel_confiabilidad_final)/count(*) INTO numero_crudos_va, nivel_confiabilidad_promedio_va FROM CRUDO_PIEZA cp, CRUDO c WHERE cp.fk_crudo = c.id AND cp.fk_pieza_inteligencia = id_pieza;
	RAISE INFO 'numero de crudos en la pieza (id = %): %', id_pieza, numero_crudos_va;


   	IF (numero_crudos_va < 1) THEN
   		RAISE INFO 'La pieza no tiene ningun crudo asociado';
  		RAISE EXCEPTION 'La pieza no tiene ningun crudo asociado';
   	END IF;   	
   
    IF (nivel_confiabilidad_promedio_va < 85) THEN
   		RAISE INFO 'No se cumple un nivel de confiabilidad promedio de 85 porciento';
  		RAISE EXCEPTION 'No se cumple un nivel de confiabilidad promedio de 85 porciento';
   	END IF;  
  
   
   -------------///////////--------------	
	
	UPDATE PIEZA_INTELIGENCIA SET 
		nivel_confiabilidad = nivel_confiabilidad_promedio_va, 
		precio_base = precio_base_va
	;
   
   	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
   
   	RAISE INFO 'PIEZA CERTIFICADA CON EXITO!';
   	RAISE INFO 'Datos de la pieza certificada: %', pieza_reg ; 
	
 

END $$;



-- CALL CERTIFICAR_PIEZA( 37, 1 );

-- VALIDAR CON EL ID DEL ANALISTA 



----------------------------------///////////////////----------------------------


-- DROP FUNCTION IF EXISTS VER_DATOS_PIEZA CASCADE;


CREATE OR REPLACE FUNCTION VER_DATOS_PIEZA (id_pieza IN integer, id_personal_inteligencia IN integer)
RETURNS setof PIEZA_INTELIGENCIA
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
   	
    personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;
   	hist_cargo_reg HIST_CARGO%ROWTYPE;
   
    id_empleado_va integer;
	
	fecha_hora_va INTENTO_NO_AUTORIZADO.fecha_hora%TYPE;

BEGIN 

	fecha_hora_va = NOW();

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DE LA FUNCION VER_DATOS_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	

    SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia;
    RAISE INFO 'datos de persona inteligencia: %', personal_inteligencia_reg;
   
   	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo: %', hist_cargo_reg;

   --------
    
	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
	-- RAISE INFO 'dato de la pieza: %', pieza_reg ; 



   	IF (hist_cargo_reg IS NULL OR personal_inteligencia_reg IS NULL) THEN
   		RAISE INFO 'El personal inteligencia que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El personal inteligencia que ingresó no existe o ya no trabaja en AII';
   	END IF;   	

	IF (pieza_reg IS NULL) THEN
   		RAISE INFO 'La pieza que ingresó no exite';
  		RAISE EXCEPTION 'La pieza que ingresó no exite';
   	END IF;  

	
    IF (personal_inteligencia_reg.class_seguridad = 'top_secret') THEN 
        RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    
	ELSIF (personal_inteligencia_reg.class_seguridad = 'confidencial' AND (pieza_reg.class_seguridad = 'confidencial' OR pieza_reg.class_seguridad = 'no_clasificado')) THEN
       RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
	
	ELSIF (personal_inteligencia_reg.class_seguridad = 'no_clasificado' AND pieza_reg.class_seguridad = 'no_clasificado') THEN
        RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
	
	ELSE 
		SELECT fk_empleado_jefe INTO id_empleado_va FROM ESTACION WHERE id = hist_cargo_reg.fk_estacion ; 
		RAISE INFO 'id del jefe de la estacion del personal inteligencia: %', id_empleado_va;
	
		INSERT INTO INTENTO_NO_AUTORIZADO (
			fecha_hora,
			id_pieza,
			id_empleado,
			fk_personal_inteligencia
		) VALUES (
			fecha_hora_va,
			id_pieza,
			id_empleado_va,
			hist_cargo_reg.fk_personal_inteligencia
		);
    END IF;
 	------///- 
   
   	
	
	
   
END $$;



-- SELECT VER_DATOS_PIEZA(2,10);
-- SELECT id_pieza,fk_personal_inteligencia FROM intento_no_autorizado ina order by fecha_hora desc;



-------------------------///////////////////////////////------------------------------



-- DROP FUNCTION IF EXISTS VALIDAR_VENTA_EXCLUSIVA CASCADE;

 CREATE OR REPLACE FUNCTION VALIDAR_VENTA_EXCLUSIVA ( id_pieza IN integer ) 
 RETURNS boolean
 LANGUAGE PLPGSQL
SECURITY DEFINER 
 AS $$
 DECLARE 

-- 	curdos_en_pieza_int integer;
-- 	curdos_en_pieza_int integer;
	
 	numero_piezas_compartidas integer := 0;
 	numero_veces_pieza_vendida integer := 0;
 
 
 BEGIN 
	 
	SELECT COUNT(*) INTO numero_veces_pieza_vendida FROM ADQUISICION WHERE fk_pieza_inteligencia = id_pieza;

	RAISE INFO 'Número de veces en las que se ha vendido la pieza a verificar %', numero_veces_pieza_vendida; 

	IF (numero_veces_pieza_vendida != 0) THEN
 		RETURN false;
 	END IF;
 
    -----------////// 
	
	SELECT COUNT( DISTINCT fk_pieza_inteligencia) INTO numero_piezas_compartidas FROM CRUDO_PIEZA WHERE fk_crudo IN (SELECT fk_crudo FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza);

	RAISE INFO 'Número de piezas que contienen los crudos de la pieza a verificar %', numero_piezas_compartidas; 	

 	IF (numero_piezas_compartidas != 1) THEN
 		RETURN false;
 	END IF;

 
 	RETURN true;
	
 END $$;


-------------------------------------///////////////////////----------------------------------



-- DROP PROCEDURE IF EXISTS REGISTRO_VENTA CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_VENTA (id_pieza IN integer, id_cliente IN integer, precio_vendido_va IN ADQUISICION.precio_vendido%TYPE)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$  
DECLARE

    pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
   	cliente_reg CLIENTE%ROWTYPE;
	
	adquisicion_reg ADQUISICION%ROWTYPE;

	fecha_hora_venta_va ADQUISICION.fecha_hora_venta%TYPE;

BEGIN 

	fecha_hora_venta_va = NOW();


	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_VENTA ( % ) ------', NOW();
	
	-------------///////////--------------	

	SELECT * INTO cliente_reg FROM CLIENTE WHERE id = id_cliente;
    RAISE INFO 'datos del cliente: %', cliente_reg;
    
	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
	RAISE INFO 'dato de la pieza: %', pieza_reg ; 

   --------

   	IF (cliente_reg IS NULL) THEN
   		RAISE INFO 'El cliente que ingresó no existe';
  		RAISE EXCEPTION 'El cliente que ingresó no existe';
   	END IF;   	
  	
	IF (pieza_reg IS NULL) THEN
   		RAISE INFO 'La pieza que ingresó no exite';
  		RAISE EXCEPTION 'La pieza que ingresó no exite';
   	END IF;   	

	IF (pieza_reg.precio_base IS NULL OR pieza_reg.nivel_confiabilidad IS NULL) THEN
   		RAISE INFO 'La pieza que intenta vender no ha sido certificada';
  		RAISE EXCEPTION 'La pieza que intenta vender no ha sido certificada';
   	END IF;   	

	IF (precio_vendido_va < 1) THEN
		RAISE INFO 'El precio de venta no puede negativo ni igual a 0$';
  		RAISE EXCEPTION 'El precio de venta no puede negativo ni igual a 0$';
	END IF;
  

	IF (cliente_reg.exclusivo = TRUE) THEN

		IF ( (precio_vendido_va - pieza_reg.precio_base)/(pieza_reg.precio_base) < 0.45) THEN
			RAISE INFO 'El precio de venta de una pieza exclusiva tiene un recargo del 45 porciento sobre el precio base de la pieza ( $% ), es decir, $% o más', pieza_reg.precio_base , 1.45*pieza_reg.precio_base ;
			RAISE EXCEPTION 'El precio de venta de una pieza exclusiva tiene un recargo del 45 porciento sobre el precio base de la pieza ( $% ), es decir, $% o más', pieza_reg.precio_base , 1.45*pieza_reg.precio_base ;
		END IF;

		
		IF (VALIDAR_VENTA_EXCLUSIVA(id_pieza) IS TRUE) THEN 
		
			INSERT INTO ADQUISICION (fecha_hora_venta,precio_vendido,fk_cliente,fk_pieza_inteligencia) VALUES (
		
				fecha_hora_venta_va,
				precio_vendido_va,
				cliente_reg.id,
				pieza_reg.id
			
			) RETURNING * INTO adquisicion_reg;
		
		
			RAISE INFO 'VENTA EXCLUSIVA EXITOSA!';
	  		RAISE INFO 'Datos de la venta: %', adquisicion_reg ; 
	  	
	  		-- CALL REGISTRO_TEMA_VENTA(id_cliente,id_tema);

	  		CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA(pieza_reg.id);	
			
		
		ELSE
		
			RAISE INFO 'No es posible la venta de esta pieza de forma exclusiva, debido a que la pieza ya fue vendida; o contiene algun(os) crudo(s) que pertenece(n) a otra(s) pieza(s); o porque la pieza no continene ningun crudo' ;
			RAISE EXCEPTION 'No es posible la venta de esta pieza de forma exclusiva, debido a que la pieza ya fue vendida; o contiene algun(os) crudo(s) que pertenece(n) a otra(s) pieza(s); o porque la pieza no continene ningun crudo' ;
		
		
		END IF;
	
	ELSE


		INSERT INTO ADQUISICION (fecha_hora_venta,precio_vendido,fk_cliente,fk_pieza_inteligencia) VALUES (
		
			fecha_hora_venta_va,
			precio_vendido_va,
			cliente_reg.id,
			pieza_reg.id
			
		) RETURNING * INTO adquisicion_reg;
	
		-- CALL REGISTRO_TEMA_VENTA(id_cliente,id_tema);

		RAISE INFO 'VENTA EXITOSA!';
   		RAISE INFO 'Datos de la venta: %', adquisicion_reg ; 	
	
	END IF;
 	
 

END $$;


--CALL REGISTRO_VENTA( 1,  1, 10000.0 );

-- select * from adquisicion a 

-- select c.id as id_cliente, c.exclusivo, p.id as id_pieza, p.precio_base, a.*, ((a.precio_vendido - p.precio_base)/(p.precio_base))*100 as porcentaje_recargo from adquisicion a, cliente c, PIEZA_INTELIGENCIA p where a.fk_cliente = c.id AND a.fk_pieza_inteligencia = p.id;



----------///////////- --------------------------------------------------------- ///////////----------
----------------/////////////------------- SCRIPTS DE REPORTE ----------------/////////////-------------
----------///////////- --------------------------------------------------------- ///////////----------



------------------------------- FONDOS DE ALL Y APORTE DE ESTACION ------------------------------------------
--LISTO
/*  El Director Ejecutivo debe poder consultar en cualquier momento de cuantos fondos dispone la All.
    Asi como cada Jefe de Estacion debe poder saber a tiempo las ganancias netas anuales de cada estacion.
*/


DROP TYPE IF EXISTS REPORTE_BALANCE CASCADE;

CREATE TYPE REPORTE_BALANCE as (pago_informantes int, pago_informantes_alt int, total_informantes int,
                                piezas_vendidas int, piezas_vendidas_exclusivas int, total_piezas int,
                                presupuesto_estaciones int, total_balance int
                                );


DROP FUNCTION IF EXISTS SUMAR_PAGO_INFORMANTES CASCADE;
DROP FUNCTION IF EXISTS SUMAR_PAGO_INFORMANTES_ALT CASCADE;

DROP FUNCTION IF EXISTS SUMAR_PIEZAS CASCADE;
DROP FUNCTION IF EXISTS SUMAR_PIEZAS_ALT CASCADE;

DROP FUNCTION IF EXISTS SUMAR_PRESUPUESTO CASCADE;

DROP FUNCTION IF EXISTS FONDOS_ALL_Y_APORTE_ESTACION CASCADE;


CREATE OR REPLACE FUNCTION SUMAR_PAGO_INFORMANTES (estacion int) --CHECK
RETURNS int 
    AS $$
	DECLARE
	resultado int;
    BEGIN
    IF (estacion>0) THEN
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO t
        WHERE t.fk_informante IN (SELECT i.id FROM INFORMANTE i WHERE i.fk_estacion_encargado = estacion)
        AND t.fecha_hora BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO t)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE OR REPLACE FUNCTION SUMAR_PAGO_INFORMANTES_ALT (estacion int) --CHECK
RETURNS int 
    AS $$
	DECLARE
	resultado int;
    BEGIN
    IF (estacion>0) THEN
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO_ALT t
        WHERE t.fk_informante IN (SELECT i.id FROM INFORMANTE i WHERE i.fk_estacion_encargado = estacion)
        AND t.fecha_hora BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO_ALT t)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE OR REPLACE FUNCTION SUMAR_PIEZAS (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION a
        WHERE a.fk_pieza_inteligencia IN 
            (SELECT cp.fk_pieza_inteligencia FROM CRUDO_PIEZA cp WHERE cp.fk_pieza_inteligencia IN 
                (SELECT p.id FROM PIEZA_INTELIGENCIA p WHERE p.fk_personal_inteligencia_analista IN
                    (SELECT pa.id FROM PERSONAL_INTELIGENCIA pa WHERE pa.fk_lugar_ciudad IN 
                        (SELECT e.fk_lugar_ciudad FROM ESTACION e WHERE e.id = estacion)
                    )
                )
            )
        AND a.fecha_hora_venta BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION a)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE OR REPLACE FUNCTION SUMAR_PIEZAS_ALT (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION_ALT a
        WHERE a.fk_pieza_inteligencia IN 
            (SELECT cp.fk_pieza_inteligencia FROM CRUDO_PIEZA cp WHERE cp.fk_pieza_inteligencia IN 
                (SELECT p.id FROM PIEZA_INTELIGENCIA p WHERE p.fk_personal_inteligencia_analista IN
                    (SELECT pa.id FROM PERSONAL_INTELIGENCIA pa WHERE pa.fk_lugar_ciudad IN 
                        (SELECT e.fk_lugar_ciudad FROM ESTACION e WHERE e.id = estacion)
                    )
                )
            )
        AND a.fecha_hora_venta BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION_ALT a)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;




CREATE OR REPLACE FUNCTION SUMAR_PRESUPUESTO (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT c.presupuesto as presupuesto_estacion FROM CUENTA c
        WHERE c.fk_estacion = estacion 
        AND c.año BETWEEN RESTA_1_YEAR_DATE(NOW()::date) AND NOW()::date
        LIMIT 1)::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(c.presupuesto),0) FROM CUENTA c)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;

-- - - - - - - --

-- Estacion 0 hace referencia a toda All (Fondos totales de ALL)
CREATE OR REPLACE FUNCTION FONDOS_ALL_Y_APORTE_ESTACION (estacion int)
RETURNS REPORTE_BALANCE
    AS $$
    DECLARE resultado REPORTE_BALANCE;
	BEGIN
	resultado.pago_informantes = SUMAR_PAGO_INFORMANTES(estacion);
	resultado.pago_informantes_alt = SUMAR_PAGO_INFORMANTES_ALT(estacion);
	resultado.total_informantes = resultado.pago_informantes + resultado.pago_informantes_alt;
	
    
    resultado.piezas_vendidas = SUMAR_PIEZAS(estacion);
	resultado.piezas_vendidas_exclusivas = SUMAR_PIEZAS_ALT(estacion);
	resultado.total_piezas = resultado.piezas_vendidas + resultado.piezas_vendidas_exclusivas;

    resultado.presupuesto_estaciones = SUMAR_PRESUPUESTO(estacion);

    resultado.total_balance = resultado.total_piezas + resultado.presupuesto_estaciones - resultado.total_informantes;
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql
SECURITY DEFINER;


-- LLAMADA:     SELECT * FROM FONDOS_ALL_Y_APORTE_ESTACION(0);




-------------------------------------- BALANCE GENERAL --------------------------------------------

/*  Los jefes de las estaciones y los directores correspondientes monitorean el uso de este presupuesto a traves de
    revisiones trimestrales y al final del año.
    Cada estacion debe generar un informe con su balance:
        Pago otorgado (Presupuesto). -- BG
        Fecha. -- RBG (Trimestral y otro reporte anual)
        --------------- REPORTE PARTE 2 -------------------
        Hecho crudo recolectado. 
        Pieza de Inteligencia que lo utiliza (si aplica).
        Valor de la pieza.
        ---------------------------------------------------
        Ganancia o perdida alcanzada (TOTAL) --
    Y los totales generales:
        Total pagado. (A INFORMANTES) --
        Total obtenido por ventas de las piezas de inteligencia logradas por estos hechos aportados por informantes. --
*/



DROP TYPE IF EXISTS REPORTE_BALANCE_GENERAL CASCADE;

CREATE TYPE REPORTE_BALANCE_GENERAL as 
    (fecha_inicio date, fecha_fin date, pago_informantes int, pago_informantes_alt int, 
    total_informantes int, piezas_vendidas int, piezas_vendidas_exclusivas int, total_piezas int, 
    presupuesto_estaciones int, total_balance int
    );


DROP FUNCTION IF EXISTS SUMAR_PAGO_INFORMANTES_TRIMESTRAL CASCADE;
DROP FUNCTION IF EXISTS SUMAR_PAGO_INFORMANTES_ALT_TRIMESTRAL CASCADE;

DROP FUNCTION IF EXISTS SUMAR_PIEZAS_TRIMESTRAL CASCADE;
DROP FUNCTION IF EXISTS SUMAR_PIEZAS_ALT_TRIMESTRAL CASCADE;

DROP FUNCTION IF EXISTS SUMAR_PRESUPUESTO_TRIMESTRAL CASCADE;

DROP FUNCTION IF EXISTS FONDOS_ALL_Y_APORTE_ESTACION_TRIMESTRAL CASCADE;


CREATE OR REPLACE FUNCTION SUMAR_PAGO_INFORMANTES_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
	DECLARE
	resultado int;
    BEGIN
    IF (estacion>0) THEN
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO t
        WHERE t.fk_informante IN (SELECT i.id FROM INFORMANTE i WHERE i.fk_estacion_encargado = estacion)
        AND t.fecha_hora BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO t)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE OR REPLACE FUNCTION SUMAR_PAGO_INFORMANTES_ALT_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
	DECLARE
	resultado int;
    BEGIN
    IF (estacion>0) THEN
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO_ALT t
        WHERE t.fk_informante IN (SELECT i.id FROM INFORMANTE i WHERE i.fk_estacion_encargado = estacion)
        AND t.fecha_hora BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO_ALT t)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE OR REPLACE FUNCTION SUMAR_PIEZAS_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION a
        WHERE a.fk_pieza_inteligencia IN 
            (SELECT cp.fk_pieza_inteligencia FROM CRUDO_PIEZA cp WHERE cp.fk_pieza_inteligencia IN 
                (SELECT p.id FROM PIEZA_INTELIGENCIA p WHERE p.fk_personal_inteligencia_analista IN
                    (SELECT pa.id FROM PERSONAL_INTELIGENCIA pa WHERE pa.fk_lugar_ciudad IN 
                        (SELECT e.fk_lugar_ciudad FROM ESTACION e WHERE e.id = estacion)
                    )
                )
            )
        AND a.fecha_hora_venta BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION a)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;


CREATE OR REPLACE FUNCTION SUMAR_PIEZAS_ALT_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION_ALT a
        WHERE a.fk_pieza_inteligencia IN 
            (SELECT cp.fk_pieza_inteligencia FROM CRUDO_PIEZA cp WHERE cp.fk_pieza_inteligencia IN 
                (SELECT p.id FROM PIEZA_INTELIGENCIA p WHERE p.fk_personal_inteligencia_analista IN
                    (SELECT pa.id FROM PERSONAL_INTELIGENCIA pa WHERE pa.fk_lugar_ciudad IN 
                        (SELECT e.fk_lugar_ciudad FROM ESTACION e WHERE e.id = estacion)
                    )
                )
            )
        AND a.fecha_hora_venta BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION_ALT a)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;




CREATE OR REPLACE FUNCTION SUMAR_PRESUPUESTO_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT c.presupuesto as presupuesto_estacion FROM CUENTA c
        WHERE c.fk_estacion = estacion 
        AND c.año BETWEEN RESTA_3_MESES_DATE(NOW()::date) AND NOW()::date 
        LIMIT 1)::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(c.presupuesto),0) FROM CUENTA c)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql
SECURITY DEFINER;




DROP FUNCTION IF EXISTS BALANCE_GENERAL_TRIMESTRAL CASCADE;

CREATE OR REPLACE FUNCTION BALANCE_GENERAL_TRIMESTRAL (estacion int)
RETURNS REPORTE_BALANCE_GENERAL
    AS $$
    DECLARE    resultado REPORTE_BALANCE_GENERAL;
	BEGIN
    resultado.presupuesto_estaciones = SUMAR_PRESUPUESTO_TRIMESTRAL(estacion);
    resultado.fecha_inicio = (RESTA_3_MESES_DATE(NOW()::date))::date;
    resultado.fecha_fin = NOW()::date;
    resultado.pago_informantes = SUMAR_PAGO_INFORMANTES_TRIMESTRAL(estacion);
    resultado.pago_informantes_alt = SUMAR_PAGO_INFORMANTES_ALT_TRIMESTRAL(estacion); 
    resultado.total_informantes = resultado.pago_informantes_alt + resultado.pago_informantes;
    resultado.piezas_vendidas = SUMAR_PIEZAS_TRIMESTRAL(estacion);
    resultado.piezas_vendidas_exclusivas = SUMAR_PIEZAS_ALT_TRIMESTRAL(estacion);
    resultado.total_piezas = resultado.piezas_vendidas + resultado.piezas_vendidas_exclusivas;
    resultado.total_balance = resultado.total_piezas + resultado.presupuesto_estaciones 
                                - resultado.total_informantes;
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql
SECURITY DEFINER;



DROP FUNCTION IF EXISTS BALANCE_GENERAL_TRIMESTRAL_PARTE2 CASCADE;

CREATE OR REPLACE FUNCTION BALANCE_GENERAL_TRIMESTRAL_PARTE2 (estacion int)
RETURNS TABLE (id_crudo int, id_pieza int, costo_pieza int)
    AS $$
    SELECT cp.fk_crudo, cp.fk_pieza_inteligencia, p.precio_base FROM CRUDO_PIEZA cp, PIEZA_INTELIGENCIA p
    WHERE cp.fk_pieza_inteligencia = p.id AND cp.fk_crudo IN 
        (SELECT c.id FROM CRUDO c WHERE c.fk_estacion_pertenece = estacion 
            AND c.id IN (SELECT t.fk_crudo FROM TRANSACCION_PAGO t 
                WHERE t.fecha_hora BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp))  
$$ LANGUAGE SQL
SECURITY DEFINER;

----------------

DROP FUNCTION IF EXISTS BALANCE_GENERAL_ANUAL CASCADE;

CREATE OR REPLACE FUNCTION BALANCE_GENERAL_ANUAL (estacion int)
RETURNS REPORTE_BALANCE_GENERAL
    AS $$
     DECLARE    resultado REPORTE_BALANCE_GENERAL;
	BEGIN
    resultado.presupuesto_estaciones = SUMAR_PRESUPUESTO(estacion);
    resultado.fecha_inicio = (RESTA_1_YEAR_DATE(NOW()::date))::date;
    resultado.fecha_fin = NOW()::date;
    resultado.pago_informantes = SUMAR_PAGO_INFORMANTES(estacion);
    resultado.pago_informantes_alt = SUMAR_PAGO_INFORMANTES_ALT(estacion); 
    resultado.total_informantes = resultado.pago_informantes_alt + resultado.pago_informantes;
    resultado.piezas_vendidas = SUMAR_PIEZAS(estacion);
    resultado.piezas_vendidas_exclusivas = SUMAR_PIEZAS_ALT(estacion);
    resultado.total_piezas = resultado.piezas_vendidas + resultado.piezas_vendidas_exclusivas;
    resultado.total_balance = resultado.total_piezas + resultado.presupuesto_estaciones 
                                - resultado.total_informantes;
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql
SECURITY DEFINER;



DROP FUNCTION IF EXISTS BALANCE_GENERAL_ANUAL_PARTE2 CASCADE;

CREATE OR REPLACE FUNCTION BALANCE_GENERAL_ANUAL_PARTE2 (estacion int)
RETURNS TABLE (id_crudo int, id_pieza int, costo_pieza int)
    AS $$
    SELECT cp.fk_crudo, cp.fk_pieza_inteligencia, p.precio_base FROM CRUDO_PIEZA cp, PIEZA_INTELIGENCIA p
    WHERE cp.fk_pieza_inteligencia = p.id AND cp.fk_crudo IN 
        (SELECT c.id FROM CRUDO c WHERE c.fk_estacion_pertenece = estacion 
            AND c.id IN (SELECT t.fk_crudo FROM TRANSACCION_PAGO t 
                WHERE t.fecha_hora BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp))  
$$ LANGUAGE SQL
SECURITY DEFINER;



----------------------------------- INFORMACION DE SUS INFORMANTES -------------------------------------
-- LISTO
/*  Se debe llevar un control sobre la eficacia de estos tratos.
    Saber el % de su eficacia, en proporcion de los hechos crudos aportados por tal informante y se han convertido
    en piezas de inteligencia.
    Esta medida se genera semestralmente y se usa en combinacion con la productividad de los agentes.
*/

-- 

DROP TYPE IF EXISTS INFORMACION_INFORMANTE CASCADE;

CREATE TYPE INFORMACION_INFORMANTE as 
    (   nombre_clave varchar(50), agente_encargado int, id_estacion int, nombre_estacion varchar(50), 
        crudos int, piezas int, crudos_alt int, piezas_alt int, 
        total_crudos int, total_piezas int, crudos_usados int, eficacia numeric(20,4)
                                );


DROP FUNCTION IF EXISTS INFORMACION_INFORMANTES CASCADE;

CREATE OR REPLACE FUNCTION INFORMACION_INFORMANTES (informante int)
RETURNS INFORMACION_INFORMANTE
    AS $$
    DECLARE resultado INFORMACION_INFORMANTE;
	BEGIN
	resultado.nombre_clave = (SELECT i.nombre_clave FROM INFORMANTE i WHERE i.id = informante LIMIT 1)::varchar(50);
    resultado.agente_encargado = (SELECT i.fk_personal_inteligencia_encargado FROM INFORMANTE i 
                                    WHERE i.id = informante LIMIT 1):: int;
    resultado.id_estacion = (SELECT i.fk_estacion_encargado FROM INFORMANTE i WHERE i.id = informante LIMIT 1)::int;
    resultado.nombre_estacion = (SELECT e.nombre FROM ESTACION e 
                                    WHERE e.id = resultado.id_estacion LIMIT 1)::varchar(50);

    resultado.crudos = (SELECT COUNT(c.id) FROM CRUDO c WHERE c.fk_informante = informante
                            AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                        )::int;
    resultado.piezas = (SELECT COUNT(cp.fk_pieza_inteligencia) FROM CRUDO_PIEZA cp 
                                WHERE cp.fk_crudo IN (SELECT c.id FROM CRUDO c WHERE c.fk_informante = informante
                                    AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                                    )
                            )::int;

    resultado.crudos_alt = (SELECT COUNT(c.id) FROM CRUDO_ALT c WHERE c.fk_informante = informante
                            AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                            )::int;
    resultado.piezas_alt = (SELECT COUNT(cp.fk_pieza_inteligencia) FROM CRUDO_PIEZA_ALT cp 
                                WHERE cp.fk_crudo IN (SELECT c.id FROM CRUDO_ALT c
                                                        WHERE c.fk_informante = informante
                                                        AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                                                        )
                            )::int;


    resultado.crudos_usados = ((SELECT COUNT(c.id) FROM CRUDO c WHERE c.fk_informante = informante AND c.id IN 
                                (SELECT cp.fk_crudo FROM CRUDO_PIEZA cp WHERE cp.fk_crudo = c.id)
                                AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                                )::int)
                            + ((SELECT COUNT(c.id) FROM CRUDO c WHERE c.fk_informante = informante AND c.id IN 
                                (SELECT cp.fk_crudo FROM CRUDO_PIEZA_ALT cp WHERE cp.fk_crudo = c.id)
                                AND c.id NOT IN (SELECT cp.fk_crudo FROM CRUDO_PIEZA cp WHERE cp.fk_crudo = c.id)
                                AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                                )::int);


    resultado.total_crudos = resultado.crudos + resultado.crudos_alt;
    resultado.total_piezas = resultado.piezas + resultado.piezas_alt;
    IF resultado.total_crudos > 0 THEN
    resultado.eficacia = ((resultado.crudos_usados * 100) / resultado.total_crudos):: NUMERIC(20,4);
    ELSE
        resultado.eficacia = 0;
    END IF;
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql
SECURITY DEFINER;

-- SELECT * FROM INFORMACION_INFORMANTES (1);



------------------------------- INTENTOS NO AUTORIZADOS ------------------------------------
--LISTO
/*  Cuando algun empleado trate de acceder a una pieza de inteligencia se debe quedar registrado y emitir una alerta
    al jefe de la estacion.
    Cada semana se debe emitir el reporte para el jefe de su estacion.
*/

DROP FUNCTION IF EXISTS INTENTOS_NO_AUTORIZADOS CASCADE;

CREATE OR REPLACE FUNCTION INTENTOS_NO_AUTORIZADOS (estacion int)
RETURNS TABLE(  primer_nombre varchar(50), segundo_nombre2 varchar(50), primer_apellido varchar(50), 
                segundo_apellido varchar(50), id_Empleado integer, id_Pieza integer, 
                clasificacion_Pieza varchar(50), fecha TIMESTAMP) 
    AS $$
        SELECT p.primer_nombre, p.segundo_nombre, p.primer_apellido, p.segundo_apellido, p.id,
                    pz.id, pz.class_seguridad, i.fecha_hora
            FROM PERSONAL_INTELIGENCIA p, INTENTO_NO_AUTORIZADO i, PIEZA_INTELIGENCIA pz 
            WHERE p.id = i.fk_personal_inteligencia AND pz.id = i.id_pieza AND p.id IN 
                (SELECT DISTINCT hc.fk_personal_inteligencia from HIST_CARGO hc, ESTACION e WHERE 
                    e.id=estacion AND e.id = hc.fk_estacion)
$$ LANGUAGE SQL
SECURITY DEFINER;


-- PARAMETRO:  id de la estacion.
-- LLAMADA:     SELECT * FROM INTENTOS_NO_AUTORIZADOS(3);



--------------------------------------- LISTA DE INFORMANTES ----------------------------------------
-- LISTO
/*  Es importante que otro empleado de All pueda acceder a la lista de informantes de un agente.    */
--LISTO


DROP FUNCTION IF EXISTS LISTA_INFORMANTES CASCADE;

CREATE OR REPLACE FUNCTION LISTA_INFORMANTES (agente int)
RETURNS TABLE(  nombre_clave varchar(50), agente_encargado int, fecha_inicio_agente timestamp, id_estacion_agente int,
                oficina_principal_agente int, id_jefe_confidente integer, id_confidente int, 
                fecha_inicio_confidente timestamp, id_estacion_confidente int, oficina_principal_confidente int
                ) 
    AS $$
    SELECT  i.nombre_clave, i.fk_personal_inteligencia_encargado, i.fk_fecha_inicio_encargado, i.fk_estacion_encargado,
            i.fk_oficina_principal_encargado, i.fk_empleado_jefe_confidente, i.fk_personal_inteligencia_confidente, 
            i.fk_fecha_inicio_confidente, i.fk_estacion_confidente, i.fk_oficina_principal_confidente 
        FROM PERSONAL_INTELIGENCIA e, INFORMANTE i
        WHERE e.id = agente AND e.id = i.fk_personal_inteligencia_encargado
$$ LANGUAGE SQL
SECURITY DEFINER;

-- PARAMETRO:  fk_personal_inteligencia_encargado (id del agente o confidente)
-- LLAMADA:     SELECT * FROM LISTA_INFORMANTES(13);










----------///////////- ------------------------------------------------------------------------------------ ///////////----------
-----------------//////////////- VALIDACIONES DE TRIGGERS  -- EJECUTAR COMO DEV -//////////////------------------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------




CREATE OR REPLACE PROCEDURE VALIDAR_JERARQUIA_EMPLEADO_JEFE (id_empleado_sup IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
AS $$
DECLARE

	jefe_superior_reg EMPLEADO_JEFE%ROWTYPE;
	
BEGIN

	SELECT * INTO jefe_superior_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_sup AND tipo = tipo_va;
	
	IF (jefe_superior_reg IS NULL) THEN
		RAISE INFO 'El jefe del empleado que ingresó debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El jefe del empleado que ingresó debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


---------/-///-/-/-/--/---/-/-/-/-/-/-/--/--//---//-/-/-/-/-/-/-/-/-/-/-/-/--/----//////--------------------


CREATE OR REPLACE PROCEDURE VALIDAR_TIPO_EMPLEADO_JEFE(id_empleado IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
AS $$
DECLARE

	empleado_reg EMPLEADO_JEFE%ROWTYPE;
	
BEGIN

	select * into empleado_reg from EMPLEADO_JEFE where id = id_empleado AND tipo = tipo_va;
	
	IF (empleado_reg IS NULL) THEN
		RAISE INFO 'El empleado ingresado debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El empleado ingresado debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


---------/-///-/-/-/--/---/-/-/-/-/-/-/--/--//---//-/-/-/-/-/-/-/-/-/-/-/-/--/----//////--------------------


CREATE OR REPLACE PROCEDURE VALIDAR_TIPO_LUGAR(id_lugar IN integer, tipo_va IN LUGAR.tipo%TYPE)
AS $$
DECLARE

	lugar_reg LUGAR%ROWTYPE;
	
BEGIN

	select * into lugar_reg from LUGAR where id = id_lugar AND tipo = tipo_va;
	
	IF (lugar_reg IS NULL) THEN
		RAISE INFO 'El lugar/direccion ingresado debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El lugar/direccion ingresado debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;







-----------------------/////////////////-----------------------



CREATE OR REPLACE PROCEDURE VALIDAR_EXIT_TEMA(id_tema IN integer)
AS $$
DECLARE

	tema_reg CLAS_TEMA%ROWTYPE;
	
BEGIN

	SELECT * INTO tema_reg FROM CLAS_TEMA WHERE id = id_tema;

	RAISE INFO 'DATOS DE TEMA %:', tema_reg;
	
	IF (tema_reg IS NULL) THEN
		RAISE INFO 'El tema que ingresó no se encuetra registrado';
		RAISE EXCEPTION 'El tema que ingresó no se encuetra registrado';
	END IF;
		
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;



--DROP FUNCTION IF EXISTS VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO CASCADE;

CREATE OR REPLACE FUNCTION VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO ( id_crudo IN integer ) 
RETURNS integer
LANGUAGE PLPGSQL
SECURITY DEFINER 
AS $$
DECLARE 

	numero_analistas_va integer;	

BEGIN 
	
	SELECT count(*) INTO numero_analistas_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;
	
	RETURN numero_analistas_va;
	
END $$;







----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////////- CREACION DE TRIGGERS pt.1  -- EJECUTAR COMO ADMINISTRADOR -//////////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------



-- A. Triggers para validar las jerarquías en empleado_jefe

CREATE OR REPLACE function TRIGGER_EMPLEADO_JEFE()
RETURNS TRIGGER AS $$
BEGIN
	
	IF (TG_OP = 'DELETE') THEN
        
		--/
		RETURN OLD;

	ELSIF (TG_OP = 'UPDATE') THEN
		
		IF (new.tipo = old.tipo ) THEN
			RAISE INFO 'El cargo nuevo y el cargo viejo son iguales';
        	RAISE EXCEPTION 'El cargo nuevo y el cargo viejo son iguales';
		END IF;

		CASE new.tipo
		
			WHEN 'director_ejecutivo' THEN 

				IF (new.fk_empleado_jefe IS NOT NULL) THEN
					
					RAISE EXCEPTION 'El director ejecutivo no tiene jefe';	
				END IF;	

			WHEN 'director_area' THEN
			
				CALL VALIDAR_JERARQUIA_EMPLEADO_JEFE(new.fk_empleado_jefe,'director_ejecutivo');
				
			WHEN 'jefe' THEN

				CALL VALIDAR_JERARQUIA_EMPLEADO_JEFE(new.fk_empleado_jefe,'director_area');
				
			ELSE 
				RETURN null;
				
		END CASE;

		-- CALL VALIDAR_TELEFONO_TY(new.telefono);

		RETURN NEW;

	ELSIF (TG_OP = 'INSERT') THEN

		-- IF (new.primer_nombre IS NULL OR new.primer_nombre = '') THEN  
		-- 	RAISE EXCEPTION 'El primer nombre no puede estar vacio';
		-- END IF;
		-- IF (new.primer_apellido IS NULL OR new.primer_apellido = '') THEN  
		-- 	RAISE EXCEPTION 'El primer apellido no puede estar vacio';
		-- END IF;
		-- IF (new.segundo_apellido IS NULL OR new.segundo_apellido = '') THEN  
		-- 	RAISE EXCEPTION 'El segundo apellido no puede estar vacio';
		-- END IF;

		CASE new.tipo
		
			WHEN 'director_ejecutivo' THEN 

				IF (new.fk_empleado_jefe IS NOT NULL) THEN
					
					RAISE EXCEPTION 'El director ejecutivo no tiene jefe';	
				END IF;	

			WHEN 'director_area' THEN
			
				CALL VALIDAR_JERARQUIA_EMPLEADO_JEFE(new.fk_empleado_jefe,'director_ejecutivo');
				
			WHEN 'jefe' THEN

				CALL VALIDAR_JERARQUIA_EMPLEADO_JEFE(new.fk_empleado_jefe,'director_area');
				
			ELSE 
				RETURN null;
				
		END CASE;

		-- CALL VALIDAR_TELEFONO_TY(new.telefono);

		RETURN NEW;

	END IF;
    

	RETURN NULL;


END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


-- DROP TRIGGER IF EXISTS TRIGGER_INSERT_EMPLEADO_JEFE ON EMPLEADO_JEFE CASCADE;	
-- DROP TRIGGER IF EXISTS TRIGGER_UPDATE_EMPLEADO_JEFE_TIPO_FK_EMPLEADO_JEFE ON EMPLEADO_JEFE CASCADE;

CREATE TRIGGER TRIGGER_EMPLEADO_JEFE 
BEFORE INSERT OR UPDATE OR DELETE ON EMPLEADO_JEFE 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_EMPLEADO_JEFE();


-- CREATE TRIGGER TRIGGER_DELETE_EMPLEADO_JEFE
-- BEFORE DELETE EMPLEADO_JEFE
-- FOR EACH ROW
-- EXECUTE PROCEDURE TRIGGER_EMPLEADO_JEFE();
	

-- PRUEBAS
--
--INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
--('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_ejecutivo', null);
--
--INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
--('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_area', 1);
--
--UPDATE empleado_jefe SET tipo = 'jefe' , fk_empleado_jefe = 2  where id = 42;
--
--INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
--('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'jefe', 11);
--
--
--select * from empleado_jefe ej order by id DESC  limit 5;
--
--delete from empleado_jefe where id = 1;
--
--update empleado_jefe set fk_empleado_jefe=null, tipo='director_ejecutivo' where id=3;
--
--select id,tipo,fk_empleado_jefe from empleado_jefe ej where ej.id=3



-- A. Triggers para validar las jerarquías en lugar (si aplica); para validar tipo ciudad o país si aplica;

CREATE OR REPLACE function TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR()
RETURNS TRIGGER AS $$
DECLARE  

	fk_lugar_temp_va LUGAR.fk_lugar%type ;
	lugar_superior_registro LUGAR := NULL ;

BEGIN
	
	-- VALIDACION DE JEREAQUIA DE LUGAR
	
	raise notice '-------%------', NOW();
	raise notice 'old.tipo %', old.tipo;
	raise notice 'new.tipo %', new.tipo;
	raise notice 'old.region %', old.region;
	raise notice 'new.region %', new.region;
	raise notice 'old.fk_lugar %', old.fk_lugar;
	raise notice 'new.fk_lugar %', new.fk_lugar;


	IF (new.fk_lugar is NOT NULL) then
	
		fk_lugar_temp_va = new.fk_lugar;
	
		select * into lugar_superior_registro from LUGAR where id = fk_lugar_temp_va;
	END IF;
	

	case new.tipo
	
		when 'pais' then 
					
			IF (lugar_superior_registro is null and new.region is not null) then
				RETURN new;
			ELSE 
				RAISE EXCEPTION 'La referencia a la región del país es solo a través del atributo "region"';
				RETURN null;	
			END IF;	
		
		when 'ciudad' then
		
			IF (lugar_superior_registro.tipo = 'pais' and new.region is null) then
				RETURN new;
			ELSE 
				RAISE EXCEPTION 'Las ciudades no tiene región asignada y deben referenciar a un país';
				RETURN null;	
				
			END IF;
			
		ELSE 
			RETURN null;
	end case;

	
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;


-- DROP TRIGGER IF EXISTS TRIGGER_INSERT_LUGAR ON LUGAR CASCADE;	
-- DROP TRIGGER IF EXISTS TRIGGER_UPDATE_LUGAR_TIPO_FK_LUGAR_REGION ON LUGAR CASCADE;


CREATE TRIGGER TRIGGER_INSERT_LUGAR 
BEFORE INSERT OR UPDATE ON LUGAR 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR();

	
-- -- PRUEBAS

-- --INSERT INTO LUGAR (nombre,tipo,region,fk_lugar) VALUES ('prueba_pais','pais',null,null);
-- --INSERT INTO LUGAR (nombre,tipo,region,fk_lugar) VALUES ('prueba_ciudad','ciudad',null,1);
-- --
-- --select * from LUGAR;



CREATE OR REPLACE FUNCTION TRIGGER_OFICINA_PRINCIPAL()
RETURNS TRIGGER AS $$
DECLARE

	numero_estaciones_dep integer;
	
BEGIN
	

    IF (TG_OP = 'DELETE') THEN
        
		SELECT COUNT(*) INTO numero_estaciones_dep FROM ESTACION WHERE fk_oficina_principal = old.id;
 
		IF (numero_estaciones_dep != 0) THEN 
			RAISE EXCEPTION 'No se puede eliminar la oficina ya que hay registros que dependen de ella';
		END IF;

		RETURN old;


	ELSIF (TG_OP = 'UPDATE') THEN
		
		-- IF (new.nombre IS NULL OR new.nombre = '') THEN  
		-- 	RAISE EXCEPTION 'El nombre no puede estar vacio';
		-- END IF;

		CALL VALIDAR_TIPO_LUGAR(new.fk_lugar_ciudad, 'ciudad');
		
		IF (new.sede = true) THEN 
			CALL VALIDAR_TIPO_EMPLEADO_JEFE(new.fk_director_ejecutivo, 'director_ejecutivo');

		ELSIF (new.fk_director_ejecutivo IS NOT NULL) THEN
			RAISE EXCEPTION 'Solo las oficinas sede pueden tener director ejecutivo';
			
		END IF;
			
		CALL VALIDAR_TIPO_EMPLEADO_JEFE(new.fk_director_area, 'director_area');

		RETURN new;


	ELSIF (TG_OP = 'INSERT') THEN

		-- IF (new.nombre IS NULL OR new.nombre = '') THEN  
		-- 	RAISE EXCEPTION 'El nombre no puede estar vacio';
		-- END IF;

		CALL VALIDAR_TIPO_LUGAR(new.fk_lugar_ciudad, 'ciudad');
		
		IF (new.sede = true) THEN 
			CALL VALIDAR_TIPO_EMPLEADO_JEFE(new.fk_director_ejecutivo, 'director_ejecutivo');

		ELSIF (new.fk_director_ejecutivo IS NOT NULL) THEN
			RAISE EXCEPTION 'Solo las oficinas sede pueden tener director ejecutivo';
			
		END IF;
			
		CALL VALIDAR_TIPO_EMPLEADO_JEFE(new.fk_director_area, 'director_area');
	
		
		RETURN new;

	END IF;
    

	RETURN NULL;

END;
$$ LANGUAGE plpgsql
SECURITY DEFINER;





-- DROP TRIGGER IF EXISTS TRIGGER_OFICINA_PRINCIPAL ON OFICINA_PRINCIPAL CASCADE;	
-- DROP TRIGGER IF EXISTS TRIGGER_OFICINA_PRINCIPAL ON OFICINA_PRINCIPAL CASCADE;

CREATE TRIGGER TRIGGER_OFICINA_PRINCIPAL
BEFORE INSERT OR UPDATE OR DELETE ON OFICINA_PRINCIPAL 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_OFICINA_PRINCIPAL();

	
---------------------////////////////-----------------------


CREATE OR REPLACE FUNCTION TRIGGER_PERSONAL_INTELIGENCIA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE

	personal_reg personal_inteligencia%rowtype;
	i integer;

BEGIN
	
	----INFORMACION A INSERTAR EN PERSONAL INTELIGENCIA
	
	IF (TG_OP = 'DELETE') THEN
        
		--/
		RETURN OLD;

	ELSIF (TG_OP = 'UPDATE') THEN

		IF (new.primer_nombre = '') THEN
			RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE';
		END IF;
		
		IF ((new.primer_apellido = '') OR (new.segundo_apellido = '')) THEN
			RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
		END IF;

		IF (new.peso_kg <= 0 OR new.altura_cm <= 0 ) THEN
			RAISE EXCEPTION 'Ni el peso ni la altura pueden ser negativos ni cero';
		END IF;


		---- VALIDAR LA FECHA DEL PERSONAL DE INTELIGENCIA MAYOR DE 26 AÑOS ------
		IF (FUNCION_EDAD(new.fecha_nacimiento) = FALSE) THEN
		---MENOR DE 26 AÑOS
			RAISE EXCEPTION 'NO ES PERMITIDO LA EDAD DEL PERSONAL';
			RETURN NULL;		
		END IF;
		
		---MAYOR DE 26 AÑOS		
		RAISE INFO 'EDAD PERMITIDA PARA INGRESO DE PERSONAL';
		
		-----VALIDACION DEL FAMILIAR ---------

		---EL PERSONAL DE INTELIGENCIA DEBE TENER DOS FAMILIARES
		IF (new.familiares[2] IS NULL OR new.familiares[1] IS NULL ) THEN
			RAISE EXCEPTION 'DEBE TENER DOS FAMILIARES EL PERSONAL DE INTELIGENCIA A INSERTAR';			
			RETURN NULL;		
		END IF;			


		-- RAISE INFO 'INFORMACION DEL PERSONAL(NOMBRE COMPLETO Y EDAD): %, %, %, %, %',new.primer_nombre, new.segundo_nombre, new.primer_apellido, new.segundo_apellido, fu_obtener_edad (new.fecha_nacimiento::DATE, NOW()::DATE);
		
		-- RAISE INFO 'INFORMACION DEL PRIMER FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, % ',new.familiares[1].primer_nombre, new.familiares[1].segundo_nombre, new.familiares[1].primer_apellido, new.familiares[1].segundo_apellido,fu_obtener_edad (new.familiares[1].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[1].parentesco, new.familiares[1].telefono;

		-- RAISE INFO 'INFORMACION DEL SEGUNDO FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, %',new.familiares[2].primer_nombre, new.familiares[2].segundo_nombre, new.familiares[2].primer_apellido, new.familiares[2].segundo_apellido,fu_obtener_edad (new.familiares[2].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[2].parentesco, new.familiares[2].telefono;

		RETURN NEW;


	ELSIF (TG_OP = 'INSERT') THEN


		IF (new.primer_nombre = '') THEN
			RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE';
		END IF;
		
		IF ((new.primer_apellido = '') OR (new.segundo_apellido = '')) THEN
			RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
		END IF;

		IF (new.peso_kg <= 0 OR new.altura_cm <= 0 ) THEN
			RAISE EXCEPTION 'Ni el peso ni la altura pueden ser negativos ni cero';
		END IF;


		---- VALIDAR LA FECHA DEL PERSONAL DE INTELIGENCIA MAYOR DE 26 AÑOS ------
		IF (FUNCION_EDAD(new.fecha_nacimiento) = FALSE) THEN
		---MENOR DE 26 AÑOS
			RAISE EXCEPTION 'NO ES PERMITIDO LA EDAD DEL PERSONAL';
			RETURN NULL;		
		END IF;
		
		---MAYOR DE 26 AÑOS		
		RAISE INFO 'EDAD PERMITIDA PARA INGRESO DE PERSONAL';
		
		-----VALIDACION DEL FAMILIAR ---------

		---EL PERSONAL DE INTELIGENCIA DEBE TENER DOS FAMILIARES
		IF (new.familiares[2] IS NULL OR new.familiares[1] IS NULL ) THEN
			RAISE EXCEPTION 'DEBE TENER DOS FAMILIARES EL PERSONAL DE INTELIGENCIA A INSERTAR';			
			RETURN NULL;		
		END IF;			


		RAISE INFO 'INFORMACION DEL PERSONAL(NOMBRE COMPLETO Y EDAD): %, %, %, %, %',new.primer_nombre, new.segundo_nombre, new.primer_apellido, new.segundo_apellido, fu_obtener_edad (new.fecha_nacimiento::DATE, NOW()::DATE);
		
		RAISE INFO 'INFORMACION DEL PRIMER FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, % ',new.familiares[1].primer_nombre, new.familiares[1].segundo_nombre, new.familiares[1].primer_apellido, new.familiares[1].segundo_apellido,fu_obtener_edad (new.familiares[1].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[1].parentesco, new.familiares[1].telefono;

		RAISE INFO 'INFORMACION DEL SEGUNDO FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, %',new.familiares[2].primer_nombre, new.familiares[2].segundo_nombre, new.familiares[2].primer_apellido, new.familiares[2].segundo_apellido,fu_obtener_edad (new.familiares[2].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[2].parentesco, new.familiares[2].telefono;

		RETURN NEW;


	END IF;


	RETURN NULL;

END
$$;


-- INSERT INTO personal_inteligencia (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, altura_cm, peso_kg, color_ojos, vision, class_seguridad, fotografia, huella_retina, huella_digital, telefono, licencia_manejo, idiomas, familiares, identificaciones, nivel_educativo, aliases, fk_lugar_ciudad) VALUES
-- ('Florentina','Mariluz','Landa','Heredia','1993-03-05',189,66,'verde claro','20/25','top_secret','personal_inteligencia_data/foto.png','personal_inteligencia_data/huella_digital.png','personal_inteligencia_data/huella_retina.png',ROW(58,4145866510) ,ROW('75518194','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Araceli',null,'Alcantara','Candelaria','1960-06-01','tío',ROW(58,4145335249) ), ROW('Calixtrato','Vicente','Quintanilla','Estrada','1960-06-01','hermano',ROW(58,4142583859) )]::familiar_ty[], ARRAY[ ROW('31656053','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Economía','Máster','Finanzas')]::nivel_educativo_ty[],null,'10');

-- DROP FUNCTION TRIGGER_PERSONAL_INTELIGENCIA();

CREATE TRIGGER TRIGGER_INSERT_UPDATE_PERSONAL_INTELIGENCIA
BEFORE INSERT OR UPDATE ON PERSONAL_INTELIGENCIA
FOR EACH ROW EXECUTE FUNCTION TRIGGER_PERSONAL_INTELIGENCIA();


-- DROP TRIGGER TRIGGER_INSERT_UPDATE_PERSONAL_INTELIGENCIA ON PERSONAL_INTELIGENCIA



--------------------------------/\/\/\/\/\/\/\/\///\/\/\//\/\//\/\/\\\/-----------------------------



CREATE OR REPLACE FUNCTION TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
	area_interes_reg AREA_INTERES%ROWTYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_REGISTRO_TEMAS_CLEINTE_ADQUISICION ( % ) ------', NOW();
	
	-------------///////////--------------	

	RAISE INFO 'datos de la aquisicion: %', new;

	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = new.fk_pieza_inteligencia;
    RAISE INFO 'datos de la pieza: %', area_interes_reg;

	SELECT * INTO area_interes_reg FROM AREA_INTERES WHERE fk_clas_tema = pieza_reg.fk_clas_tema AND fk_cliente = new.fk_cliente ;
    RAISE INFO 'datos del AREA_INTERES: %', area_interes_reg;


	IF (area_interes_reg IS NULL) THEN
   
		INSERT INTO AREA_INTERES (
			fk_clas_tema, 
			fk_cliente
		) VALUES (

			pieza_reg.fk_clas_tema, 
			new.fk_cliente 
		
		) RETURNING * INTO area_interes_reg;


		RAISE INFO 'REGISTRO AREA_INTERES!';
		RAISE INFO 'Datos de area_intereses: %', area_interes_reg ; 
	  	
	ELSE
		RAISE INFO 'AREA_INTERESES YA REGISTRADA';
	

	END IF;	
 
	RETURN NULL;

END $$;

----DROP PROCEDURE TRIGGER_COPIA_ADQUISICION(integer)

CREATE TRIGGER TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION
AFTER INSERT ON ADQUISICION
FOR EACH ROW EXECUTE FUNCTION TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION();





----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////////- CREACION DE TRIGGERS pt.2  -- EJECUTAR COMO ADMINISTRADOR -//////////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------



CREATE OR REPLACE FUNCTION TRIGGER_INSERT_UPDATE_INFORMANTE()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 

	agente_campo_encargado_reg personal_inteligencia%rowtype; 	
	hist_agente_encargado_reg hist_cargo%rowtype;
	
	personal_confidente_reg personal_inteligencia%rowtype;
	hist_cargo_personal_inteligencia_reg hist_cargo%rowtype;
	
	empleado_jefe_reg empleado_jefe%rowtype;
	
	informante_check_reg informante%rowtype;
	
BEGIN
	---SI EL TRIGGER ES DISPARADO POR INSERT ---
 	IF (TG_OP = 'INSERT') THEN
        
		---- VALIDACIONES DE NOMBRE CLAVE DE INFORMANTE ---

		IF(new.nombre_clave IS NULL OR new.nombre_clave = '') THEN
			RAISE INFO 'Ingrese un nombre clave para el informante';
			RAISE EXCEPTION 'Ingrese un nombre clave para el informante';
			RETURN NULL;
		END IF;
		--- BUSQUEDA DE LOS DATOS DEL INFORMANTE CON EL NOMBRE CLAVE ---
		
		SELECT * INTO informante_check_reg FROM informante 
		WHERE nombre_clave = new.nombre_clave;

		RAISE INFO 'DATOS DE INFORMANTE %:', informante_check_reg;
		--- SI EXISTE EL NOMBRE CLAVE DEL INFORMANTE NO INSERTA ---
		IF (informante_check_reg.id IS NOT NULL) THEN
			RAISE INFO 'El nombre clave que ingresó ya se encuentra en uso';
			RAISE EXCEPTION 'El nombre clave que ingresó ya se encuentra en uso: %', new.nombre_clave;
			RETURN NULL;
		END IF;		
		--- FUNCION VALIDAR ARCO EXCLUSIVO ---
		
		IF (new.fk_empleado_jefe_confidente IS NOT NULL AND (new.fk_personal_inteligencia_confidente IS NOT NULL OR new.fk_estacion_confidente IS NOT NULL OR new.fk_oficina_principal_confidente IS NOT NULL)) THEN
		RAISE INFO 'Tiene dos confidentes el informante, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
		RAISE EXCEPTION 'Tiene dos confidentes el informante, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
	
		END IF;
		IF (new.fk_empleado_jefe_confidente IS NULL AND (new.fk_personal_inteligencia_confidente IS NULL OR new.fk_estacion_confidente IS NULL OR new.fk_oficina_principal_confidente IS NULL)) THEN 
			RAISE INFO 'El informante no tiene confidente, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
			RAISE EXCEPTION 'El informante no tiene confidente, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;

		END IF;
		IF (new.fk_personal_inteligencia_encargado = new.fk_personal_inteligencia_confidente) THEN
			RAISE INFO 'EL AGENTE DE CAMPO ENCARGADO Y EL PERSONAL DE INTELIGENCIA CONFIDENTE NO PUEDEN SER EL MISMO';
			RAISE EXCEPTION 'EL AGENTE DE CAMPO ENCARGADO Y EL PERSONAL DE INTELIGENCIA CONFIDENTE NO PUEDEN SER EL MISMO';
		
		END IF;

		
		----- BUSQUEDA AGENTE ENCARGAGO

		SELECT * INTO agente_campo_encargado_reg FROM personal_inteligencia
		WHERE id = new.fk_personal_inteligencia_encargado;
		RAISE INFO ' DATOS DEL AGENTE DE CAMPO ENCARGADO: %',agente_campo_encargado_reg;
		
		SELECT * INTO hist_agente_encargado_reg FROM hist_cargo 
		WHERE fk_personal_inteligencia = new.fk_personal_inteligencia_encargado 
		AND fecha_fin IS NULL;
		
		IF (hist_agente_encargado_reg IS NULL) THEN
			RAISE INFO 'EL AGENTE DE CAMPO QUE INGRESÓ NO EXISTE O YA NO TRABAJA EN AII';
			RAISE EXCEPTION 'EL AGENTE DE CAMPO QUE INGRESÓ NO EXISTE O YA NO TRABAJA EN AII, ID: %', new.fk_personal_inteligencia_encargado;
		END IF; 
		
		IF (hist_agente_encargado_reg.cargo != 'agente') THEN
			RAISE INFO 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
			RAISE EXCEPTION 'El agente de campo que ingresó no es un agente de campo en su cargo actual, en el informante: %', new.nombre_clave;

		END IF;	
		
		
		-----VALIDACION DEL CONFIDENTE


		IF (new.fk_personal_inteligencia_confidente IS NOT NULL) THEN
		
		----- BUSQUEDA DEL PERSONAL CONFIDENTE
		
			SELECT * INTO personal_confidente_reg from personal_inteligencia 
			WHERE id = new.fk_personal_inteligencia_confidente;
			RAISE INFO 'datos del personal de inteligencia confidente: %', personal_confidente_reg;
			
			SELECT * INTO hist_cargo_personal_inteligencia_reg FROM hist_cargo
			WHERE fk_personal_inteligencia = new.fk_personal_inteligencia_confidente
			AND fecha_fin IS NULL;
			RAISE INFO 'datos de hist_cargo del personal de inteligencia confidente: %', hist_cargo_personal_inteligencia_reg;
			
			IF (hist_agente_encargado_reg IS NULL) THEN
				RAISE INFO 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
				RAISE EXCEPTION 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
				
			END IF; 
			
				
		ELSE 

		-----VALIDACION DEL EMPLEADO_JEFE CONFIDENTE

			SELECT * INTO empleado_jefe_reg FROM empleado_jefe 
			WHERE id = new.fk_empleado_jefe_confidente;

			IF (empleado_jefe_reg IS NULL) THEN
				RAISE INFO 'El confidente empleado que ingresó no existe o ya no trabaja en AII';
				RAISE EXCEPTION 'El confidente empleado que ingresó no existe o ya no trabaja en AII';
				
			END IF; 

			RAISE INFO 'datos del empleado jefe confidente: %', empleado_jefe_reg;

		END IF;

		
		RAISE INFO 'INFORMANTE CREADO CON EXITO!';
		RAISE INFO 'Datos del informante: %', NEW ; 
		--- RETURN NEW = INSERTA EL REGISTRO---
		RETURN NEW;

		--- SI EL TRIGGER ES DISPARADO POR UPDATE ---

	ELSIF (TG_OP = 'UPDATE') THEN
		
		---- VALIDACIONES DE NOMBRE CLAVE DE INFORMANTE ---

		IF(new.nombre_clave IS NULL OR new.nombre_clave = '') THEN
			RAISE INFO 'Ingrese un nombre clave para el informante';
			RAISE EXCEPTION 'Ingrese un nombre clave para el informante';
			RETURN NULL;
		END IF;
		
		
		SELECT * INTO informante_check_reg FROM informante 
		WHERE nombre_clave = new.nombre_clave;

		RAISE INFO 'DATOS DE INFORMANTE %:', informante_check_reg;
		--- SI EXISTE EL NOMBRE CLAVE DEL INFORMANTE NO INSERTA ---
		IF (informante_check_reg.id IS NOT NULL) THEN
			RAISE INFO 'El nombre clave que ingresó ya se encuentra en uso';
			RAISE EXCEPTION 'El nombre clave que ingresó ya se encuentra en uso: %', new.nombre_clave;
			RETURN NULL;
		END IF;		
		--- FUNCION VALIDAR ARCO EXCLUSIVO ---
		IF (new.fk_empleado_jefe_confidente IS NOT NULL AND (new.fk_personal_inteligencia_confidente IS NOT NULL OR new.fk_estacion_confidente IS NOT NULL OR new.fk_oficina_principal_confidente IS NOT NULL)) THEN
		RAISE INFO 'Tiene dos confidentes el informante, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
		RAISE EXCEPTION 'Tiene dos confidentes el informante, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
	
		END IF;
		IF (new.fk_empleado_jefe_confidente IS NULL AND (new.fk_personal_inteligencia_confidente IS NULL OR new.fk_estacion_confidente IS NULL OR new.fk_oficina_principal_confidente IS NULL)) THEN 
			RAISE INFO 'El informante no tiene confidente, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
			RAISE EXCEPTION 'El informante no tiene confidente, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;

		END IF;
		IF (new.fk_personal_inteligencia_encargado = new.fk_personal_inteligencia_confidente) THEN
			RAISE INFO 'EL AGENTE DE CAMPO ENCARGADO Y EL PERSONAL DE INTELIGENCIA CONFIDENTE NO PUEDEN SER EL MISMO';
			RAISE EXCEPTION 'EL AGENTE DE CAMPO ENCARGADO Y EL PERSONAL DE INTELIGENCIA CONFIDENTE NO PUEDEN SER EL MISMO';
		
		END IF;

		
		----- BUSQUEDA AGENTE ENCARGAGO

		SELECT * INTO agente_campo_encargado_reg FROM personal_inteligencia
		WHERE id = new.fk_personal_inteligencia_encargado;
		RAISE INFO ' DATOS DEL AGENTE DE CAMPO ENCARGADO: %',agente_campo_encargado_reg;
		
		SELECT * INTO hist_agente_encargado_reg FROM hist_cargo 
		WHERE fk_personal_inteligencia = new.fk_personal_inteligencia_encargado 
		AND fecha_fin IS NULL;
		
		IF (hist_agente_encargado_reg IS NULL) THEN
			RAISE INFO 'EL AGENTE DE CAMPO QUE INGRESÓ NO EXISTE O YA NO TRABAJA EN AII';
			RAISE EXCEPTION 'EL AGENTE DE CAMPO QUE INGRESÓ NO EXISTE O YA NO TRABAJA EN AII, ID: %', new.fk_personal_inteligencia_encargado;
		END IF; 
		
		IF (hist_agente_encargado_reg.cargo != 'agente') THEN
			RAISE INFO 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
			RAISE EXCEPTION 'El agente de campo que ingresó no es un agente de campo en su cargo actual, en el informante: %', new.nombre_clave;

		END IF;	
		
		
		-----VALIDACION DEL CONFIDENTE


		IF (new.fk_personal_inteligencia_confidente IS NOT NULL) THEN
		
		----- BUSQUEDA DEL PERSONAL CONFIDENTE
		
			SELECT * INTO personal_confidente_reg from personal_inteligencia 
			WHERE id = new.fk_personal_inteligencia_confidente;
			RAISE INFO 'datos del personal de inteligencia confidente: %', personal_confidente_reg;
			
			SELECT * INTO hist_cargo_personal_inteligencia_reg FROM hist_cargo
			WHERE fk_personal_inteligencia = new.fk_personal_inteligencia_confidente
			AND fecha_fin IS NULL;
			RAISE INFO 'datos de hist_cargo del personal de inteligencia confidente: %', hist_cargo_personal_inteligencia_reg;
			
			IF (hist_agente_encargado_reg IS NULL) THEN
				RAISE INFO 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
				RAISE EXCEPTION 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
				
			END IF; 
			
				
		ELSE 

		-----VALIDACION DEL EMPLEADO_JEFE CONFIDENTE

			SELECT * INTO empleado_jefe_reg FROM empleado_jefe 
			WHERE id = new.fk_empleado_jefe_confidente;

			IF (empleado_jefe_reg IS NULL) THEN
				RAISE INFO 'El confidente empleado que ingresó no existe o ya no trabaja en AII';
				RAISE EXCEPTION 'El confidente empleado que ingresó no existe o ya no trabaja en AII';
				
			END IF; 

			RAISE INFO 'datos del empleado jefe confidente: %', empleado_jefe_reg;



		END IF;


		RAISE INFO 'INFORMANTE ACTUALIZADO CON EXITO!';
		RAISE INFO 'Datos del informante: %', NEW ; 
		--- RETURN NEW = INSERTA EL REGISTRO---
		RETURN NEW;



	END IF;
	
END
$$;


CREATE TRIGGER TRIGGER_INSERT_UPDATE_INFORMANTE
BEFORE INSERT OR UPDATE ON INFORMANTE
FOR EACH ROW 
EXECUTE FUNCTION TRIGGER_INSERT_UPDATE_INFORMANTE();  --SIEMPRE FOR EACH ROW



-- DROP TRIGGER trigger_VALIDAR_ARCO_EXCLUSIVO on informante
-- INSERT INTO informante (nombre_clave, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado, fk_empleado_jefe_confidente, fk_personal_inteligencia_confidente, fk_fecha_inicio_confidente, fk_estacion_confidente, fk_oficina_principal_confidente) VALUES
-- ('Ameamezersalica', 2, '2021-03-09 07:00:00', 1, 1, 11, null, null, null, null)






-- -/=/- ARCHIVO TRIGGER_INSERT_UPDATE_CRUDO_PIEZA.sql -/=/- 

-- --////-- TABLA CRUDO_PIEZA
-- -/TRIGGER_INSERT_UPDATE_CRUDO_PIEZA BEFORE INSERT OR UPDATE FOR EACH ROW TRIGGER_CRUDO_PIEZA();


CREATE OR REPLACE FUNCTION TRIGGER_UPDATE_INSERT_CRUDO()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
BEGIN
	
	--- SI EL TRIGGER ES DISPARADO POR INSERT ---
	IF (TG_OP = 'INSERT') THEN
		--- VALIDACIÓN DE TODOS LOS ATRIBUTOS DEL CRUDO ---
		IF (new.contenido IS NULL OR new.contenido = '') THEN
			RAISE INFO 'Debe ingresar el contenido del crudo que quiere crear';
			RAISE EXCEPTION 'Debe ingresar el contenido del crudo que quiere crear';
		END IF;  

		IF (new.tipo_contenido != 'texto' AND new.tipo_contenido != 'imagen' AND new.tipo_contenido != 'sonido' AND new.tipo_contenido != 'video') THEN
			RAISE INFO 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video), %', new.tipo_contenido;
			RAISE EXCEPTION 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video)';
		END IF;   	

		IF (new.fuente != 'abierta' AND new.fuente != 'secreta' AND new.fuente != 'tecnica') THEN
			RAISE INFO 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
			RAISE EXCEPTION 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
		END IF;  

		IF (new.resumen IS NULL OR new.resumen = '') THEN
			RAISE INFO 'Debe ingresar el resumen del crudo que quiere crear';
			RAISE EXCEPTION 'Debe ingresar el resumen del crudo que quiere crear';
		END IF;   

		IF (new.valor_apreciacion IS NOT NULL AND new.valor_apreciacion <= 0) THEN
			RAISE INFO 'El valor de apreciacion del crudo debe ser mayor a 0$';
			RAISE EXCEPTION 'El valor de apreciacion del crudo debe ser mayor a 0$';
		END IF; 

		IF (new.nivel_confiabilidad_inicial IS NULL OR new.nivel_confiabilidad_inicial < 0 OR new.nivel_confiabilidad_inicial > 100 ) THEN
			RAISE INFO 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
			RAISE EXCEPTION 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
		END IF; 
		
		IF (new.cant_analistas_verifican IS NULL OR new.cant_analistas_verifican < 2) THEN	
			RAISE INFO 'Debe ingresar un número valido de analistas requeridos para la verificación';
			RAISE EXCEPTION 'Debe ingresar un número valido de analistas requeridos para la verificación';
		END IF;   
		
			
		CALL VALIDAR_EXIT_TEMA(new.fk_clas_tema);
		--- RETURN NEW = INSERTA EL REGISTRO---
		RETURN NEW;

	
	ELSIF (TG_OP = 'UPDATE') THEN


		IF (new.contenido IS NULL OR new.contenido = '') THEN
			RAISE INFO 'Debe ingresar el contenido del crudo que quiere crear';
			RAISE EXCEPTION 'Debe ingresar el contenido del crudo que quiere crear';
		END IF;  

		IF (new.tipo_contenido != 'texto' AND new.tipo_contenido != 'imagen' AND new.tipo_contenido != 'sonido' AND new.tipo_contenido != 'video') THEN
			RAISE INFO 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video), %', new.tipo_contenido;
			RAISE EXCEPTION 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video)';
		END IF;   	

		IF (new.fuente != 'abierta' AND new.fuente != 'secreta' AND new.fuente != 'tecnica') THEN
			RAISE INFO 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
			RAISE EXCEPTION 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
		END IF;  

		IF (new.resumen IS NULL OR new.resumen = '') THEN
			RAISE INFO 'Debe ingresar el resumen del crudo que quiere crear';
			RAISE EXCEPTION 'Debe ingresar el resumen del crudo que quiere crear';
		END IF;   

		IF (new.valor_apreciacion IS NOT NULL AND new.valor_apreciacion <= 0) THEN
			RAISE INFO 'El valor de apreciacion del crudo debe ser mayor a 0$';
			RAISE EXCEPTION 'El valor de apreciacion del crudo debe ser mayor a 0$';
		END IF; 

		IF (new.nivel_confiabilidad_inicial IS NULL OR new.nivel_confiabilidad_inicial < 0 OR new.nivel_confiabilidad_inicial > 100 ) THEN
			RAISE INFO 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
			RAISE EXCEPTION 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
		END IF; 
		
		IF (new.cant_analistas_verifican IS NULL OR new.cant_analistas_verifican < 2) THEN	
			RAISE INFO 'Debe ingresar un número valido de analistas requeridos para la verificación';
			RAISE EXCEPTION 'Debe ingresar un número valido de analistas requeridos para la verificación';
		END IF;   
		
			
		CALL VALIDAR_EXIT_TEMA(new.fk_clas_tema);
		--- RETURN NEW = INSERTA EL REGISTRO---
	
		RETURN NEW;

	END IF;

END
$$;

---DROP FUNCTION TRIGGER_INSERT_CRUDO()

CREATE TRIGGER TRIGGER_UPDATE_INSERT_CRUDO
BEFORE INSERT OR UPDATE ON CRUDO
FOR EACH ROW EXECUTE FUNCTION TRIGGER_UPDATE_INSERT_CRUDO();

---DROP TRIGGER TRIGGER_INSERT_CRUDO ON crudo

------SELECT * FROM CRUDO
----INSERT INTO crudo (contenido, tipo_contenido, resumen, fuente, valor_apreciacion, nivel_confiabilidad_inicial, nivel_confiabilidad_final, fecha_obtencion, fecha_verificacion_final, cant_analistas_verifican, fk_clas_tema, fk_informante, fk_estacion_pertenece, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente) VALUES
----('crudo_contenido/texto2.txt', 'texto', 'Conflictos entre paises por poder II', 'abierta', 600, 90, 90 , '2019-03-05 01:00:00', null, 2, 1, null, 1, 1, 1, 1, '2020-01-05 01:00:00', 1);

----SELECT * FROM HIST_CARGO where fecha_inicio='2034-01-05 01:00:00' 
----	AND fk_personal_inteligencia_agente = 17
----	AND fk_estacion_agente= 5
----	AND fk_oficina_principal_agente = 2




----TRIGGER PARA VALIDAR EL INSERT DEL CLIENTE----

CREATE OR REPLACE FUNCTION TRIGGER_CLIENTE ()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE
	
	lugar_reg lugar%rowtype;
	
BEGIN
	---VALIDACIONES DE ATRIBUTOS---
	---TIENE NOMBRE LA EMPRESA----
	
	IF (TG_OP = 'DELETE') THEN
		
		RETURN OLD;
	
	ELSIF (TG_OP = 'UPDATE') THEN
	
		IF (new.nombre_empresa IS NULL OR new.nombre_empresa = ' ') THEN
		RAISE EXCEPTION 'EL NOMBRE DEL CLIENTE ESTA VACIO';
		END IF;
	
		---TIENE PAGINA WEB LA EMPRESA---
	
		IF (new.pagina_web IS NULL OR new.pagina_web =' ') THEN
			RAISE EXCEPTION 'DEBE INSERTAR UNA PAGINA WEB';
		END IF;

		---VALIDA EL TIPO DE LUGAR (PAIS) DONDE SE REGISTRÓ EL CLIENTE---
		CALL VALIDAR_TIPO_LUGAR(new.fk_lugar_pais,'pais');
		
		RAISE INFO 'MODIFICÓ EL CLIENTE';
		
		RETURN new;	
		
	ELSIF (TG_OP = 'INSERT') THEN
	
		IF (new.nombre_empresa IS NULL OR new.nombre_empresa = ' ') THEN
		RAISE EXCEPTION 'EL NOMBRE DEL CLIENTE ESTA VACIO';
		END IF;
	
		---TIENE PAGINA WEB LA EMPRESA---
	
		IF (new.pagina_web IS NULL OR new.pagina_web =' ') THEN
			RAISE EXCEPTION 'DEBE INSERTAR UNA PAGINA WEB';
		END IF;

		---VALIDA EL TIPO DE LUGAR (PAIS) DONDE SE REGISTRÓ EL CLIENTE---
		CALL VALIDAR_TIPO_LUGAR(new.fk_lugar_pais,'pais');
		
		RAISE INFO 'SE INSERTÓ EL CLIENTE';
		
		RETURN new;	
	
	END IF;
	
	RETURN NULL;
	

END

$$;

--INSERT INTO cliente (nombre_empresa, pagina_web, exclusivo, telefonos, contactos, fk_lugar_pais) VALUES
--('mexicaso', 'mexicaso.org.ve' ,true, ARRAY[CAST((58,4126909353) as telefono_ty), CAST((58,4165420879)as telefono_ty)],  ARRAY[ ROW('Eloisa', 'Petronila', 'Nolasco', 'White', '91 Sage Ave. Colorado Springs, CO 80911',  ROW(58,4121705701)), ROW('Nicolas', 'Abelardo', 'Tafoya', 'Peralta', '8370 Euclid Lane Harrisburg, PA 17109', ROW(58,4127728311))]::contacto_ty[], 4);


-- DROP FUNCTION TRIGGER_CLIENTE()

-- DROP TRIGGER TRIGGER_CLIENTE on cliente

CREATE TRIGGER TRIGGER_CLIENTE
BEFORE INSERT OR UPDATE OR DELETE on CLIENTE
FOR EACH ROW EXECUTE FUNCTION TRIGGER_CLIENTE();



-- -/=/- ARCHIVO TRIGGER_UPDATE_PIEZA_REGISTRADA.sql -/=/- 

-- --////-- TABLA PIEZA_INTELIGENCIA
-- -/TRIGGER_UPDATE_PIEZA_REGISTRADA BEFORE UPDATE FOR EACH ROW TRIGGER_ACUALIZACION_PIEZA();



-------------------------------//////////////////------------------------------------

CREATE OR REPLACE FUNCTION TRIGGER_INSERT_UPDATE_CRUDO_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
	crudo_reg CRUDO%ROWTYPE;
	crudo_pieza_reg CRUDO_PIEZA%ROWTYPE;
	
	-- nivel_confiabilidad_va CRUDO.nivel_confiabilidad_final%ROWTYPE;
		
BEGIN
	---SI EL TRIGGER ES DISPARADO POR INSERT---
	IF (TG_OP = 'INSERT') THEN
        
		SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza AND precio_base IS NULL;
		RAISE INFO 'datos de la pieza de inteligencia %', pieza_reg;

		SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo;
		RAISE INFO 'datos del crudo: %', crudo_reg;
		
		SELECT * INTO crudo_pieza_reg FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza AND fk_crudo = id_crudo;
		RAISE INFO 'datos de crudo_pieza: %', crudo_pieza_reg;
	
		--------

		IF (pieza_reg IS NULL) THEN
			RAISE INFO 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
			RAISE EXCEPTION 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
		END IF;   
	
		IF (crudo_reg IS NULL) THEN
			RAISE INFO 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
			RAISE EXCEPTION 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
		END IF;   	
	
		IF (crudo_pieza_reg IS NOT NULL) THEN
			RAISE INFO 'El crudo que intenta asociar ya está asociado a esta pieza';
			RAISE EXCEPTION 'El crudo que intenta asociar ya está asociado a esta pieza';
		END IF;   	
	
		IF ( VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo) != crudo_reg.cant_analistas_verifican ) THEN
			RAISE INFO 'El crudo que ingresó no ha sido verificado';
			RAISE EXCEPTION 'El crudo que ingresó no ha sido verificado';
		END IF;   	

		IF (crudo_reg.nivel_confiabilidad_final < 85 ) THEN
			RAISE INFO 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
			RAISE EXCEPTION 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
		END IF;   	

		RETURN NEW;

	---SI EL TRIGGER ES DISPARADO POR UPDATE---
	ELSIF (TG_OP = 'UPDATE') THEN

		SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza AND precio_base IS NULL;
		RAISE INFO 'datos de la pieza de inteligencia %', pieza_reg;

		SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo;
		RAISE INFO 'datos del crudo: %', crudo_reg;
		
		SELECT * INTO crudo_pieza_reg FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza AND fk_crudo = id_crudo;
		RAISE INFO 'datos de crudo_pieza: %', crudo_pieza_reg;
	
		--------

		IF (pieza_reg IS NULL) THEN
			RAISE INFO 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
			RAISE EXCEPTION 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
		END IF;   
	
		IF (crudo_reg IS NULL) THEN
			RAISE INFO 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
			RAISE EXCEPTION 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
		END IF;   	
	
		IF (crudo_pieza_reg IS NOT NULL) THEN
			RAISE INFO 'El crudo que intenta asociar ya está asociado a esta pieza';
			RAISE EXCEPTION 'El crudo que intenta asociar ya está asociado a esta pieza';
		END IF;   	
	
		IF ( VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo) != crudo_reg.cant_analistas_verifican ) THEN
			RAISE INFO 'El crudo que ingresó no ha sido verificado';
			RAISE EXCEPTION 'El crudo que ingresó no ha sido verificado';
		END IF;   	

		IF (crudo_reg.nivel_confiabilidad_final < 85 ) THEN
			RAISE INFO 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
			RAISE EXCEPTION 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
		END IF;   	

		RETURN NEW;


	END IF;

	


END $$;
---------ELIMINACION DE LA FUNCION------
---DROP FUNCTION TRIGGER_CRUDO_PIEZA()

---------CREACION DEL TRIGGER-----
CREATE TRIGGER TRIGGER_INSERT_UPDATE_CRUDO_PIEZA
BEFORE INSERT OR UPDATE ON CRUDO_PIEZA
FOR EACH ROW EXECUTE FUNCTION TRIGGER_INSERT_UPDATE_CRUDO_PIEZA();


DROP TRIGGER TRIGGER_INSERT_UPDATE_CRUDO_PIEZA on crudo_pieza;
-- DROP TRIGGER trigger_update_pieza ON PIEZA_INTELIGENCIA;
---------ELIMINACION DEL TRIGGER-----
---DROP TRIGGER TRIGGER_CRUDO_PIEZA

---PRUEBA ---------------------------
---INSERT INTO crudo_pieza (fk_pieza_inteligencia, fk_crudo )
---VALUES (1,19)






-------------------------------//////////////////------------------------------------




CREATE OR REPLACE FUNCTION TRIGGER_UPDATE_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE
	
	-- pieza pieza_inteligencia%rowtype;
	
BEGIN

	---SELECT PARA BUSCAR LAS PIEZAS VENDIDAS EN LA TABLA ADQUISICION
	---PUEDE SER VENDIDA VARIAS VECES LA PIEZA
	
	-- SELECT * INTO pieza
	-- FROM PIEZA_INTELIGENCIA p, ADQUISICION a
	-- WHERE p.id = a.fk_pieza_inteligencia
	-- AND p.id = old.id;
	
	IF (old.precio_base IS NULL) THEN
		RAISE INFO 'SE ACTUALIZO LA PIEZA DE INTELIGENCIA';
		RETURN new;
	ELSE
		RAISE INFO 'DATOS DE LA PIEZA DE INTELIGENCIA: %',old;
		RAISE EXCEPTION 'LA PIEZA DE INTELIGENCIA YA FUE CERTIFICADA';	
		return null;
		
	END IF;

END
$$;





----------------CREACION DEL TRIGGER --------------------
CREATE TRIGGER TRIGGER_UPDATE_PIEZA
BEFORE UPDATE ON PIEZA_INTELIGENCIA
FOR EACH ROW EXECUTE FUNCTION TRIGGER_UPDATE_PIEZA();


DROP TRIGGER TRIGGER_UPDATE_PIEZA ON PIEZA_INTELIGENCIA;






CREATE OR REPLACE FUNCTION TRIGGER_CLAS_TEMA()
RETURNS TRIGGER LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE
	pieza_reg record;
	crudo_reg record;
	temas_esp record;
	area_interes record;
BEGIN
	
	IF(TG_OP = 'INSERT') THEN
	
		IF(new.nombre IS NULL OR new.nombre = '')THEN
			RAISE EXCEPTION 'EL NOMBRE DEL TEMA ESTA VACIO';
		END IF;
		IF(new.descripcion IS NULL OR new.descripcion = '') THEN
			RAISE EXCEPTION 'LA DESCRIPCION DEL TEMA ESTA VACIO';
		END IF;
		CASE new.topico
			WHEN 'paises' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'individuos' THEN
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'eventos' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'empresas' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
		END CASE;

		RETURN NEW; 
	
	ELSIF (TG_OP = 'UPDATE') THEN
		
		IF(new.nombre IS NULL OR new.nombre = '')THEN
			RAISE EXCEPTION 'EL NOMBRE DEL TEMA ESTA VACIO';
		END IF;
		IF(new.descripcion IS NULL OR new.descripcion = '') THEN
			RAISE EXCEPTION 'LA DESCRIPCION DEL TEMA ESTA VACIO';
		END IF;
		CASE new.topico
			WHEN 'paises' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'individuos' 
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'eventos'
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'empresas'
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
		END CASE;

		RETURN NEW; 
	ELSIF (TG_OP = 'DELETE') THEN
		--- VALIDACION RAPIDA DE LOS FK DE LA CLASIFICACION PIEZA EN LAS OTRAS TABLAS ANTES DE ELIMINAR ----
		--- PERSONAL_INTELIGENCIA, CRUDO, CLAS_TEMA, TEMAS_ESP ---
		
		SELECT id INTO  pieza_reg FROM pieza_inteligencia
		WHERE fk_clas_tema  =  new.id;
		
		SELECT id INTO crudo_reg FROM crudo
		WHERE fk_clas_tema = new.id;
		
		SELECT fk_clas_tema INTO temas_esp FROM clas_tema
		WHERE fk_clas_tema = new.id;
		
		SELECT fk_clas_tema INTO area_interes FROM area_interes
		WHERE fk_clas_tema = new.id;
		
		IF (pieza_reg IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UNA PIEZA DE INTELIGENCIA';
		END IF;
		
		IF (crudo_reg IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN CRUDO';
		END IF;
		
		IF (temas_esp IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN TEMA ESPECIFICO DE UN PERSONAL DE INTELIGENCIA';
		END IF;
		
		IF (area_interes IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN AREA DE INTERES DE UN CLIENTE';
		END IF;
		
		RETURN OLD;
	END IF;	
END 
$$;

-- DROP FUNCTION TRIGGER_CLAS_TEMA()

CREATE TRIGGER TRIGGER_CLAS_TEMA
BEFORE INSERT OR UPDATE ON clas_tema
FOR EACH ROW EXECUTE FUNCTION TRIGGER_CLAS_TEMA();








----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////////- ASIGNACION DE PRIVILEGIOS SOBRE OBJETOS A ROLES   -- EJECUTAR COMO DEV -//////////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------



-- PRIVILEGIOS A ROL: DIRECTOR EJECUTIVO
GRANT SELECT ON VISTA_DIRECTORES_AREA TO ROL_DIRECTOR_EJECUTIVO;
GRANT SELECT ON VISTA_OFICINAS TO ROL_DIRECTOR_EJECUTIVO;
GRANT SELECT ON VISTA_CUENTA_AII TO ROL_DIRECTOR_EJECUTIVO;


-- PRIVILEGIOS A USUARIOS: DIRECTORES DE AREA

-- dir_area_2_dublin
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_DUBLIN TO dir_area_2_dublin;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_DUBLIN TO dir_area_2_dublin;

-- dir_area_3_amsterdam
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_AMSTERDAM TO dir_area_3_amsterdam;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_AMSTERDAM TO dir_area_3_amsterdam;

-- dir_area_4_nuuk
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_NUUK TO dir_area_4_nuuk;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_NUUK TO dir_area_4_nuuk;

-- dir_area_5_buenos_aires
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_BUENOS_AIRES TO dir_area_5_buenos_aires;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_BUENOS_AIRES TO dir_area_5_buenos_aires;

-- dir_area_6_taipei
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_TAIPEI TO dir_area_6_taipei;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_TAIPEI TO dir_area_6_taipei;

-- dir_area_7_kuala_lumpur
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_KUALA_LUMPUR TO dir_area_7_kuala_lumpur;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_KUALA_LUMPUR TO dir_area_7_kuala_lumpur;

-- dir_area_8_kampala
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_KAMPALA TO dir_area_8_kampala;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_KAMPALA TO dir_area_8_kampala;

-- dir_area_9_harare
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_HARARE TO dir_area_9_harare;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_HARARE TO dir_area_9_harare;

-- dir_area_10_sidney
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_SIDNEY TO dir_area_10_sidney;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_SIDNEY TO dir_area_10_sidney;

-- dir_area_38_ginebra
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_GINEBRA TO dir_area_38_ginebra;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_GINEBRA TO dir_area_38_ginebra;


-- ROL_DIRECTOR_EJECUTIVO

GRANT EXECUTE ON FUNCTION VER_DIRECTOR_AREA(integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_DIRECTORES_AREA () TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_LUGAR (integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_LUGARES () TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_OFICINA (integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_OFICINAS () TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_DIRECTOR_EJECUTIVO (integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_DIRECTORES_EJECUTIVOS () TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CREAR_DIRECTOR_AREA (varchar, varchar, varchar, varchar, telefono_ty, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ELIMINAR_DIRECTOR_AREA (INTEGER) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_DIRECTOR_AREA (integer, varchar, varchar, varchar, varchar, telefono_ty, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CREAR_OFICINA_PRINCIPAL (varchar, boolean, int, int, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ELIMINAR_OFICINA_PRINCIPAL (INTEGER) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_OFICINA_PRINCIPAL (integer, varchar, boolean, int, int, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CREAR_DIRECTOR_EJECUTIVO (varchar, varchar, varchar, varchar, telefono_ty) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ELIMINAR_DIRECTOR_EJECUTIVO (INTEGER) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_DIRECTOR_EJECUTIVO (integer, varchar, varchar, varchar, varchar, telefono_ty) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CAMBIAR_ROL_EMPLEADO (integer, integer, integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CREAR_LUGAR (varchar, varchar, varchar, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ELIMINAR_LUGAR (INTEGER) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_LUGAR (integer, varchar, varchar, varchar, int) TO ROL_DIRECTOR_EJECUTIVO;



-- ROL_DIRECTOR_AREA

GRANT EXECUTE ON FUNCTION VER_JEFE_E (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_JEFES_E (INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_ESTACIONES (INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_PRESUPUESTO_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_CLIENTE (INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_CLIENTES () TO  ROL_DIRECTOR_AREA;

GRANT EXECUTE ON FUNCTION CREAR_CONTACTO  ( VARCHAR, VARCHAR,  VARCHAR,  VARCHAR,  VARCHAR,  NUMERIC,  NUMERIC) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION CREAR_TELEFONO   (NUMERIC,  NUMERIC) TO  ROL_DIRECTOR_AREA;

GRANT EXECUTE ON PROCEDURE VALIDAR_ACESSO_DIR_AREA_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE CREAR_JEFE_ESTACION (INTEGER, VARCHAR, VARCHAR, VARCHAR, VARCHAR, telefono_ty) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_JEFE_ESTACION ( INTEGER, INTEGER, VARCHAR, VARCHAR, VARCHAR, VARCHAR, telefono_ty) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ELIMINAR_JEFE_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE CREAR_ESTACION (INTEGER, VARCHAR, INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ELIMINAR_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_ESTACION (INTEGER, VARCHAR, INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ASIGNACION_PRESUPUESTO (INTEGER, INTEGER, NUMERIC) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE CREAR_CLIENTE (VARCHAR, VARCHAR, BOOLEAN, telefono_ty, contacto_ty, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ELIMINAR_CLIENTE (INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_CLIENTE (INTEGER, VARCHAR, VARCHAR, BOOLEAN, telefono_ty, contacto_ty, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ASIGNAR_TEMA_CLIENTE (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;


-- ROL EMPLEADO_JEFE

GRANT EXECUTE ON PROCEDURE ELIMINAR_PERSONAL_INTELIGENCIA (INTEGER, INTEGER) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE CERRAR_HIST_CARGO (integer, integer) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO (integer, integer, integer, varchar) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE ASIGNAR_TEMA_ANALISTA (integer, integer, integer) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA ( integer, integer) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE VALIDAR_ACESSO_EMPLEADO_ESTACION (integer, integer) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE CREAR_PERSONAL_INTELIGENCIA (varchar, varchar, varchar, varchar, date, numeric(5), numeric(5), varchar, varchar, varchar, bytea, bytea, bytea, telefono_ty, licencia_ty,varchar(50)[], familiar_ty, familiar_ty, identificacion_ty, nivel_educativo_ty, int) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_PERSONAL_INTELIGENCIA (integer, integer, varchar, varchar, varchar, varchar, date, numeric(5), numeric(5), varchar, varchar, varchar, bytea, bytea, bytea, telefono_ty, licencia_ty,varchar(50)[], familiar_ty, familiar_ty, identificacion_ty, nivel_educativo_ty, int) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE ELIMINAR_PERSONAL_INTELIGENCIA (INTEGER, INTEGER) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE CAMBIAR_ROL_PERSONAL_INTELIGENCIA (integer, integer, varchar) TO ROL_JEFE_ESTACION;



-- ROL_ANALISTA Y ROL_AGENTE


GRANT EXECUTE ON FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (integer) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (integer) TO ROL_AGENTE_CAMPO;

GRANT EXECUTE ON PROCEDURE REGISTRO_INFORMANTE (varchar, integer, integer,integer) TO ROL_AGENTE_CAMPO;
GRANT EXECUTE ON PROCEDURE REGISTRO_CRUDO_SIN_INFORMANTE ( integer, integer, bytea, varchar,  varchar, varchar, numeric, numeric, numeric) TO ROL_AGENTE_CAMPO;
GRANT EXECUTE ON PROCEDURE REGISTRO_CRUDO_CON_INFORMANTE ( integer, numeric , integer, integer, bytea, varchar,  varchar, numeric, numeric, numeric ) TO ROL_AGENTE_CAMPO;

GRANT EXECUTE ON FUNCTION ANALISTA_VERIFICO_CRUDO ( integer, integer )  TO  ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION ANALISTA_PUEDE_VERIFICA_CRUDO ( integer, integer )  TO  ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE VERIFICAR_CRUDO ( integer, integer, numeric) TO  ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE CERRAR_CRUDO ( integer ) TO  ROL_ANALISTA;


GRANT EXECUTE ON PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (integer, varchar, integer) TO ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION VER_DATOS_PIEZA (integer, integer) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE AGREGAR_CRUDO_A_PIEZA ( integer, integer ) TO ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE REGISTRO_VENTA (integer, integer, numeric) TO ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE CERTIFICAR_PIEZA (integer, numeric) TO ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE ELIMINACION_REGISTROS_VENTA_EXCLUSIVA ( integer )  TO ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION VALIDAR_VENTA_EXCLUSIVA ( integer )  TO ROL_ANALISTA;



GRANT EXECUTE ON FUNCTION FORMATO_ARCHIVO_A_BYTEA(text) TO ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO, ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION VER_LISTA_CRUDOS_ESTACION (integer) TO ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO, ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION VER_LISTA_CRUDOS_PERSONAL (integer) TO ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO, ROL_ANALISTA;


GRANT EXECUTE ON FUNCTION VER_LISTA_PIEZAS_ESTACION (integer) TO ROL_JEFE_ESTACION;






-----///////- Probado con PostgreSQL 13.4 on x86_64-pc-linux-gnu, compiled by gcc (GCC) 11.1.0, 64-bit-\\\\\\\\\------

----------///////////---------------------------------------------------------------------------\\\\\\\\\\\----------
----------///////////- SCRIPTS DE CREACION DE LA BASES DE DATOS DOS - PROYECTO AII - GRUPO 09  -\\\\\\\\\\\----------
----------///////////----------- ANTONIO BADILLO - GABRIEL MANRIQUE - MICKEL ARROZ -------------\\\\\\\\\\\----------
----------///////////---------------------------------------------------------------------------\\\\\\\\\\\-----------


