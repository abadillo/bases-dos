-- DROP PROCEDURE IF EXISTS CAMBIAR_ROL CASCADE;

CREATE OR REPLACE PROCEDURE CAMBIAR_ROL_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia IN integer, cargo_va IN HIST_CARGO.cargo%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

   hist_cargo_actual_reg HIST_CARGO%ROWTYPE;
   
   fecha_hoy_va timestamp;
  
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CAMBIAR_ROL ( % ) ------', NOW();
	
	-------------///////////--------------	
   
   	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo actual: %', hist_cargo_actual_reg;

    
   --------

   	IF (hist_cargo_actual_reg IS NULL) THEN
   		RAISE INFO 'El personal de inteligencia que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El personal de inteligencia que ingresó no existe o ya no trabaja en AII';
   	
	ELSE 
		
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, id_personal_inteligencia);

	END IF;


	IF (hist_cargo_actual_reg.cargo = cargo_va) THEN
		RAISE INFO 'Ya el personal de inteligencia es un %', cargo_va;
		RAISE EXCEPTION 'Ya el personal de inteligencia es un %', cargo_va;
	END IF;


	IF (cargo_va != 'analista' AND cargo_va != 'agente') THEN
	RAISE INFO 'El cargo que ingresó no existe';
	RAISE EXCEPTION 'El cargo que ingresó no existe';
	END IF;
	
   
	fecha_hoy_va = NOW();


	UPDATE HIST_CARGO SET fecha_fin = fecha_hoy_va WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL;
		
	INSERT INTO HIST_CARGO (
		fecha_inicio,
		cargo,
		fk_personal_inteligencia,
		fk_estacion,
		fk_oficina_principal
	) VALUES (
		fecha_hoy_va,
		cargo_va,
		hist_cargo_actual_reg.fk_personal_inteligencia,
		hist_cargo_actual_reg.fk_estacion,
		hist_cargo_actual_reg.fk_oficina_principal
	);

	RAISE INFO 'CAMBIO DE CARGO EXITOSO!';
 	

END $$;


-- CALL CAMBIAR_ROL_PERSONAL_INTELIGENCIA(14,13,'agente');

-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(14,13);

-- select * from hist_cargo where fk_personal_inteligencia = 1;







