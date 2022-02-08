-- Se crean tablas Dim con los mismos cambos de las tablas iniciales? SE MODIFICAN SEGUND LO NECESARIO
-- Tabla lugar o region? NUEVA TABLA REGION_OFICINA
-- fechac en las tablas solo dim? SI
-- Oficina Principal o Estaciones? OFICINAS PRINCIPALES

---------------------------------- TABLAS DIMENSION -------------------------------

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

)


CREATE OR REPLACE PROCEDURE COPIA_T1_DESEMEPÑO_AII ()
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 
    maxid INTEGER;
BEGIN
    maxid := (Select max(id) from T1_CLAS_TEMA);
    INSERT INTO T1_CLAS_TEMA (id, nombre, descripcion, topico) 
    SELECT id, nombre, descripcion, topico FROM CLAS_TEMA c
        WHERE c.id > maxid;
    maxid := 0;
    

    maxid := (Select max(id) from T1_CLIENTE);
    INSERT INTO T1_CLIENTE (id, nombre_empresa, pagina_web, fk_lugar_pais) 
    SELECT id, nombre_empresa, pagina_web, fk_lugar_pais FROM CLIENTE c
        WHERE c.id > maxid;
    maxid := 0;
    
    maxid := (Select max(id) from T1_OFICINA_PRINCIPAL);
    INSERT INTO T1_OFICINA_PRINCIPAL (id, nombre, fk_lugar_ciudad) 
    SELECT id, nombre, fk_lugar_ciudad FROM OFICINA_PRINCIPAL c
        WHERE c.id > maxid;
    maxid := 0;


    maxid := (Select max(id) from T1_LUGAR);
    INSERT INTO T1_LUGAR (id, nombre, tipo, region, fk_lugar) 
    SELECT id, nombre, tipo, region, fk_lugar FROM LUGAR c
        WHERE c.id > maxid;
    maxid := 0;


    maxid := (Select max(id) from T1_AREA_INTERES);
    INSERT INTO T1_AREA_INTERES (id, fk_clas_tema, fk_cliente) 
    SELECT id, fk_clas_tema, fk_cliente FROM AREA_INTERES c
        WHERE c.id > maxid;
    maxid := 0;



    maxid := (Select max(id) from T1_PIEZA_INTELIGENCIA); -- T1_PIEZA_INTELIGENCIA = PIEZA_INTELIGENCIA + PIEZA_INTELIGENCIA_ALT
    INSERT INTO T1_PIEZA_INTELIGENCIA (id, fk_clas_tema) 
    SELECT id, fk_clas_tema FROM PIEZA_INTELIGENCIA c
        WHERE c.id > maxid;
    
    INSERT INTO T1_PIEZA_INTELIGENCIA (id, fk_clas_tema) 
    SELECT id, fk_clas_tema FROM PIEZA_INTELIGENCIA_ALT c
        WHERE c.id > maxid;
    maxid := 0;



    maxid := (Select max(id) from T1_ADQUISICION); -- T1_ADQUISICION = ADQUISICION + ADQUISICION_ALT
    INSERT INTO T1_ADQUISICION (id, fk_cliente, fk_pieza_inteligencia) 
    SELECT id, fecha_hora_venta, precio_vendido, fk_cliente, fk_pieza_inteligencia FROM ADQUISICION c
        WHERE c.id > maxid;

    INSERT INTO T1_ADQUISICION (id, fk_cliente, fk_pieza_inteligencia) 
    SELECT id, fecha_hora_venta, precio_vendido, fk_cliente, fk_pieza_inteligencia FROM ADQUISICION_ALT c
        WHERE c.id > maxid;
    maxid := 0;

END
$$;

-----------------------------


CREATE OR REPLACE PROCEDURE COPIA_T2_DESEMEPÑO_AII ()
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 
    maxid INTEGER;
BEGIN
    
    maxid := (Select max(id) from T2_CLAS_TEMA);
    INSERT INTO T2_CLAS_TEMA (nombre, descripcion, topico, fechac) 
    SELECT nombre, descripcion, topico, NOW() FROM T1_CLAS_TEMA c
        WHERE c.id > maxid;
    maxid := 0;
    
    -- REVISAR
    maxid := (Select max(id) from T2_CLIENTE);
    INSERT INTO T2_CLIENTE (nombre_empresa, pagina_web, fk_lugar_pais, fechac) 
    SELECT nombre_empresa, pagina_web, exclusivo, fk_lugar_pais, NOW() FROM T1_CLIENTE c
        WHERE c.id > maxid;
    maxid := 0;
    

-- REVISAR (REGION)
    maxid := (Select max(id) from T2_LUGAR);
    INSERT INTO T2_LUGAR (nombre, tipo, region, fk_lugar, fechac) 
    SELECT nombre, tipo, region, fk_lugar, NOW() FROM T1_LUGAR c
        WHERE c.id > maxid;
    maxid := 0;
----------------------------------------------------------------------

    maxid := (Select max(id) from T2_AREA_INTERES);
    INSERT INTO T2_LUGAR (fk_clas_tema, fk_cliente, fechac) 
    SELECT fk_clas_tema, fk_cliente, NOW() FROM T1_AREA_INTERES c
        WHERE c.id > maxid;
    maxid := 0;


    maxid := (Select max(id) from T2_PIEZA_INTELIGENCIA); -- T1_PIEZA_INTELIGENCIA = PIEZA_INTELIGENCIA + PIEZA_INTELIGENCIA_ALT
    INSERT INTO T2_PIEZA_INTELIGENCIA (id, fk_clas_tema, fechac) 
    SELECT id, fk_clas_tema, NOW() FROM T1_PIEZA_INTELIGENCIA c
        WHERE c.id > maxid;
    
    INSERT INTO T2_PIEZA_INTELIGENCIA (id, fk_clas_tema, fechac) 
    SELECT id, fk_clas_tema, NOW() FROM T1_PIEZA_INTELIGENCIA_ALT c
        WHERE c.id > maxid;
    maxid := 0;



    maxid := (Select max(id) from T2_ADQUISICION); -- T1_ADQUISICION = ADQUISICION + ADQUISICION_ALT
    INSERT INTO T2_ADQUISICION (id, fk_cliente, fk_pieza_inteligencia, fechac) 
    SELECT id, fecha_hora_venta, precio_vendido, fk_cliente, fk_pieza_inteligencia, NOW() FROM T1_ADQUISICION c
        WHERE c.id > maxid;

    INSERT INTO T2_ADQUISICION (id, fk_cliente, fk_pieza_inteligencia, fechac) 
    SELECT id, fecha_hora_venta, precio_vendido, fk_cliente, fk_pieza_inteligencia, NOW() FROM T1_ADQUISICION_ALT c
        WHERE c.id > maxid;
    maxid := 0;

END
$$;
--------------------------------------------------------------------------------


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

-- Productividad_Eficacia

DROP TYPE IF EXISTS contacto_ty CASCADE;


CREATE TYPE ProdEmpleado as (

    nombre varchar(200),
    productividad numeric(6,3)
);


DROP TABLE IF EXISTS PRODUCTIVIDAD_EFICACIA CASCADE;

CREATE TABLE PRODUCTIVIDAD_EFICACIA (
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




----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 			    Create tablas T1 - METRICA 1 y 2  	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------

DROP TABLE IF EXISTS T1_INFORMANTE CASCADE;

CREATE TABLE T1_INFORMANTE (
    
    id serial NOT NULL,

    nombre_clave varchar(100) unique NOT NULL,
    fk_personal_inteligencia_encargado integer NOT NULL,    

    CONSTRAINT INFORMANTE_PK PRIMARY KEY (id),
);

----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 			    Create tablas T2 - METRICA 1 y 2  	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------

DROP TABLE IF EXISTS T2_PAIS CASCADE;

CREATE TABLE T2_PAIS (
    id integer NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    fechac TIMESTAMP NOT NULL,
    
    CONSTRAINT LUGAR_PK PRIMARY KEY (id)
);




----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 		    EXTRACCION DE DATOS  - METRICA 3 y 4  	-- EJECUTAR COMO DEV 		     -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------

CREATE OR REPLACE PROCEDURE COPIA_T1_DESEMPEÑO_AII ()
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 
    maxid INTEGER;
	n_filas_afect integer;
BEGIN
    


    INSERT INTO T2_PAIS (id, nombre, fechac)
    SELECT l.id, l.nombre, NOW() FROM T1_LUGAR l WHERE l.tipo = 'pais' AND l.id > maxid;


    INSERT INTO T1_INFORMANTE (id, nombre_clave, fk_personal_inteligencia_encargado)
    SELECT id, nombre_clave, fk_personal_inteligencia_encargado FROM INFORMANTE


	SELECT COALESCE(max(id), 0) INTO maxid from T1_CLAS_TEMA;
    
	INSERT INTO T1_CLAS_TEMA (id, nombre, descripcion, topico) 
    SELECT id, nombre, descripcion, topico FROM CLAS_TEMA c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

   	RAISE NOTICE 'Filas insertadas en T1_CLAS_TEMA: %', n_filas_afect;

   
    -- maxid := (Select max(id) from T1_CLIENTE);
    -- INSERT INTO T1_CLIENTE (id, nombre_empresa, pagina_web, fk_lugar_pais) 
    -- SELECT id, nombre_empresa, pagina_web, fk_lugar_pais FROM CLIENTE c
    --     WHERE c.id > maxid;
    -- maxid := 0;
    
    -- maxid := (Select max(id) from T1_OFICINA_PRINCIPAL);
    -- INSERT INTO T1_OFICINA_PRINCIPAL (id, nombre, fk_lugar_ciudad) 
    -- SELECT id, nombre, fk_lugar_ciudad FROM OFICINA_PRINCIPAL c
    --     WHERE c.id > maxid;
    -- maxid := 0;


    -- maxid := (Select max(id) from T1_LUGAR);
    -- INSERT INTO T1_LUGAR (id, nombre, tipo, region, fk_lugar) 
    -- SELECT id, nombre, tipo, region, fk_lugar FROM LUGAR c
    --     WHERE c.id > maxid;
    -- maxid := 0;


    -- maxid := (Select max(id) from T1_AREA_INTERES);
    -- INSERT INTO T1_AREA_INTERES (id, fk_clas_tema, fk_cliente) 
    -- SELECT id, fk_clas_tema, fk_cliente FROM AREA_INTERES c
    --     WHERE c.id > maxid;
    -- maxid := 0;



    -- maxid := (Select max(id) from T1_PIEZA_INTELIGENCIA); -- T1_PIEZA_INTELIGENCIA = PIEZA_INTELIGENCIA + PIEZA_INTELIGENCIA_ALT
    -- INSERT INTO T1_PIEZA_INTELIGENCIA (id, fk_clas_tema) 
    -- SELECT id, fk_clas_tema FROM PIEZA_INTELIGENCIA c
    --     WHERE c.id > maxid;
    
    -- INSERT INTO T1_PIEZA_INTELIGENCIA (id, fk_clas_tema) 
    -- SELECT id, fk_clas_tema FROM PIEZA_INTELIGENCIA_ALT c
    --     WHERE c.id > maxid;
    -- maxid := 0;



    -- maxid := (Select max(id) from T1_ADQUISICION); -- T1_ADQUISICION = ADQUISICION + ADQUISICION_ALT
    -- INSERT INTO T1_ADQUISICION (id, fk_cliente, fk_pieza_inteligencia) 
    -- SELECT id, fecha_hora_venta, precio_vendido, fk_cliente, fk_pieza_inteligencia FROM ADQUISICION c
    --     WHERE c.id > maxid;

    -- INSERT INTO T1_ADQUISICION (id, fk_cliente, fk_pieza_inteligencia) 
    -- SELECT id, fecha_hora_venta, precio_vendido, fk_cliente, fk_pieza_inteligencia FROM ADQUISICION_ALT c
    --     WHERE c.id > maxid;
    -- maxid := 0;

END
$$;


