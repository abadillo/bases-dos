

CREATE OR REPLACE PROCEDURE CREAR_PERSONAL_INTELIGENCIA (

    primer_nombre_va IN PERSONAL_INTELIGENCIA.primer_nombre%TYPE, 
    segundo_nombre_va IN PERSONAL_INTELIGENCIA.segundo_nombre%TYPE, 
    primer_apellido_va IN PERSONAL_INTELIGENCIA.primer_apellido%TYPE, 
    segundo_apellido_va IN PERSONAL_INTELIGENCIA.segundo_apellido%TYPE, 
    fecha_nacimiento_va IN PERSONAL_INTELIGENCIA.fecha_nacimiento%TYPE, 
    altura_cm_va IN PERSONAL_INTELIGENCIA.altura_cm%TYPE, 
    peso_kg_va IN PERSONAL_INTELIGENCIA.peso_kg%TYPE, 
    color_ojos_va IN PERSONAL_INTELIGENCIA.color_ojos%TYPE, 
    vision_va IN PERSONAL_INTELIGENCIA.vision%TYPE, 
    class_seguridad_va IN PERSONAL_INTELIGENCIA.class_seguridad%TYPE, 

    fotografia_va IN PERSONAL_INTELIGENCIA.fotografia%TYPE, 
    huella_retina_va IN PERSONAL_INTELIGENCIA.huella_retina%TYPE, 
    huella_digital_va IN PERSONAL_INTELIGENCIA.huella_digital%TYPE, 

    telefono_va IN PERSONAL_INTELIGENCIA.telefono%TYPE, 
    licencia_manejo_va IN PERSONAL_INTELIGENCIA.licencia_manejo%TYPE,

    idiomas_va IN PERSONAL_INTELIGENCIA.idiomas%TYPE, 
    familiar_1_va IN familiar_ty, 
    familiar_2_va IN familiar_ty, 
    
    identificacion_1_va IN identificacion_ty, 
    
    nivel_educativo_1_va IN nivel_educativo_ty, 

    id_ciudad IN PERSONAL_INTELIGENCIA.fk_lugar_ciudad%TYPE
)
LANGUAGE plpgsql
AS $$  
DECLARE

    personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_PERSONAL_INTELIGENCIA ( % ) ------', NOW();
	

	-------------////////
	
	INSERT INTO PERSONAL_INTELIGENCIA (
		
        primer_nombre,
        segundo_nombre,
        primer_apellido,
        segundo_apellido,
        fecha_nacimiento,
        altura_cm,
        peso_kg,
        color_ojos,
        vision,
        class_seguridad,
        fotografia,
        huella_retina,
        huella_digital,
        telefono,
        licencia_manejo,
        idiomas,
        familiares,
        identificaciones,
        nivel_educativo,

        fk_lugar_ciudad
	
	) VALUES (
		primer_nombre_va,
        segundo_nombre_va,
        primer_apellido_va,
        segundo_apellido_va,
        fecha_nacimiento_va,
        altura_cm_va,
        peso_kg_va,
        color_ojos_va,
        vision_va,
        class_seguridad_va,

        fotografia_va,
        huella_retina_va,
        huella_digital_va,

        telefono_va,
        licencia_manejo_va,

        idiomas_va,
        ARRAY [ familiar_1_va, familiar_2_va ],
       
        ARRAY [ identificacion_1_va ],
    
        ARRAY [ nivel_educativo_1_va ],
        id_ciudad

	) RETURNING * INTO personal_inteligencia_reg;

   RAISE INFO 'PERSONAL DE INTELIGENCIA CREADO CON EXITO!';
   RAISE INFO 'Datos del personal de inteligencia: %', personal_inteligencia_reg ; 

END $$;


-- CALL CREAR_PERSONAL_INTELIGENCIA (
--     'nombre1',
--     'nombre2',
--     'apellido1',
--     'apellido2',
-- 	'1995-03-09',
--     165, 
--     70,
--     'negro',
--     '20/20',
--     'no_clasificado',
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),
--     FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),
--     CREAR_TELEFONO(0212,2847268),
--     CREAR_LICENCIA('021390213','Argentina'),
--     CREAR_ARRAY_IDIOMAS('español','italiano','chino','portugués',null,null),
--     CREAR_FAMILIAR ('Gabriel','alberto,','manrique','ulacio','1960-06-01','tio',0414,0176620),
--     CREAR_FAMILIAR ('familiarn2','familiarn2,','familiara2','familiara2','1980-07-01','primo',0416,7876620),
--     CREAR_IDENTIFICACION('0213120431','Australia'),
--     CREAR_NIVEL_EDUCATIVO('Economía', 'Master', 'Finanzas'),
-- 	20
-- );

-- select * from personal_inteligencia;

-- -- 
-- select CREAR_NIVEL_EDUCATIVO('Economía', 'Master', 'Finanzas');
-- select CREAR_IDENTIFICACION('0213120431','Australia');
-- SELECT CREAR_FAMILIAR ('Gabriel','alberto,','manrique','ulacio','1960-06-01','tio',0414,0176620);
-- SELECT CREAR_LICENCIA('1233992432','Uganda');
-- SELECT CREAR_TELEFONO(0212,20121312);


CREATE OR REPLACE PROCEDURE ELIMINAR_PERSONAL_INTELIGENCIA (id_empleado_acceso IN INTEGER, id_personal_inteligencia IN INTEGER)
LANGUAGE plpgsql
AS $$  
DECLARE

	personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;
    empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

	numero_hist_cargo_dep integer;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_PERSONAL_INTELIGENCIA ( % ) ------', NOW();
	
	-------------////////

    SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia;

	IF (personal_inteligencia_reg IS NULL) THEN
		RAISE INFO 'El personal de inteligencia no existe';
		RAISE EXCEPTION 'El personal de inteligencia no existe';
	END IF;

    -------------////////

	SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_empleado_acceso;

	IF (empleado_jefe_reg IS NULL) THEN
		RAISE INFO 'El empleado no existe';
		RAISE EXCEPTION 'El empleado no existe';
	END IF;

	IF (empleado_jefe_reg.tipo != 'jefe') THEN
		RAISE INFO 'El empleado no es un jefe de estacion';
		RAISE EXCEPTION 'El empleado no es un jefe de estacion';
	END IF;


	SELECT count(*) INTO numero_hist_cargo_dep FROM HIST_CARGO WHERE id_personal_inteligencia = fk_personal_inteligencia;

	IF ( numero_hist_cargo_dep > 0 ) THEN

		RAISE EXCEPTION 'No se puede eliminar al personal de inteligencia ya algunos registros dependen de el';
	END IF;


	DELETE FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia; 
	
    RAISE INFO 'PERSONAL DE INTELIGENCIA ELIMINADO CON EXITO!';
 

END $$;






-------------------------//////////////---------------------------------------------//////////////--------------------

CREATE OR REPLACE FUNCTION VER_TODOS_PERSONAL_INTELIGENCIA_SIN_CARGO ()
RETURNS setof PERSONAL_INTELIGENCIA
LANGUAGE sql
AS $$  
 	
    SELECT * FROM PERSONAL_INTELIGENCIA WHERE id NOT IN (SELECT fk_personal_inteligencia FROM HIST_CARGO); 
$$;


CREATE OR REPLACE FUNCTION VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO (id_empleado_acceso in integer)
RETURNS setof PERSONAL_INTELIGENCIA
LANGUAGE sql
AS $$  
 	
    SELECT * FROM PERSONAL_INTELIGENCIA WHERE id IN (SELECT fk_personal_inteligencia FROM HIST_CARGO WHERE fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso)); 
$$;



CREATE OR REPLACE FUNCTION VER_PERSONAL_INTELIGENCIA_SIN_CARGO (id_personal_inteligencia in integer)
RETURNS PERSONAL_INTELIGENCIA
LANGUAGE sql
AS $$  
 	
    SELECT * FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia AND id NOT IN (SELECT fk_personal_inteligencia FROM HIST_CARGO); 
$$;


CREATE OR REPLACE FUNCTION VER_PERSONAL_INTELIGENCIA_CON_CARGO (id_empleado_acceso in integer, id_personal_inteligencia in integer)
RETURNS PERSONAL_INTELIGENCIA
LANGUAGE sql
AS $$  
 	
    SELECT * FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia AND id IN (SELECT fk_personal_inteligencia FROM HIST_CARGO WHERE fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso)); 
$$;





CREATE OR REPLACE FUNCTION VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia in integer)
RETURNS setof HIST_CARGO
LANGUAGE sql
AS $$  
 	
    SELECT * FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso); 
$$;


-- SELECT * FROM VER_TODOS_PERSONAL_INTELIGENCIA_SIN_CARGO();
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20,37);
-- SELECT * FROM VER_PERSONAL_INTELIGENCIA_SIN_CARGO(109);



-------------------------//////////////---------------------------------------------//////////////--------------------


CREATE OR REPLACE FUNCTION VER_CUENTA_ESTACION (id_empleado_acceso in integer, id_estacion in INTEGER)
RETURNS setof CUENTA
LANGUAGE sql
AS $$  
 	
    SELECT * FROM CUENTA WHERE fk_estacion = id_estacion AND fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso); 
$$;

-- SELECT * FROM VER_CUENTA_ESTACION(12,4);
-- SELECT * FROM estacion;



-------------------------//////////////---------------------------------------------//////////////--------------------


CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_EMPLEADO_CONFIDENTE (id_empleado_acceso in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_empleado_jefe_confidente = id_empleado_acceso; 
$$;

-- SELECT * FROM VER_LISTA_INFORMANTES_EMPLEADO_CONFIDENTE(11);


CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_personal_inteligencia_confidente = id_personal_inteligencia; 
$$;

-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE(11);

-- SELECT * from informante;




-------------------------//////////////---------------------------------------------//////////////--------------------





-- DROP PROCEDURE IF EXISTS CERRAR_HIST_CARGO CASCADE;

CREATE OR REPLACE PROCEDURE CERRAR_HIST_CARGO (id_empleado_acceso in integer, id_personal_inteligencia IN integer)
LANGUAGE plpgsql
AS $$  
DECLARE

   hist_cargo_actual_reg HIST_CARGO%ROWTYPE;
   
   fecha_hoy_va timestamp;
  
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERRAR_HIST_CARGO ( % ) ------', NOW();
	
	-------------///////////--------------	
   
   	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL AND fk_estacion IN ( SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso); 
   	RAISE INFO 'datos de hist_cargo actual: %', hist_cargo_actual_reg;

   --------

   	IF (hist_cargo_actual_reg IS NULL) THEN
   		RAISE INFO 'El personal de inteligencia que ingresó no existe, ya no trabaja en AII o no le pertenece';
  		RAISE EXCEPTION 'El personal de inteligencia que ingresó no existe, ya no trabaja en AII o no le pertenece';
   	END IF;   	
  	
	fecha_hoy_va = NOW();

	UPDATE HIST_CARGO SET fecha_fin = fecha_hoy_va WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL;
		
	RAISE INFO 'CARGO CERRADO CON EXITO!';
 	

END $$;


-- SELECT * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(20);
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20, 37);
-- CALL CERRAR_HIST_CARGO(20,37);



-------------------------//////////////---------------------------------------------//////////////--------------------






-- DROP PROCEDURE IF EXISTS ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO CASCADE;

CREATE OR REPLACE PROCEDURE ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO (id_empleado_acceso in integer, id_personal_inteligencia IN integer, id_estacion in integer, cargo_va IN HIST_CARGO.cargo%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

    hist_cargo_actual_reg HIST_CARGO%ROWTYPE;
    hist_cargo_nuevo_reg HIST_CARGO%ROWTYPE;

    estacion_nueva_reg ESTACION%ROWTYPE;
    estacion_vieja_reg ESTACION%ROWTYPE;

    fecha_hoy_va timestamp;
  
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERRAR_HIST_CARGO ( % ) ------', NOW();
	
	-------------///////////--------------	

    SELECT * INTO estacion_nueva_reg FROM ESTACION WHERE id = id_estacion; 
   	RAISE INFO 'Datos de la estacion nueva: %', estacion_nueva_reg;

    IF (estacion_nueva_reg IS NULL) THEN
        RAISE EXCEPTION 'La estacion nueva no existe';
    END IF;


   	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia ORDER BY fecha_inicio DESC LIMIT 1; 
   	RAISE INFO 'Datos de hist_cargo actual: %', hist_cargo_actual_reg;

   
   	IF (hist_cargo_actual_reg.fk_personal_inteligencia IS NOT NULL) THEN
   		
        IF (hist_cargo_actual_reg.fecha_fin IS NULL) THEN
            RAISE EXCEPTION 'Debe cerrar el cargo antes de poder hacer una tranferencia de estacion';   
        END IF;

        SELECT * INTO estacion_vieja_reg FROM ESTACION WHERE id = hist_cargo_actual_reg.fk_estacion; 
   	    RAISE INFO 'Datos de la estacion vieja: %', estacion_vieja_reg;

        IF (estacion_vieja_reg IS NULL) THEN
            RAISE EXCEPTION 'La estacion vieja no existe';
        END IF;

        IF (estacion_vieja_reg.id = estacion_nueva_reg.id) THEN
            RAISE EXCEPTION 'No se puede cambiar a la misma estacion';
        END IF;

    END IF;   	

    

    IF (id_empleado_acceso != estacion_nueva_reg.fk_empleado_jefe AND (estacion_vieja_reg IS NOT NULL AND id_empleado_acceso != estacion_vieja_reg.fk_empleado_jefe)) THEN
        RAISE EXCEPTION 'El jefe tiene que ser dueño de la estacion nueva, o en caso de ser una tranferencia, dueño de la vieja o de la nueva';
    END IF;  

    
    --------

	fecha_hoy_va = NOW();


	INSERT INTO HIST_CARGO (
		fecha_inicio,
		cargo,
		fk_personal_inteligencia,
		fk_estacion,
		fk_oficina_principal
	) VALUES (
		fecha_hoy_va,
		cargo_va,
		id_personal_inteligencia,
		estacion_nueva_reg.id,
		estacion_nueva_reg.fk_oficina_principal
	);


	RAISE INFO 'PERSONAL DE INTELIGENCIA FUE ASIGNADO EXITOSAMENTE A LA ESTACION!';
 	

END $$;


-- SELECT * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(20);
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20, 37);
-- CALL CERRAR_HIST_CARGO(20,37);




-- select * FROM VER_TODOS_PERSONAL_INTELIGENCIA_SIN_CARGO();
-- select * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(20);
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20,37);

-- CALL cerrar_hist_cargo(20, 109); 
-- CALL ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO(20,109,10,'analista');

-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20,109);


-- select * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(21);
-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(21,109);
-- CALL cerrar_hist_cargo(21, 109); 

-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(20,109);

