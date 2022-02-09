
----------//////////////////////-------------------------------------------------------------------///////////--///////////-----------
----------//////////////////////-   	    		DW - PROYECTO AII - GRUPO 09		    	  -///////////--///////////-----------
----------//////////////////////-------------------------------------------------------------------///////////--///////////-----------


--/ METRICA 3 y 4 - DESEMPENO_AII
--- Sería ideal contar con información sobre los puntos anteriores, como por ejemplo, cuál es el tema con
--- mayor demanda (tema en el que la mayor cantidad de clientes ha adquirido piezas de inteligencia),
--- cuál es el cliente más activo (que compra más frecuentemente). Esta información se debería
--- presentar por región semestral y anualmente



----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 			    Create tablas T1 - METRICA 3 y 4  	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------


DROP TABLE IF EXISTS T1_LUGAR CASCADE;
DROP TABLE IF EXISTS T1_CLIENTE CASCADE;
DROP TABLE IF EXISTS T1_CLAS_TEMA CASCADE;
-- DROP TABLE IF EXISTS T1_AREA_INTERES CASCADE;
DROP TABLE IF EXISTS T1_OFICINA_PRINCIPAL CASCADE; 
DROP TABLE IF EXISTS T1_ADQUISICION CASCADE;
DROP TABLE IF EXISTS T1_PIEZA_INTELIGENCIA CASCADE;


CREATE TABLE T1_LUGAR(

    id integer NOT NULL,
    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),

    fk_lugar integer,

	CONSTRAINT T1_LUGAR_PK PRIMARY KEY (id),
	CONSTRAINT T1_LUGAR_CH_tipo CHECK ( tipo IN ('ciudad', 'pais') ),
	CONSTRAINT T1_LUGAR_CH_region CHECK ( region IN ('europa', 'africa', 'america_sur', 'america_norte', 'asia', 'oceania') ),
    CONSTRAINT T1_LUGAR_LUGAR_FK FOREIGN KEY (fk_lugar) REFERENCES T1_LUGAR (id)
);


CREATE TABLE T1_OFICINA_PRINCIPAL (

    id integer NOT NULL,

    nombre varchar(50) NOT NULL,

    fk_lugar_ciudad integer NOT NULL,

    CONSTRAINT T1_OFICINA_PRINCIPAL_PK PRIMARY KEY (id),
    CONSTRAINT T1_OFICINA_PRINCIPAL_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES T1_LUGAR (id)
);


CREATE TABLE T1_CLIENTE (

    id integer NOT NULL,
    nombre_empresa varchar(100) NOT NULL,
    pagina_web varchar(100) NOT NULL,   

    fk_lugar_pais integer NOT NULL,

	CONSTRAINT T1_CLIENTE_PK PRIMARY KEY (id),
    CONSTRAINT T1_CLIENTE_LUGAR_FK FOREIGN KEY (fk_lugar_pais) REFERENCES T1_LUGAR (id)
);

CREATE TABLE T1_CLAS_TEMA (

    id integer NOT NULL,
    nombre varchar(255) NOT NULL,
    descripcion varchar(500) NOT NULL,
	topico varchar(50) NOT NULL, -- 'paises, individuos, eventos, empresas' 

    CONSTRAINT T1_AREA_INTERES_PK PRIMARY KEY (id),
	CONSTRAINT CLAS_TEMA_CH_topico CHECK ( topico IN ('paises', 'individuos', 'eventos', 'empresas') )    
);

-- CREATE TABLE T1_AREA_INTERES (

--     fk_clas_tema integer NOT NULL,
--     fk_cliente integer NOT NULL,

-- 	CONSTRAINT T1_TEMAS_ESP_PK PRIMARY KEY (fk_clas_tema,fk_cliente),
--     CONSTRAINT T1_TEMAS_ESP_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES T1_CLAS_TEMA (id),
--     CONSTRAINT T1_TEMAS_ESP_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_cliente) REFERENCES T1_CLIENTE (id)
-- );


CREATE TABLE T1_PIEZA_INTELIGENCIA (

    id integer NOT NULL,
	fk_clas_tema integer NOT NULL,
	
    CONSTRAINT T1_PIEZA_INTELIGENCIA_PK PRIMARY KEY (id),
	CONSTRAINT T1_PIEZA_INTELIGENCIA_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES T1_CLAS_TEMA (id)
);

CREATE TABLE T1_ADQUISICION (

    id integer NOT NULL,

	fecha_hora_venta timestamp NOT NULL,

	fk_cliente integer NOT NULL,
    fk_pieza_inteligencia integer NOT NULL,
	
	CONSTRAINT T1_ADQUISICION_PK PRIMARY KEY (id, fk_cliente, fk_pieza_inteligencia),

    CONSTRAINT T1_ADQUISICION_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES T1_CLIENTE (id),
    CONSTRAINT T1_ADQUISICION_PIEZA_INTELIGENCIA_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES T1_PIEZA_INTELIGENCIA (id)
	
);



----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 		    EXTRACCION DE DATOS - METRICA 3 y 4  	-- EJECUTAR COMO DEV 		     -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------




CREATE OR REPLACE PROCEDURE EXTRACCION_DESEMPENO_AII ()
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 
    maxid INTEGER;
	n_filas_afect integer;
BEGIN
        
	RAISE NOTICE ' ';
	RAISE NOTICE 'PROCEDIMIENTO EXTRACCION_DESEMPENO_AII - %', NOW();
	RAISE NOTICE '-----------------------------------------------------';
	RAISE NOTICE ' ';
	
	-- T1_LUGAR
    SELECT COALESCE(max(id),0) INTO maxid FROM T1_LUGAR;
   
    INSERT INTO T1_LUGAR (id, nombre, tipo, region, fk_lugar) 
    SELECT id, nombre, tipo, region, fk_lugar FROM LUGAR c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_LUGAR: %', n_filas_afect;
	

	-- T1_CLAS_TEMA
	SELECT COALESCE(max(id), 0) INTO maxid from T1_CLAS_TEMA;
    
	INSERT INTO T1_CLAS_TEMA (id, nombre, descripcion, topico) 
    SELECT id, nombre, descripcion, topico FROM CLAS_TEMA c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

   	RAISE NOTICE 'Filas insertadas en T1_CLAS_TEMA: %', n_filas_afect;

   
   	-- T1_CLIENTE
    SELECT COALESCE(max(id),0) INTO maxid FROM T1_CLIENTE;
   
    INSERT INTO T1_CLIENTE (id, nombre_empresa, pagina_web, fk_lugar_pais) 
    SELECT id, nombre_empresa, pagina_web, fk_lugar_pais FROM CLIENTE c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_CLIENTE: %', n_filas_afect;
    
    SELECT COALESCE(max(id),0) INTO maxid FROM T1_OFICINA_PRINCIPAL;
    INSERT INTO T1_OFICINA_PRINCIPAL (id, nombre, fk_lugar_ciudad) 
    SELECT id, nombre, fk_lugar_ciudad FROM OFICINA_PRINCIPAL c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_OFICINA_PRINCIPAL: %', n_filas_afect;



--    SELECT COALESCE(max(id),0) INTO maxid FROM T1_AREA_INTERES;
--    INSERT INTO T1_AREA_INTERES (id, fk_clas_tema, fk_cliente) 
--    SELECT id, fk_clas_tema, fk_cliente FROM AREA_INTERES c
--        WHERE c.id > maxid;
--    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;
--
--	RAISE NOTICE 'Filas insertadas en T1_AREA_INTERES: %', n_filas_afect;


	-- T1_PIEZA_INTELIGENCIA
    SELECT COALESCE(max(id),0) INTO maxid FROM T1_PIEZA_INTELIGENCIA; -- T1_PIEZA_INTELIGENCIA = PIEZA_INTELIGENCIA + PIEZA_INTELIGENCIA_ALT
    
    INSERT INTO T1_PIEZA_INTELIGENCIA (id, fk_clas_tema) 
    SELECT id, fk_clas_tema FROM PIEZA_INTELIGENCIA c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;
    
	RAISE NOTICE 'Filas insertadas en T1_PIEZA_INTELIGENCIA: %', n_filas_afect;

    INSERT INTO T1_PIEZA_INTELIGENCIA (id, fk_clas_tema) 
    SELECT id, fk_clas_tema FROM PIEZA_INTELIGENCIA_ALT c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas de PIEZA_INTELIGENCIA_ALT: %', n_filas_afect;


	-- T1_ADQUISICION
    SELECT COALESCE(max(id),0) INTO maxid FROM T1_ADQUISICION; -- T1_ADQUISICION = ADQUISICION + ADQUISICION_ALT
    
    INSERT INTO T1_ADQUISICION (id, fecha_hora_venta, fk_cliente, fk_pieza_inteligencia) 
    SELECT id, fecha_hora_venta, fk_cliente, fk_pieza_inteligencia FROM ADQUISICION c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_ADQUISICION: %', n_filas_afect;
	

    INSERT INTO T1_ADQUISICION (id, fecha_hora_venta, fk_cliente, fk_pieza_inteligencia) 
    SELECT id, fecha_hora_venta, fk_cliente, fk_pieza_inteligencia FROM ADQUISICION_ALT c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas de ADQUISICION_ALT: %', n_filas_afect;

END
$$;









----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 			    Create tablas T2 - METRICA 3 y 4  	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------


DROP TABLE IF EXISTS T2_REGION_OFICINA CASCADE;
DROP TABLE IF EXISTS T2_CLIENTE CASCADE;
DROP TABLE IF EXISTS T2_CLAS_TEMA CASCADE;
DROP TABLE IF EXISTS T2_ADQUISICION CASCADE;
DROP TABLE IF EXISTS T2_PIEZA_INTELIGENCIA CASCADE;


CREATE TABLE T2_REGION_OFICINA(

    id_oficina integer NOT NULL,
    nombre_oficina varchar(50) NOT NULL,
	nombre_region varchar(50) NOT NULL,
	fechac timestamp,
		
	CONSTRAINT T2_REGION_OFICINA_PK PRIMARY KEY (id_oficina),
	CONSTRAINT T2_REGION_OFICINA_CH_region CHECK ( nombre_region IN ('europa', 'africa', 'america_sur', 'america_norte', 'asia', 'oceania') )
  
);


CREATE TABLE T2_CLIENTE (

    id integer NOT NULL,
    nombre_empresa varchar(100) NOT NULL,
    pagina_web varchar(100) NOT NULL,
	fechac timestamp,   

    fk_region_oficina integer NOT NULL,

	CONSTRAINT T2_CLIENTE_PK PRIMARY KEY (id),
    CONSTRAINT T2_CLIENTE_LUGAR_FK FOREIGN KEY (fk_region_oficina) REFERENCES T2_REGION_OFICINA (id_oficina)
);

CREATE TABLE T2_CLAS_TEMA (

    id integer NOT NULL,
    nombre varchar(255) NOT NULL,
    descripcion varchar(500) NOT NULL,
	topico varchar(50) NOT NULL, -- 'paises, individuos, eventos, empresas' 
	fechac timestamp,

    CONSTRAINT T2_AREA_INTERES_PK PRIMARY KEY (id),
	CONSTRAINT CLAS_TEMA_CH_topico CHECK ( topico IN ('paises', 'individuos', 'eventos', 'empresas') )    
);



CREATE TABLE T2_PIEZA_INTELIGENCIA (

    id integer NOT NULL,
	fk_clas_tema integer NOT NULL,
	fechac timestamp,
	
    CONSTRAINT T2_PIEZA_INTELIGENCIA_PK PRIMARY KEY (id),
	CONSTRAINT T2_PIEZA_INTELIGENCIA_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES T2_CLAS_TEMA (id)
);

CREATE TABLE T2_ADQUISICION (

    id integer NOT NULL,

	fecha_hora_venta timestamp NOT NULL,
	fechac timestamp,

	fk_cliente integer NOT NULL,
    fk_pieza_inteligencia integer NOT NULL,
	
	CONSTRAINT T2_ADQUISICION_PK PRIMARY KEY (id, fk_cliente, fk_pieza_inteligencia),

    CONSTRAINT T2_ADQUISICION_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES T2_CLIENTE (id),
    CONSTRAINT T2_ADQUISICION_PIEZA_INTELIGENCIA_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES T2_PIEZA_INTELIGENCIA (id)
	
);







----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 		    TRANSFORMACION DE DATOS - METRICA 3 y 4  	-- EJECUTAR COMO DEV 		     -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------


CREATE OR REPLACE PROCEDURE TRANSFORMACION_T2_DESEMPENO_AII ()
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 
    maxid INTEGER;
	n_filas_afect integer;
BEGIN
    
	RAISE NOTICE ' ';
	RAISE NOTICE 'PROCEDIMIENTO TRANSFORMACION_T2_DESEMPENO_AII - %', NOW();
	RAISE NOTICE '-----------------------------------------------------';
	RAISE NOTICE ' ';
	

	-- T2_REGION_OFICINA
    SELECT COALESCE(max(id_oficina),0) INTO maxid FROM T2_REGION_OFICINA;

	-- - LLENADO / TRANSORMACION EN REGION_OFICINA - 
	INSERT INTO T2_REGION_OFICINA (id_oficina, nombre_oficina, fechac, nombre_region) 
	SELECT o.id, o.nombre, NOW(), ( SELECT b.region FROM T1_LUGAR a, T1_LUGAR b WHERE o.fk_lugar_ciudad = a.id AND a.fk_lugar = b.id ) FROM T1_OFICINA_PRINCIPAL o 
		WHERE o.id > maxid;
     GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	 RAISE NOTICE 'Filas insertadas en T2_REGION_OFICINA: %', n_filas_afect;
	
	

	 -- T2_CLIENTE
     SELECT COALESCE(max(id),0) INTO maxid FROM T2_CLIENTE;
   
     INSERT INTO T2_CLIENTE (id, nombre_empresa, pagina_web, fechac, fk_region_oficina) 
     SELECT id, nombre_empresa, pagina_web, NOW() ,(SELECT id_oficina FROM T2_REGION_OFICINA oe WHERE oe.nombre_region = ( SELECT region FROM T1_LUGAR WHERE id = c.fk_lugar_pais ) ) FROM T1_CLIENTE c
         WHERE c.id > maxid;
     GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	 RAISE NOTICE 'Filas insertadas en T2_CLIENTE: %', n_filas_afect;

	

	-- T2_CLAS_TEMA
	SELECT COALESCE(max(id), 0) INTO maxid from T2_CLAS_TEMA;
    
	INSERT INTO T2_CLAS_TEMA (id, nombre, descripcion, topico, fechac) 
    SELECT id, nombre, descripcion, topico, NOW() FROM T1_CLAS_TEMA c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

   	RAISE NOTICE 'Filas insertadas en T2_CLAS_TEMA: %', n_filas_afect;

   

	-- T2_PIEZA_INTELIGENCIA
    SELECT COALESCE(max(id),0) INTO maxid FROM T2_PIEZA_INTELIGENCIA; -- T2_PIEZA_INTELIGENCIA = PIEZA_INTELIGENCIA + PIEZA_INTELIGENCIA_ALT
    
    INSERT INTO T2_PIEZA_INTELIGENCIA (id, fk_clas_tema, fechac) 
    SELECT id, fk_clas_tema, NOW() FROM T1_PIEZA_INTELIGENCIA c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;
    
	RAISE NOTICE 'Filas insertadas en T2_PIEZA_INTELIGENCIA: %', n_filas_afect;


	-- T2_ADQUISICION
    SELECT COALESCE(max(id),0) INTO maxid FROM T2_ADQUISICION; -- T2_ADQUISICION = ADQUISICION + ADQUISICION_ALT
    
    INSERT INTO T2_ADQUISICION (id, fecha_hora_venta, fk_cliente, fk_pieza_inteligencia, fechac) 
    SELECT id, fecha_hora_venta, fk_cliente, fk_pieza_inteligencia, NOW() FROM T1_ADQUISICION c
        WHERE c.id > maxid;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T2_ADQUISICION: %', n_filas_afect;
	
END
$$;

















----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 			    Create tablas T3 - METRICA 3 y 4  	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------

DROP TABLE IF EXISTS T3_CLIENTE CASCADE;
DROP TABLE IF EXISTS T3_REGION_OFICINA CASCADE;
DROP TABLE IF EXISTS T3_DESEMPEÑO_AII CASCADE;
DROP TABLE IF EXISTS T3_TIEMPO CASCADE;


CREATE TABLE T3_TIEMPO (

    id_tiempo INTEGER NOT NULL,
    año DATE,
   	semestre SMALLINT
    
);

CREATE TABLE T3_CLIENTE(
  	
	id_cliente INTEGER NOT NULL,
	nombre_empresa VARCHAR(100),
	pagina_web VARCHAR(100),

	fechac TIMESTAMP
	  
);

CREATE TABLE T3_REGION_OFICINA (

   	id_oficina integer NOT NULL,
    nombre_oficina varchar(50),
	nombre_region varchar(50),
	fechac timestamp
		
);


CREATE TABLE T3_DESEMPEÑO_AII (
    
	id_tiempo INTEGER NOT NULL,
    id_region_oficina INTEGER,
    id_tema INTEGER,
    id_cliente INTEGER,

    clienteMasActivo_semestre VARCHAR(50),
    clienteMasActivo_año VARCHAR(50),
	numeroComprasCliente_semestre integer,
	numeroComprasCliente_año integer,

    temaMayorDemanda_semestre VARCHAR(50),
    temaMayorDemanda_año VARCHAR(50),
    numeroVentasTema_semestre integer,
	numeroVentasTema_año integer
    
);



--/ METRICA 3 y 4 - DESEMPENO_AII
--- Sería ideal contar con información sobre los puntos anteriores, como por ejemplo, cuál es el tema con
--- mayor demanda (tema en el que la mayor cantidad de clientes ha adquirido piezas de inteligencia),
--- cuál es el cliente más activo (que compra más frecuentemente). Esta información se debería
--- presentar por región semestral y anualmente




CREATE OR REPLACE PROCEDURE TRANSFORMACION_T3_DESEMPENO_AII_DIMENSIONES (año IN varchar, semestre IN integer)
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 
    
	n_filas_afect integer;
	ultfechac timestamp;
	
BEGIN
    
--	RAISE NOTICE ' ';
--	RAISE NOTICE 'PROCEDIMIENTO TRANSFORMACION_T3_DESEMPENO_AII_DIMENSIONES - %', NOW();
--	RAISE NOTICE '-----------------------------------------------------';
--	RAISE NOTICE ' ';


	-- T3_CLIENTE
	SELECT COALESCE(max(fechac), NOW() - interval '5 years') INTO ultfechac from T3_CLIENTE;

	RAISE NOTICE 'Ultima fecha de actualizacion de T3_CLIENTE: %', ultfechac;
    
	INSERT INTO T3_CLIENTE (id_cliente, nombre_empresa, pagina_web, fechac) 
    SELECT id, nombre_empresa, pagina_web, fechac FROM T2_CLIENTE c
         WHERE c.fechac > ultfechac;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

   	RAISE NOTICE 'Filas insertadas en T3_CLIENTE: %', n_filas_afect;

   
   	-- T3_REGION_OFICINA 
	SELECT COALESCE(max(fechac), NOW() - interval '5 years') INTO ultfechac from T3_REGION_OFICINA;

	RAISE NOTICE 'Ultima fecha de actualizacion de T3_REGION_OFICINA: %', ultfechac;
    
	INSERT INTO T3_REGION_OFICINA (id_oficina, nombre_oficina, nombre_region, fechac) 
    SELECT id_oficina, nombre_oficina, nombre_region, fechac FROM T2_REGION_OFICINA c
         WHERE c.fechac > ultfechac;
	GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

   	RAISE NOTICE 'Filas insertadas en T3_REGION_OFICINA: %', n_filas_afect;
   	RAISE NOTICE ' ';

	
   	IF (semestre = 0) THEN
   	
   		INSERT INTO T3_TIEMPO (id_tiempo,semestre,año) VALUES ( (año::INTEGER)*10+semestre, null, to_date(año,'YYYY') );
   	
   	ELSIF (semestre = 1 or semestre = 2) THEN
   	
   		INSERT INTO T3_TIEMPO (id_tiempo,semestre,año) VALUES ( (año::INTEGER)*10+semestre, semestre, to_date(año,'YYYY') );
   	
   	ELSE 
   	
   		RAISE EXCEPTION 'Semestre solo puede ser 1 para el primer semestre y 2 para el segundo. En el caso de las metricas anuales, semestre es igual a 0';
   	
   	END IF;
   
   	
END
$$;



CREATE OR REPLACE PROCEDURE TRANSFORMACION_T3_DESEMPENO_AII (año IN varchar, semestre IN integer)
LANGUAGE PLPGSQL
SECURITY DEFINER
AS $$
DECLARE 
    
	n_filas_afect integer;
	año_timestamp_ini timestamp;
	año_timestamp_fin timestamp;
	
BEGIN
    
	RAISE NOTICE ' ';
	RAISE NOTICE 'PROCEDIMIENTO TRANSFORMACION_T3_DESEMPENO_AII_ANUAL - %', NOW();
	RAISE NOTICE '-----------------------------------------------------';
	RAISE NOTICE ' ';
	
	año_timestamp_ini := to_timestamp(año, 'YYYY');	

	

	-- METRICAS ANUALES

	IF (semestre = 0) THEN
	
		año_timestamp_fin := año_timestamp_ini + interval '1 year';
		
		RAISE NOTICE ' ';
		RAISE NOTICE 'METRICAS ANUALES - %', año;
		RAISE NOTICE 'fechaini % - fechafin %', año_timestamp_ini, año_timestamp_fin;
		RAISE NOTICE '-----------------------------------------------------';
		RAISE NOTICE ' ';
		
		-- metrica cliente mas activo
	
		INSERT INTO T3_DESEMPEÑO_AII (id_region_oficina, id_cliente, clienteMasActivo_año, numeroComprasCliente_año, id_tiempo) 
	  
			SELECT DISTINCT ON (c.fk_region_oficina) c.fk_region_oficina, c.id, c.nombre_empresa, count(a.id) as numero_compras, (año::INTEGER)*10+semestre 
			from t2_cliente c, t2_adquisicion a 
			WHERE c.id = a.fk_cliente 
			AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
			GROUP BY c.id, c.nombre_empresa 
			ORDER BY c.fk_region_oficina ASC, numero_compras DESC;
	
	    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;
	
	   
	   	RAISE NOTICE '--- > Filas insertadas por metrica cliente: %', n_filas_afect;
	   	RAISE NOTICE '---------------------';
	  	RAISE NOTICE ' ';
	   
	   	IF (n_filas_afect > 0) THEN 
	   
	   		CALL transformacion_t3_desempeno_aii_dimensiones(año,semestre);
	   	
	   	END IF;
	   
	   
	   -- metrica tema mas popular
	   
	   INSERT INTO T3_DESEMPEÑO_AII (id_region_oficina, id_tema, temaMayorDemanda_año, numeroVentasTema_año, id_tiempo) 
	  
			SELECT DISTINCT ON (c.fk_region_oficina) c.fk_region_oficina, p.fk_clas_tema, t.nombre , count(p.fk_clas_tema) as numero_tema, (año::INTEGER)*10+semestre   
			from t2_cliente c, t2_adquisicion a, t2_pieza_inteligencia p, t2_clas_tema t
			WHERE p.id = a.fk_pieza_inteligencia AND a.fk_cliente = c.id AND p.fk_clas_tema = t.id
			AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
			GROUP BY fk_region_oficina, fk_clas_tema, t.nombre
			ORDER BY c.fk_region_oficina ASC,  numero_tema DESC;
	
	    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;
	
	   	RAISE NOTICE '--- > Filas insertadas por metrica tema: %', n_filas_afect;
	   	RAISE NOTICE '---------------------';
	  	RAISE NOTICE ' ';
	   
	   	IF (n_filas_afect > 0) THEN 
	   
	   		CALL transformacion_t3_desempeno_aii_dimensiones(año,semestre);
	   	
	   	END IF;
		
	   
	   
	   --- METRICAS SEMESTRALES 
	   
	   
   	ELSIF (semestre = 1 or semestre = 2 ) THEN
   		
   		IF (semestre = 1) THEN
   			año_timestamp_fin := año_timestamp_ini + interval '6 months';
   	
   		ELSE 
	   		año_timestamp_fin := año_timestamp_ini + interval '1 year';
	   		año_timestamp_ini := año_timestamp_ini + interval '6 months';
   		
   		END IF;
  
   		RAISE NOTICE ' ';
		RAISE NOTICE 'METRICAS SEMESTRALES - año % - semestre %', año, semestre;
		RAISE NOTICE 'fechaini % - fechafin %', año_timestamp_ini, año_timestamp_fin;
		RAISE NOTICE '-----------------------------------------------------';
		RAISE NOTICE ' ';
   	
   		
		-- metrica cliente mas activo
	
		INSERT INTO T3_DESEMPEÑO_AII (id_region_oficina, id_cliente, clienteMasActivo_semestre, numeroComprasCliente_semestre, id_tiempo) 
	  
			SELECT DISTINCT ON (c.fk_region_oficina) c.fk_region_oficina, c.id, c.nombre_empresa, count(a.id) as numero_compras, (año::INTEGER)*10+semestre 
			from t2_cliente c, t2_adquisicion a 
			WHERE c.id = a.fk_cliente 
			AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
			GROUP BY c.id, c.nombre_empresa 
			ORDER BY c.fk_region_oficina ASC, numero_compras DESC;
	
	    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;
	
	   	RAISE NOTICE '--- > Filas insertadas por metrica cliente: %', n_filas_afect;
	   	RAISE NOTICE '---------------------';
	  	RAISE NOTICE ' ';
	   
	   	IF (n_filas_afect > 0) THEN 
	   
	   		CALL transformacion_t3_desempeno_aii_dimensiones(año,semestre);
	   	
	   	END IF;
	   
	   
	   -- metrica tema mas popular
	   
	   INSERT INTO T3_DESEMPEÑO_AII (id_region_oficina, id_tema, temaMayorDemanda_semestre, numeroVentasTema_semestre, id_tiempo) 
	  
			SELECT DISTINCT ON (c.fk_region_oficina) c.fk_region_oficina, p.fk_clas_tema, t.nombre , count(p.fk_clas_tema) as numero_tema, (año::INTEGER)*10+semestre   
			from t2_cliente c, t2_adquisicion a, t2_pieza_inteligencia p, t2_clas_tema t
			WHERE p.id = a.fk_pieza_inteligencia AND a.fk_cliente = c.id AND p.fk_clas_tema = t.id
			AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
			GROUP BY fk_region_oficina, fk_clas_tema, t.nombre
			ORDER BY c.fk_region_oficina ASC,  numero_tema DESC;
	
	    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;
	
	   	RAISE NOTICE '--- > Filas insertadas por metrica tema: %', n_filas_afect;
	   	RAISE NOTICE '---------------------';
	  	RAISE NOTICE ' ';
	   
	   	IF (n_filas_afect > 0) THEN 
	   
	   		CALL transformacion_t3_desempeno_aii_dimensiones(año,semestre);
	   	
	   	END IF;
   	
   	
   	ELSE 
   	
   		RAISE EXCEPTION 'Semestre solo puede ser 1 para el primer semestre y 2 para el segundo. En el caso de las metricas anuales, semestre es igual a 0';
   	
   	END IF;
   	
		
	


END
$$;









----------///////////- ------------------------------------------------------------------------------------ ///////////----------
----------//////////- 			    Create tablas T1 - METRICA 1 y 2  	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------

DROP TABLE IF EXISTS T1_INFORMANTE CASCADE;
DROP TABLE IF EXISTS T1_PERSONAL_INTELIGENCIA CASCADE;
DROP TABLE IF EXISTS T1_CRUDO_PIEZA CASCADE;
DROP TABLE IF EXISTS T1_CRUDO CASCADE;
DROP TABLE IF EXISTS T1_ANALISTA_CRUDO CASCADE;
DROP TABLE IF EXISTS T1_HIST_CARGO CASCADE;



CREATE TABLE T1_PERSONAL_INTELIGENCIA ( 

	id INTEGER NOT NULL,

    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50),
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,

    --foreign keys 
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
----------//////////- 	 Create tablas T3 - METRICA 1 y 2  PRODUCTIVIDAD_EFICACIA 	-- EJECUTAR COMO DEV 		       -//////////----------
----------///////////- ----------------------------------------------------------------------------------- ///////////----------

DROP TYPE IF EXISTS ProdEmpleado CASCADE;

CREATE TYPE ProdEmpleado as (

    nombre varchar(200),
    productividad numeric(6,3)
);


DROP TABLE IF EXISTS T3_PERSONAL_INTELIGENCIA_LOOKUP CASCADE;
DROP TABLE IF EXISTS T3_INFORMANTE CASCADE;
DROP TABLE IF EXISTS T3_PAIS CASCADE;
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
    proc_EficaciaInformante numeric (6,3),
    proc_ProdPromedioAgentesPais numeric (6,3),
    proc_ProdPromedioAnalistasPais numeric (6,3),
    proc_ProdPromedioAgentesOficina numeric (6,3),
    proc_ProdPromedioAnalistasOficina numeric (6,3),
    proc_ProdGeneralAgente ProdEmpleado,
    proc_ProdGeneralAnalista ProdEmpleado
);




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
	

	-- T1_LUGAR
    SELECT COALESCE(max(id),0) INTO maxid FROM T1_LUGAR;
   
    INSERT INTO T1_LUGAR (id, nombre, tipo, region, fk_lugar) 
    SELECT id, nombre, tipo, region, fk_lugar FROM LUGAR c
        WHERE c.id > maxid;
    GET DIAGNOSTICS n_filas_afect = ROW_COUNT;

	RAISE NOTICE 'Filas insertadas en T1_LUGAR: %', n_filas_afect;
	
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

	RAISE NOTICE 'Filas insertadas de INFORMANTE_ALT: %', n_filas_afect;
    
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



















-----///////- Probado con PostgreSQL 13.4 on x86_64-pc-linux-gnu, compiled by gcc (GCC) 11.1.0, 64-bit-\\\\\\\\\------

----------///////////---------------------------------------------------------------------------\\\\\\\\\\\----------
----------///////////- SCRIPTS DE CREACION DE LA BASES DE DATOS DOS - PROYECTO AII - GRUPO 09  -\\\\\\\\\\\----------
----------///////////----------- ANTONIO BADILLO - GABRIEL MANRIQUE - MICKEL ARROZ -------------\\\\\\\\\\\----------
----------///////////---------------------------------------------------------------------------\\\\\\\\\\\-----------



