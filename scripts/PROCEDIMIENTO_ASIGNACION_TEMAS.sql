
-- DROP PROCEDURE ASIGNAR_TEMA_CLIENTE;


CREATE OR REPLACE PROCEDURE ASIGNAR_TEMA_CLIENTE (tema_id integer,cliente_id integer)
LANGUAGE PLPGSQL
AS $$
DECLARE 

	tema_reg TEMA%ROWTYPE;
	cliente_reg CLIENTE%ROWTYPE;

	area_interes_exit AREA_INTERES%ROWTYPE;

BEGIN 
	
	SELECT * INTO tema_reg FROM CLAS_TEMA WHERE id = tema_id;
	
	---VALIDACION SI EL TEMA ES NULO---		
	IF (tema_reg IS NULL) THEN
		
		RAISE EXCEPTION 'No existe el tema';
	END IF;


	SELECT * INTO cliente_reg FROM CLIENTE WHERE id = cliente_id;
	
	---VALIDACION SI EL TEMA ES NULO---		
	IF (cliente_reg IS NULL) THEN
		
		RAISE EXCEPTION 'No existe el cliente';
	END IF;


	SELECT * INTO area_interes_exit FROM AREA_INTERES WHERE fk_clas_tema = tema_id and fk_cliente = cliente_id;
		
	---VALIDACION SI EL TEMA ES NULO---		
	IF (area_interes_exit IS NOT NULL) THEN
		
		RAISE EXCEPTION 'Ya el tema fue asignado';
	END IF;


	INSERT INTO AREA_INTERES (
		fk_clas_tema,
		fk_cliente				
	) VALUES (
		tema_id, 
		cliente_id					
	);
	

	RAISE INFO 'SE INSERTO EN EL CLIENTE CON EL ID: % Y EL NOMBRE: %, EL TEMA CON ID: % Y NOMBRE: %', cliente_reg.id, cliente_reg.nombre, tema_reg.id, tema_reg.nombre;   
		
END
$$;







CREATE OR REPLACE PROCEDURE ASIGNAR_TEMAS_ANALISTA (id_empleado_acceso integer, tema_id integer, analista_id integer)
LANGUAGE PLPGSQL
AS $$
DECLARE 

	-- estacion_reg estacion%ROWTYPE;
	hist_cargo_reg hist_cargo%ROWTYPE;	
	empleado_jefe_reg empleado_jefe%ROWTYPE;
	
	tema_reg CLAS_TEMA%ROWTYPE;

	personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;

	temas_esp_exit TEMAS_ESP%ROWTYPE;
	

BEGIN 

	-- CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, personal_inteligencia);

	
	SELECT * INTO tema_reg FROM CLAS_TEMA WHERE id = tema_id;
	
	---VALIDACION SI EL TEMA ES NULO---		
	IF (tema_reg IS NULL) THEN
		
		RAISE EXCEPTION 'No existe el tema';
	END IF;


	SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = analista_id;
	
	---VALIDACION SI EL TEMA ES NULO---		
	IF (personal_inteligencia_reg IS NULL) THEN
		
		RAISE EXCEPTION 'No existe el canalista';
	END IF;


	SELECT * INTO temas_esp_exit FROM TEMAS_ESP WHERE fk_clas_tema = tema_id and fk_personal_inteligencia = analista_id;
		
	---VALIDACION SI EL TEMA ES NULO---		
	IF (temas_esp_exit IS NOT NULL) THEN
		
		RAISE EXCEPTION 'Ya el tema fue asignado';
	END IF;
		
	

	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = analista_id LIMIT 1;

	IF (hist_cargo_reg IS NOT NULL) THEN	
		
		CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, id_analista);

	END IF;


	INSERT INTO TEMAS_ESP (
		fk_personal_inteligencia,
		fk_clas_tema
	) VALUES (
		analista_id,
		tema_id				
	);
							
	RAISE INFO 'SE INSERTO EN EL PERSONAL DE INTELIGENCIA CON EL ID: %, EL TEMA CON ID: % Y NOMBRE: %', analista_id, tema_id, tema_reg.nombre;
	
END
$$;










