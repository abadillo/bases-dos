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




------ PROCEDIMIENTO PARA COPIAR HISTORICO CARGO ---------------

CREATE OR REPLACE PROCEDURE COPIA_HISTORICO_CARGO(fecha timestamp, personal integer, estacion integer, oficina integer)
LANGUAGE PLPGSQL
AS $$
DECLARE
	HISTORICO hist_cargo%rowtype;
	
	hist_cargo_alt_reg hist_cargo%rowtype;
	
BEGIN
	
	SELECT fecha_inicio, fecha_fin, cargo, fk_personal_inteligencia, fk_estacion, fk_oficina_principal
	INTO HISTORICO FROM hist_cargo 
	WHERE fecha_inicio=fecha
	AND fk_personal_inteligencia = personal
	AND fk_estacion = estacion
	AND fk_oficina_principal = oficina;
	
	--- BUSCA LA INFORMACION EN HIST_CARGO PARA COPIARLA y VALIDACION SI EXISTE EL CARGO EN LA TABLA ALTE

	select * into hist_cargo_alt_reg 
	from hist_cargo_alt
	where fecha_inicio = fecha
	AND fk_personal_inteligencia = personal
	AND fk_estacion = estacion
	AND fk_oficina_principal = oficina;

	--- INSERT EN LA TABLA ALTERNATIVA DE HISTORICO CARGO
	
	IF (hist_cargo_alt_reg IS NULL) THEN
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
		RAISE INFO 'INSER DE LA INFORMACION COPIADA EN LA TABLA HISTORICO_CARGO_ALT';
	ELSE
	
		RAISE INFO 'EL HISTORICO CARGO YA ESTA REGISTRADO ';
		RAISE INFO 'EL HISTORICO CARGO YA ESTA REGISTRADO ';
		
	END IF;	
	
END
$$;




CALL copia_historico_cargo('2034-01-06 01:00:00',1,3,4)
select * from hist_cargo_alt
SELECT * FROM hist_cargo


CREATE OR REPLACE PROCEDURE COPIA_PIEZA(id_pieza integer)
LANGUAGE PLPGSQL
AS $$
DECLARE
	
	copia_pieza pieza_inteligencia%rowtype;
	
	copia_historico hist_cargo%rowtype;
	
BEGIN

	----SELECT PARA EXTRAER LA INFO DE LA TRABLA PIEZA_INTELIGENCIA
	
	SELECT *
		INTO copia_pieza FROM pieza_inteligencia
		WHERE id = id_pieza;
	RAISE INFO 'INFORMACION DE LA PIEZA A COPIAR %:', copia_pieza;
	
	
	----SELECT PARA COPIAR EL HISTORICO CARGO
	
	SELECT fecha_inicio, fecha_fin, cargo, fk_personal_inteligencia, fk_estacion, fk_oficina_principal
	INTO copia_historico FROM hist_cargo
	where copia_pieza.fk_fecha_inicio_analista = hist_cargo.fecha_inicio;
	
	RAISE INFO 'INFORMACION DEL HISTORICO CARGO A COPIAR %:', copia_historico;
	
	---- INSERT EN LA TABLA ALT DE HISTORICO(COPIA DE INFORMACION)
	
	CALL copia_historico_cargo(copia_historico.fecha_inicio, copia_historico.fk_personal_inteligencia, copia_historico.fk_estacion, copia_historico.fk_oficina_principal);
	
	
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

select * from pieza_inteligencia_alt

SELECT * FROM hist_cargo_alt
CALL copia_pieza(5);


