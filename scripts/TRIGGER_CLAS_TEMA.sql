CREATE OR REPLACE FUNCTION TRIGGER_CLAS_TEMA()
RETURNS TRIGGER LANGUAGE PLPGSQL
AS $$
DECLARE
	pieza_reg record;
	crudo_reg record;
	temas_esp record;
	area_interes record;
BEGIN
	
	IF(TG_OP = 'INSERT') THEN
	
		IF(new.nombre IS NULL OR new.nombre = '')THEN
			RAISE EXCEPTION 'EL NOMBRE DEL TEMA ESTA VACIO';
		END IF;
		IF(new.descripcion IS NULL OR new.descripcion = '') THEN
			RAISE EXCEPTION 'LA DESCRIPCION DEL TEMA ESTA VACIO';
		END IF;
		CASE topico
			WHEN 'paises' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'individuos' THEN
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'eventos' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'empresas' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
		END CASE;

		RETURN NEW; 
	
	ELSIF (TG_OP = 'UPDATE') THEN
		
		IF(new.nombre IS NULL OR new.nombre = '')THEN
			RAISE EXCEPTION 'EL NOMBRE DEL TEMA ESTA VACIO';
		END IF;
		IF(new.descripcion IS NULL OR new.descripcion = '') THEN
			RAISE EXCEPTION 'LA DESCRIPCION DEL TEMA ESTA VACIO';
		END IF;
		CASE new.topico
			WHEN 'paises' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'individuos' 
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'eventos'
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'empresas'
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
		END CASE;

		RETURN NEW; 
	ELSIF (TG_OP = 'DELETE') THEN
		--- VALIDACION RAPIDA DE LOS FK DE LA CLASIFICACION PIEZA EN LAS OTRAS TABLAS ANTES DE ELIMINAR ----
		--- PERSONAL_INTELIGENCIA, CRUDO, CLAS_TEMA, TEMAS_ESP ---
		
		SELECT id INTO  pieza_reg FROM pieza_inteligencia
		WHERE fk_clas_tema  =  new.id;
		
		SELECT id INTO crudo_reg FROM crudo
		WHERE fk_clas_tema = new.id;
		
		SELECT fk_clas_tema INTO temas_esp FROM clas_tema
		WHERE fk_clas_tema = new.id;
		
		SELECT fk_clas_tema INTO area_interes FROM area_interes
		WHERE fk_clas_tema = new.id;
		
		IF (pieza_reg IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UNA PIEZA DE INTELIGENCIA';
		END IF;
		
		IF (crudo_reg IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN CRUDO';
		END IF;
		
		IF (temas_esp IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN TEMA ESPECIFICO DE UN PERSONAL DE INTELIGENCIA';
		END IF;
		
		IF (area_interes IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN AREA DE INTERES DE UN CLIENTE';
		END IF;
		
		RETURN OLD;
	END IF;	
END 
$$;

DROP FUNCTION TRIGGER_CLAS_TEMA()

CREATE TRIGGER TRIGGER_CLAS_TEMA
BEFORE INSERT OR UPDATE ON clas_tema
FOR EACH ROW EXECUTE FUNCTION TRIGGER_CLAS_TEMA()

DROP TRIGGER TRIGGER_CLAS_TEMA