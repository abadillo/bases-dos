
------------------------------------------------------------------------
------TRIGGER PARA LA COPIA DE ADQUISICION----- BUENO

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
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_CRUDO_PIEZA()
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
--		RAISE INFO 'Fecha de inicio del analista: %, Id del personal inteligencia: %', old.fk_fecha_inicio_analista, old.fk_personal_inteligencia_analista;
--		RAISE INFO 'Id de la estacion del analista: %, Id de la oficina principal de analista: % y Tema de la pieza : %', old.fk_estacion_analista, old.fk_oficina_principal_analista, old.fk_clas_tema;
--				
	----SELECT PARA COPIAR EL HISTORICO CARGO
	
--		SELECT fecha_inicio, fecha_fin, cargo, fk_personal_inteligencia, fk_estacion, fk_oficina_principal
--		INTO copia_historico FROM hist_cargo
--		where old.fk_fecha_inicio_analista = hist_cargo.fecha_inicio;
--	
--		RAISE INFO 'INFORMACION DEL HISTORICO CARGO A COPIAR: %', copia_historico;
	
		---- INSERT EN LA TABLA ALT DE HISTORICO(COPIA DE INFORMACION)
	
--		CALL copia_historico_cargo(copia_historico.fecha_inicio, copia_historico.fk_personal_inteligencia, copia_historico.fk_estacion, copia_historico.fk_oficina_principal);
	
		
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
FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_INFO_PIEZA()

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
------DROP PROCEDURE PROCEDIMIENTO_COPIA_INFORMANTE(integer, timestamp)













--------------------------@@@@@@@@@@@@@@----------------------------


------------------------------------------------------------------------
-----FUNCION DEL TRIGGER PARA TRANSACCION_PAGO----
CREATE OR REPLACE FUNCTION TRIGGER_COPIAR_TRANSACCION_PAGO()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE

	transaccion_alt_reg transaccion_pago%rowtype;
	
BEGIN
	---SELECT PARA LA INFORMACION DE LA TABLA TRANSACCION
	
	CALL PROCEDIMIENTO_COPIA_INFORMANTE(old.fk_informante);
	
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





-------------------////--------------////---------------//---------------




--
--------------------------------------------------------------------------
------- FUNCION DEL TRIGGER PARA COPIAR EL CRUDO-----
--CREATE OR REPLACE FUNCTION TRIGGER_COPIA_CRUDO()
--RETURNS TRIGGER
--LANGUAGE PLPGSQL
--AS $$
--DECLARE
--  
--  crudo_reg crudo%rowtype;
--  
--  copia_historico hist_cargo%rowtype;
--  
--  informante_reg informante%rowtype;
--  
--BEGIN
--
--  --SELECT PARA EXTRAR LA INFO DEL CRUDO
--  
--  SELECT * INTO crudo_reg FROM crudo
--  WHERE id = old.id;
--  
--  RAISE INFO 'INFORMACION DE CRUDO A COPIAR ';
--  RAISE INFO '%: ', crudo_reg;
--
--  --SELECT PARA COPIAR EL HISTORICO CARGO
--  
--  
--  SELECT * INTO copia_historico FROM hist_cargo
--  WHERE old.fk_fecha_inicio_agente = hist_cargo.fecha_inicio;
--  
--  SELECT * INTO informante_reg FROM informante
--  WHERE id = old.fk_informante;
--  
--  RAISE INFO 'INFORMACION DEL HISTORICO CARGO A COPIAR %:', copia_historico;
--  
--  IF (copia_historico IS NOT NULL AND informante_reg IS NOT NULL) THEN
--  
--    ---- INSERT EN LA TABLA ALT DE HISTORICO(COPIA DE INFORMACION)
--
--    CALL copia_historico_cargo(copia_historico.fecha_inicio, copia_historico.fk_personal_inteligencia, copia_historico.fk_estacion, copia_historico.fk_oficina_principal);
--
--    ----INSERT EN LA TABLA ALT DE CRUDO (COPIA DE INFORMACION)
--    INSERT INTO crudo_alt (
--      fuente, 
--      fecha_obtencion,
--
--      fk_clas_tema,
--      fk_informante,
--
--      fk_estacion_pertenece, 
--      fk_oficina_principal_pertenece,
--
--      fk_estacion_agente,
--      fk_oficina_principal_agente,
--      fk_fecha_inicio_agente,
--      fk_personal_inteligencia_agente
--      )  VALUES (
--      old.fuente, 
--      old.fecha_obtencion,
--
--      old.fk_clas_tema,
--      old.fk_informante,
--
--      old.fk_estacion_pertenece, 
--      old.fk_oficina_principal_pertenece,
--
--      old.fk_estacion_agente,
--      old.fk_oficina_principal_agente,
--      old.fk_fecha_inicio_agente,
--      old.fk_personal_inteligencia_agente    
--      );
--
--      RAISE INFO 'COPIADO LA INFORMACION EN LA TABLA ALTERNATIVA DE CRUDO';
--      
--    ELSE
--      RAISE INFO 'HUBO UN ERROR EN COPIAR INFORMANTE O HISTORICO CARGO';
--      RAISE EXCEPTION 'HUBO UN ERROR EN COPIAR INFORMANTE O HISTORICO CARGO';
--      RETURN NULL;
--    END IF;
--    
--  END
--$$;





















-------------------////--------------////---------------//---------------



----------------------------------------------
---- TRIGGER DE COPIA_HISTORICO_CARGO ----

--CREATE OR REPLACE PROCEDURE COPIA_HISTORICO_CARGO(fecha timestamp, personal integer, estacion integer, oficina integer)
--LANGUAGE PLPGSQL
--AS $$
--DECLARE
--	HISTORICO hist_cargo%rowtype;
--	
--	hist_cargo_alt_reg hist_cargo_alt%rowtype; 
--	
--BEGIN
--		
--	
--	--- BUSCA LA INFORMACION EN HIST_CARGO PARA COPIARLA y VALIDACION SI EXISTE EL CARGO EN LA TABLA ALTE
--
--	select * into hist_cargo_alt_reg 
--	from hist_cargo_alt
--	where fecha_inicio = fecha
--	AND fk_personal_inteligencia = personal
--	AND fk_estacion = estacion
--	AND fk_oficina_principal = oficina;
--
--	--- INSERT EN LA TABLA ALTERNATIVA DE HISTORICO CARGO
--	
--	IF (hist_cargo_alt_reg IS NULL) THEN
--
--		SELECT * INTO HISTORICO 
--		FROM hist_cargo 
--		WHERE fecha_inicio=fecha
--		AND fk_personal_inteligencia = personal
--		AND fk_estacion = estacion
--		AND fk_oficina_principal = oficina;
--
--
--		RAISE INFO 'DATOS DEL HIST_CARGO BASE A COPIAR: %', HISTORICO;
--
--
--		INSERT INTO hist_cargo_alt (
--			fecha_inicio,
--			fecha_fin,
--			cargo,
--
--			fk_personal_inteligencia,
--			fk_estacion,
--			fk_oficina_principal
--
--		) VALUES (
--			HISTORICO.fecha_inicio,
--			HISTORICO.fecha_fin, 
--			HISTORICO.cargo, 
--			HISTORICO.fk_personal_inteligencia,
--			HISTORICO.fk_estacion, 
--			HISTORICO.fk_oficina_principal
--		);	
--
--		RAISE INFO 'INSERT DE LA INFORMACION COPIADA EN LA TABLA HISTORICO_CARGO_ALT';
--
--	ELSE
--	
--		RAISE INFO 'EL HISTORICO CARGO YA ESTA REGISTRADO ';
--		RAISE INFO 'EL HISTORICO CARGO YA ESTA REGISTRADO ';
--		
--	END IF;	
--	
--END
--$$;
----DROP PROCEDURE COPIA_HISTORICO_CARGO(timestamp, integer, integer, integer)









--
--------------------------------------------------------------------------
------- FUNCION DEL TRIGGER PARA COPIAR EL CRUDO-----
--CREATE OR REPLACE FUNCTION TRIGGER_COPIA_CRUDO()
--RETURNS TRIGGER
--LANGUAGE PLPGSQL
--AS $$
--DECLARE
--	
--	crudo_reg crudo%rowtype;
--	
--	copia_historico hist_cargo%rowtype;
--	
--	informante_reg informante%rowtype;
--	
--BEGIN
--
--	--SELECT PARA EXTRAR LA INFO DEL CRUDO
--	
--	SELECT * INTO crudo_reg FROM crudo
--	WHERE id = old.id;
--	
--	RAISE INFO 'INFORMACION DE CRUDO A COPIAR ';
--	RAISE INFO '%: ', crudo_reg;
--	--RAISE INFO 'Fuente: %, Valor de apreciacion: %, Nivel de confiabilidad: %', old.fuente, old.valor_apreciacion, old.nivel_confiabilidad_inicial;
--	--RAISE INFO 'Nivel de confiabilidad fianl: %, Fecha de obtencion: %, Fecha de verificacion final: %', old.nivel_confiabilidad_final, old.fecha_obtencion, old.fecha_verificacion_final;
--	--RAISE INFO 'Cantidad de analistas: %, Nummero de clasificacion tema: %, Id informante: %,'
--
--	--SELECT PARA COPIAR EL HISTORICO CARGO
--	
--	
--	SELECT * INTO copia_historico FROM hist_cargo
--	WHERE old.fk_fecha_inicio_agente = hist_cargo.fecha_inicio;
--	
--	SELECT * INTO informante_reg FROM informante
--	WHERE id = old.fk_informante;
--	
--	RAISE INFO 'INFORMACION DEL HISTORICO CARGO A COPIAR %:', copia_historico;
--	
--	IF (copia_historico IS NOT NULL AND informante_reg IS NOT NULL) THEN
--	
--		---- INSERT EN LA TABLA ALT DE HISTORICO(COPIA DE INFORMACION)
--
--		CALL copia_historico_cargo(copia_historico.fecha_inicio, copia_historico.fk_personal_inteligencia, copia_historico.fk_estacion, copia_historico.fk_oficina_principal);
--
--		----INSERT EN LA TABLA ALT DE CRUDO (COPIA DE INFORMACION)
--		INSERT INTO crudo_alt (
--			id
--			fuente, 
--			fecha_obtencion,
--
--			fk_clas_tema,
--			fk_informante,
--
--			fk_estacion_pertenece, 
--			fk_oficina_principal_pertenece,
--
--			fk_estacion_agente,
--			fk_oficina_principal_agente,
--			fk_fecha_inicio_agente,
--			fk_personal_inteligencia_agente
--			
--		) VALUES (
--			
--			old.id,
--			old.fuente, 
--			old.fecha_obtencion,
--
--			old.fk_clas_tema,
--			old.fk_informante,
--
--			old.fk_estacion_pertenece, 
--			old.fk_oficina_principal_pertenece,
--
--			old.fk_estacion_agente,
--			old.fk_oficina_principal_agente,
--			old.fk_fecha_inicio_agente,
--			old.fk_personal_inteligencia_agente		
--		);
--
--		RAISE INFO 'COPIADO LA INFORMACION EN LA TABLA ALTERNATIVA DE CRUDO';
--	ELSE
--		RAISE INFO 'HUBO UN ERROR EN COPIAR INFORMANTE O HISTORICO CARGO';
--		RAISE EXCEPTION 'HUBO UN ERROR EN COPIAR INFORMANTE O HISTORICO CARGO';
--	END IF;
--		
--	END
--$$;
------------------CREACION DEL TRIGGER --------------------
------CREATE TRIGGER TRIGGER_COPIA_CRUDO
------BEFORE DELETE ON crudo
------FOR EACH ROW EXECUTE FUNCTION TRIGGER_COPIA_CRUDO()
------DROP TRIGGER TRIGGER_COPIA_CRUDO
--
--
--










