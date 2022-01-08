
-- CREATE TABLE PIEZA_INTELIGENCIA (

--     id serial NOT NULL,

--     fecha_creacion timestamp,
--     nivel_confiabilidad numeric(5), 
--     precio_base numeric(20),

--     descripcion varchar(500),

--     class_seguridad varchar(50) NOT NULL,
    
--     --fks hist_cargo
--     fk_fecha_inicio_analista timestamp NOT NULL,
--     fk_personal_inteligencia_analista integer NOT NULL,
--     fk_estacion_analista integer NOT NULL,
--     fk_oficina_principal_analista integer NOT NULL,

--     fk_clas_tema integer NOT NULL,

-- );


--------------------------///////////////////////-----------------------------

-- 4. Demostración de la implementación de los requerimientos del sistema de bases de datos transaccional referidos al proceso de venta de piezas de inteligencia – construcción de piezas de inteligencia y venta a clientes, incluyendo la seguridad correspondiente (roles, cuentas con privilegios para poder ejecutar los programas y reportes).


-- Registro_Verificación_Pieza_Inteligencia – Asignar analista, registro id, analista y descripción de la pieza; pedir y registrar los hechos crudos que la conforman, calcular confiabilidad, asignar tema según hechos y registrar precio. Aplicando todas las validaciones necesarias sobre cada paso…


DROP PROCEDURE IF EXISTS REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA ( id_analista_encargado IN integer )
LANGUAGE plpgsql AS $$  
DECLARE  
    
    fecha_creacion_va PIEZA_INTELIGENCIA.fecha_creacion%TYPE;
    class_seguridad_va PIEZA_INTELIGENCIA.class_seguridad%TYPE;

    analista_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
   	hist_cargo_reg HIST_CARGO%ROWTYPE;

BEGIN 

	RAISE NOTICE ' ';
	RAISE NOTICE '------ EJECUCION DEL PROCEDIMINETO REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA ( % ) ------', NOW();
	
	
    SELECT * INTO analista_encargado_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_analista_encargado;

    raise notice 'datos de persona inteligencia: %', analista_encargado_reg;
   
   
   	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista_encargado AND fecha_fin IS NULL;
    
   	raise notice 'datos de hist_cargo: %', hist_cargo_reg;
    
   
   	IF (hist_cargo_reg IS NULL) THEN
  		RAISE EXCEPTION 'El analista que ingresó no existe';
   	ELSE 
   		IF hist_cargo_reg.cargo != 'analista' THEN
   			RAISE EXCEPTION 'El analista que ingresó no es un analista, es un agente de campo';
   		END IF;
  
 	END IF;
   
    -- IF ( analista  )

	-- INSERT INTO PIEZA_INTELIGENCIA (fecha_creacion,nivel_confiabilidad,descripcion,precio_base,class_seguridad,fk_fecha_inicio_analista,fk_personal_inteligencia_analista,fk_estacion_analista,fk_oficina_principal_analista,fk_clas_tema) VALUES ();	
    
    -- INSERT INTO PIEZA_INTELIGENCIA (class_seguridad,fk_fecha_inicio_analista,fk_personal_inteligencia_analista,fk_estacion_analista,fk_oficina_principal_analista,fk_clas_tema) VALUES ();

	   
END $$;


CALL REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA( 0 );

