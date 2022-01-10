-- DROP FUNCTION IF EXISTS NUMERO_ANALISTAS_VERIFICAN_CRUDO CASCADE;

-- CREATE OR REPLACE FUNCTION NUMERO_ANALISTAS_VERIFICAN_CRUDO ( id_crudo IN integer ) 
-- RETURNS integer
-- LANGUAGE PLPGSQL 
-- AS $$
-- DECLARE 

-- 	numero_analistas_va integer;	

-- BEGIN 
	
-- 	SELECT count(*) INTO numero_analistas_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;
	
-- 	RETURN numero_analistas_va;
	
-- END $$;


-- -------------////////.........^^^^^^^^^^^^^^^^^^^^^..........\\\\\\\\\\-------------



-- DROP FUNCTION IF EXISTS ANALISTA_VERIFICO_CRUDO CASCADE;

-- CREATE OR REPLACE FUNCTION ANALISTA_VERIFICO_CRUDO ( id_crudo IN integer, id_analista IN integer ) 
-- RETURNS boolean
-- LANGUAGE PLPGSQL 
-- AS $$
-- DECLARE 

-- 	registro record;

-- BEGIN 
	
-- 	SELECT * INTO registro FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo AND fk_personal_inteligencia_analista = id_analista;
	
-- 	IF (registro IS NULL) THEN
-- 		RETURN false;
-- 	END IF;

-- 	RETURN true;
	
-- END $$;




--------------------------///////////////////////-----------------------------


-- Demostración de la implementación de los requerimientos del sistema de bases de datos 
-- transaccional referidos al proceso de venta de piezas – actividades de recolección y 
-- verificación de hechos crudos y manejo de informantes, incluyendo la seguridad correspondiente 
-- (roles, cuentas con privilegios para poder ejecutar los programas y reportes).


-- Verificación_Hechos_Crudos (3) - elegir analistas, definir rango de tiempo para cargar 
-- confiabilidades, pedir nivel a asignar por analista, guardar y calcular promedio, actualizar 
-- el hecho crudo con la fecha final y el promedio calculado. Aplicando todas las validaciones
-- necesarias sobre cada paso…

--------------------------///////////////////////-----------------------------





-- DROP PROCEDURE IF EXISTS REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA CASCADE;


-- CREATE OR REPLACE PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (id_analista_encargado IN integer, descripcion IN PIEZA_INTELIGENCIA.descripcion%TYPE, id_crudo_base IN integer)
-- LANGUAGE plpgsql
-- AS $$  
-- DECLARE

-- 	id_pieza integer;

--     fecha_creacion_va PIEZA_INTELIGENCIA.fecha_creacion%TYPE;
--     class_seguridad_va PIEZA_INTELIGENCIA.class_seguridad%TYPE;

--     analista_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
--    	hist_cargo_reg HIST_CARGO%ROWTYPE;
-- 	crudo_base_reg CRUDO%ROWTYPE;
     
--     pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;

-- BEGIN 

-- 	RAISE INFO ' ';
-- 	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA ( % ) ------', NOW();
	
-- 	-------------///////////--------------	


--     SELECT * INTO analista_encargado_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_analista_encargado;
--     RAISE INFO 'datos de persona inteligencia: %', analista_encargado_reg;
   
--    	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista_encargado AND fecha_fin IS NULL; 
--    	RAISE INFO 'datos de hist_cargo: %', hist_cargo_reg;

-- 	SELECT * INTO crudo_base_reg FROM CRUDO WHERE id = id_crudo_base;
--     RAISE INFO 'datos del crudo base: %', crudo_base_reg;
    
--    --------

--    	IF (hist_cargo_reg IS NULL) THEN
--    		RAISE INFO 'El analista que ingresó no existe o ya no trabaja en AII';
--   		RAISE EXCEPTION 'El analista que ingresó no existe o ya no trabaja en AII';
--    	END IF;   	
  	
   
-- 	IF (hist_cargo_reg.cargo != 'analista') THEN
-- 		RAISE INFO 'El analista que ingresó no es un analista en su cargo actual';
-- 		RAISE EXCEPTION 'El analista que ingresó no es un analista en su cargo actual';
-- 	END IF;

-- 	IF (crudo_base_reg IS NULL) THEN
--    		RAISE INFO 'El crudo que ingresó no está registrado o no cumple con los requerimientos necesarios';
--   		RAISE EXCEPTION 'El crudo que ingresó no está registrado o no cumple con los requerimientos necesarios';
--    	END IF;   	
  
--    	IF (NUMERO_ANALISTAS_VERIFICAN_CRUDO(id_crudo_base) = 0) THEN
--    		RAISE INFO 'El crudo que ingresó no ha sido verificado';
--   		RAISE EXCEPTION 'El crudo que ingresó no ha sido verificado';
--    	END IF;   	

-- 	IF (ANALISTA_VERIFICO_CRUDO(id_crudo_base, id_analista_encargado) = true) THEN
--    		RAISE INFO 'La pieza no puede tener ningun crudo verificado por el analista encargado';
--   		RAISE EXCEPTION 'La pieza no puede tener ningun crudo verificado por el analista encargado';
--    	END IF; 

-- 	IF (hist_cargo_reg.fk_estacion != crudo_base_reg.fk_estacion_pertenece) THEN
-- 		RAISE INFO 'El analista no pertenece a la misma estación que el crudo';
--   		RAISE EXCEPTION 'El analista no pertenece a la misma estación que el crudo';
-- 	END IF;

--    	IF (crudo_base_reg.nivel_confiabilidad_final <= 85 ) THEN
--    		RAISE INFO 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 )';
--   		RAISE EXCEPTION 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 )';
--    	END IF;   	
   
-- 	fecha_creacion_va = NOW();
-- 	class_seguridad_va = analista_encargado_reg.class_seguridad;
 
 	

--  	-------------///////////--------------	
 

--     INSERT INTO PIEZA_INTELIGENCIA (fecha_creacion,descripcion,class_seguridad,fk_fecha_inicio_analista,fk_personal_inteligencia_analista,fk_estacion_analista,fk_oficina_principal_analista,fk_clas_tema) VALUES (
   	
--     	fecha_creacion_va,
--     	descripcion,
--     	class_seguridad_va,
--    		hist_cargo_reg.fecha_inicio,
--    		hist_cargo_reg.fk_personal_inteligencia,
--    		hist_cargo_reg.fk_estacion,
--    		hist_cargo_reg.fk_oficina_principal,
   		
--     	crudo_base_reg.fk_clas_tema
--     ) RETURNING id INTO id_pieza;
   
   
--    SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
   
--    RAISE INFO 'PIEZA CREADA CON EXITO!';
--    RAISE INFO 'Datos de la pieza creada: %', pieza_reg ; 

-- 	-------------///////////--------------	

-- 	INSERT INTO CRUDO_PIEZA (fk_pieza_inteligencia, fk_crudo) VALUES (
--    		id_pieza,
--    		id_crudo_base
--     );
   
--    	RAISE INFO 'CRUDO DE ID = %, FUE AGREGADO A LA PIEZA ID = % EXITOSAMENTE', id_crudo_base, id_pieza;
 

-- END $$;


-- CALL REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA( 1 , 'descripcion pieza prueba', 1 );




-- --select c.id, c.nivel_confiabilidad_final , (SELECT count(*) FROM ANALISTA_CRUDO WHERE fk_crudo = c.id) as numero_analistas from crudo c ;
-- --select * from crudo where id = 1;



-- --SELECT c.id, count(*) as numero_analistas, c.cant_analistas_verifican FROM ANALISTA_CRUDO ac, CRUDO c WHERE ac.fk_crudo = c.id  GROUP BY c.id, c.cant_analistas_verifican ORDER BY c.id  ;
-- --
-- --select * from analista_crudo ac where fk_crudo =24;
-- --select * from crudo  where id=24;


-- -----------------------------===========$$$$$$$$$$///////////////|\\\\\\\\\\\\\\\$$$$$$$$$$===========-------------------------------------------




-- DROP PROCEDURE IF EXISTS AGREGAR_CRUDO_A_PIEZA CASCADE;

-- CREATE OR REPLACE PROCEDURE AGREGAR_CRUDO_A_PIEZA (id_crudo IN integer, id_pieza IN integer)
-- LANGUAGE plpgsql
-- AS $$  
-- DECLARE

-- 	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
-- 	crudo_reg CRUDO%ROWTYPE;

-- 	crudo_pieza_reg CRUDO_PIEZA%ROWTYPE;
    
-- BEGIN 

-- 	RAISE INFO ' ';
-- 	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO AGREGAR_CRUDO_A_PIEZA ( % ) ------', NOW();
	
-- 	-------------///////////--------------	


-- 	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza AND precio_base IS NULL;
--     RAISE INFO 'datos de la pieza de inteligencia %', pieza_reg;

-- 	SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo;
--     RAISE INFO 'datos del crudo: %', crudo_reg;
    
--     SELECT * INTO crudo_pieza_reg FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza AND fk_crudo = id_crudo;
-- 	RAISE INFO 'datos de crudo_pieza: %', crudo_pieza_reg;
   
-- 	--------


-- 	IF (pieza_reg IS NULL) THEN
--    		RAISE INFO 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
--   		RAISE EXCEPTION 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
--    	END IF;   
 
-- 	IF (crudo_reg IS NULL) THEN
--    		RAISE INFO 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
--   		RAISE EXCEPTION 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
--    	END IF;   	
   
--    IF (crudo_pieza_reg IS NOT NULL) THEN
--    		RAISE INFO 'El crudo que intenta asociar ya está asociado a esta pieza';
--   		RAISE EXCEPTION 'El crudo que intenta asociar ya está asociado a esta pieza';
--    	END IF;   	
   
--    	IF (NUMERO_ANALISTAS_VERIFICAN_CRUDO(id_crudo) = 0) THEN
--    		RAISE INFO 'El crudo que ingresó no ha sido verificado';
--   		RAISE EXCEPTION 'El crudo que ingresó no ha sido verificado';
--    	END IF;   	

-- 	IF (crudo_reg.nivel_confiabilidad_final < 85 ) THEN
--    		RAISE INFO 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
--   		RAISE EXCEPTION 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
--    	END IF;   	
   
  
   
--    -------------///////////--------------	
	

-- 	INSERT INTO CRUDO_PIEZA (fk_pieza_inteligencia, fk_crudo) VALUES (
--    		pieza_reg.id,
--    		crudo_reg.id
--     );
   
--    	RAISE INFO 'CRUDO DE ID = %, FUE AGREGADO A LA PIEZA ID = % EXITOSAMENTE', id_crudo, id_pieza;
 

-- END $$;


-- CALL AGREGAR_CRUDO_A_PIEZA( 37, 19 );




-- --SELECT count(*) as numero_crudos_va_en_pieza, sum(c.nivel_confiabilidad_final)/count(*) as nivel_confiabilidad_promedio_va
-- ----	INTO numero_crudos_va, nivel_confiabilidad 
-- --FROM CRUDO_PIEZA cp, CRUDO c WHERE cp.fk_crudo = c.id AND cp.fk_pieza_inteligencia = 2;
-- --
-- --
-- --SELECT cp.fk_pieza_inteligencia as id_pieza, count(*) as numero_crudos_va_en_pieza, sum(c.nivel_confiabilidad_final)/count(*) as nivel_confiabilidad_promedio_va
-- ----	INTO numero_crudos_va, nivel_confiabilidad 
-- --FROM CRUDO_PIEZA cp, CRUDO c WHERE cp.fk_crudo = c.id GROUP BY cp.fk_pieza_inteligencia ORDER BY cp.fk_pieza_inteligencia;


-- -----------------------------===========$$$$$$$$$$///////////////|\\\\\\\\\\\\\\\$$$$$$$$$$===========-------------------------------------------




-- DROP PROCEDURE IF EXISTS CERTIFICAR_PIEZA CASCADE;


-- CREATE OR REPLACE PROCEDURE CERTIFICAR_PIEZA (id_pieza IN integer, precio_base_va IN PIEZA_INTELIGENCIA.precio_base%TYPE)
-- LANGUAGE plpgsql
-- AS $$  
-- DECLARE

-- 	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
	
-- 	numero_crudos_va integer;
-- 	nivel_confiabilidad_promedio_va PIEZA_INTELIGENCIA.nivel_confiabilidad%TYPE;
	
-- BEGIN 

-- 	RAISE INFO ' ';
-- 	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERTIFICAR_PIEZA ( % ) ------', NOW();
	
-- 	-------------///////////--------------	


-- 	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza AND precio_base IS NULL;
--     RAISE INFO 'datos de la pieza de inteligencia %', pieza_reg;


-- 	IF (pieza_reg IS NULL) THEN
--    		RAISE INFO 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
--   		RAISE EXCEPTION 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
--    	END IF;   
 
-- 	IF (precio_base_va < 1) THEN
--    		RAISE INFO 'El precio base no puede negativo ni igual a 0$';
--   		RAISE EXCEPTION 'El precio base no puede negativo ni igual a 0$';
--    	END IF;  

--    ---------
   
   
--    	SELECT count(*), sum(c.nivel_confiabilidad_final)/count(*) INTO numero_crudos_va, nivel_confiabilidad_promedio_va FROM CRUDO_PIEZA cp, CRUDO c WHERE cp.fk_crudo = c.id AND cp.fk_pieza_inteligencia = id_pieza;
-- 	RAISE INFO 'numero de crudos en la pieza (id = %): %', id_pieza, numero_crudos_va;


--    	IF (numero_crudos_va < 1) THEN
--    		RAISE INFO 'La pieza no tiene ningun crudo asociado';
--   		RAISE EXCEPTION 'La pieza no tiene ningun crudo asociado';
--    	END IF;   	
   
--     IF (nivel_confiabilidad_promedio_va < 85) THEN
--    		RAISE INFO 'No se cumple un nivel de confiabilidad promedio de 85 porciento';
--   		RAISE EXCEPTION 'No se cumple un nivel de confiabilidad promedio de 85 porciento';
--    	END IF;  
  
   
--    -------------///////////--------------	
	
-- 	UPDATE PIEZA_INTELIGENCIA SET 
-- 		nivel_confiabilidad = nivel_confiabilidad_promedio_va, 
-- 		precio_base = precio_base_va
-- 	;
   
--    	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
   
--    	RAISE INFO 'PIEZA CERTIFICADA CON EXITO!';
--    	RAISE INFO 'Datos de la pieza certificada: %', pieza_reg ; 
	
 

-- END $$;



-- CALL CERTIFICAR_PIEZA( 37, 1 );








