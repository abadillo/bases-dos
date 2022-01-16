
--------------------------///////////////////////-----------------------------



CREATE OR REPLACE FUNCTION TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
	area_interes_reg AREA_INTERES%ROWTYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_REGISTRO_TEMAS_CLEINTE_ADQUISICION ( % ) ------', NOW();
	
	-------------///////////--------------	

	RAISE INFO 'datos de la aquisicion: %', new;

	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = new.fk_pieza_inteligencia;
    RAISE INFO 'datos de la pieza: %', area_interes_reg;

	SELECT * INTO area_interes_reg FROM AREA_INTERES WHERE fk_clas_tema = pieza_reg.fk_clas_tema AND fk_cliente = new.fk_cliente ;
    RAISE INFO 'datos del AREA_INTERES: %', area_interes_reg;


	IF (area_interes_reg IS NULL) THEN
   
	
		INSERT INTO AREA_INTERES (
			fk_clas_tema, 
			fk_cliente
		) VALUES (

			pieza_reg.fk_clas_tema, 
			new.fk_cliente 
		
		) RETURNING * INTO area_interes_reg;


		RAISE INFO 'REGISTRO AREA_INTERES!';
		RAISE INFO 'Datos de area_intereses: %', area_interes_reg ; 
	  	
	ELSE
		RAISE INFO 'AREA_INTERESES YA REGISTRADA';
	

	END IF;	
 
	RETURN NULL;

END $$;
----DROP PROCEDURE TRIGGER_COPIA_ADQUISICION(integer)



CREATE TRIGGER TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION
AFTER INSERT ON ADQUISICION
FOR EACH ROW EXECUTE FUNCTION TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION();


--
--INSERT INTO adquisicion (fecha_hora_venta, fk_pieza_inteligencia, fk_cliente, precio_vendido) VALUES (now(),17,1,100);
--
--select * from area_interes ai where fk_cliente = 1;
--select fk_clas_tema from pieza_inteligencia pi2  where id  = 17;
