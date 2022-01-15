CREATE OR REPLACE FUNCTION TRIGGER_INSERT_CRUDO()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	
	crudo_reg crudo%rowtype;

BEGIN
	
	IF (new.fuente ='secreta') THEN	
	
		IF (new.fk_informante IS NOT NULL) then		
			RAISE INFO 'EL CRUDO HA SIDO REGISTRADO CON UN INFORMANTE';
			RETURN new;
		ELSE 
			RAISE EXCEPTION 'EL CRUDO DEBE TENER UN INFORMANTE SI LA FUENTE ES "SECRETA" ';
			RAISE EXCEPTION 'NO SE PUDO INSERTAR EL CRUDO';
			RETURN null;
		END IF;
	ELSE
		IF (new.fk_informante IS NOT NULL) then		
			RAISE EXCEPTION 'EL CRUDO SOLO TIENE UN INFORMANTE SI LA FUETE ES "SECRETA" ';
			RAISE EXCEPTION 'NO SE PUDO INSERTAR EL CRUDO';
			RETURN null;
		ELSE 
			RAISE INFO 'EL CRUDO HA SIDO REGISTRADO CON FUENTE ABIERTA O TECNICA';
			RETURN new;
		END IF;
	END IF;
END
$$;

---DROP FUNCTION TRIGGER_INSERT_CRUDO()

---CREATE TRIGGER TRIGGER_INSERT_CRUDO
---BEFORE INSERT ON crudo
---FOR EACH ROW EXECUTE FUNCTION TRIGGER_INSERT_CRUDO()

---DROP TRIGGER TRIGGER_INSERT_CRUDO ON crudo

------SELECT * FROM CRUDO
----INSERT INTO crudo (contenido, tipo_contenido, resumen, fuente, valor_apreciacion, nivel_confiabilidad_inicial, nivel_confiabilidad_final, fecha_obtencion, fecha_verificacion_final, cant_analistas_verifican, fk_clas_tema, fk_informante, fk_estacion_pertenece, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente) VALUES
----('crudo_contenido/texto2.txt', 'texto', 'Conflictos entre paises por poder II', 'abierta', 600, 90, 90 , '2019-03-05 01:00:00', null, 2, 1, null, 1, 1, 1, 1, '2020-01-05 01:00:00', 1);

----SELECT * FROM HIST_CARGO where fecha_inicio='2034-01-05 01:00:00' 
----	AND fk_personal_inteligencia_agente = 17
----	AND fk_estacion_agente= 5
----	AND fk_oficina_principal_agente = 2