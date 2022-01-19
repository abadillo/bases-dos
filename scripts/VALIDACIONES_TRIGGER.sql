

CREATE OR REPLACE PROCEDURE VALIDAR_JERARQUIA_EMPLEADO_JEFE (id_empleado_sup IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
AS $$
DECLARE

	jefe_superior_reg EMPLEADO_JEFE%ROWTYPE;
	
BEGIN

	SELECT * INTO jefe_superior_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_sup AND tipo = tipo_va;
	
	IF (jefe_superior_reg IS NULL) THEN
		RAISE INFO 'El jefe del empleado que ingresó debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El jefe del empleado que ingresó debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql;


---------/-///-/-/-/--/---/-/-/-/-/-/-/--/--//---//-/-/-/-/-/-/-/-/-/-/-/-/--/----//////--------------------



CREATE OR REPLACE PROCEDURE VALIDAR_TIPO_EMPLEADO_JEFE(id_empleado IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
AS $$
DECLARE

	empleado_reg EMPLEADO_JEFE%ROWTYPE;
	
BEGIN

	select * into empleado_reg from EMPLEADO_JEFE where id = id_empleado AND tipo = tipo_va;
	
	IF (empleado_reg IS NULL) THEN
		RAISE INFO 'El empleado ingresado debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El empleado ingresado debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql;


---------/-///-/-/-/--/---/-/-/-/-/-/-/--/--//---//-/-/-/-/-/-/-/-/-/-/-/-/--/----//////--------------------


CREATE OR REPLACE PROCEDURE VALIDAR_TIPO_LUGAR(id_lugar IN integer, tipo_va IN LUGAR.tipo%TYPE)
AS $$
DECLARE

	lugar_reg LUGAR%ROWTYPE;
	
BEGIN

	select * into lugar_reg from LUGAR where id = id_lugar AND tipo = tipo_va;
	
	IF (lugar_reg IS NULL) THEN
		RAISE INFO 'El lugar/direccion ingresado debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El lugar/direccion ingresado debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql;





--------------------------///////////////---------------------


CREATE OR REPLACE PROCEDURE VALIDAR_ARCO_EXCLUSIVO()
LANGUAGE PLPGSQL
AS $$
DECLARE 

	agente_campo_encargado_reg personal_inteligencia%rowtype; 	
	hist_agente_encargado_reg hist_cargo%rowtype;
	
	personal_confidente_reg personal_inteligencia%rowtype;
	hist_cargo_personal_inteligencia_reg hist_cargo%rowtype;
	
	empleado_jefe_reg empleado_jefe%rowtype;
	
BEGIN 

	------------- VALIDACIONES DE LLAVES FORÁNEAS
	
	IF (new.fk_empleado_jefe_confidente IS NOT NULL AND (new.fk_personal_inteligencia_confidente IS NOT NULL OR new.fk_estacion_confidente IS NOT NULL OR new.fk_oficina_principal_confidente IS NOT NULL)) THEN
		RAISE INFO 'Tiene dos confidentes el informante, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
		RAISE EXCEPTION 'Tiene dos confidentes el informante, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
	
	END IF;
	IF (new.fk_empleado_jefe_confidente IS NULL AND (new.fk_personal_inteligencia_confidente IS NULL OR new.fk_estacion_confidente IS NULL OR new.fk_oficina_principal_confidente IS NULL)) THEN 
		RAISE INFO 'El informante no tiene confidente, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;
		RAISE EXCEPTION 'El informante no tiene confidente, no puede ocurrir % %', new.fk_empleado_jefe_confidente, new.fk_personal_inteligencia_confidente;

	END IF;
	IF (new.fk_personal_inteligencia_encargado = new.fk_personal_inteligencia_confidente) THEN
		RAISE INFO 'EL AGENTE DE CAMPO ENCARGADO Y EL PERSONAL DE INTELIGENCIA CONFIDENTE NO PUEDEN SER EL MISMO';
		RAISE EXCEPTION 'EL AGENTE DE CAMPO ENCARGADO Y EL PERSONAL DE INTELIGENCIA CONFIDENTE NO PUEDEN SER EL MISMO';
	
	END IF;

	
----- BUSQUEDA AGENTE ENCARGAGO

	SELECT * INTO agente_campo_encargado_reg FROM personal_inteligencia
	WHERE id = new.fk_personal_inteligencia_encargado;
	RAISE INFO ' DATOS DEL AGENTE DE CAMPO ENCARGADO: %',agente_campo_encargado_reg;
	
	SELECT * INTO hist_agente_encargado_reg FROM hist_cargo 
	WHERE fk_personal_inteligencia = new.fk_personal_inteligencia_encargado 
	AND fecha_fin IS NULL;
	
	IF (hist_agente_encargado_reg IS NULL) THEN
		RAISE INFO 'EL AGENTE DE CAMPO QUE INGRESÓ NO EXISTE O YA NO TRABAJA EN AII';
		RAISE EXCEPTION 'EL AGENTE DE CAMPO QUE INGRESÓ NO EXISTE O YA NO TRABAJA EN AII, ID: %', new.fk_personal_inteligencia_encargado;
	END IF; 
	
	IF (hist_agente_encargado_reg.cargo != 'agente') THEN
		RAISE INFO 'El agente de campo que ingresó no es un agente de campo en su cargo actual';
		RAISE EXCEPTION 'El agente de campo que ingresó no es un agente de campo en su cargo actual, en el informante: %', new.nombre_clave;

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
			
		END IF; 
		
			
	ELSE 

	-----VALIDACION DEL EMPLEADO_JEFE CONFIDENTE

		SELECT * INTO empleado_jefe_reg FROM empleado_jefe 
		WHERE id = new.fk_empleado_jefe_confidente;

		IF (empleado_jefe_reg IS NULL) THEN
			RAISE INFO 'El confidente empleado que ingresó no existe o ya no trabaja en AII';
	  		RAISE EXCEPTION 'El confidente empleado que ingresó no existe o ya no trabaja en AII';
			
		END IF; 

		RAISE INFO 'datos del empleado jefe confidente: %', empleado_jefe_reg;

	END IF;


END $$;



-----------------------/////////////////-----------------------



CREATE OR REPLACE PROCEDURE VALIDAR_EXIT_TEMA(id_tema IN integer)
AS $$
DECLARE

	tema_reg CLAS_TEMA%ROWTYPE;
	
BEGIN

	SELECT * INTO tema_reg FROM CLAS_TEMA WHERE id = id_tema;

	RAISE INFO 'DATOS DE TEMA %:', tema_reg;
	
	IF (tema_reg IS NULL) THEN
		RAISE INFO 'El tema que ingresó no se encuetra registrado';
		RAISE EXCEPTION 'El tema que ingresó no se encuetra registrado';
	END IF;
		
END;
$$ LANGUAGE plpgsql;




---------=-=-=-==-=-=--=-=-=---------------------------//////////////////-----------------


DROP FUNCTION IF EXISTS VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO CASCADE;

CREATE OR REPLACE FUNCTION VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO ( id_crudo IN integer ) 
RETURNS integer
LANGUAGE PLPGSQL 
AS $$
DECLARE 

	numero_analistas_va integer;	

BEGIN 
	
	SELECT count(*) INTO numero_analistas_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;
	
	RETURN numero_analistas_va;
	
END $$;