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



CALL NUMERO_REGISTROS();   
SELECT fk_personal_inteligencia_encargado, count(*) FROM INFORMANTE GROUP BY fk_personal_inteligencia_encargado; 


SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE(13); 


select * from transaccion_pago tp  where fk_informante  = 7;
select * from crudo where fk_informante  = 7;
SELECT * FROM INFORMACION_INFORMANTES(7);

nombre_clave,agente_encargado,id_estacion,nombre_estacion,crudos,piezas,crudos_alt,piezas_alt,total_crudos,total_piezas,crudos_usados,eficacia
Traccion,13,4,Est. Amsterdam,1,8,0,0,1,8,1,100.0000

CALL ELIMINACION_REGISTROS_INFORMANTE(7);
SELECT * FROM INFORMACION_INFORMANTES(7);


select * from informante where 

select * from transaccion_pago tp  where fk_informante  = 19;
select * from crudo where fk_informante  = 19;
SELECT * FROM INFORMACION_INFORMANTES(19);


CALL ELIMINACION_REGISTROS_INFORMANTE(13);

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







