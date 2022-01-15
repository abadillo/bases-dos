CREATE OR REPLACE PROCEDURE TRIGGER_COPIA_ADQUISICION(fk_pieza integer)
LANGUAGE PLPGSQL
AS $$
DECLARE

	adquisicion_reg adquisicion%rowtype;
	
	adquisicion_reg_alt adquisicion_alt%rowtype;

BEGIN

	
	SELECT * INTO adquisicion_reg_alt
	FROM adquisicion_alt	
	WHERE fk_pieza = (SELECT id FROM pieza_inteligencia WHERE fk_pieza = id)
	AND fk_cliente = (SELECT id FROM cliente WHERE fk_cliente = id);
	
	--select * from adquisicion
	
	IF (adquisicion_reg_alt IS NULL) THEN
		
		SELECT * INTO adquisicion_reg
		FROM adquisicion
		WHERE fk_pieza = (SELECT id FROM pieza_inteligencia WHERE fk_pieza = id)
		AND fk_cliente = (SELECT id FROM cliente WHERE fk_cliente = id);
		
		RAISE INFO 'DATOS DE ADQUISICION A COPIAR %',adquisicion_reg;
		
		INSERT INTO adquisicion_alt(
			fecha_hora_venta,
			precio_vendido,
			
			fk_cliente,
			fk_pieza_inteligencia		
		)	VALUES (
			adquisicion_reg.fecha_hora_venta,
			adquisicion_reg.precio_vendido,
			
			adquisicion_reg.fk_cliente,
			adquisicion_reg.fk_pieza_inteligencia		
			);
			
			RAISE INFO 'INSERT DE LA INFORMACION COPIADA EN LA TABLA ADQUISICION_ALT';
		
		ELSE
		
			RAISE INFO 'LA ADQUISICION YA ESTA REGISTRADO';
		
		END IF;				
END
$$;

call TRIGGER_COPIA_ADQUISICION(6)



