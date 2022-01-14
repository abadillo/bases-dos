CREATE OR REPLACE FUNCTION trigger_copia_info_pieza()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
	DECLARE 
	historico hist_cargo%rowtype;
	
	copia_pieza pieza_inteligencia%rowtype;
	
	BEGIN
	raise info '%',copia_pieza;	
	CALL copia_historico_cargo(fk.fecha_inicio_analista);
	
	----SELECT PARA EXTRAER LA INFO DE LA TRABLA PIEZA_INTELIGENCIA
	SELECT fecha_creacion,
		precio_base,
		fk_fecha_inicio_analista,
		fk_personal_inteligencia,
		fk_estacion_analista,
		fk_oficina_principal_analista, 
		fk_clas_tema
		INTO copia_pieza FROM pieza_inteligencia
		WHERE old.fecha_creacion=fecha_creacion;
	
	----INSERT EN LA TABLA ALT DE PIEZA (COPIA DE INFORMACION)
	
	INSERT INTO pieza_inteligencia_alt (
		fecha_creacion,
		precio_base,
		fk_fecha_inicio_analista,
		fk_personal_inteligencia,
		fk_estacion_analista,
		fk_oficina_principal_analista, 
		fk_clas_tema)
	values (
		old.fecha_creacion,
		old.precio_base, 
		old.fk_fecha_inicio_analista,
		old.fk_personal_inteligencia,
		old.fk_estacion_analista,
		old.fk_oficina_principal_analista,
		old.fk_clas_tema	
	);
	
	
	END
$$;

DELETE from pieza_inteligencia where id=1

SELECT * FROM pieza_inteligencia_alt

CREATE TRIGGER trigger_copia_pieza
BEFORE DELETE ON pieza_inteligencia
FOR EACH ROW EXECUTE FUNCTION trigger_copia_info_pieza()

DROP TRIGGER trigger_copia_pieza ON pieza_inteligencia;

------ PROCEDIMIENTO PARA COPIAR HISTORICO CARGO

CREATE OR REPLACE PROCEDURE copia_historico_cargo(fecha timestamp)
LANGUAGE PLPGSQL
AS $$
DECLARE
	HISTORICO hist_cargo%rowtype;
BEGIN
	SELECT fecha_inicio, fecha_fin, cargo, fk_personal_inteligencia, fk_estacion, fk_oficina_principal
	INTO HISTORICO FROM hist_cargo 
	WHERE fecha_inicio=fecha;
	
	INSERT INTO hist_cargo_alt (
		fecha_inicio,
		fecha_fin,
		cargo,

		fk_personal_inteligencia,
		fk_estacion,
		fk_oficina_principal)
	VALUES (
			HISTORICO.fecha_inicio,
			HISTORICO.fecha_fin, 
			HISTORICO.cargo, 
			HISTORICO.fk_personal_inteligencia,
			HISTORICO.fk_estacion, 
			HISTORICO.fk_oficina_principal
	);	
END
$$;


CALL copia_historico_cargo('2034-01-05 01:00:00')
select * from hist_cargo_alt
SELECT * FROM hist_cargo



