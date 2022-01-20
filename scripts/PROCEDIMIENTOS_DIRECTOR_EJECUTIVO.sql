
--DROP FUNCTION VER_DIRECTOR_AREA;

CREATE OR REPLACE FUNCTION VER_LUGAR (id_lugar in integer)
RETURNS LUGAR
LANGUAGE sql
AS $$  
 	SELECT * FROM LUGAR WHERE id = id_lugar; 
$$;


--
--select VER_DIRECTOR_AREA(8);

--DROP FUNCTION VER_DIRECTOR_AREA;

CREATE OR REPLACE FUNCTION VER_LUGARES ()
RETURNS setof LUGAR
LANGUAGE sql
AS $$  
 	SELECT * FROM LUGAR; 
$$;




CREATE OR REPLACE PROCEDURE CREAR_LUGAR (nombre_va IN LUGAR.nombre%TYPE, tipo_va in LUGAR.tipo%TYPE, region_va in LUGAR.region%TYPE, id_lugar_sup IN LUGAR.fk_lugar%TYPE)
LANGUAGE plpgsql
AS $$  

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_LUGAR ( % ) ------', NOW();
	

	INSERT INTO LUGAR (
		nombre,
		tipo,
		region,
		fk_lugar
	) VALUES (
		nombre_va,
		tipo_va,
		region_va,
		id_lugar_sup
	);

END $$;

-- call CREAR_LUGAR('Perú','pais','america_sur',null);
-- select * from ver_lugares();
-- CALL CREAR_LUGAR('prueba',20, 2);
-- SELECT * FROM lugar order by id desc; 
-- select * from lugar where id = 2;
-- select * from EMPLEADO_JEFE where id = 20;



CREATE OR REPLACE PROCEDURE ELIMINAR_LUGAR (id_lugar IN INTEGER)
LANGUAGE plpgsql
AS $$  
DECLARE

	-- empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--	lugar_reg LUGAR%ROWTYPE;
	-- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';

BEGIN 


	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_LUGAR ( % ) ------', NOW();
	
	DELETE FROM LUGAR WHERE id = id_lugar; 
	
   	RAISE INFO 'LUGAR ELIMINADA CON EXITO!';
 

END $$;



-- CALL ELIMINAR_LUGAR(15)


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/

CREATE OR REPLACE PROCEDURE ACTUALIZAR_LUGAR (id_lugar IN integer,nombre_va IN LUGAR.nombre%TYPE, tipo_va in LUGAR.tipo%TYPE, region_va in LUGAR.region%TYPE, id_lugar_sup IN LUGAR.fk_lugar%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

	lugar_reg LUGAR%ROWTYPE;
 
BEGIN 

	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ACTUALIZAR_LUGAR ( % ) ------', NOW();
	
	SELECT * INTO lugar_reg FROM LUGAR WHERE id = id_lugar;

	IF (lugar_reg IS NULL) THEN
		RAISE INFO 'La lugar no existe';
		RAISE EXCEPTION 'La lugar no existe';
	END IF;


	UPDATE LUGAR SET 
		nombre = nombre_va,
		tipo = tipo_va,
		region = region_va,
		fk_lugar = id_lugar_sup
	
	WHERE id = id_lugar
	RETURNING * INTO lugar_reg;
	
	-------------////////


   RAISE INFO 'LUGAR MODIFICADA CON EXITO';
   RAISE INFO 'Datos de la lugar modificada %', lugar_reg ; 

END $$;





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

--DROP FUNCTION VER_DIRECTOR_AREA;

CREATE OR REPLACE FUNCTION VER_DIRECTORES_AREA ()
RETURNS setof EMPLEADO_JEFE
LANGUAGE sql
AS $$  
 	SELECT * FROM EMPLEADO_JEFE WHERE tipo = 'director_area' ; 
$$;
--
--
--select VER_DIRECTOR_AREA(8);




-- DROP PROCEDURE IF EXISTS CREAR_DIRECTOR_AREA CASCADE;

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


-- CALL CREAR_DIRECTOR_AREA('nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



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



-- CALL eliminar_director_area(5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



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


-- CALL actualizar_director_area (2,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- SELECT * FROM empleado_jefe ej order by id desc; 




--DROP FUNCTION VER_OFICINA;

CREATE OR REPLACE FUNCTION VER_OFICINA (id_oficina in integer)
RETURNS OFICINA_PRINCIPAL
LANGUAGE sql
AS $$  
 	SELECT * FROM OFICINA_PRINCIPAL WHERE id = id_oficina; 
$$;
--
--
--select VER_DIRECTOR_AREA(8);

--DROP FUNCTION VER_OFICINAS;

CREATE OR REPLACE FUNCTION VER_OFICINAS ()
RETURNS setof OFICINA_PRINCIPAL
LANGUAGE sql
AS $$  
 	SELECT * FROM OFICINA_PRINCIPAL; 
$$;
--
--
-- select VER_OFICINAS();



-- DROP PROCEDURE IF EXISTS CREAR_OFICINA_PRINCIPAL CASCADE;

CREATE OR REPLACE PROCEDURE CREAR_OFICINA_PRINCIPAL (nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;

	-- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_OFICINA_PRINCIPAL ( % ) ------', NOW();
	
	-------------////////
		
	INSERT INTO OFICINA_PRINCIPAL (
		nombre,
		sede,
		fk_director_area,
		fk_director_ejecutivo,
		fk_lugar_ciudad
	
	) VALUES (
		nombre_va,
		sede_va,
		id_director_area,
		id_director_ejecutivo,
		id_ciudad 

	) RETURNING * INTO oficina_reg;

   RAISE INFO 'OFICINA CREADA CON EXITO';
   RAISE INFO 'Datos de la oficina creada %', oficina_reg ; 


END $$;


-- CALL CREAR_OFICINA_PRINCIPAL('prueba',20, 2);


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_OFICINA_PRINCIPAL (id_oficina IN INTEGER)
LANGUAGE plpgsql
AS $$  
DECLARE

	-- empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
	-- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_area';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_OFICINA_PRINCIPAL ( % ) ------', NOW();
	
	DELETE FROM OFICINA_PRINCIPAL WHERE id = id_oficina; 
	
   	RAISE INFO 'OFICINA ELIMINADA CON EXITO!';
 

END $$;



-- CALL ELIMINAR_OFICINA_PRINCIPAL(15);




-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ACTUALIZAR_OFICINA_PRINCIPAL (id_oficina IN integer, nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
 
BEGIN 

	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_OFICINA_PRINCIPAL ( % ) ------', NOW();
	
	-------------////////
	
	SELECT * INTO oficina_reg FROM OFICINA_PRINCIPAL WHERE id = id_oficina;

	IF (oficina_reg IS NULL) THEN
		RAISE INFO 'La oficina no existe';
		RAISE EXCEPTION 'La oficina no existe';
	END IF;


	UPDATE OFICINA_PRINCIPAL SET 
		nombre = nombre_va,
		sede = sede_va,
		fk_director_area = id_director_area,
		fk_director_ejecutivo = id_director_ejecutivo,
		fk_lugar_ciudad = id_ciudad 

	WHERE id = id_oficina
	RETURNING * INTO oficina_reg;


   RAISE INFO 'OFICINA MODIFICADA CON EXITO';
   RAISE INFO 'Datos de la oficina modificada %', oficina_reg ; 



END $$;


-- select VER_OFICINAS();
-- CALL ACTUALIZAR_OFICINA_PRINCIPAL (13,'nombre1',false, 21, 9, null);
-- select VER_DIRECTORES_AREA();





-- SELECCIONAR, CREAR, MODIFICAR y ELIMINAR OFICINAS


CREATE OR REPLACE FUNCTION VER_DIRECTOR_EJECUTIVO (id_director_ejecutivo in integer)
RETURNS EMPLEADO_JEFE
LANGUAGE sql
AS $$  
 	SELECT * FROM EMPLEADO_JEFE WHERE id = id_director_ejecutivo AND tipo = 'director_ejecutivo' ; 
$$;
--
--
--select VER_DIRECTOR_EJECUTIVO(8);

--DROP FUNCTION VER_DIRECTOR_EJECUTIVO;

CREATE OR REPLACE FUNCTION VER_DIRECTORES_EJECUTIVOS ()
RETURNS setof EMPLEADO_JEFE
LANGUAGE sql
AS $$  
 	SELECT * FROM EMPLEADO_JEFE WHERE tipo = 'director_ejecutivo' ; 
$$;
--
--
--select VER_DIRECTOR_EJECUTIVO(8);




-- DROP PROCEDURE IF EXISTS CREAR_DIRECTOR_EJECUTIVO CASCADE;


CREATE OR REPLACE PROCEDURE CREAR_DIRECTOR_EJECUTIVO (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_ejecutivo';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO CREAR_DIRECTOR_EJECUTIVO ( % ) ------', NOW();
	

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
		null 

	) RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR EJECUTIVO CREADO CON EXITO!';
   RAISE INFO 'Datos del director ejecutivo: %', empleado_jefe_reg ; 



END $$;


-- CALL CREAR_DIRECTOR_EJECUTIVO('nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_DIRECTOR_EJECUTIVO (id_director_ejecutivo IN INTEGER)
LANGUAGE plpgsql
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_ejecutivo';

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO ELIMINAR_DIRECTOR_EJECUTIVO ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_director_ejecutivo;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != tipo_va) THEN
		RAISE INFO 'El empleado no es un director ejecutivo';
		RAISE EXCEPTION 'El empleado no es un director ejecutivo';
	END IF;

	UPDATE oficina_principal SET fk_director_ejecutivo = null WHERE fk_director_ejecutivo = id_director_ejecutivo;
	UPDATE empleado_jefe SET fk_empleado_jefe = null WHERE fk_empleado_jefe = id_director_ejecutivo;

	DELETE FROM EMPLEADO_JEFE WHERE id = id_director_ejecutivo; 
	
   RAISE INFO 'DIRECTOR EJECUTIVO ELIMINADO CON EXITO!';
 

END $$;



-- CALL eliminar_director_ejecutivo(5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ACTUALIZAR_DIRECTOR_EJECUTIVO (id_director_ejecutivo IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	tipo_va EMPLEADO_JEFE.tipo%TYPE := 'director_ejecutivo';


BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO ACTUALIZAR_DIRECTOR_EJECUTIVO ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_director_ejecutivo;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != tipo_va) THEN
		RAISE INFO 'El empleado no es un director ejecutivo';
		RAISE EXCEPTION 'El empleado no es un director ejecutivo';
	END IF;
	

	-------------////////
	
	UPDATE EMPLEADO_JEFE SET 
	
		primer_nombre = primer_nombre_va,
		segundo_nombre = segundo_nombre_va, 
		primer_apellido = primer_apellido_va,  
		segundo_apellido = segundo_apellido_va, 
		telefono = telefono_va

	WHERE id = id_director_ejecutivo
	RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR EJECUTIVO ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del director ejecutivo: %', empleado_jefe_reg ; 



END $$;


-- CALL actualizar_director_ejecutivo (2,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- SELECT * FROM empleado_jefe ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------

CREATE OR REPLACE PROCEDURE CAMBIAR_ROL_EMPLEADO (id_empleado IN integer, id_jefe in integer, cargo in integer)
LANGUAGE plpgsql
AS $$  
DECLARE

	empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;


BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMIENTO CAMBIAR_ROL_EMPLEADO ( % ) ------', NOW();
	

    SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_empleado;

    IF (empleado_jefe_reg IS NULL) THEN
        RAISE INFO 'El empleado no existe';
        RAISE EXCEPTION 'El empleado no existe';
    END IF;


	-------------////////
	
	UPDATE EMPLEADO_JEFE SET 
	
		primer_nombre = primer_nombre_va,
		segundo_nombre = segundo_nombre_va, 
		primer_apellido = primer_apellido_va,  
		segundo_apellido = segundo_apellido_va, 
		telefono = telefono_va,
        tipo = cargo,
        fk_empleado_jefe = id_jefe
        
	WHERE id = id_empleado
	RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'DIRECTOR EJECUTIVO ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del director ejecutivo: %', empleado_jefe_reg ; 

END $$;





--------------------------//////////////////////////-------------------------\\

-------------------------//////////////---------------------------------------------//////////////--------------------


CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_EMPLEADO_CONFIDENTE (id_empleado_acceso in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_empleado_jefe_confidente = id_empleado_acceso; 
$$;

-- SELECT * FROM VER_LISTA_INFORMANTES_EMPLEADO_CONFIDENTE(11);

