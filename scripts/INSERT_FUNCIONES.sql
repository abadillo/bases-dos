
-------------------------- FUNCIONES PARA EL INSERT -----------------------------

CREATE OR REPLACE PROCEDURE ELIMINACION_REGISTROS_VENTA_EXCLUSIVA ( id_pieza IN integer ) 
LANGUAGE PLPGSQL 
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
LANGUAGE plpgsql AS $$ 
DECLARE 

--  ruta text := 'C:\Users\Mickel\BD2\bases-dos\scripts\';
--	ruta text := '/mnt/postgres/';
--  ruta text := 'C:\Users\Mickel\BD2\bases-dos\scripts\';

	ruta text := 'temp_files/';
	
BEGIN 

--	RAISE INFO 'Ruta: %', ruta || ruta_archivo ;
--	RAISE INFO 'Archivo -> bytea: %', pg_read_binary_file(ruta || ruta_archivo) ;
    
	RETURN pg_read_binary_file(ruta || ruta_archivo); 
	
END $$;


-- INSERT INTO crudo (contenido, tipo_contenido, resumen, fuente, valor_apreciacion, nivel_confiabilidad_inicial, nivel_confiabilidad_final, fecha_obtencion, fecha_verificacion_final, cant_analistas_verifican, fk_clas_tema, fk_informante, fk_estacion_pertenece, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente) VALUES
-- (FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Problemas politicos en Vitnam I', 'secreta', 500, 85, 85 , '2034-01-08 01:00:00', '2034-01-06 01:00:00', 2, 1, 1, 1, 1, 1, 1, '2034-01-05 01:00:00', 1);


-- SELECT FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg');

-- SHOW  data_directory;
--SELECT  * from crudo c ;






----------------------- FUNCIONES REPORTES -------------------------------

DROP FUNCTION IF EXISTS RESTA_7_DIAS CASCADE;

CREATE OR REPLACE FUNCTION RESTA_7_DIAS ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '7 days';
	
END $$;


DROP FUNCTION IF EXISTS RESTA_6_MESES CASCADE;

CREATE OR REPLACE FUNCTION RESTA_6_MESES ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '6 month';
	
END $$;



DROP FUNCTION IF EXISTS RESTA_1_YEAR CASCADE;

CREATE OR REPLACE FUNCTION RESTA_1_YEAR ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '1 years';
	
END $$;


DROP FUNCTION IF EXISTS RESTA_1_YEAR_DATE CASCADE;

CREATE OR REPLACE FUNCTION RESTA_1_YEAR_DATE ( fecha IN date ) 
RETURNS date
LANGUAGE PLPGSQL 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '1 years';
	
END $$;



DROP FUNCTION IF EXISTS RESTA_3_MESES CASCADE;

CREATE OR REPLACE FUNCTION RESTA_3_MESES ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '3 month';
	
END $$;


DROP FUNCTION IF EXISTS RESTA_3_MESES_DATE CASCADE;

CREATE OR REPLACE FUNCTION RESTA_3_MESES_DATE ( fecha IN date ) 
RETURNS date
LANGUAGE PLPGSQL 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '3 month';
	
END $$;


------- .... -------


-------------------------------------------------------------------
   
 

-------------------------//////////ACTUALIZAR TODAS LAS FECHAS - RESTA 14 años  /////////////-------------------------


DROP FUNCTION IF EXISTS RESTA_14_FECHA CASCADE;

CREATE OR REPLACE FUNCTION RESTA_14_FECHA ( fecha IN date ) 
RETURNS date
LANGUAGE PLPGSQL 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '14 years';
	
END $$;

------- .... -------

DROP FUNCTION IF EXISTS RESTA_14_FECHA_HORA CASCADE;

CREATE OR REPLACE FUNCTION RESTA_14_FECHA_HORA ( fecha IN timestamp ) 
RETURNS timestamp
LANGUAGE PLPGSQL 
AS $$
BEGIN 
		
	RETURN fecha - INTERVAL '14 years';
	
END $$;



---------.'.'.'.'.'.'.'.---------