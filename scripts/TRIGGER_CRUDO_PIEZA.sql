CREATE OR REPLACE FUNCTION TRIGGER_CRUDO_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE

	crudo_reg crudo%rowtype;
	
	crudo_record record;
		
BEGIN

	SELECT c.nivel_confiabilidad_final INTO crudo_record FROM crudo_pieza cp, crudo c
	WHERE new.fk_crudo = c.id;	
---- SELECT PARA MOSTRAR DATOS DEL CRUDO

	SELECT * INTO crudo_reg FROM crudo
	WHERE id = new.fk_crudo;
	RAISE INFO 'VALORES DEL CRUDO %', crudo_reg;
	
	IF (crudo_record.nivel_confiabilidad_final >= 85) THEN
		RAISE INFO 'SE INSERTO UN CRUDO A UNA PIEZA DE INTELIGENCIA, Id crudo: %', new.fk_crudo;
		RETURN new;
	
	ELSE 
		RAISE EXCEPTION 'NO SE PUDO INSERTAR EN LA TABLA crudo_pieza, NIVEL DE CONFIABILIDAD DEL CRUDO ES MENOR a 85 Id crudo: %', new.fk_crudo;
		RETURN NULL;
	END IF;

END 

$$;
---------ELIMINACION DE LA FUNCION------
---DROP FUNCTION TRIGGER_CRUDO_PIEZA()

---------CREACION DEL TRIGGER-----
---CREATE TRIGGER TRIGGER_CRUDO_PIEZA
---BEFORE INSERT OR UPDATE ON crudo_pieza
---FOR EACH ROW EXECUTE FUNCTION TRIGGER_CRUDO_PIEZA()

---------ELIMINACION DEL TRIGGER-----
---DROP TRIGGER TRIGGER_CRUDO_PIEZA

---PRUEBA ---------------------------
---INSERT INTO crudo_pieza (fk_pieza_inteligencia, fk_crudo )
---VALUES (1,19)