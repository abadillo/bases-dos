---- 	TRIGGER PARA VALIDAR LOS ARCOS EXCLUSIVOS ---------

CREATE OR REPLACE FUNCTION arco_exclusivo()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE 
	agente_campo_encargado_reg personal_inteligencia%rowtype; 	
	hist_agente_encargado_reg hist_cargo%rowtype;
	
	personal_confidente_reg personal_inteligencia%rowtype;
	hist_cargo_personal_inteligencia_reg hist_cargo%rowtype;
	
	empleado_jefe_reg empleado_jefe%rowtype;
	
	informante_reg informante%rowtype;
	
	BEGIN 
		
		------------- VALIDACIONES DE LLAVES FORÁNEAS
		
		IF (new.fk_empleado_jefe_confidente IS NOT NULL AND (new.fk_personal_inteligencia_confidente IS NOT NULL OR new.fk_estacion_confidente IS NOT NULL OR new.fk_oficina_principal_confidente IS NOT NULL)) THEN
			RAISE INFO 'Tiene dos confidentes el informante, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
			RAISE EXCEPTION 'Tiene dos confidentes el informante, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
			RETURN NULL;
		END IF;
		IF (new.fk_empleado_jefe_confidente IS NULL AND (new.fk_personal_inteligencia_confidente IS NULL OR new.fk_estacion_confidente IS NULL OR new.fk_oficina_principal_confidente IS NULL)) THEN 
			RAISE INFO 'El informante no tiene confidente, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
			RAISE EXCEPTION 'El informante no tiene confidente, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
			RETURN NULL;
		END IF;
		IF (new.fk_personal_inteligencia_encargado = new.fk_personal_inteligencia_confidente) THEN
			RAISE INFO 'EL AGENTE DE CAMPO ENCARGADO Y EL PERSONAL DE INTELIGENCIA CONFIDENTE NO PUEDEN SER EL MISMO';
			RAISE EXCEPTION 'EL AGENTE DE CAMPO ENCARGADO Y EL PERSONAL DE INTELIGENCIA CONFIDENTE NO PUEDEN SER EL MISMO';
			RETURN NULL;
		END IF;


	
---- VALIDACIONES DE NOMBRE CLAVE 

	IF(new.nombre_clave IS NULL OR new.nombre_clave = '') THEN
		RAISE INFO 'Ingrese un nombre clave para el informante';
		RAISE EXCEPTION 'Ingrese un nombre clave para el informante';
		RETURN NULL;
	END IF;
	
	SELECT * INTO informante_reg FROM informante 
	WHERE nombre_clave = new.nombre_clave;
	RAISE INFO 'DATOS DE INFORMANTE %:', informante_reg;
	
	IF (informante_reg.id IS NOT NULL) THEN
		RAISE INFO 'El nombre clave que ingresó ya se encuentra en uso';
  		RAISE EXCEPTION 'El nombre clave que ingresó ya se encuentra en uso: %', new.nombre_clave;
		RETURN NULL;
	END IF;		
	
----- BUSQUEDA AGENTE ENCARGAGO

	SELECT * INTO agente_campo_encargado_reg FROM personal_inteligencia
	WHERE id=new.fk_personal_inteligencia_encargado;
	RAISE INFO ' DATOS DEL AGENTE DE CAMPO ENCARGADO: %',agente_campo_encargado_reg;
	
	SELECT * INTO hist_agente_encargado_reg FROM hist_cargo 
	WHERE fk_personal_inteligencia = new.fk_personal_inteligencia_encargado 
	AND fecha_fin IS NULL;
	
	IF (hist_agente_encargado_reg IS NULL) THEN
		RAISE INFO 'EL AGENTE DE CAMPO QUE INGRESÓ NO EXISTE O YA NO TRABAJA EN AII';
		RAISE EXCEPTION 'EL AGENTE DE CAMPO QUE INGRESÓ NO EXISTE O YA NO TRABAJA EN AII, ID: %', new.fk_personal_inteligencia_encargado;
		RETURN NULL;
	END IF; 
	
	IF (hist_agente_encargado_reg.cargo != 'agente')	THEN
		RAISE INFO 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
		RAISE EXCEPTION 'El agente de campo que ingresó no es un agente de campo en su cargo actual, en el informante: %', new.nombre_clave;
		RETURN NULL;
	END IF;	
	
	
-----VALIDACION DEL CONFIDENTE


	IF (new.fk_personal_inteligencia_confidente IS NOT NULL) THEN
	
	----- BUSQUEDA DEL PERSONAL CONFIDENTE
	
		SELECT * INTO personal_confidente_reg from personal_inteligencia 
		WHERE id = new.fk_personal_inteligencia_confidente;
		RAISE INFO 'datos del personal de inteligencia confidente: %', personal_confidente_reg;
		
		SELECT * INTO hist_cargo_personal_inteligencia_reg FROM hist_cargo
		WHERE fk_personal_inteligencia = new.fk_personal_inteligencia_confidente
		AND fecha_fin IS NULL;
		RAISE INFO 'datos de hist_cargo del personal de inteligencia confidente: %', hist_cargo_personal_confidente_reg;
		
		
		IF (hist_agente_encargado_reg IS NULL) THEN
			RAISE INFO 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
	  		RAISE EXCEPTION 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
			RETURN NULL;
		END IF; 
		
	RETURN new; 
		
	ELSE 

-----VALIDACION DEL EMPLEADO_JEFE CONFIDENTE

		SELECT * INTO empleado_jefe_reg FROM empleado_jefe 
		WHERE id= new.fk_empleado_jefe_confidente;
		RAISE INFO 'datos del empleado jefe confidente: %', empleado_jefe_reg;

		RETURN new;		
		
	END IF;
	
	RAISE INFO 'INFORMANTE CREADO CON EXITO!';
	RAISE INFO 'Datos del informante: %', informante_reg ; 
	
	END
$$;

INSERT INTO informante (nombre_clave, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado, fk_empleado_jefe_confidente, fk_personal_inteligencia_confidente, fk_fecha_inicio_confidente, fk_estacion_confidente, fk_oficina_principal_confidente) VALUES
('Ameamezersalica', 2, '2021-03-09 07:00:00', 1, 1, 11, null, null, null, null)

CREATE TRIGGER trigger_arco_exclusivo
BEFORE INSERT ON informante
FOR EACH ROW EXECUTE FUNCTION arco_exclusivo();  --SIEMPRE FOR EACH ROW

DROP TRIGGER trigger_arco_exclusivo on informante