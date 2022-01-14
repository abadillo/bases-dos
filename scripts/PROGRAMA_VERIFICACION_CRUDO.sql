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




DROP PROCEDURE IF EXISTS REGISTRO_INFORMANTE CASCADE;


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



CALL REGISTRO_INFORMANTE( 'aja prueba 2', 2, 1, null );





--------------------------///////////////////////-----------------------------




DROP PROCEDURE IF EXISTS REGISTRO_CRUDO_SIN_INFORMANTE CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_CRUDO_SIN_INFORMANTE ( id_agente_campo IN integer, id_tema IN integer, contenido_va IN CRUDO.contenido%TYPE, tipo_contenido_va IN CRUDO.tipo_contenido%TYPE, resumen_va IN CRUDO.resumen%TYPE, fuente_va IN CRUDO.fuente%TYPE, valor_apreciacion_va IN CRUDO.valor_apreciacion%TYPE, nivel_confiabilidad_inicial_va IN CRUDO.nivel_confiabilidad_inicial%TYPE, cant_analistas_verifican_va IN CRUDO.cant_analistas_verifican%TYPE )
LANGUAGE plpgsql
AS $$  
DECLARE

    agente_campo_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
	hist_cargo_agente_encargado_reg HIST_CARGO%ROWTYPE;

	-- informante_reg INFORMANTE%ROWTYPE;
	tema_reg CLAS_TEMA%ROWTYPE;
	crudo_reg CRUDO%ROWTYPE;

	fecha_obtencion_va CRUDO.fecha_obtencion%TYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_CRUDO_SIN_INFORMANTE ( % ) ------', NOW();
	
	-------------/////////// VALIDACIONES DE LLAVES

	
	IF (contenido_va IS NULL OR contenido_va = '') THEN
   		RAISE INFO 'Debe ingresar el contenido del crudo que quiere crear';
  		RAISE EXCEPTION 'Debe ingresar el contenido del crudo que quiere crear';
   	END IF;  

	IF (tipo_contenido_va != 'texto' AND tipo_contenido_va != 'imagen' AND tipo_contenido_va != 'sonido' AND tipo_contenido_va != 'video') THEN
   		RAISE INFO 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video), %', tipo_contenido_va;
  		RAISE EXCEPTION 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video)';
   	END IF;   	

	IF (resumen_va IS NULL OR resumen_va = '') THEN
   		RAISE INFO 'Debe ingresar el resumen del crudo que quiere crear';
  		RAISE EXCEPTION 'Debe ingresar el resumen del crudo que quiere crear';
   	END IF;   

	IF (fuente_va != 'abierta' AND fuente_va != 'secreta' AND fuente_va != 'tecnica') THEN
   		RAISE INFO 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
  		RAISE EXCEPTION 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
   	END IF;  

	IF (fuente_va = 'secreta') THEN
		RAISE INFO 'Para el registro de crudos con fuente secreta, por favor use el programa "REGISTRO_CRUDO_CON_INFORMANTE" ';
  		RAISE EXCEPTION 'Para el registro de crudos con fuente secreta, por favor use el programa "REGISTRO_CRUDO_CON_INFORMANTE" ';
	END IF;

	IF (valor_apreciacion_va IS NOT NULL AND valor_apreciacion_va <= 0) THEN
   		RAISE INFO 'El valor de apreciacion del crudo debe ser mayor a 0$';
  		RAISE EXCEPTION 'El valor de apreciacion del crudo debe ser mayor a 0$';
   	END IF; 

	IF (nivel_confiabilidad_inicial_va IS NULL OR nivel_confiabilidad_inicial_va < 0 OR nivel_confiabilidad_inicial_va > 100 ) THEN
   		RAISE INFO 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
  		RAISE EXCEPTION 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
   	END IF; 
	   
	IF (cant_analistas_verifican_va IS NULL OR cant_analistas_verifican_va < 2) THEN	
   		RAISE INFO 'Debe ingresar un número valido de analistas requeridos para la verificación';
  		RAISE EXCEPTION 'Debe ingresar un número valido de analistas requeridos para la verificación';
   	END IF;   



	-- SELECT * INTO informante_reg FROM INFORMANTE WHERE id = id_informante;

	-- RAISE INFO 'DATOS DE INFORMANTE %:', informante_reg;
	
	-- IF (informante_reg IS NULL) THEN
	-- 	RAISE INFO 'El informante que ingresó no se encuetra registrado';
  	-- 	RAISE EXCEPTION 'El informante que ingresó no se encuetra registrado';
	-- END IF;

	SELECT * INTO tema_reg FROM CLAS_TEMA WHERE id = id_tema;

	RAISE INFO 'DATOS DE TEMA %:', tema_reg;
	
	IF (tema_reg IS NULL) THEN
		RAISE INFO 'El tema que ingresó no se encuetra registrado';
  		RAISE EXCEPTION 'El tema que ingresó no se encuetra registrado';
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
--		fk_informante,

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
--		id_informante,

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
CALL REGISTRO_CRUDO_SIN_INFORMANTE(2, 1, FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'resumen crudo prueba', 'abierta', 999, 5, 3);

-- mal
CALL REGISTRO_CRUDO_SIN_INFORMANTE(2, 1, FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'resumen', 'tecnica', null, 25, 5);


select * from crudo where fk_personal_inteligencia_agente = 2;
