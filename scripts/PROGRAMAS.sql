
--------------------------///////////////////////-----------------------------

-- 4. Demostración de la implementación de los requerimientos del sistema de bases de datos transaccional referidos al proceso de venta de piezas de inteligencia – construcción de piezas de inteligencia y venta a clientes, incluyendo la seguridad correspondiente (roles, cuentas con privilegios para poder ejecutar los programas y reportes).


-- Registro_Verificación_Pieza_Inteligencia – Asignar analista, registro id, analista y descripción de la pieza; pedir y registrar los hechos crudos que la conforman, calcular confiabilidad, asignar tema según hechos y registrar precio. Aplicando todas las validaciones necesarias sobre cada paso…

--------------------------///////////////////////-----------------------------

DROP PROCEDURE IF EXISTS REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (id_analista_encargado IN integer, precio_base IN PIEZA_INTELIGENCIA.precio_base%TYPE, descripcion IN PIEZA_INTELIGENCIA.descripcion%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE
    
    fecha_creacion_va PIEZA_INTELIGENCIA.fecha_creacion%TYPE;
    class_seguridad_va PIEZA_INTELIGENCIA.class_seguridad%TYPE;

    analista_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
   	hist_cargo_reg HIST_CARGO%ROWTYPE;
     
    tmp record;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA ( % ) ------', NOW();
	
	-------------///////////--------------	


    SELECT * INTO analista_encargado_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_analista_encargado;
    RAISE INFO 'datos de persona inteligencia: %', analista_encargado_reg;
   
   
   	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista_encargado AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo: %', hist_cargo_reg;
    
   
   	IF (hist_cargo_reg IS NULL) THEN
   		RAISE INFO 'El analista que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El analista que ingresó no existe';
   	END IF;   	
  	
   
	IF (hist_cargo_reg.cargo != 'analista') THEN
		RAISE INFO 'El analista que ingresó no es un analista, es un agente de campo';
		RAISE EXCEPTION 'El analista que ingresó no es un analista, es un agente de campo';
	END IF;
  
   
	fecha_creacion_va = NOW();
	class_seguridad_va = analista_encargado_reg.class_seguridad;
 
 	

 	-------------///////////--------------	
 

    INSERT INTO PIEZA_INTELIGENCIA (fecha_creacion,nivel_confiabilidad,precio_base,descripcion,class_seguridad,fk_fecha_inicio_analista,fk_personal_inteligencia_analista,fk_estacion_analista,fk_oficina_principal_analista,fk_clas_tema) VALUES (
   	
    	fecha_creacion_va,
    	1,	    -- FALTA
    	precio_base,
    	descripcion,
    	class_seguridad_va,
   		hist_cargo_reg.fecha_inicio,
   		hist_cargo_reg.fk_personal_inteligencia,
   		hist_cargo_reg.fk_estacion,
   		hist_cargo_reg.fk_oficina_principal,
   		
   		1      -- FALTA 
    	
    );
   
   
   SELECT * INTO tmp FROM PIEZA_INTELIGENCIA  ORDER BY id DESC LIMIT 1; 
   
   RAISE INFO 'PIEZA CREADA CON EXITO!';
   RAISE INFO 'Datos de la pieza creada: %', tmp;

	   
END $$;


CALL REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA( 1, 9999 , 'descripcion pieza prueba' );

