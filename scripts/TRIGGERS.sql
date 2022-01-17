--ALTER TABLE producto ENABLE TRIGGER insert_producto;
--ALTER TABLE producto DISABLE TRIGGER insert_producto;
--ALTER TABLE producto ENABLE TRIGGER all;
--ALTER TABLE producto DISABLE TRIGGER ALL;


-- CREATE OR REPLACE PROCEDURE VALIDAR_TELEFONO_TY (telefono IN telefono_ty)
-- AS $$
-- BEGIN

-- 	IF (telefono.codigo IS NULL OR telefono.codigo = 0) THEN
-- 		RAISE EXCEPTION 'El codigo del telefono no puede ser nulo';
-- 	END IF;

-- 	IF (telefono.numero IS NULL OR telefono.numero = 0) THEN
-- 		RAISE EXCEPTION 'El numero del telefono no puede ser nulo';
-- 	END IF;
		
-- END;
-- $$ LANGUAGE plpgsql;


-- call VALIDAR_TELEFONO_TY( CREAR_TELEFONO(0414,2133421) );

-----/-/---//-/-/-/-/-/-/-/-/-/----------------/--/--//-/-/-/-/-/-/-/--/-/--/-----



-----/-/---//-/-/-/-/-/-/-/-/-/----------------/--/--//-/-/-/-/-/-/-/--/-/--/-----
-----/-/---//-/-/-/-/-/-/-/-/-/----------------/--/--//-/-/-/-/-/-/-/--/-/--/-----

-- A. Triggers para validar las jerarquías en empleado_jefe

CREATE OR REPLACE function TRIGGER_EMPLEADO_JEFE()
RETURNS TRIGGER AS $$
BEGIN
	
	IF (TG_OP = 'DELETE') THEN
        
		--/
		RETURN OLD;

	ELSIF (TG_OP = 'UPDATE') THEN
		
		CASE new.tipo
		
			WHEN 'director_ejecutivo' THEN 

				IF (new.fk_empleado_jefe IS NOT NULL) THEN
					
					RAISE EXCEPTION 'El director ejecutivo no tiene jefe';	
				END IF;	

			WHEN 'director_area' THEN
			
				CALL VALIDAR_JERARQUIA_EMPLEADO_JEFE(new.fk_empleado_jefe,'director_ejecutivo');
				
			WHEN 'jefe' THEN

				CALL VALIDAR_JERARQUIA_EMPLEADO_JEFE(new.fk_empleado_jefe,'director_area');
				
			ELSE 
				RETURN null;
				
		END CASE;

		-- CALL VALIDAR_TELEFONO_TY(new.telefono);

		RETURN NEW;

	ELSIF (TG_OP = 'INSERT') THEN

		-- IF (new.primer_nombre IS NULL OR new.primer_nombre = '') THEN  
		-- 	RAISE EXCEPTION 'El primer nombre no puede estar vacio';
		-- END IF;
		-- IF (new.primer_apellido IS NULL OR new.primer_apellido = '') THEN  
		-- 	RAISE EXCEPTION 'El primer apellido no puede estar vacio';
		-- END IF;
		-- IF (new.segundo_apellido IS NULL OR new.segundo_apellido = '') THEN  
		-- 	RAISE EXCEPTION 'El segundo apellido no puede estar vacio';
		-- END IF;

		CASE new.tipo
		
			WHEN 'director_ejecutivo' THEN 

				IF (new.fk_empleado_jefe IS NOT NULL) THEN
					
					RAISE EXCEPTION 'El director ejecutivo no tiene jefe';	
				END IF;	

			WHEN 'director_area' THEN
			
				CALL VALIDAR_JERARQUIA_EMPLEADO_JEFE(new.fk_empleado_jefe,'director_ejecutivo');
				
			WHEN 'jefe' THEN

				CALL VALIDAR_JERARQUIA_EMPLEADO_JEFE(new.fk_empleado_jefe,'director_area');
				
			ELSE 
				RETURN null;
				
		END CASE;

		-- CALL VALIDAR_TELEFONO_TY(new.telefono);

		RETURN NEW;

	END IF;
    

	RETURN NULL;


END;
$$ LANGUAGE plpgsql;


-- DROP TRIGGER IF EXISTS TRIGGER_INSERT_EMPLEADO_JEFE ON EMPLEADO_JEFE CASCADE;	
-- DROP TRIGGER IF EXISTS TRIGGER_UPDATE_EMPLEADO_JEFE_TIPO_FK_EMPLEADO_JEFE ON EMPLEADO_JEFE CASCADE;

CREATE TRIGGER TRIGGER_INSERT_EMPLEADO_JEFE 
BEFORE INSERT ON EMPLEADO_JEFE 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_EMPLEADO_JEFE();

CREATE TRIGGER TRIGGER_UPDATE_EMPLEADO_JEFE
BEFORE UPDATE EMPLEADO_JEFE
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_EMPLEADO_JEFE();

CREATE TRIGGER TRIGGER_DELETE_EMPLEADO_JEFE
BEFORE DELETE EMPLEADO_JEFE
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_EMPLEADO_JEFE();
	

-- PRUEBAS
--
--INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
--('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_ejecutivo', null);
--
--INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
--('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_area', 1);
--
--UPDATE empleado_jefe SET tipo = 'jefe' , fk_empleado_jefe = 2  where id = 42;
--
--INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
--('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'jefe', 11);
--
--
--select * from empleado_jefe ej order by id DESC  limit 5;
--
--delete from empleado_jefe where id = 1;
--
--update empleado_jefe set fk_empleado_jefe=null, tipo='director_ejecutivo' where id=3;
--
--select id,tipo,fk_empleado_jefe from empleado_jefe ej where ej.id=3



-- A. Triggers para validar las jerarquías en lugar (si aplica); para validar tipo ciudad o país si aplica;

-- CREATE OR REPLACE function TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR()
-- RETURNS TRIGGER AS $$
-- DECLARE  

-- 	fk_lugar_temp_va LUGAR.fk_lugar%type ;
-- 	lugar_superior_registro LUGAR := NULL ;

-- BEGIN
	
-- 	-- VALIDACION DE JEREAQUIA DE LUGAR
	
-- 	raise notice '-------%------', NOW();
-- 	raise notice 'old.tipo %', old.tipo;
-- 	raise notice 'new.tipo %', new.tipo;
-- 	raise notice 'old.region %', old.region;
-- 	raise notice 'new.region %', new.region;
-- 	raise notice 'old.fk_lugar %', old.fk_lugar;
-- 	raise notice 'new.fk_lugar %', new.fk_lugar;


-- 	IF (new.fk_lugar is NOT NULL) then
	
-- 		fk_lugar_temp_va = new.fk_lugar;
	
-- 		select * into lugar_superior_registro from LUGAR where id = fk_lugar_temp_va;
-- 	END IF;
	

-- 	case new.tipo
	
-- 		when 'pais' then 
					
-- 			IF (lugar_superior_registro is null and new.region is not null) then
-- 				RETURN new;
-- 			ELSE 
-- 				RAISE EXCEPTION 'La referencia a la región del país es solo a través del atributo "region"';
-- 				RETURN null;	
-- 			END IF;	
		
-- 		when 'ciudad' then
		
-- 			IF (lugar_superior_registro.tipo = 'pais' and new.region is null) then
-- 				RETURN new;
-- 			ELSE 
-- 				RAISE EXCEPTION 'Las ciudades no tiene región asignada y deben referenciar a un país';
-- 				RETURN null;	
				
-- 			END IF;
			
-- 		ELSE 
-- 			RETURN null;
-- 	end case;

	
-- END;
-- $$ LANGUAGE plpgsql;


-- DROP TRIGGER IF EXISTS TRIGGER_INSERT_LUGAR ON LUGAR CASCADE;	
-- DROP TRIGGER IF EXISTS TRIGGER_UPDATE_LUGAR_TIPO_FK_LUGAR_REGION ON LUGAR CASCADE;


-- CREATE TRIGGER TRIGGER_INSERT_LUGAR 
-- BEFORE INSERT ON LUGAR 
-- FOR EACH ROW
-- EXECUTE PROCEDURE TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR();

-- CREATE TRIGGER TRIGGER_UPDATE_LUGAR_TIPO_FK_LUGAR_REGION
-- BEFORE UPDATE OF tipo, fk_lugar, region ON LUGAR
-- FOR EACH ROW
-- EXECUTE PROCEDURE TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR();
	
-- -- PRUEBAS

-- --INSERT INTO LUGAR (nombre,tipo,region,fk_lugar) VALUES ('prueba_pais','pais',null,null);
-- --INSERT INTO LUGAR (nombre,tipo,region,fk_lugar) VALUES ('prueba_ciudad','ciudad',null,1);
-- --
-- --select * from LUGAR;




-- A. Trigger para VALIDAR fk_lugar_ciudad y fk_lugar_pais en CLIENTE, ESTACION, OFICINA_PRINCIPAL, PERSONAL_INTELIGENCIA

-- CLIENTE















-- CREATE OR REPLACE FUNCTION TRIGGER_FUNCTION_CLIENTE()
-- RETURNS TRIGGER AS $$
-- DECLARE

-- 	fk_lugar_temp_va CLIENTE.fk_lugar_pais%type ;
-- 	lugar_tipo_va LUGAR.tipo%type ;

-- BEGIN

-- 	IF (new.fk_lugar_pais is NOT NULL) then
	
-- 		fk_lugar_temp_va = new.fk_lugar_pais;
	
-- 		select tipo into lugar_tipo_va from LUGAR where id = fk_lugar_temp_va;
	
-- 		IF (lugar_tipo_va = 'pais') then
-- 			RETURN new;
-- 		END IF;
		
-- 	END IF;
	

-- 	RAISE EXCEPTION 'Debe ingresar un país de registro para el cliente';
-- 	RETURN null;

	
-- END;
-- $$ LANGUAGE plpgsql;


-- DROP TRIGGER IF EXISTS TRIGGER_INSERT_CLIENTE ON CLIENTE CASCADE;	
-- DROP TRIGGER IF EXISTS TRIGGER_UPDATE_CLIENTE ON CLIENTE CASCADE;

-- CREATE TRIGGER TRIGGER_INSERT_CLIENTE
-- BEFORE INSERT ON CLIENTE 
-- FOR EACH ROW
-- EXECUTE PROCEDURE TRIGGER_FUNCTION_CLIENTE();

-- CREATE TRIGGER TRIGGER_UPDATE_CLIENTE
-- BEFORE UPDATE OF fk_lugar_pais ON CLIENTE
-- FOR EACH ROW
-- EXECUTE PROCEDURE TRIGGER_FUNCTION_CLIENTE();
	

-- PRUEBAS 
--
--INSERT INTO cliente (nombre_empresa, pagina_web, exclusivo, telefonos, contactos, fk_lugar_pais) VALUES
--('prueba', 'mexicaso.org.ve' ,true, ARRAY[CAST((0,0) as telefono_ty)],  ARRAY[ ROW('', '', '', '', '', ROW(0,0))]::contacto_ty[], 1);
--
--UPDATE CLIENTE set fk_lugar_pais = 11;
--
--select * from lugar where tipo = 'ciudad';










CREATE OR REPLACE FUNCTION TRIGGER_OFICINA_PRINCIPAL()
RETURNS TRIGGER AS $$
DECLARE

	numero_estaciones_dep integer;
	
BEGIN
	

    IF (TG_OP = 'DELETE') THEN
        
		SELECT COUNT(*) INTO numero_estaciones_dep FROM ESTACION WHERE fk_oficina_principal = old.id;
 
		IF (numero_estaciones_dep != 0) THEN 
			RAISE EXCEPTION 'No se puede eliminar la oficina ya que hay registros que dependen de ella';
		END IF;

		RETURN old;


	ELSIF (TG_OP = 'UPDATE') THEN
		
		-- IF (new.nombre IS NULL OR new.nombre = '') THEN  
		-- 	RAISE EXCEPTION 'El nombre no puede estar vacio';
		-- END IF;

		CALL VALIDAR_TIPO_LUGAR(new.fk_lugar_ciudad, 'ciudad');
		
		IF (new.sede = true) THEN 
			CALL VALIDAR_TIPO_EMPLEADO_JEFE(new.fk_director_ejecutivo, 'director_ejecutivo');

		ELSIF (new.fk_director_ejecutivo IS NOT NULL) THEN
			RAISE EXCEPTION 'Solo las oficinas sede pueden tener director ejecutivo';
			
		END IF;
			
		CALL VALIDAR_TIPO_EMPLEADO_JEFE(new.fk_director_area, 'director_area');

		RETURN new;


	ELSIF (TG_OP = 'INSERT') THEN

		-- IF (new.nombre IS NULL OR new.nombre = '') THEN  
		-- 	RAISE EXCEPTION 'El nombre no puede estar vacio';
		-- END IF;

		CALL VALIDAR_TIPO_LUGAR(new.fk_lugar_ciudad, 'ciudad');
		
		IF (new.sede = true) THEN 
			CALL VALIDAR_TIPO_EMPLEADO_JEFE(new.fk_director_ejecutivo, 'director_ejecutivo');

		ELSIF (new.fk_director_ejecutivo IS NOT NULL) THEN
			RAISE EXCEPTION 'Solo las oficinas sede pueden tener director ejecutivo';
			
		END IF;
			
		CALL VALIDAR_TIPO_EMPLEADO_JEFE(new.fk_director_area, 'director_area');
	
		
		RETURN new;

	END IF;
    

	RETURN NULL;

END;
$$ LANGUAGE plpgsql;





-- DROP TRIGGER IF EXISTS TRIGGER_OFICINA_PRINCIPAL ON OFICINA_PRINCIPAL CASCADE;	
-- DROP TRIGGER IF EXISTS TRIGGER_OFICINA_PRINCIPAL ON OFICINA_PRINCIPAL CASCADE;

CREATE TRIGGER TRIGGER_INSERT_OFICINA_PRINCIPAL
BEFORE INSERT ON OFICINA_PRINCIPAL 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_OFICINA_PRINCIPAL();

CREATE TRIGGER TRIGGER_UPDATE_OFICINA_PRINCIPAL
BEFORE UPDATE ON OFICINA_PRINCIPAL
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_OFICINA_PRINCIPAL();

CREATE TRIGGER TRIGGER_DELETE_OFICINA_PRINCIPAL
BEFORE DELETE ON OFICINA_PRINCIPAL 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_OFICINA_PRINCIPAL();
	




-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! FALTA EL DE ESTACION, OFICINA_PRINCIPAL y PERSONAL_INTELIGENCIA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 















-- B. Para los empleados Jefe deben validar también que los jefes de estaciones tengan como director de área el que corresponde según su ubicación y demás características de las reglas vinculadas.
--
-- C. Función edad y validar personal > 26 años. Validar aliases y edades (familair_ty y personal)
--
-- D. Triggers para validar los arcos exclusivos que apliquen.
--
-- E. Triggers para copiar la info necesaria previa eliminación (Piezas de inteligencia, hechos crudos con venta exclusiva e informantes y contactos cuando el agente se va, cambia de rol o es despedido.)
--
-- F. Trigger para fuente = secreta debe tener id de contacto_pagoinformante
--
-- G. Trigger controlar actualización de una pieza de inteligencia registrada

-- EXTRAS:

-- VALIDAR EL NUMERO DE TELEFONOS, CONTACTOS, etc ( CREO QUE LA INSERCION ES CON UN PROCEDURE )




--drop function fallos cascade
--drop function verif_hora cascade
