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



CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_personal_inteligencia_confidente = id_personal_inteligencia; 
$$;

-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE(11);

-- SELECT * from informante;


-------------------------/////////////////////-----------------------



CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_personal_inteligencia_encargado = id_personal_inteligencia; 
$$;


--------------------------///////////////////////-----------------------------


-- DROP PROCEDURE IF EXISTS REGISTRO_INFORMANTE CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_INFORMANTE (nombre_clave_va IN INFORMANTE.nombre_clave%TYPE, id_agente_campo IN integer, id_empleado_jefe_confidente IN integer, id_personal_inteligencia_confidente IN integer)
LANGUAGE plpgsql
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










