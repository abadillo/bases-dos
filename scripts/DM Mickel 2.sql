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

SELECT COUNT(fk_cliente) FROM T2_ADQUISICION 

SELECT id, nombre_empresa, pagina_web, fk_lugar_pais, fechac FROM T2_CLIENTE c 
WHERE c.id IN (SELECT a.fk_cliente FROM T2_ADQUISICION a WHERE a.fk_cliente LIMIT 1) 

DROP FUNCTION IF EXISTS CALCULO_DESEMPEÑO CASCADE;

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
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql;

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
    INSERT INTO T2_CLAS_TEMA (id, nombre, descripcion, topico, fechac) 
    SELECT id, nombre, descripcion, topico, NOW() FROM T1_CLAS_TEMA c
        WHERE c.id > maxid;
    maxid := 0;
    
    -- REVISAR
    maxid := (Select max(id) from T2_CLIENTE);
    INSERT INTO T2_CLIENTE (id, nombre_empresa, pagina_web, fk_lugar_pais, fechac) 
    SELECT id, nombre_empresa, pagina_web, fk_lugar_pais, NOW() FROM T1_CLIENTE c
        WHERE c.id > maxid;
    maxid := 0;
    

-- REVISAR (REGION)
    maxid := (Select max(id) from T2_LUGAR);
    INSERT INTO T2_LUGAR (id, nombre, tipo, region, fk_lugar, fechac) 
    SELECT id, nombre, tipo, region, fk_lugar, NOW() FROM T1_LUGAR c
        WHERE c.id > maxid;
    maxid := 0;
----------------------------------------------------------------------

    maxid := (Select max(id) from T2_AREA_INTERES);
    INSERT INTO T2_LUGAR (id, fk_clas_tema, fk_cliente, fechac) 
    SELECT id, fk_clas_tema, fk_cliente, NOW() FROM T1_AREA_INTERES c
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
);