
DROP FUNCTION IF EXISTS NUMERO_ANALISTAS_VERIFICAN_CRUDO CASCADE;

CREATE OR REPLACE FUNCTION NUMERO_ANALISTAS_VERIFICAN_CRUDO ( id_crudo IN integer ) 
RETURNS integer
LANGUAGE PLPGSQL 
AS $$
DECLARE 

	numero_analistas_va integer;	

BEGIN 
	
	SELECT count(*) INTO numero_analistas_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;
	
	RETURN numero_analistas_va;
	
END $$;


-------------////////.........^^^^^^^^^^^^^^^^^^^^^..........\\\\\\\\\\-------------



DROP FUNCTION IF EXISTS ANALISTA_VERIFICO_CRUDO CASCADE;

CREATE OR REPLACE FUNCTION ANALISTA_VERIFICO_CRUDO ( id_crudo IN integer, id_analista IN integer ) 
RETURNS boolean
LANGUAGE PLPGSQL 
AS $$
DECLARE 

	registro record;

BEGIN 
	
	SELECT * INTO registro FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo AND fk_personal_inteligencia_analista = id_analista;
	
	IF (registro IS NULL) THEN
		RETURN false;
	END IF;

	RETURN true;
	
END $$;


-------------////////.........^^^^^^^^^^^^^^^^^^^^^..........\\\\\\\\\\-------------



DROP FUNCTION IF EXISTS ANALISTA_PUEDE_VERIFICA_CRUDO CASCADE;

CREATE OR REPLACE FUNCTION ANALISTA_PUEDE_VERIFICA_CRUDO ( id_crudo IN integer, id_analista IN integer ) 
RETURNS boolean
LANGUAGE PLPGSQL 
AS $$
DECLARE 

	id_estacion_analista integer;
	id_estaciones_otros_analistas integer[];
	id_estacion_crudo integer;

BEGIN 

	-- estacion del analista
	SELECT fk_estacion INTO id_estacion_analista FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista AND fecha_fin IS NULL; 
	
	-- estacion del crudo
	id_estacion_crudo := ARRAY( 
		SELECT fk_estacion_pertenece FROM CRUDO WHERE id = id_crudo
	);

	-- estacion de los analistas que verificaron el crudo
	SELECT fk_estacion_analista INTO id_estaciones_otros_analistas FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;
	
	IF (id_estacion_analista = id_estacion_crudo OR id_estacion_analista = ANY(id_estaciones_otros_analistas)) THEN
		RETURN false;
	END IF;

	RETURN true;
	
END $$;

--
--select analista_puede_verifica_crudo(5, 4);
--
--select * from analista_crudo ac where fk_crudo = 5;
--select * from hist_cargo hc where fk_personal_inteligencia = 4;

--------------------------///////////////////////-----------------------------


-- Demostración de la implementación de los requerimientos del sistema de bases de datos 
-- transaccional referidos al proceso de venta de piezas – actividades de recolección y 
-- verificación de hechos crudos y manejo de informantes, incluyendo la seguridad correspondiente 
-- (roles, cuentas con privilegios para poder ejecutar los programas y reportes).


-- Verificación_Hechos_Crudos (3) - elegir analistas, definir rango de tiempo para cargar 
-- confiabilidades, pedir nivel a asignar por analista, guardar y calcular promedio, actualizar 
-- el hecho crudo con la fecha final y el promedio calculado. Aplicando todas las validaciones
-- necesarias sobre cada paso…


-- La información recolectada por los agentes de campo se indexa (fecha más reciente) y almacena
-- como hechos crudos y se puede buscar por tópicos principales (países, individuos, eventos,
-- empresas), cada uno de los cuales está dividido en temas de interés. La AII no vende hechos crudos
-- (la información traída por los agentes) sino piezas de inteligencia verificadas por varias fuentes (al
-- menos 2 analistas de diferentes estaciones deben participar en la verificación de los hechos crudos
-- que conforman la pieza de inteligencia). Cuando un agente reporta un hecho crudo también indica
-- su nivel de confiabilidad de 0 a 100 con respecto a la exactitud o veracidad del mismo. Los analistas,
-- luego de su verificación pueden avalar ese nivel, aumentarlo o bajarlo. Sólo hechos crudos con un
-- nivel superior a 85 pueden formar parte de una pieza de inteligencia. Cada pieza de inteligencia
-- debe tener registrado su nivel de confiabilidad (se calcula como el promedio del nivel de
-- confiabilidad verificada de los hechos crudos que la conforman). El analista responsable5 por la
-- construcción de la pieza la certifica fijándole un precio aproximado, el cual será exacto luego de la
-- negociación en la cual es vendida – debe haber registro del precio final alcanzado. Sólo los analistas
-- fijan el precio base de las piezas de inteligencia. Una pieza de inteligencia registrada no puede ser
-- alterada.

--------------------------///////////////////////-----------------------------






DROP PROCEDURE IF EXISTS VERIFICAR_CRUDO CASCADE;


CREATE OR REPLACE PROCEDURE VERIFICAR_CRUDO ( id_analista IN integer, id_crudo IN integer, nivel_confiabilidad_va IN ANALISTA_CRUDO.nivel_confiabilidad%TYPE )
LANGUAGE plpgsql
AS $$  
DECLARE

    analista_reg PERSONAL_INTELIGENCIA%ROWTYPE;
	hist_cargo_analista_reg HIST_CARGO%ROWTYPE;

	crudo_reg CRUDO%ROWTYPE;
	analista_crudo_reg ANALISTA_CRUDO%ROWTYPE;

	fecha_hora_va ANALISTA_CRUDO.fecha_hora%TYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO VERIFICAR_CRUDO ( % ) ------', NOW();
	
	
	IF (nivel_confiabilidad_va IS NULL OR nivel_confiabilidad_va < 0 OR nivel_confiabilidad_va > 100 ) THEN
   		RAISE INFO 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
  		RAISE EXCEPTION 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
   	END IF; 


    SELECT * INTO analista_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_analista;
    RAISE INFO 'datos del analista a verficar: %', analista_reg;
   
   	SELECT * INTO hist_cargo_analista_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo del analista: %', hist_cargo_analista_reg;

	
	IF (hist_cargo_analista_reg IS NULL) THEN
   		RAISE INFO 'El analista que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El analista que ingresó no existe o ya no trabaja en AII';
   	END IF;   	
  	
	IF (hist_cargo_analista_reg.cargo != 'analista') THEN
		RAISE INFO 'El analista que ingresó no es un analista en su cargo actual';
		RAISE EXCEPTION 'El analista que ingresó no es un analista en su cargo actual';
	END IF;

	-------------////////

	SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo; 
   	RAISE INFO 'datos de crudo a verificar: %', crudo_reg;

	
	IF (crudo_reg IS NULL) THEN
   		RAISE INFO 'El crudo que ingresó no existe';
  		RAISE EXCEPTION 'El crudo que ingresó no existe';
   	END IF;  

	-------------////////

	IF (ANALISTA_VERIFICO_CRUDO(id_crudo, id_analista) = true) THEN
   		RAISE INFO 'Ya el analista que ingresó verificó este crudo';
  		RAISE EXCEPTION 'Ya el analista que ingresó verificó este crudo';
   	END IF; 


	IF (crudo_reg.nivel_confiabilidad_final IS NOT NULL OR crudo_reg.fecha_verificacion_final IS NOT NULL OR NUMERO_ANALISTAS_VERIFICAN_CRUDO(id_crudo) >= crudo_reg.cant_analistas_verifican) THEN
   		RAISE INFO 'El crudo ya fue verificado';
  		RAISE EXCEPTION 'El crudo ya fue verificado';
   	END IF; 

	IF (ANALISTA_PUEDE_VERIFICA_CRUDO(id_crudo, id_analista) = false) THEN
   		RAISE INFO 'El analista no puede verificar el crudo ya que tiene que pertenecer a una estacion diferente que los otros analistas que verificaron, asi como la estacion de procedencia del crudo';
  		RAISE EXCEPTION 'El analista no puede verificar el crudo ya que tiene que pertenecer a una estacion diferente que los otros analistas que verificaron, asi como la estacion de procedencia del crudo';
   	END IF; 

	------------- ///////
	
	fecha_hora_va = NOW();

	INSERT INTO ANALISTA_CRUDO (
		fecha_hora,
		nivel_confiabilidad,
		fk_crudo,
		
		fk_fecha_inicio_analista,
		fk_personal_inteligencia_analista,
		fk_estacion_analista,
		fk_oficina_principal_analista
	
	) VALUES (
		fecha_hora_va,
		nivel_confiabilidad_va,
		id_crudo,

		hist_cargo_analista_reg.fecha_inicio,
		hist_cargo_analista_reg.fk_personal_inteligencia,
		hist_cargo_analista_reg.fk_estacion,
		hist_cargo_analista_reg.fk_oficina_principal

	) RETURNING * INTO analista_crudo_reg;


    

   RAISE INFO 'CRUDO VERIFICADO CREADO CON EXITO!';
   RAISE INFO 'Datos del informante: %', informante_reg ; 

   RAISE INFO 'Faltan % verificaciones para poder cerrar el crudo', ( crudo_reg.cant_analistas_verifican - NUMERO_ANALISTAS_VERIFICAN_CRUDO(id_crudo)) ;



END $$;



--CALL VERIFICAR_CRUDO( id_analista, id_crudo, nivel_confiabilidad );





--------------------------///////////////////////-----------------------------



DROP PROCEDURE IF EXISTS CERRAR_CRUDO CASCADE;


CREATE OR REPLACE PROCEDURE CERRAR_CRUDO ( id_crudo IN integer )
LANGUAGE plpgsql
AS $$  
DECLARE

   	crudo_reg CRUDO%ROWTYPE;

	fecha_verificacion_final_va CRUDO.fecha_verificacion_final%TYPE;
	nivel_confiabilidad_promedio_va CRUDO.nivel_confiabilidad_final%TYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERRAR_CRUDO ( % ) ------', NOW();
	
	
	SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo; 
   	RAISE INFO 'datos de crudo a verificar: %', crudo_reg;

	IF (crudo_reg IS NULL) THEN
   		RAISE INFO 'El crudo que ingresó no existe';
  		RAISE EXCEPTION 'El crudo que ingresó no existe';
   	END IF;  
	
	-------------////////


	IF (crudo_reg.nivel_confiabilidad_final IS NOT NULL OR crudo_reg.fecha_verificacion_final IS NOT NULL) THEN
   		RAISE INFO 'El crudo ya fue verificado';
  		RAISE EXCEPTION 'El crudo ya fue verificado';
   	END IF; 


	IF ( NUMERO_ANALISTAS_VERIFICAN_CRUDO(id_crudo) < crudo_reg.cant_analistas_verifican ) THEN
   		RAISE INFO 'No se cumple el número mínimo de verificaciones, faltan: %', ( crudo_reg.cant_analistas_verifican - NUMERO_ANALISTAS_VERIFICAN_CRUDO(id_crudo)) ;
  		RAISE EXCEPTION 'No se cumple el número mínimo de verificaciones, faltan: %', ( crudo_reg.cant_analistas_verifican - NUMERO_ANALISTAS_VERIFICAN_CRUDO(id_crudo)) ;
   	END IF;   	

	
	SELECT MAX(fecha_hora) INTO fecha_verificacion_final_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;

	SELECT sum(nivel_confiabilidad)/count(*) INTO nivel_confiabilidad_promedio_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;

	UPDATE CRUDO SET nivel_confiabilidad_final = nivel_confiabilidad_promedio_va, fecha_verificacion_final = fecha_verificacion_final_va RETURNING * INTO crudo_reg;


   RAISE INFO 'CRUDO CERRADO EXITO!';
   RAISE INFO 'Datos del crudo verificado: %', crudo_reg ; 



END $$;



--CALL VERIFICAR_CRUDO( id_analista, id_crudo, nivel_confiabilidad );
