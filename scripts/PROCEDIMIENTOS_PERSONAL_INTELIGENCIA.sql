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



-------------------------/////////////////////-----------------------\




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
-- CALL REGISTRO_CRUDO_SIN_INFORMANTE(2, 1, FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'resumen', 'tecnica', null, 25, 5);








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













--------------------------///////////////////////-----------------------------

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
-- alterada

-- Cuando un hecho crudo tiene un nivel de confiabilidad superior al 85, el jefe de la estación asigna 
-- al analista responsable - debe ser diferente de los analistas que verificaron el hecho.
 

-- 4. Demostración de la implementación de los requerimientos del sistema de bases de datos transaccional referidos al proceso de venta de piezas de inteligencia – construcción de piezas de inteligencia y venta a clientes, incluyendo la seguridad correspondiente (roles, cuentas con privilegios para poder ejecutar los programas y reportes).


-- Registro_Verificación_Pieza_Inteligencia – Asignar analista, registro id, analista y descripción de la pieza; pedir y registrar los hechos crudos que la conforman, calcular confiabilidad, asignar tema según hechos y registrar precio. Aplicando todas las validaciones necesarias sobre cada paso…

--------------------------///////////////////////-----------------------------





-- DROP PROCEDURE IF EXISTS REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (id_analista_encargado IN integer, descripcion IN PIEZA_INTELIGENCIA.descripcion%TYPE, id_crudo_base IN integer)
LANGUAGE plpgsql
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




--select c.id, c.nivel_confiabilidad_final , (SELECT count(*) FROM ANALISTA_CRUDO WHERE fk_crudo = c.id) as numero_analistas from crudo c ;
--select * from crudo where id = 1;



--SELECT c.id, count(*) as numero_analistas, c.cant_analistas_verifican FROM ANALISTA_CRUDO ac, CRUDO c WHERE ac.fk_crudo = c.id  GROUP BY c.id, c.cant_analistas_verifican ORDER BY c.id  ;
--
--select * from analista_crudo ac where fk_crudo =24;
--select * from crudo  where id=24;


-----------------------------===========$$$$$$$$$$///////////////|\\\\\\\\\\\\\\\$$$$$$$$$$===========-------------------------------------------




--DROP PROCEDURE IF EXISTS AGREGAR_CRUDO_A_PIEZA CASCADE;

CREATE OR REPLACE PROCEDURE AGREGAR_CRUDO_A_PIEZA (id_crudo IN integer, id_pieza IN integer)
LANGUAGE plpgsql
AS $$  
DECLARE

	crudo_pieza_reg CRUDO_PIEZA%ROWTYPE;
    
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO AGREGAR_CRUDO_A_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	


 

	INSERT INTO CRUDO_PIEZA (fk_pieza_inteligencia, fk_crudo) VALUES (
   		pieza_reg.id,
   		crudo_reg.id
    );
   
   	RAISE INFO 'CRUDO DE ID = %, FUE AGREGADO A LA PIEZA ID = % EXITOSAMENTE', id_crudo, id_pieza;
 

END $$;


COMMIT;

--CALL AGREGAR_CRUDO_A_PIEZA( id_pieza, id_crudo , id_analista);

--CALL AGREGAR_CRUDO_A_PIEZA( 9, 10 , 11);


--SELECT id_pieza,fk_personal_inteligencia FROM intento_no_autorizado ina order by fecha_hora desc;




--SELECT count(*) as numero_crudos_va_en_pieza, sum(c.nivel_confiabilidad_final)/count(*) as nivel_confiabilidad_promedio_va
----	INTO numero_crudos_va, nivel_confiabilidad 
--FROM CRUDO_PIEZA cp, CRUDO c WHERE cp.fk_crudo = c.id AND cp.fk_pieza_inteligencia = 2;
--
--
--SELECT cp.fk_pieza_inteligencia as id_pieza, count(*) as numero_crudos_va_en_pieza, sum(c.nivel_confiabilidad_final)/count(*) as nivel_confiabilidad_promedio_va
----	INTO numero_crudos_va, nivel_confiabilidad 
--FROM CRUDO_PIEZA cp, CRUDO c WHERE cp.fk_crudo = c.id GROUP BY cp.fk_pieza_inteligencia ORDER BY cp.fk_pieza_inteligencia;


-----------------------------===========$$$$$$$$$$///////////////|\\\\\\\\\\\\\\\$$$$$$$$$$===========-------------------------------------------




-- DROP PROCEDURE IF EXISTS CERTIFICAR_PIEZA CASCADE;


CREATE OR REPLACE PROCEDURE CERTIFICAR_PIEZA (id_pieza IN integer, precio_base_va IN PIEZA_INTELIGENCIA.precio_base%TYPE)
LANGUAGE plpgsql
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

   ---------
   
   
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



--CALL CERTIFICAR_PIEZA( 37, 1 );

-- VALIDAR CON EL ID DEL ANALISTA 






----------------------------------///////////////////----------------------------


DROP FUNCTION IF EXISTS VER_DATOS_PIEZA CASCADE;


CREATE OR REPLACE FUNCTION VER_DATOS_PIEZA (id_pieza IN integer, id_personal_inteligencia IN integer)
RETURNS setof PIEZA_INTELIGENCIA
LANGUAGE plpgsql
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
    END IF;

    IF (personal_inteligencia_reg.class_seguridad = 'confidencial' AND (pieza_reg.class_seguridad = 'confidencial' OR pieza_reg.class_seguridad = 'no_clasificado')) THEN
       RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    END IF;

    IF (personal_inteligencia_reg.class_seguridad = 'no_clasificado' AND pieza_reg.class_seguridad = 'no_clasificado') THEN
        RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    END IF;

   
--    RAISE INFO 'ACCESO DENEGADO A LA PIEZA. ESTA ACCIÓN SERÁ NOTIFICADA';
   
 	------///- 
   
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
	
	
--	RAISE INFO ' ';
--	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO VER_DATOS_PIEZA ( % ) ------', NOW();
--	
--	IF (VALIDAR_ACCESO_PIEZA(id_pieza, id_personal_inteligencia) = TRUE) THEN 
--		
--		RAISE INFO 'ACCESO CONCEBIDO';
--	
--		RETURN QUERY 
--			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
--	
--	ELSE
--		
--		RAISE INFO 'NO TIENE ACCESO A LA PIEZA. ESTA ACCIÓN SERÁ NOTIFICADA';
--		RAISE EXCEPTION 'NO TIENE ACCESO A LA PIEZA. ESTA ACCIÓN SERÁ NOTIFICADA';
--	
--	END IF;
   
END $$;

--
SELECT VER_DATOS_PIEZA(2,10);
--SELECT id_pieza,fk_personal_inteligencia FROM intento_no_autorizado ina order by fecha_hora desc;








-------------------------///////////----------------------




-- DROP FUNCTION IF EXISTS ELIMINACION_REGISTROS_VENTA_EXCLUSIVA CASCADE;

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



--
--
--select * from adquisicion a where id = 1;
--select * from adquisicion_alt aa where id = 1;
--
--select * from crudo_pieza cp where fk_pieza_inteligencia = 1;
--select * from crudo_pieza_alt cpa where fk_pieza_inteligencia = 1;
--
--select * from pieza_inteligencia pi2 where id = 1;
--SELECT * from pieza_inteligencia_alt where id = 1;
--
--SELECT * from transaccion_pago tp where fk_crudo in	(SELECT fk_crudo FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = 1);
--SELECT * from transaccion_pago_alt tp;
--
--SELECT * FROM informante_alt ia ;
--
--select * from analista_crudo_alt ac ;
--select * from analista_crudo ac ;
--
--Select * from crudo_alt;
--
--SELECT ELIMINACION_REGISTROS_VENTA_EXCLUSIVA(1);



--------------------------///////////////////////-----------------------------
 



DROP FUNCTION IF EXISTS VALIDAR_VENTA_EXCLUSIVA CASCADE;

 CREATE OR REPLACE FUNCTION VALIDAR_VENTA_EXCLUSIVA ( id_pieza IN integer ) 
 RETURNS boolean
 LANGUAGE PLPGSQL 
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





DROP PROCEDURE IF EXISTS REGISTRO_VENTA CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_VENTA (id_pieza IN integer, id_cliente IN integer, precio_vendido_va IN ADQUISICION.precio_vendido%TYPE)
LANGUAGE plpgsql
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
	  	
	  		CALL REGISTRO_TEMA_VENTA(id_cliente,id_tema);

	  		SELECT ELIMINACION_REGISTROS_VENTA_EXCLUSIVA(pieza_reg.id);	
			
		
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
	
		CALL REGISTRO_TEMA_VENTA(id_cliente,id_tema);

		RAISE INFO 'VENTA EXITOSA!';
   		RAISE INFO 'Datos de la venta: %', adquisicion_reg ; 	
	
	END IF;

	
 	
 

END $$;


--CALL REGISTRO_VENTA( 1,  1, 10000.0 );

--select * from adquisicion a 

-- select c.id as id_cliente, c.exclusivo, p.id as id_pieza, p.precio_base, a.*, ((a.precio_vendido - p.precio_base)/(p.precio_base))*100 as porcentaje_recargo from adquisicion a, cliente c, PIEZA_INTELIGENCIA p where a.fk_cliente = c.id AND a.fk_pieza_inteligencia = p.id;




-----------------------///////////////--------------------





-------------////////.........^^^^^^^^^^^^^^^^^^^^^..........\\\\\\\\\\-------------



DROP FUNCTION IF EXISTS ANALISTA_VERIFICO_CRUDO CASCADE;

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



DROP FUNCTION IF EXISTS ANALISTA_PUEDE_VERIFICA_CRUDO CASCADE;

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

--
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






DROP PROCEDURE IF EXISTS VERIFICAR_CRUDO CASCADE;


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



DROP PROCEDURE IF EXISTS CERRAR_CRUDO CASCADE;


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

CALL VERIFICAR_CRUDO( 53, 31 , 85);

CALL CERRAR_CRUDO(31);

