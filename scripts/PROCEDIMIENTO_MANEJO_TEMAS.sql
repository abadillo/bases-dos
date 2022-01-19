CREATE OR REPLACE PROCEDURE CREAR_TEMA (nombre_va varchar, descripcion_va varchar, topico_va varchar)
LANGUAGE PLPGSQL
AS $$

BEGIN
	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_LUGAR ( % ) ------', NOW();
	
	INSERT INTO clas_tema (
		nombre,
		descripcion,
		topico
	)	VALUES (
		nombre_va,
		descripcion_va,
		topico_va		
		);

END;
$$;

