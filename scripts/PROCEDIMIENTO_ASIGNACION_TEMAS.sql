DROP PROCEDURE VALIDAR_JEFE_PERSONAL (integer, integer);

CREATE OR REPLACE PROCEDURE VALIDAR_JEFE_PERSONAL (jefe integer, personal integer)
LANGUAGE PLPGSQL
AS $$
DECLARE
	estacion_reg estacion%ROWTYPE;
	hist_cargo_reg hist_cargo%ROWTYPE;
	
BEGIN

	SELECT * INTO estacion_reg 
	FROM estacion
	WHERE fk_empleado_jefe = jefe;
		
	SELECT * INTO hist_cargo_reg 
	FROM hist_cargo 
	WHERE fk_estacion = estacion_reg.id;
	
	
	IF(estacion_reg IS NOT NULL AND hist_cargo_reg IS NOT NULL) THEN
		RAISE INFO 'EL DIRECTOR DE AREA CON ID: % ES JEFE DEL EMPLEADO DE ID: % ',jefe, hist_cargo_reg.fk_personal_inteligencia;
	
	
	ELSE
		RAISE EXCEPTION 'EL DIRECTOR DE AREA NO ES JEFE DEL PERSONAL INSERTADO';
	
	END IF;

END

$$;





DROP PROCEDURE PROCEDIMIENTO_ASIGNAR_TEMAS(integer,integer,integer,integer)

CREATE OR REPLACE PROCEDURE PROCEDIMIENTO_ASIGNAR_TEMAS (id_empleado_acceso integer, tema integer, personal_inteligencia integer, cliente_va integer)
LANGUAGE PLPGSQL
AS $$
DECLARE 

	estacion_reg estacion%ROWTYPE;
	hist_cargo_reg hist_cargo%ROWTYPE;	
	empleado_jefe_reg empleado_jefe%ROWTYPE;
	tema_nombre record;
	cliente_nombre record;
	

BEGIN 
	
		---SELECT EL DIRECTOR DE AREA---
		SELECT * INTO empleado_jefe_reg 
		FROM empleado_jefe 
		WHERE id = id_empleado_acceso
		AND tipo = 'director_area';		
		
		---VALIDACION SI EXISTE EL DIRECTOR DE AREA---
		IF (empleado_jefe_reg IS NULL) THEN
			
			RAISE EXCEPTION 'SE REQUIERE UN DIRECTOR DE AREA PARA ASIGNAR LOS TEMAS';
		
		END IF;
		
		---VALIDACION SI EL TEMA ES NULO---		
		IF (tema IS NULL) THEN
			
			RAISE EXCEPTION 'TIENE QUE INSERTAR UN TEMA PARA LA ASIGNACION DE TEMAS';
		
		END IF;
		---BUSCAR NOMBRE DEL TEMA---
		SELECT nombre INTO tema_nombre
				FROM clas_tema 
				WHERE id = tema;				
		
		---VALIDACION DEL PERSONAL DE INTELIGENCIA Y DEL CLIENTE QUE NO SEAN NULOS---
		IF (personal_inteligencia IS NULL AND cliente_va IS NULL) THEN
			RAISE EXCEPTION 'DEBE ESPECIFICAR UN PERSONAL DE INTELIGENCIA O UN CLIENTE PARA ASIGNAR UN TEMA';
		
		--- SI EXISTE EL PERSONAL ---
		ELSIF (personal_inteligencia IS NOT NULL) THEN
			
			--- VALIDACION DEL DIRECTOR EJECUTIVO SEA JEFE DEL PERSONAL DE INTELIGENCIA ---
			CALL VALIDAR_JEFE_PERSONAL(id_empleado_acceso, personal_inteligencia);
			
			
			--- INSERT EN LA TABLA TEMAS DE PERSONAL DE INTELIGENCIA ---
			INSERT INTO temas_esp (
				fk_personal_inteligencia,
				fk_clas_tema
				)	VALUES (
					personal_inteligencia,
					tema				
				);
								
				RAISE INFO 'SE INSERTO EN EL PERSONAL DE INTELIGENCIA CON EL ID: %, EL TEMA CON ID: % Y NOMBRE: %', personal_inteligencia, tema, tema_nombre;
		--- SI EXISTE EL CLIENTE ---
		ELSIF (cliente_va IS NOT NULL) THEN
				
				--- INSERT EN LA TABLA TEMAS DE CLIENTE ---
				INSERT INTO area_interes (
					fk_clas_tema,
					fk_cliente				
				) 	VALUES (
					tema, 
					cliente					
				);
			
				--- BUSCA NOMBRE DEL CLIENTE ---			
				SELECT nombre INTO cliente_nombre
				FROM cliente
				WHERE id = cliente_va;
		
				RAISE INFO 'SE INSERTO EN EL CLIENTE CON EL ID: % Y EL NOMBRE: %, EL TEMA CON ID: % Y NOMBRE: %', cliente_va, cliente_nombre, tema, tema_nombre;   
		
		END IF;			

END
$$;

					DIRECTOR_AREA, TEMA, PERSONAL O CLIENTE
CALL PROCEDIMIENTO_ASIGNAR_TEMAS(1, 4,1,0)



SELECT * FROM empleado_jefe
ID_JEFE: 11 --> 
ESTACION: 1

SELECT * FROM hist_cargo

SELECT * FROM estacion






