--- FUNCION VALIDAR EL TIPO DE LUGAR ----
CREATE OR REPLACE PROCEDURE VALIDAR_TIPO_LUGAR(id_lugar IN integer, tipo_va IN LUGAR.tipo%TYPE)
AS $$
DECLARE

	lugar_reg LUGAR%ROWTYPE;
	
BEGIN

	select * into lugar_reg from LUGAR where id = id_lugar AND tipo = tipo_va;
	
	IF (lugar_reg IS NULL) THEN
		RAISE INFO 'El lugar/direccion ingresado debe ser de tipo %', tipo_va;
		RAISE EXCEPTION 'El lugar/direccion ingresado debe ser de tipo %', tipo_va;
	END IF;
		
END;
$$ LANGUAGE plpgsql;

----TRIGGER PARA VALIDAR EL INSERT DEL CLIENTE----

CREATE OR REPLACE FUNCTION TRIGGER_CREAR_CLIENTE ()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	
	lugar_reg lugar%rowtype;
	
BEGIN
	---VALIDACIONES DE ATRIBUTOS---
	---TIENE NOMBRE LA EMPRESA----
	
	IF (TG_OP = 'DELETE') THEN
		
		RETURN OLD;
	
	ELSIF (TG_OP = 'UPDATE') THEN
	
		IF (new.nombre_empresa IS NULL OR new.nombre_empresa = ' ') THEN
		RAISE EXCEPTION 'EL NOMBRE DEL CLIENTE ESTA VACIO';
		END IF;
	
		---TIENE PAGINA WEB LA EMPRESA---
	
		IF (new.pagina_web IS NULL OR new.pagina_web =' ') THEN
			RAISE EXCEPTION 'DEBE INSERTAR UNA PAGINA WEB';
		END IF;

		---VALIDA EL TIPO DE LUGAR (PAIS) DONDE SE REGISTRÓ EL CLIENTE---
		CALL  VALIDAR_TIPO_LUGAR(new.fk_lugar_pais,'pais');
		
		RAISE INFO 'MODIFICÓ EL CLIENTE';
		
		RETURN new;	
		
	ELSIF (TG_OP = 'INSERT') THEN
	
		IF (new.nombre_empresa IS NULL OR new.nombre_empresa = ' ') THEN
		RAISE EXCEPTION 'EL NOMBRE DEL CLIENTE ESTA VACIO';
		END IF;
	
		---TIENE PAGINA WEB LA EMPRESA---
	
		IF (new.pagina_web IS NULL OR new.pagina_web =' ') THEN
			RAISE EXCEPTION 'DEBE INSERTAR UNA PAGINA WEB';
		END IF;

		---VALIDA EL TIPO DE LUGAR (PAIS) DONDE SE REGISTRÓ EL CLIENTE---
		CALL  VALIDAR_TIPO_LUGAR(new.fk_lugar_pais,'pais');
		
		RAISE INFO 'SE INSERTÓ EL CLIENTE';
		
		RETURN new;	
	
	END IF;
	
	RETURN NULL;
	

END

$$;

--INSERT INTO cliente (nombre_empresa, pagina_web, exclusivo, telefonos, contactos, fk_lugar_pais) VALUES
--('mexicaso', 'mexicaso.org.ve' ,true, ARRAY[CAST((58,4126909353) as telefono_ty), CAST((58,4165420879)as telefono_ty)],  ARRAY[ ROW('Eloisa', 'Petronila', 'Nolasco', 'White', '91 Sage Ave. Colorado Springs, CO 80911',  ROW(58,4121705701)), ROW('Nicolas', 'Abelardo', 'Tafoya', 'Peralta', '8370 Euclid Lane Harrisburg, PA 17109', ROW(58,4127728311))]::contacto_ty[], 4);


DROP FUNCTION TRIGGER_CREAR_CLIENTE()

DROP TRIGGER TRIGGER_CREAR_CLIENTE on cliente

CREATE TRIGGER TRIGGER_CREAR_CLIENTE
BEFORE INSERT OR UPDATE OR DELETE on cliente
FOR EACH ROW EXECUTE FUNCTION TRIGGER_CREAR_CLIENTE()


CREATE OR REPLACE CREAR_CONTACTO (primer_nombre varchar, segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar, direccion varchar)
LANGUAGE PLPGSQL
AS $$



$$;
