
-- SELECCIONAR, CREAR, MODIFICAR y ELIMINAR EMPLEADOS_AREA


-- CREATE TABLE EMPLEADO_JEFE (

--     id serial NOT NULL,

--     primer_nombre varchar(50) NOT NULL,
--     segundo_nombre varchar(50) ,
--     primer_apellido varchar(50) NOT NULL,
--     segundo_apellido varchar(50) NOT NULL,
--     telefono telefono_ty,
--     tipo varchar(50) NOT NULL, -- 'director_area, jefe, director_ejecutivo'
--     fk_empleado_jefe integer,

--     CONSTRAINT EMPLEADO_JEFE_PK PRIMARY KEY (id),
--     CONSTRAINT EMPLEADO_JEFE_FK FOREIGN KEY (fk_empleado_jefe) REFERENCES EMPLEADO_JEFE (id),
--     CONSTRAINT EMPLEADO_JEFE_CH_tipo CHECK ( tipo IN ('director_area', 'jefe', 'director_ejecutivo') )
-- );

CREATE OR REPLACE FUNCTION CREAR_TELEFONO (codigo numeric(10), numero NUMERIC(15))
RETURNS telefono_ty
LANGUAGE sql
AS $$  
 	SELECT (ROW(codigo,numero)::telefono_ty); 
$$;
--
--
--select crear_telefono(12,0120301230);

-----------------------------///////////////-------------------------------


--DROP FUNCTION VER_DIRECTOR_AREA;

CREATE OR REPLACE FUNCTION VER_DIRECTOR_AREA (id_director_area in integer)
RETURNS EMPLEADO_JEFE
LANGUAGE sql
AS $$  
 	SELECT * FROM EMPLEADO_JEFE WHERE id = id_director_area AND tipo = 'director_area' ; 
$$;
--
--
--select VER_DIRECTOR_AREA(8);





DROP PROCEDURE IF EXISTS CREAR_DIRECTOR_AREA CASCADE;


CREATE OR REPLACE PROCEDURE CREAR_DIRECTOR_AREA (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_DIRECTOR_AREA ( % ) ------', NOW();
	

	-------------////////
	
	INSERT INTO EMPLEADO_JEFE (
		primer_nombre,
		segundo_nombre, 
		primer_apellido, 
		segundo_apellido, 
		telefono,
		tipo,
		fk_empleado_jefe 
	
	) VALUES (
		primer_nombre_va,
		segundo_nombre_va, 
		primer_apellido_va, 
		segundo_apellido_va, 
		telefono_va,
		tipo_va,
		id_jefe 

	) RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR DE AREA CREADO CON EXITO!';
   RAISE INFO 'Datos del director de area: %', empleado_jefe_reg ; 



END $$;


CALL CREAR_DIRECTOR_AREA('nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
SELECT * FROM empleado_jefe ej order by id desc; 





CREATE OR REPLACE PROCEDURE ELIMINAR_DIRECTOR_AREA (id_director_area IN INTEGER)
LANGUAGE plpgsql
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_DIRECTOR_AREA ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_director_area;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != tipo_va) THEN
		RAISE INFO 'El empleado no es un director de area';
		RAISE EXCEPTION 'El empleado no es un director de area';
	END IF;

	UPDATE oficina_principal SET fk_director_area = null WHERE fk_director_area = id_director_area;
	UPDATE empleado_jefe SET fk_empleado_jefe = null WHERE fk_empleado_jefe = id_director_area;

	DELETE FROM EMPLEADO_JEFE WHERE id = id_director_area; 
	
   RAISE INFO 'DIRECTOR DE AREA ELIMINADO CON EXITO!';
 

END $$;



CALL eliminar_director_area(5);
SELECT * FROM empleado_jefe ej order by id desc; 



-----------==--=-==--==-=-=-=--==-=-=----=---------


CREATE OR REPLACE PROCEDURE ACTUALIZAR_DIRECTOR_AREA (id_director_area IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';


BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ACTUALIZAR_DIRECTOR_AREA ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_director_area;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != tipo_va) THEN
		RAISE INFO 'El empleado no es un director de area';
		RAISE EXCEPTION 'El empleado no es un director de area';
	END IF;
	

	-------------////////
	
	UPDATE EMPLEADO_JEFE SET 
	
		primer_nombre = primer_nombre_va,
		segundo_nombre = segundo_nombre_va, 
		primer_apellido = primer_apellido_va,  
		segundo_apellido = segundo_apellido_va, 
		telefono = telefono_va,
		fk_empleado_jefe = id_jefe 
		
	WHERE id = id_director_area
	RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR DE AREA ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del director de area: %', empleado_jefe_reg ; 



END $$;


CALL actualizar_director_area (2,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
SELECT * FROM empleado_jefe ej order by id desc; 


select now;

-------------------------/////////--------......---------------------


-- CAMBIAR ROL DE DIRECTOR AREA A JEFE 


-- SELECCIONAR, CREAR, MODIFICAR y ELIMINAR OFICINAS