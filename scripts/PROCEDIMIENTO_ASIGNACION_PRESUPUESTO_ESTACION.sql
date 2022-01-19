CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_DE_DIR_AREA_A_ESTACION(id_empleado_acceso in integer, id_estacion in integer)
AS $$
DECLARE

	dir_area_reg EMPLEADO_JEFE%ROWTYPE;	
	oficina_dir_reg OFICINA_PRINCIPAL%ROWTYPE;
	estacion_reg ESTACION%ROWTYPE;

BEGIN

	SELECT * INTO dir_area_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_acceso;

	IF (dir_area_reg IS NULL OR dir_area_reg.tipo != 'director_area') THEN
		RAISE EXCEPTION 'El empleado no es un director de area o no existe';
	END IF;

	SELECT * INTO estacion_reg FROM ESTACION WHERE id = id_estacion;
	SELECT * INTO oficina_dir_reg FROM OFICINA_PRINCIPAL WHERE fk_director_area = id_empleado_acceso; 

	IF (estacion_reg.fk_oficina_principal != oficina_dir_reg.id) THEN
		RAISE EXCEPTION 'No tiene acesso a esta informacion';
	END IF;
		
END;
$$ LANGUAGE plpgsql;


DROP PROCEDURE PROCEDIMIENTO_ASIGNACION_PRESUPUESTO (integer, integer, numeric)


CREATE OR REPLACE PROCEDURE PROCEDIMIENTO_ASIGNACION_PRESUPUESTO (id_empleado_acceso integer, estacion_va integer, presupuesto numeric)
LANGUAGE PLPGSQL
AS $$
DECLARE 	

	estacion_reg estacion%rowtype;
	oficina_reg oficina_principal%rowtype;
	jefe_reg empleado_jefe%rowtype;
	
BEGIN 
	
		RAISE INFO '------ EJECUCION DEL PROCEDIMINETO PARA ASIGNAR PRESUPUESTO EN ESTACIONES ( % ) ------', NOW();
		
		---PROCEDIMIENTO QUE VALIDA SI EL DIRECTOR DE AREA TIENE ACCESO A LA ESTACION---
		
		CALL VALIDAR_ACESSO_DE_DIR_AREA_A_ESTACION(id_empleado_acceso, estacion_va);
		
		---SE VALIDA QUE EL DIRECCTOR DE AREA PERTENESCA A LA OFICINA_PRINCIPAL---
		SELECT * INTO oficina_reg FROM oficina_principal WHERE fk_director_area = id_empleado_acceso; ---MIRAR 
		
		---SE VALIDA SI LA OFICINA EXISTE--
		
		IF (oficina_reg IS NULL) THEN
			RAISE INFO 'La oficina no existe';
			RAISE EXCEPTION 'La oficina no existe';
		END IF;
	
		SELECT * INTO estacion_reg FROM estacion WHERE id = estacion_va;
		
		IF (estacion_reg IS NULL) THEN
			RAISE INFO 'La estacion no existe';
			RAISE EXCEPTION 'La estacion no existe';
		END IF;
		
		INSERT INTO cuenta (
			año,
			presupuesto,
			fk_estacion,
			fk_oficina_principal		
		)	VALUES	(NOW()::DATE, 
					presupuesto,
					estacion_va,
					oficina_reg.id
					);
					
		
END
$$;


CALL PROCEDIMIENTO_ASIGNACION_PRESUPUESTO(2, 1, 5000)


-- PROCEDIMIENTO DE DIRECTOR DE AREA, 
-- ASIGNAR LOS PRESUPUESTOS DE ESTACIONES,
-- REFERENCIA:: ACTUALIZAR ESTACIÓN,
-- VALIDAR QUE EL DIRECTOR TENGA ACCESO,
-- id_empleado_acceso, ES EL ID DEL DIRECTOR DE AREA.

