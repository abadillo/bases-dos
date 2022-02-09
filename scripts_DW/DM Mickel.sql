
---------------------------------- TABLAS DIMENSION -------------------------------
/*
DROP TABLE IF EXISTS DimLugar CASCADE;

CREATE TABLE DimLugar (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar integer,
    fechac TIMESTAMP NOT NULL,

    CONSTRAINT LUGAR_PK PRIMARY KEY (id),
    CONSTRAINT LUGAR_LUGAR_FK FOREIGN KEY (fk_lugar) REFERENCES LUGAR (id),
    CONSTRAINT LUGAR_CH_tipo CHECK ( tipo IN ('ciudad', 'pais') ),
    CONSTRAINT LUGAR_CH_region CHECK ( region IN ('europa', 'africa', 'america_sur', 'america_norte', 'asia', 'oceania') )
);




DROP TABLE IF EXISTS TIEMPO CASCADE;

CREATE TABLE TIEMPO (

    id serial NOT NULL,
    semestre SMALLINT NOT NULL,
    anio numeric(4) NOT NULL,

    CONSTRAINT TIEMPO_PK PRIMARY KEY (id),
    CONSTRAINT SEMESTRE_CHECK CHECK (semestre = 1 or semestre = 2)

);


INSERT INTO TIEMPO (semestre, anio) VALUES 
    (1,2034), 
    (2,2034), 
    (1,2035), 
    (2,2035), 
    (1,2036), 
    (2,2036)
    ;


DROP TABLE IF EXISTS DimOFICINA_PRINCIPAL CASCADE;

CREATE TABLE DimOFICINA_PRINCIPAL (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    sede boolean NOT NULL,
    fk_director_area integer ,
    fk_director_ejecutivo integer ,
    fk_lugar_ciudad integer NOT NULL,
    fechac TIMESTAMP NOT NULL,

    CONSTRAINT OFICINA_PRINCIPAL_PK PRIMARY KEY (id),
    CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe FOREIGN KEY (fk_director_area) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe_2 FOREIGN KEY (fk_director_ejecutivo) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT OFICINA_PRINCIPAL_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id)
);

*/


------------------------------------------ TABLAS FACT -----------------------------------


-- Desempeño AII

-- Sería ideal contar con información sobre los puntos anteriores, como por ejemplo, cuál es el tema con 
-- mayor demanda (tema en el que la mayor cantidad de clientes ha adquirido piezas de inteligencia), 
-- cuál es el cliente más activo (que compra más frecuentemente). Esta información se debería 
-- presentar por región semestral y anualmente. 


DROP TABLE IF EXISTS DESEMPEÑO_AII CASCADE;

CREATE TABLE Desempeño_AII (
    id_tiempo integer NOT NULL,
    id_lugar integer,
    clienteMasActivo_Semestre VARCHAR(50),
    clienteMasActivo_Year VARCHAR(50),
    temaMayorDemanda_Semestre VARCHAR(50),
    temaMayorDemanda_Year VARCHAR(50)

);

--------------------------------------------------------------------------------
--
-- 
-- 
-- 
-- 
-- 
-- 
-- 
---
---
---
---
---
---
---

-- Productividad_Eficacia

--Para la AII es importante tener información confiable relacionada con el desempeño de sus 
--empleados: productividad2 de los analistas y agentes de campo por año, País, Oficina. La medida 
--debe ser calculada de manera directa para el empleado y promedio para oficinas y países. En 
--cualquier momento en el que el cálculo de la productividad sea inferior al 65% anual se debe resaltar 
--ese resultado con el color rojo.
--Como muchos hechos crudos vienen de informantes e implican pagos, se debe llevar un control 
--sobre la eficacia de esos tratos – o sea para un informante dado poder saber el % de su eficacia (en 
--qué proporción los hechos crudos aportados por tal informante se han convertido en piezas de 
--inteligencia). Esta medida se genera semestralmente y se usa en combinación con la productividad 
--de los agentes
-- La productividad es un porcentaje que representa la efectividad de las piezas de inteligencia que construyen los analistas, si 
--se lograra la venta de todas las piezas de un analista particular su productividad sería del 100%. En el caso de los agentes si
--todo hecho crudo que obtienen hace parte de una pieza de inteligencia vendida tendrían 100% de productividad.




DROP TYPE IF EXISTS ProdEmpleado CASCADE;


CREATE TYPE ProdEmpleado as (

    nombre varchar(200),
    productividad numeric(6,3)
);


DROP TABLE IF EXISTS PRODUCTIVIDAD_EFICACIA CASCADE;

CREATE TABLE PRODUCTIVIDAD_EFICACIA (
    id_tiempo integer NOT NULL,
    id_pais integer,
    id_informante integer,
    id_region_oficina integer,
    id_personal integer,
    %EficaciaInformante numeric (6,3),
    %ProdPromedioAgentesPais numeric (6,3),
    %ProdPromedioAnalistasPais numeric (6,3),
    %ProdPromedioAgentesOficina numeric (6,3),
    %ProdPromedioAnalistasOficina numeric (6,3),
    %ProdGeneralAgente ProdEmpleado,
    %ProdGeneralAnalista ProdEmpleado
);




----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 			    Create tablas T1 - METRICA 1 y 2  	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------

DROP TABLE IF EXISTS T1_INFORMANTE CASCADE;
DROP TABLE IF EXISTS T1_PERSONAL_INTELIGENCIA CASCADE;
DROP TABLE IF EXISTS T1_CRUDO_PIEZA CASCADE;
DROP TABLE IF EXISTS T1_CRUDO CASCADE;
DROP TABLE IF EXISTS T1_ANALISTA_CRUDO CASCADE;
DROP TABLE IF EXISTS T1_HIST_CARGO CASCADE;



CREATE TABLE T1_PERSONAL_INTELIGENCIA( -- 

id INTEGER NOT NULL,

    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50),
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,

--    --foreign keys 
    fk_lugar_ciudad integer NOT NULL,

    CONSTRAINT T1_PERSONAL_INTELIGENCIA_PK PRIMARY KEY (id),

    CONSTRAINT T1_PERSONAL_INTELIGENCIA_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES T1_LUGAR (id)
    
);


CREATE TABLE T1_HIST_CARGO (
    
    fecha_inicio timestamp NOT NULL,
    cargo varchar(20) NOT NULL, -- 'analista agente'
    fk_personal_inteligencia integer NOT NULL,
    fk_estacion integer NOT NULL,
    fk_oficina_principal integer NOT NULL,

    --CONSTRAINT T1_HIST_CARGO_PK PRIMARY KEY (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT T1_HIST_CARGO_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES T1_PERSONAL_INTELIGENCIA (id),

    CONSTRAINT T1_HIST_CARGO_CH_cargo CHECK ( cargo IN ('analista', 'agente') )    
);


CREATE TABLE T1_INFORMANTE ( -- 
    
     id integer NOT NULL,

    nombre_clave varchar(100),
    

    -- agente de campo encargado del informante
    fk_personal_inteligencia_encargado integer NOT NULL,    
    fk_fecha_inicio_encargado timestamp NOT NULL,
    fk_estacion_encargado integer NOT NULL,
    fk_oficina_principal_encargado integer NOT NULL,
    
    CONSTRAINT T1_INFORMANTE_PK PRIMARY KEY (id)


    -- CONSTRAINT T1_INFORMANTE_HIST_CARGO_encargado FOREIGN KEY (fk_fecha_inicio_encargado, fk_personal_inteligencia_encargado, fk_estacion_encargado, fk_oficina_principal_encargado) 
    --     REFERENCES T1_HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal)

);


CREATE TABLE T1_CRUDO_PIEZA( -- 
    
    fk_pieza_inteligencia integer NOT NULL,
    fk_crudo integer NOT NULL,

    CONSTRAINT T1_CRUDO_PIEZA_ALT_PK PRIMARY KEY (fk_pieza_inteligencia, fk_crudo)

);


CREATE TABLE T1_CRUDO ( -- 

 id integer NOT NULL,

    fk_informante integer,

    --estacion a donde pertence
    fk_oficina_principal_pertenece integer NOT NULL,

    --agente encargado
    fk_estacion_agente integer NOT NULL,
    fk_oficina_principal_agente integer NOT NULL,
    fk_fecha_inicio_agente timestamp NOT NULL,
    fk_personal_inteligencia_agente integer NOT NULL,

    CONSTRAINT T1_CRUDO_PK PRIMARY KEY (id),

    -- CONSTRAINT T1_CRUDO_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_agente, fk_personal_inteligencia_agente, fk_estacion_agente, fk_oficina_principal_agente) REFERENCES T1_HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT T1_CRUDO_INFORMANTE_FK FOREIGN KEY (fk_informante) REFERENCES T1_INFORMANTE (id)

);


CREATE TABLE T1_ANALISTA_CRUDO (


    fecha_hora timestamp NOT NULL,
    fk_crudo integer NOT NULL,

    -- fks de hist_cargo
    fk_fecha_inicio_analista timestamp NOT NULL,
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_estacion_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL ,

    CONSTRAINT T1_ANALISTA_CRUDO_PK PRIMARY KEY (fk_crudo, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista),

    CONSTRAINT T1_ANALISTA_CRUDO_CRUDO_FK FOREIGN KEY (fk_crudo) REFERENCES T1_CRUDO (id)
    -- CONSTRAINT T1_ANALISTA_CRUDO_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista) REFERENCES T1_HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal)


);



----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 			    Create tablas T2 - METRICA 1 y 2  	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------

DROP TABLE IF EXISTS T2_INFORMANTE CASCADE;
DROP TABLE IF EXISTS T2_PERSONAL_INTELIGENCIA CASCADE;
DROP TABLE IF EXISTS T2_CRUDO_PIEZA CASCADE;
DROP TABLE IF EXISTS T2_CRUDO CASCADE;
DROP TABLE IF EXISTS T2_ANALISTA_CRUDO CASCADE;
DROP TABLE IF EXISTS T2_HIST_CARGO CASCADE;
DROP TABLE IF EXISTS T2_PAIS CASCADE;

CREATE TABLE T2_PAIS (
    id integer NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    fechac TIMESTAMP NOT NULL,
    
    CONSTRAINT T2_LUGAR_PK PRIMARY KEY (id)
);



CREATE TABLE T2_PERSONAL_INTELIGENCIA( -- 

	id INTEGER NOT NULL,

    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50),
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,
    fechac timestamp,
--    --foreign keys 
    fk_lugar_ciudad integer NOT NULL,

    CONSTRAINT T2_PERSONAL_INTELIGENCIA_PK PRIMARY KEY (id),

    CONSTRAINT T2_PERSONAL_INTELIGENCIA_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES T2_PAIS (id)
    
);


CREATE TABLE T2_HIST_CARGO (
    
    fecha_inicio timestamp NOT NULL,
    cargo varchar(20) NOT NULL, -- 'analista agente'
    fk_personal_inteligencia integer NOT NULL,
    fk_estacion integer NOT NULL,
    fk_oficina_principal integer NOT NULL,

    --CONSTRAINT T1_HIST_CARGO_PK PRIMARY KEY (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT T2_HIST_CARGO_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES T2_PERSONAL_INTELIGENCIA (id),

    CONSTRAINT T2_HIST_CARGO_CH_cargo CHECK ( cargo IN ('analista', 'agente') )    
);


CREATE TABLE T2_INFORMANTE ( -- 
    
    id integer NOT NULL,

    nombre_clave varchar(100),
    fechac timestamp,

    -- agente de campo encargado del informante
    fk_personal_inteligencia_encargado integer NOT NULL,    
    fk_fecha_inicio_encargado timestamp NOT NULL,
    fk_estacion_encargado integer NOT NULL,
    fk_oficina_principal_encargado integer NOT NULL,
    
    CONSTRAINT T2_INFORMANTE_PK PRIMARY KEY (id)


    -- CONSTRAINT T1_INFORMANTE_HIST_CARGO_encargado FOREIGN KEY (fk_fecha_inicio_encargado, fk_personal_inteligencia_encargado, fk_estacion_encargado, fk_oficina_principal_encargado) 
    --     REFERENCES T1_HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal)

);


CREATE TABLE T2_CRUDO_PIEZA( -- 
    fechac timestamp,
    fk_pieza_inteligencia integer NOT NULL,
    fk_crudo integer NOT NULL,
	
	
    CONSTRAINT T2_CRUDO_PIEZA_ALT_PK PRIMARY KEY (fk_pieza_inteligencia, fk_crudo)

);


CREATE TABLE T2_CRUDO ( -- 

 	id integer NOT NULL,
	fechac timestamp,
    fk_informante integer,

    --estacion a donde pertence
    fk_oficina_principal_pertenece integer NOT NULL,

    --agente encargado
    fk_estacion_agente integer NOT NULL,
    fk_oficina_principal_agente integer NOT NULL,
    fk_fecha_inicio_agente timestamp NOT NULL,
    fk_personal_inteligencia_agente integer NOT NULL,

    CONSTRAINT T2_CRUDO_PK PRIMARY KEY (id),

    -- CONSTRAINT T1_CRUDO_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_agente, fk_personal_inteligencia_agente, fk_estacion_agente, fk_oficina_principal_agente) REFERENCES T1_HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT T2_CRUDO_INFORMANTE_FK FOREIGN KEY (fk_informante) REFERENCES T2_INFORMANTE (id)

);


CREATE TABLE T2_ANALISTA_CRUDO (


    fecha_hora timestamp NOT NULL,
    fk_crudo integer NOT NULL,

    -- fks de hist_cargo
    fk_fecha_inicio_analista timestamp NOT NULL,
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_estacion_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL ,

    CONSTRAINT T2_ANALISTA_CRUDO_PK PRIMARY KEY (fk_crudo, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista),

    CONSTRAINT T2_ANALISTA_CRUDO_CRUDO_FK FOREIGN KEY (fk_crudo) REFERENCES T2_CRUDO (id)
    -- CONSTRAINT T1_ANALISTA_CRUDO_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista) REFERENCES T1_HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal)


);





----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 	 Create tablas T3 - METRICA 1  PRODUCTIVIDAD_EFICACIA 	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------


DROP TABLE IF EXISTS T3_PERSONAL_INTELIGENCIA_LOOKUP CASCADE;
DROP TABLE IF EXISTS T3_INFORMANTE CASCADE;
DROP TABLE IF EXISTS T3_PAIS CASCADE;
DROP TABLE IF EXISTS T3_TIEMPO CASCADE;
DROP TABLE IF EXISTS T3_PRODUCTIVIDAD_EFICACIA CASCADE;

CREATE TABLE T3_PERSONAL_INTELIGENCIA_LOOKUP (
	
	id_personal_inteligencia INTEGER,
	nombre VARCHAR(100),
	fechac TIMESTAMP
	
);

CREATE TABLE T3_INFORMANTE (

	id_informante INTEGER,
	nombre_clave VARCHAR(50),
	id_personal_inteligencia INTEGER,
	fechac TIMESTAMP,
	fk_personal INTEGER
		
);


CREATE TABLE T3_TIEMPO (

    id_tiempo INTEGER NOT NULL,
    semestre SMALLINT,
    año DATE   

);

CREATE TABLE T3_PAIS (

	id_pais INTEGER,
	nombre VARCHAR(50),
	fechac timestamp	
);

CREATE TABLE T3_PRODUCTIVIDAD_EFICACIA (
    id_tiempo integer NOT NULL,
    id_lugar integer,
    id_informante integer,
    id_oficina integer,
    id_personal integer,
    %EficaciaInformante numeric (6,3),
    %ProdPromedioAgentesPais numeric (6,3),
    %ProdPromedioAnalistasPais numeric (6,3),
    %ProdPromedioAgentesOficina numeric (6,3),
    %ProdPromedioAnalistasOficina numeric (6,3),
    %ProdGeneralAgente ProdEmpleado,
    %ProdGeneralAnalista ProdEmpleado
)


---
---
---
---
---
---
---
---
---
----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 		    EXTRACCION DE DATOS  - METRICA 1 y 2  	-- EJECUTAR COMO DEV 		     -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------


CREATE OR REPLACE PROCEDURE EXTRACCION_A_T1_PRODUCTIVIDAD_EFICACIA ()
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 
    maxid INTEGER;
	n_filas_afect integer;
BEGIN
        
	RAISE NOTICE ' ';
	RAISE NOTICE 'EXTRACCION_A_T1_PRODUCTIVIDAD_EFICACIA - %', NOW();
	RAISE NOTICE '-----------------------------------------------------';
	RAISE NOTICE ' ';
	
	-- T1_PERSONAL_INTELIGENCIA

    SELECT COALESCE(max(id),0) INTO maxid FROM T1_PERSONAL_INTELIGENCIA;
   
    INSERT INTO T1_PERSONAL_INTELIGENCIA 
        (id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fk_lugar_ciudad) 
    SELECT id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fk_lugar_ciudad 
    FROM PERSONAL_INTELIGENCIA c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_PERSONAL_INTELIGENCIA: %', n_filas_afect;
	

	-- T1_HIST_CARGO
    /*
    fecha_inicio, cargo, fk_personal_inteligencia, fk_estacion, fk_oficina_principal

	SELECT COALESCE(max(id), 0) INTO maxid from T1_HIST_CARGO;
    
	INSERT INTO T1_HIST_CARGO (id, nombre, descripcion, topico) 
    SELECT id, nombre, descripcion, topico FROM HIST_CARGO c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

   	RAISE NOTICE 'Filas insertadas en T1_CLAS_TEMA: %', n_filas_afect;
    */


   	-- T1_INFORMANTE 
    
    SELECT COALESCE(max(id),0) INTO maxid FROM T1_INFORMANTE;

    INSERT INTO T1_INFORMANTE (id, nombre_clave, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado) 
    SELECT id, nombre_clave, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado 
    FROM INFORMANTE c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_INFORMANTE: %', n_filas_afect;

    INSERT INTO T1_INFORMANTE (id, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado) 
    SELECT id, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado 
    FROM INFORMANTE_ALT c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_INFORMANTE_ALT: %', n_filas_afect;
    
    -- T1_CRUDO_PIEZA 
    /*
    fk_pieza_inteligencia, fk_crudo
    SELECT COALESCE(max(id),0) INTO maxid FROM T1_CRUDO_PIEZA;
    INSERT INTO T1_OFICINA_PRINCIPAL (id, nombre, fk_lugar_ciudad) 
    SELECT id, nombre, fk_lugar_ciudad FROM T1_CRUDO_PIEZA c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_CRUDO_PIEZA: %', n_filas_afect;
    */

	-- T1_CRUDO  


    SELECT COALESCE(max(id),0) INTO maxid FROM T1_CRUDO;
    
    INSERT INTO T1_CRUDO (id, fk_informante, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente)
    SELECT id, fk_informante, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente 
    FROM CRUDO c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;
    
	RAISE NOTICE 'Filas insertadas en T1_CRUDO: %', n_filas_afect;

    INSERT INTO T1_CRUDO (id, fk_informante, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente) 
    SELECT id, fk_informante, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente 
    FROM CRUDO_ALT c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas de CRUDO_ALT: %', n_filas_afect;


END
$$;

