
CREATE OR REPLACE PROCEDURE CREAR_TEMA (nombre_va varchar, descripcion_va varchar, topico_va varchar)
LANGUAGE PLPGSQL
AS $$

BEGIN
	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_LUGAR ( % ) ------', NOW();
	
	INSERT INTO clas_tema (
		nombre,
		descripcion,
		topico
	)	VALUES (
		nombre_va,
		descripcion_va,
		topico_va		
		);

END;
$$;


CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA ( id_empleado_acceso in integer, id_personal_inteligencia in integer)
AS $$
DECLARE

	-- jefe_estacion_reg EMPLEADO_JEFE%ROWTYPE;
	hist_cargo_reg HIST_CARGO%ROWTYPE;
	-- estacion_reg ESTACION%ROWTYPE;

BEGIN

	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fecha_fin IS NULL AND fk_personal_inteligencia = id_personal_inteligencia AND fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso);

	IF (hist_cargo_reg IS NULL) THEN
		RAISE EXCEPTION 'No tiene acesso a esta informacion';
	END IF;
		

END;
$$ LANGUAGE plpgsql;


-- CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(15,17);
-- SELECT * FROM HIST_CARGO where fk_personal_inteligencia = 17;
-- SELECT * FROM VER_ESTACION(3,5);



-----------------------------////////////////////////-----------------------------------




CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_EMPLEADO_ESTACION ( id_empleado_acceso in integer, id_estacion in integer)
AS $$
DECLARE

	estacion_reg ESTACION%ROWTYPE;
    jefe_estacion_reg EMPLEADO_JEFE%ROWTYPE;

BEGIN

	SELECT * INTO jefe_estacion_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_acceso AND tipo = 'jefe';
	
	IF (jefe_estacion_reg IS NULL) THEN
		RAISE EXCEPTION 'El jefe no existe o no es un jefe';
	END IF;

	SELECT * INTO estacion_reg FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso AND id = id_estacion;

	IF (estacion_reg IS NULL) THEN
		RAISE EXCEPTION 'No tiene acesso a esta informacion';
	END IF;
		

END;
$$ LANGUAGE plpgsql;




-----------------------------////////////////////////-----------------------------------



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
--    RAISE INFO 'Datos del personal de inteligencia: %', personal_inteligencia_reg ; 

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


--------------------------------------------///////////////////////--------------------------------------



CREATE OR REPLACE PROCEDURE ACTUALIZAR_PERSONAL_INTELIGENCIA (
	id_empleado_acceso in integer,
	id_personal_inteligencia in integer,

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

	hist_cargo_reg hist_cargo%ROWTYPE;	
	-- empleado_jefe_reg empleado_jefe%ROWTYPE;
	

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_PERSONAL_INTELIGENCIA ( % ) ------', NOW();
	

	
	SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia;
	
	---VALIDACION SI EL TEMA ES NULO---		
	IF (personal_inteligencia_reg IS NULL) THEN
		
		RAISE EXCEPTION 'No existe el canalista';
	END IF;


	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fecha_fin IS NULL AND fk_personal_inteligencia = id_personal_inteligencia LIMIT 1;

	IF (hist_cargo_reg IS NOT NULL) THEN	
		
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, id_personal_inteligencia);


	END IF;

	-------------////////
	
	UPDATE PERSONAL_INTELIGENCIA SET
		
        primer_nombre = primer_nombre_va,
        segundo_nombre = segundo_nombre_va,
        primer_apellido = primer_apellido_va,
        segundo_apellido = segundo_apellido_va,
        fecha_nacimiento = fecha_nacimiento_va,
        altura_cm = altura_cm_va,
        peso_kg = peso_kg_va,
        color_ojos = color_ojos_va,
        vision = vision_va,
        class_seguridad = class_seguridad_va,
        fotografia = fotografia_va,
        huella_retina = huella_retina_va,
        huella_digital = huella_digital_va,
        telefono = telefono_va,
        licencia_manejo = licencia_manejo_va,
        idiomas = idiomas_va,
        familiares = ARRAY [ familiar_1_va, familiar_2_va ],
        identificaciones = ARRAY [identificacion_1_va ],
        nivel_educativo = ARRAY [nivel_educativo_1_va ],
        fk_lugar_ciudad = id_ciudad
	
	WHERE id = id_personal_inteligencia;
	-- RETURNING * INTO personal_inteligencia_reg;

   RAISE INFO 'PERSONAL DE INTELIGENCIA CREADO CON EXITO!';
--    RAISE INFO 'Datos del personal de inteligencia: %', personal_inteligencia_reg ; 

END $$;


-- CALL ACTUALIZAR_PERSONAL_INTELIGENCIA (
-- 	16,
-- 	21,
--     'nombrez',
--     'nombrez',
--     'apellidoz',
--     'apellidoz',
-- 	'1995-03-09',
--     170, 
--     80,
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


-- SELECT * FROM VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO(16);

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





------------------------------------------------------------//////////////////////////////------------------------------------------------------------






CREATE OR REPLACE PROCEDURE ASIGNAR_TEMA_ANALISTA (id_empleado_acceso integer, tema_id integer, analista_id integer)
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
		
	

	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fecha_fin IS NULL AND fk_personal_inteligencia = analista_id LIMIT 1;

	IF (hist_cargo_reg IS NOT NULL) THEN	
		
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, analista_id);

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

-- call ASIGNAR_TEMA_ANALISTA(16,2,21);
-- select * from TEMAS_ESP where fk_personal_inteligencia = 21 



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






------------------------------------------------///////////////////////-----------------------------------------------

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


CREATE OR REPLACE FUNCTION VER_CUENTA_ESTACION_JEFE_ESTACION (id_empleado_acceso in integer, id_estacion in INTEGER)
RETURNS setof CUENTA
LANGUAGE sql
AS $$  
 	
    SELECT * FROM CUENTA WHERE fk_estacion = id_estacion AND fk_estacion IN (SELECT id FROM ESTACION WHERE fk_empleado_jefe = id_empleado_acceso); 
$$;

-- SELECT * FROM VER_CUENTA_ESTACION(12,4);
-- SELECT * FROM estacion;




-------------------------------------/////////////////////--------------------------------------------




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


	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fecha_fin IS NULL AND fk_personal_inteligencia = id_personal_inteligencia;

	IF (hist_cargo_actual_reg IS NOT NULL) THEN	
		
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, analista_id);

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


---------------------------------------------////////////////////-----------------------------


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










------------------------------------------------------//////////////////////--------------------------------


-- DROP PROCEDURE IF EXISTS CAMBIAR_ROL CASCADE;

-- DROP FUNCTION IF EXISTS ELIMINACION_REGISTROS_VENTA_EXCLUSIVA CASCADE;

CREATE OR REPLACE PROCEDURE ELIMINACION_REGISTROS_INFORMANTE ( id_personal_inteligencia IN integer ) 
LANGUAGE PLPGSQL 
AS $$
DECLARE 

	id_crudos_asociados integer[] ;	
	-- id_informantes_asociados integer[] ;
	id_piezas_asociadas integer[];	

BEGIN 

	id_crudos_asociados := ARRAY( 
		SELECT id FROM CRUDO WHERE fk_personal_inteligencia_agente = id_personal_inteligencia AND fuente = 'secreta' OR fk_informante IS NOT NULL
	);

	DELETE FROM TRANSACCION_PAGO WHERE fk_informante IN (SELECT id FROM INFORMANTE WHERE fk_personal_inteligencia_encargado = id_personal_inteligencia);
--
	DELETE FROM ANALISTA_CRUDO WHERE fk_crudo = ANY(id_crudos_asociados);

	id_piezas_asociadas := ARRAY(
		SELECT fk_pieza_inteligencia FROM CRUDO_PIEZA WHERE fk_crudo = ANY(id_crudos_asociados)
	);


	DELETE FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = ANY(id_piezas_asociadas);

	DELETE FROM ADQUISICION WHERE fk_pieza_inteligencia = ANY(id_piezas_asociadas);

	DELETE FROM PIEZA_INTELIGENCIA WHERE id = ANY(id_piezas_asociadas);

	DELETE FROM CRUDO WHERE id = ANY(id_crudos_asociados);
--
	DELETE FROM INFORMANTE WHERE fk_personal_inteligencia_encargado = id_personal_inteligencia;

END $$;



-- CALL NUMERO_REGISTROS();   
-- SELECT fk_personal_inteligencia_encargado, count(*) FROM INFORMANTE GROUP BY fk_personal_inteligencia_encargado; 

-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE(13); 

-- select * from transaccion_pago tp  where fk_informante  = 7;
-- select * from crudo where fk_informante  = 7;
-- SELECT * FROM INFORMACION_INFORMANTES(7);

-- nombre_clave,agente_encargado,id_estacion,nombre_estacion,crudos,piezas,crudos_alt,piezas_alt,total_crudos,total_piezas,crudos_usados,eficacia
-- Traccion,13,4,Est. Amsterdam,1,8,0,0,1,8,1,100.0000

-- CALL ELIMINACION_REGISTROS_INFORMANTE(7);
-- SELECT * FROM INFORMACION_INFORMANTES(7);

-- select * from informante where 

-- select * from transaccion_pago tp  where fk_informante  = 19;
-- select * from crudo where fk_informante  = 19;
-- SELECT * FROM INFORMACION_INFORMANTES(19);


-- CALL ELIMINACION_REGISTROS_INFORMANTE(13);

-----------------------------//////////////////------------------------




CREATE OR REPLACE PROCEDURE DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia IN integer)
LANGUAGE plpgsql
AS $$  
DECLARE

   hist_cargo_actual_reg HIST_CARGO%ROWTYPE;
   
  
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA ( % ) ------', NOW();
	
	-------------///////////--------------	
	

   	SELECT * INTO hist_cargo_actual_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo actual: %', hist_cargo_actual_reg;

   --------

   	IF (hist_cargo_actual_reg IS NOT NULL) THEN
   			
		CALL VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA(id_empleado_acceso, id_personal_inteligencia);
		CALL CERRAR_HIST_CARGO(id_empleado_acceso,id_personal_inteligencia);

	END IF;

   
	CALL ELIMINACION_REGISTROS_INFORMANTE(id_personal_inteligencia);


	RAISE INFO 'DESPIDO / RENUNCIA EXITOSA!';
 	

END $$;










-- CALL CAMBIAR_ROL_PERSONAL_INTELIGENCIA(14,13,'agente');

-- SELECT * FROM VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA(14,13);

-- select * from hist_cargo where fk_personal_inteligencia = 1;

--
--CALL NUMERO_REGISTROS(); 
--
--CLIENTE_n: 20
--LUGAR_n: 38
--EMPLEADO_JEFE_n: 38
--OFICINA_PRINCIPAL_n: 10
--ESTACION_n: 27
--CUENTA_n: 81
--PERSONAL_INTELIGENCIA_n: 102
--INTENTO_NO_AUTORIZADO_n: 10
--CLAS_TEMA_n: 9
--AREA_INTERES_n: 20
--TEMAS_ESP_n: 0
--HIST_CARGO_n: 204
--INFORMANTE_n: 21
--TRANSACCION_PAGO_n: 0
--CRUDO_n: 6
--ANALISTA_CRUDO_n: 13
--PIEZA_INTELIGENCIA_n: 17
--CRUDO_PIEZA_n: 48
--ADQUISICION_n: 20
--HIST_CARGO_ALT_n: 0
--INFORMANTE_ALT_n: 0
--TRANSACCION_PAGO_ALT_n: 12
--CRUDO_ALT_n: 23
--ANALISTA_CRUDO_ALT_n: 51
--PIEZA_INTELIGENCIA_ALT_n: 10
--CRUDO_PIEZA_ALT_n: 23
--ADQUISICION_ALT_n: 10
-- TOTAL 813 
-- 
--CALL DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA(14,15);
--CALL NUMERO_REGISTROS();
--CLIENTE_n: 20
--LUGAR_n: 38
--EMPLEADO_JEFE_n: 38
--OFICINA_PRINCIPAL_n: 10
--ESTACION_n: 27
--CUENTA_n: 81
--PERSONAL_INTELIGENCIA_n: 102
--INTENTO_NO_AUTORIZADO_n: 10
--CLAS_TEMA_n: 9
--AREA_INTERES_n: 20
--TEMAS_ESP_n: 0
--HIST_CARGO_n: 204
--INFORMANTE_n: 19
--TRANSACCION_PAGO_n: 0
--CRUDO_n: 2
--ANALISTA_CRUDO_n: 5
--PIEZA_INTELIGENCIA_n: 0
--CRUDO_PIEZA_n: 0
--ADQUISICION_n: 0
--HIST_CARGO_ALT_n: 0
--INFORMANTE_ALT_n: 2
--TRANSACCION_PAGO_ALT_n: 12
--CRUDO_ALT_n: 27
--ANALISTA_CRUDO_ALT_n: 59
--PIEZA_INTELIGENCIA_ALT_n: 27
--CRUDO_PIEZA_ALT_n: 71
--ADQUISICION_ALT_n: 30
-- TOTAL 813 
--
-- 
--CALL DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA(10,7);
--CALL NUMERO_REGISTROS();
--
--
--CLIENTE_n: 20
--LUGAR_n: 38
--EMPLEADO_JEFE_n: 38
--OFICINA_PRINCIPAL_n: 10
--ESTACION_n: 27
--CUENTA_n: 81
--PERSONAL_INTELIGENCIA_n: 102
--INTENTO_NO_AUTORIZADO_n: 10
--CLAS_TEMA_n: 9
--AREA_INTERES_n: 20
--TEMAS_ESP_n: 0
--HIST_CARGO_n: 204
--INFORMANTE_n: 17
--TRANSACCION_PAGO_n: 0
--CRUDO_n: 2
--ANALISTA_CRUDO_n: 5
--PIEZA_INTELIGENCIA_n: 0
--CRUDO_PIEZA_n: 0
--ADQUISICION_n: 0
--HIST_CARGO_ALT_n: 0
--INFORMANTE_ALT_n: 4
--TRANSACCION_PAGO_ALT_n: 12
--CRUDO_ALT_n: 27
--ANALISTA_CRUDO_ALT_n: 59
--PIEZA_INTELIGENCIA_ALT_n: 27
--CRUDO_PIEZA_ALT_n: 71
--ADQUISICION_ALT_n: 30
-- TOTAL 813 


