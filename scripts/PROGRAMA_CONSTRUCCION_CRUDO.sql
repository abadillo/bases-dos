--------------------------///////////////////////-----------------------------


-- Demostración de la implementación de los requerimientos del sistema de bases de datos 
-- transaccional referidos al proceso de venta de piezas – actividades de recolección y 
-- verificación de hechos crudos y manejo de informantes, incluyendo la seguridad correspondiente 
-- (roles, cuentas con privilegios para poder ejecutar los programas y reportes).


-- Verificación_Hechos_Crudos (3) - elegir analistas, definir rango de tiempo para cargar 
-- confiabilidades, pedir nivel a asignar por analista, guardar y calcular promedio, actualizar 
-- el hecho crudo con la fecha final y el promedio calculado. Aplicando todas las validaciones
-- necesarias sobre cada paso…

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



CALL REGISTRO_INFORMANTE( 'aja prueba' , 2, 1 , null );


