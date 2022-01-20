
------------------------------------------------------------------------
------ TRIGGER PARA LA COPIA DE ADQUISICION----- BUENO

CREATE OR REPLACE FUNCTION TRIGGER_COPIA_ADQUISICION()
RETURNS TRIGGER
LANGUAGE PLPGSQL
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



----------------------------------/////////////////////////-----------------------------






------------------------------------------------------------------------
-----CREACION DE FUNCION TRIGGER PARA CRUDO_PIEZA---   BUENO
CREATE OR REPLACE FUNCTION TRIGGER_COPIA_CRUDO_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
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







------------------------===============================------------------------------




------------------------------------------------------------------------
----- FUNCION DEL TRIGGER PRINCIPAL DE ELIMINACION DE PIEZA POR VENTA EXCLUSIVA -----
CREATE OR REPLACE FUNCTION TRIGGER_COPIA_INFO_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
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







--------------------------------##############-------------------------------



------------------------------------------------------------------------
------CREACION DE PROCEDIMIENTO PARA LA COPIA DE DATOS DEL INFORMANTE
CREATE OR REPLACE PROCEDURE PROCEDIMIENTO_COPIA_INFORMANTE (id_informante integer)
LANGUAGE PLPGSQL
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







-------------------------- FUNCIONES NECESARIAS PARA EL PARA EL INSERT -----------------------------

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