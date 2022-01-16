--Control_accesos_no_autorizados (2) (comparar clasificación del empleado y de la pieza, validar que el empleado está activo 
--si es agente o analista y si no tiene el permiso registrar el intento en la tabla correspondiente (generar id, fecha=sysdate,
--idemp que se comparó, idpieza que se comparó y jefe que corresponda)  – FALTA

---------------/-/-/-/-/-/-/-/-//////////////////--/-/-/-/-/-/-/-/-------------------------------
--
--
----DROP FUNCTION IF EXISTS VALIDAR_ACCESO_PIEZA CASCADE;
----DROP PROCEDURE IF EXISTS VALIDAR_ACCESO_PIEZA CASCADE;
--
--
CREATE OR REPLACE PROCEDURE VALIDAR_ACCESO_PIEZA (id_pieza IN integer, id_personal_inteligencia IN integer)
--RETURNS boolean
LANGUAGE plpgsql
AS $$  
DECLARE

    pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
   	
    personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;
   	hist_cargo_reg HIST_CARGO%ROWTYPE;
   
    id_empleado_va integer;
	
	fecha_hora_va INTENTO_NO_AUTORIZADO.fecha_hora%TYPE;

BEGIN 
	
--	COMMIT;

	fecha_hora_va = NOW();

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DE LA FUNCION VALIDAR_ACESSO_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	

    SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia;
    RAISE INFO 'datos de persona inteligencia: %', personal_inteligencia_reg;
   
   	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo: %', hist_cargo_reg;

   --------
    
	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
	-- RAISE INFO 'dato de la pieza: %', pieza_reg ; 



   	IF (hist_cargo_reg IS NULL OR personal_inteligencia_reg IS NULL) THEN
   		RAISE INFO 'El personal inteligencia que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El personal inteligencia que ingresó no existe o ya no trabaja en AII';
   	END IF;   	

	IF (pieza_reg IS NULL) THEN
   		RAISE INFO 'La pieza que ingresó no exite';
  		RAISE EXCEPTION 'La pieza que ingresó no exite';
   	END IF;  

	


    IF (personal_inteligencia_reg.class_seguridad = 'top_secret') THEN 
--        RETURN true;
    	RAISE INFO 'bien';
    END IF;

    IF (personal_inteligencia_reg.class_seguridad = 'confidencial' AND (pieza_reg.class_seguridad = 'confidencial' OR pieza_reg.class_seguridad = 'no_clasificado')) THEN
--        RETURN true;
    	RAISE INFO 'bien';
    END IF;

    IF (personal_inteligencia_reg.class_seguridad = 'no_clasificado' AND pieza_reg.class_seguridad = 'no_clasificado') THEN
--        RETURN true;
   		RAISE INFO 'bien';
    END IF;

   
    RAISE INFO 'ACCESO DENEGADO A LA PIEZA. ESTA ACCIÓN SERÁ NOTIFICADA';

 	------///- 
   
   	SELECT fk_empleado_jefe INTO id_empleado_va FROM ESTACION WHERE id = hist_cargo_reg.fk_estacion ; 
   	RAISE INFO 'id del jefe de la estacion del personal inteligencia: %', id_empleado_va;
   
    INSERT INTO INTENTO_NO_AUTORIZADO (
        fecha_hora,
        id_pieza,
        id_empleado,
        fk_personal_inteligencia
    ) VALUES (
        fecha_hora_va,
        id_pieza,
        id_empleado_va,
        hist_cargo_reg.fk_personal_inteligencia
    );
	
   	COMMIT;
   
    RAISE EXCEPTION 'ACCESO DENEGADO A LA PIEZA. ESTA ACCIÓN SERÁ NOTIFICADA';
--    RETURN false;


END $$;






--
--
--
---- PRUEBAS
--
--SELECT * FROM intento_no_autorizado ina order by fecha_hora desc;
--
--
---- 2, confidencial
--select id, class_seguridad from pieza_inteligencia pi2 where id = 2 ;
--
---- 2, no clasificado 
--select id, fecha_inicio, fecha_fin, class_seguridad from hist_cargo hc, personal_inteligencia p where fk_personal_inteligencia = 2 and fk_personal_inteligencia = p.id;
--
--SELECT VALIDAR_ACCESO_PIEZA(2,2);
--
----- // -- 
--
---- 5, top_secret
--select id, class_seguridad from pieza_inteligencia pi2 where id = 5 ;
--
---- 2, no clasificado 
--select id, fecha_inicio, fecha_fin, class_seguridad from hist_cargo hc, personal_inteligencia p where fk_personal_inteligencia = 2 and fk_personal_inteligencia = p.id;
--
--SELECT VALIDAR_ACCESO_PIEZA(5,2);
--
----- // -- 
--
---- 5, top_secret
--select id, class_seguridad from pieza_inteligencia pi2 where id = 5 ;
--
---- 2, top_secret 
--select id, fecha_inicio, fecha_fin, class_seguridad from hist_cargo hc, personal_inteligencia p where fk_personal_inteligencia = 13 and fk_personal_inteligencia = p.id;
--
--SELECT VALIDAR_ACCESO_PIEZA(5,13);
--
----- // -- 
--
---- 2, confidencia
--select id, class_seguridad from pieza_inteligencia pi2 where id = 2 ;
--
---- 13, top_secret
--select id, fecha_inicio, fecha_fin, class_seguridad from hist_cargo hc, personal_inteligencia p where fk_personal_inteligencia = 13 and fk_personal_inteligencia = p.id;
--
-- SELECT VALIDAR_ACCESO_PIEZA(2,13);
--
----- // -- 


--COMMIT;
--SELECT VALIDAR_ACCESO_PIEZA(2,11);




---------------/-/-/-/-/-/-/-/-//////////////////--/-/-/-/-/-/-/-/-------------------------------



DROP FUNCTION IF EXISTS VER_DATOS_PIEZA CASCADE;


CREATE OR REPLACE FUNCTION VER_DATOS_PIEZA (id_pieza IN integer, id_personal_inteligencia IN integer)
RETURNS setof PIEZA_INTELIGENCIA
LANGUAGE plpgsql
AS $$  
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
   	
    personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;
   	hist_cargo_reg HIST_CARGO%ROWTYPE;
   
    id_empleado_va integer;
	
	fecha_hora_va INTENTO_NO_AUTORIZADO.fecha_hora%TYPE;

BEGIN 

	fecha_hora_va = NOW();

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DE LA FUNCION VER_DATOS_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	

    SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia;
    RAISE INFO 'datos de persona inteligencia: %', personal_inteligencia_reg;
   
   	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo: %', hist_cargo_reg;

   --------
    
	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
	-- RAISE INFO 'dato de la pieza: %', pieza_reg ; 



   	IF (hist_cargo_reg IS NULL OR personal_inteligencia_reg IS NULL) THEN
   		RAISE INFO 'El personal inteligencia que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El personal inteligencia que ingresó no existe o ya no trabaja en AII';
   	END IF;   	

	IF (pieza_reg IS NULL) THEN
   		RAISE INFO 'La pieza que ingresó no exite';
  		RAISE EXCEPTION 'La pieza que ingresó no exite';
   	END IF;  

	
    IF (personal_inteligencia_reg.class_seguridad = 'top_secret') THEN 
        RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    END IF;

    IF (personal_inteligencia_reg.class_seguridad = 'confidencial' AND (pieza_reg.class_seguridad = 'confidencial' OR pieza_reg.class_seguridad = 'no_clasificado')) THEN
       RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    END IF;

    IF (personal_inteligencia_reg.class_seguridad = 'no_clasificado' AND pieza_reg.class_seguridad = 'no_clasificado') THEN
        RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    END IF;

   
--    RAISE INFO 'ACCESO DENEGADO A LA PIEZA. ESTA ACCIÓN SERÁ NOTIFICADA';
   
 	------///- 
   
   	SELECT fk_empleado_jefe INTO id_empleado_va FROM ESTACION WHERE id = hist_cargo_reg.fk_estacion ; 
   	RAISE INFO 'id del jefe de la estacion del personal inteligencia: %', id_empleado_va;
   
    INSERT INTO INTENTO_NO_AUTORIZADO (
        fecha_hora,
        id_pieza,
        id_empleado,
        fk_personal_inteligencia
    ) VALUES (
        fecha_hora_va,
        id_pieza,
        id_empleado_va,
        hist_cargo_reg.fk_personal_inteligencia
    );
	
	
--	RAISE INFO ' ';
--	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO VER_DATOS_PIEZA ( % ) ------', NOW();
--	
--	IF (VALIDAR_ACCESO_PIEZA(id_pieza, id_personal_inteligencia) = TRUE) THEN 
--		
--		RAISE INFO 'ACCESO CONCEBIDO';
--	
--		RETURN QUERY 
--			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
--	
--	ELSE
--		
--		RAISE INFO 'NO TIENE ACCESO A LA PIEZA. ESTA ACCIÓN SERÁ NOTIFICADA';
--		RAISE EXCEPTION 'NO TIENE ACCESO A LA PIEZA. ESTA ACCIÓN SERÁ NOTIFICADA';
--	
--	END IF;
   
END $$;

--
--SELECT VER_DATOS_PIEZA(2,11);
--SELECT id_pieza,fk_personal_inteligencia FROM intento_no_autorizado ina order by fecha_hora desc;


