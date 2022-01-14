CREATE OR REPLACE FUNCTION TRIGGER_COPIA_INFO_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
	DECLARE 
	copia_historico hist_cargo%rowtype;
	
	copia_pieza pieza_inteligencia%rowtype;
	
	BEGIN
		
	----SELECT PARA EXTRAER LA INFO DE LA TABLA PIEZA_INTELIGENCIA
	
		SELECT * INTO copia_pieza 
		FROM pieza_inteligencia
		WHERE id = old.id;
		RAISE INFO 'INFORMACION DE LA PIEZA A COPIAR %:', copia_pieza;
	
	----SELECT PARA COPIAR EL HISTORICO CARGO
	
		SELECT fecha_inicio, fecha_fin, cargo, fk_personal_inteligencia, fk_estacion, fk_oficina_principal
		INTO copia_historico FROM hist_cargo
		where copia_pieza.fk_fecha_inicio_analista = hist_cargo.fecha_inicio;
	
		RAISE INFO 'INFORMACION DEL HISTORICO CARGO A COPIAR %:', copia_historico;
	
		---- INSERT EN LA TABLA ALT DE HISTORICO(COPIA DE INFORMACION)
	
		CALL copia_historico_cargo(copia_historico.fecha_inicio);
	
		
		
		----INSERT EN LA TABLA ALT DE PIEZA (COPIA DE INFORMACION)
	
		INSERT INTO pieza_inteligencia_alt (
			fecha_creacion,
			precio_base,
			fk_fecha_inicio_analista,
			fk_personal_inteligencia_analista,
			fk_estacion_analista,
			fk_oficina_principal_analista, 
			fk_clas_tema)
		values (
			copia_pieza.fecha_creacion,
			copia_pieza.precio_base, 
			copia_pieza.fk_fecha_inicio_analista,
			copia_pieza.fk_personal_inteligencia_analista,
			copia_pieza.fk_estacion_analista,
			copia_pieza.fk_oficina_principal_analista,
			copia_pieza.fk_clas_tema	
		);

	END
$$;

DELETE from pieza_inteligencia where id=1

SELECT * FROM pieza_inteligencia_alt

CREATE TRIGGER trigger_copia_pieza
BEFORE DELETE ON pieza_inteligencia
FOR EACH ROW EXECUTE FUNCTION trigger_copia_info_pieza()

DROP TRIGGER trigger_copia_pieza ON pieza_inteligencia;