---- 	TRIGGER PARA VALIDAR LOS ARCOS EXCLUSIVOS ---------

CREATE OR REPLACE FUNCTION arco_exclusivo()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE 
	AGENTE_CAMPO personal_inteligencia%rowtype;
 	
	HISTORICO_AGENTE hist_cargo%rowtype;
	
	INFORMANTE informante%rowtype;
	
	personal_confidente_reg personal_inteligencia%rowtype;
	
	empleado_jefe_reg empleado_jefe%rowtype;
	
	BEGIN 
	--	IF (new.fk_empleado_jefe_confidente is NOT null AND( new.fk_personal_inteligencia_confidente is null OR new.fk_estacion_confidente is null OR new.fk_oficina_principal_confidente is null)) then
	--		raise INFO 'tiene como confidente un jefe % %',new.fk_empleado_jefe_confidente,new.fk_personal_inteligencia_confidente;
	--		RETURN NEW;
	--	END IF;
	--	IF (new.fk_empleado_jefe_confidente is null AND( new.fk_personal_inteligencia_confidente is NOT null OR new.fk_estacion_confidente is NOT null OR new.fk_oficina_principal_confidente is NOT null)) then
	--		raise INFO 'tiene como confidente un personal de inteligencia % %',new.fk_empleado_jefe_confidente,new.fk_personal_inteligencia_confidente;
	--		RETURN NEW;
	--	END IF;
		IF (new.fk_empleado_jefe_confidente is NOT null AND( new.fk_personal_inteligencia_confidente is NOT null OR new.fk_estacion_confidente is NOT null OR new.fk_oficina_principal_confidente is NOT null)) then
			raise exception 'Tiene dos confidentes el informante, no puede ocurrir % %',new.fk_empleado_jefe_confidente,new.fk_personal_inteligencia_confidente;
		END IF;
		IF  (new.fk_empleado_jefe_confidente is null AND( new.fk_personal_inteligencia_confidente is null OR new.fk_estacion_confidente is null OR new.fk_oficina_principal_confidente is null)) then 
			raise exception 'El informante no tiene confidente, no puede ocurrir % %',new.fk_empleado_jefe_confidente,new.fk_personal_inteligencia_confidente;
		END IF;
		
-----VALIDACION DEL AGENTE DE CAMPO
	IF (new.fk_personal_inteligencia_confidente is not null) then
	
		SELECT * INTO AGENTE_CAMPO from personal_inteligencia 
		WHERE id=new.fk_personal_inteligencia_confidente;
		raise notice '%', AGENTE_CAMPO;
		
		SELECT * INTO HISTORICO_AGENTE FROM hist_cargo
		WHERE fk_personal_inteligencia = new.fk_personal_inteligencia_confidente
		AND fecha_fin is null;
		
		IF (HISTORICO_AGENTE IS NULL) THEN
			RAISE INFO 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
	  		RAISE EXCEPTION 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
		END IF;  			
		
	END IF;
	
---- VALIDACIONES DE NOMBRE CLAVE 

	if(new.nombre_clave is null OR new.nombre_clave ='') THEN
		RAISE INFO 'Ingrese un nombre clave para el informante';
		RAISE EXCEPTION 'Ingrese un nombre clave para el informante';
	END IF;
	
	SELECT * INTO INFORMANTE FROM informante 
	WHERE nombre_clave = new.nombre_clave;
	RAISE INFO 'DATOS DE INFORMANTE %:', INFORMANTE;
	
	IF (INFORMANTE.id is not null) then
		RAISE INFO 'El nombre clave que ingresó ya se encuentra en uso';
  		RAISE EXCEPTION 'El nombre clave que ingresó ya se encuentra en uso';
	END IF;		
	
	if (fk_personal_inteligencia_confidente is not null) then
		SELECT * INTO personal_confidente_reg from personal_inteligencia 
		where id = new.fk_personal_inteligencia_confidente;
		raise info 'datos del personal de inteligencia confidente: %', personal_confidente_reg;
		
		select * into HISTORICO_AGENTE from hist_cargo 
		where fk_personal_inteligencia = new.fk_personal_inteligencia_confidente
		AND fecha_fin is null;
		
		if (HIST_AGENTE is null) then
			RAISE INFO 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
	  		RAISE EXCEPTION 'El confidente personal de inteligencia que ingresó no existe o ya no trabaja en AII';
		END IF;
		
		return new;
		
		else
		
		SELECT * into empleado_jefe_reg from empleado_jefe
		where id = new.fk_empleado_jefe_confidente;
		
		RAISE INFO 'datos del empleado jefe confidente: %', empleado_jefe_reg;
		
		return new;
	
	end if;
	
	RAISE INFO 'INFORMANTE CREADO CON EXITO!';
	
	END
$$;

CREATE TRIGGER trigger_arco_exclusivo
BEFORE INSERT ON informante
FOR EACH ROW EXECUTE FUNCTION arco_exclusivo();  --SIEMPRE FOR EACH ROW

DROP TRIGGER trigger_arco_exclusivo on informante