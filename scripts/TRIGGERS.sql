--ALTER TABLE producto ENABLE TRIGGER insert_producto;
--ALTER TABLE producto DISABLE TRIGGER insert_producto;
--ALTER TABLE producto ENABLE TRIGGER all;
--ALTER TABLE producto DISABLE TRIGGER ALL;




-- A. Triggers para validar las jerarquías en empleado_jefe

CREATE OR REPLACE function TRIGGER_FUNCTION_VERIF_JERARQUIA_EMPLEADO_JEFE()
RETURNS TRIGGER AS $$
DECLARE  

	fk_empleado_jefe_temp_va EMPLEADO_JEFE.fk_empleado_jefe%type ;
	jefe_superior_registro EMPLEADO_JEFE := NULL ;
--	director_ejecutivo_va EMPLEADO_JEFE := NULL ;

BEGIN
	
	-- VALIDACION DE JEREAQUIA DE JEFES
	
	raise notice '-------%------', NOW();
	raise notice 'old.tipo %', old.tipo;
	raise notice 'new.tipo %', new.tipo;
	raise notice 'old.fk_empleado_jefe %', old.fk_empleado_jefe;
	raise notice 'new.fk_empleado_jefe %', new.fk_empleado_jefe;


	
	if (new.fk_empleado_jefe is NOT NULL) then
	
		fk_empleado_jefe_temp_va = new.fk_empleado_jefe;
	
		select * into jefe_superior_registro from EMPLEADO_JEFE where id = fk_empleado_jefe_temp_va;
	end if;
	

	case new.tipo
		when 'director_ejecutivo' then 
		
--			select * into director_ejecutivo_va from EMPLEADO_JEFE where tipo = 'director_ejecutivo';
--	 
--			if (director_ejecutivo_va is NOT NULL) then 
--				raise exception 'Solo puede haber un solo director ejecutivo';
--				return null;
--			end if;
			
			if (jefe_superior_registro is null) then
				return new;
			else 
				raise exception 'El director ejecutivo no tiene jefe';
				return null;	
			end if;	
		
		when 'director_area' then
		
			if (jefe_superior_registro.tipo = 'director_ejecutivo') then
				return new;
			else 
				raise exception 'El jefe de un director de area debe ser el director ejecutivo';
				return null;	
				
			end if;
	
		when 'jefe' then
		
			if (jefe_superior_registro.tipo = 'director_area') then
				return new;
			else 
				raise exception 'El jefe de jefe de estación debe ser un director de area';
				return null;	
				
			end if;
		
		else 
			return null;
	end case;

	
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS TRIGGER_INSERT_EMPLEADO_JEFE ON EMPLEADO_JEFE CASCADE;	
DROP TRIGGER IF EXISTS TRIGGER_UPDATE_EMPLEADO_JEFE_TIPO_FK_EMPLEADO_JEFE ON EMPLEADO_JEFE CASCADE;

CREATE TRIGGER TRIGGER_INSERT_EMPLEADO_JEFE 
BEFORE INSERT ON EMPLEADO_JEFE 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_FUNCTION_VERIF_JERARQUIA_EMPLEADO_JEFE();

CREATE TRIGGER TRIGGER_UPDATE_EMPLEADO_JEFE_TIPO_FK_EMPLEADO_JEFE
BEFORE UPDATE OF tipo,fk_empleado_jefe ON EMPLEADO_JEFE
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_FUNCTION_VERIF_JERARQUIA_EMPLEADO_JEFE();
	

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

CREATE OR REPLACE function TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR()
RETURNS TRIGGER AS $$
DECLARE  

	fk_lugar_temp_va LUGAR.fk_lugar%type ;
	lugar_superior_registro LUGAR := NULL ;

BEGIN
	
	-- VALIDACION DE JEREAQUIA DE LUGAR
	
	raise notice '-------%------', NOW();
	raise notice 'old.tipo %', old.tipo;
	raise notice 'new.tipo %', new.tipo;
	raise notice 'old.region %', old.region;
	raise notice 'new.region %', new.region;
	raise notice 'old.fk_lugar %', old.fk_lugar;
	raise notice 'new.fk_lugar %', new.fk_lugar;


	if (new.fk_lugar is NOT NULL) then
	
		fk_lugar_temp_va = new.fk_lugar;
	
		select * into lugar_superior_registro from LUGAR where id = fk_lugar_temp_va;
	end if;
	

	case new.tipo
	
		when 'pais' then 
					
			if (lugar_superior_registro is null and new.region is not null) then
				return new;
			else 
				raise exception 'La referencia a la región del país es solo a través del atributo "region"';
				return null;	
			end if;	
		
		when 'ciudad' then
		
			if (lugar_superior_registro.tipo = 'pais' and new.region is null) then
				return new;
			else 
				raise exception 'Las ciudades no tiene región asignada y deben referenciar a un país';
				return null;	
				
			end if;
			
		else 
			return null;
	end case;

	
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS TRIGGER_INSERT_LUGAR ON LUGAR CASCADE;	
DROP TRIGGER IF EXISTS TRIGGER_UPDATE_LUGAR_TIPO_FK_LUGAR_REGION ON LUGAR CASCADE;


CREATE TRIGGER TRIGGER_INSERT_LUGAR 
BEFORE INSERT ON LUGAR 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR();

CREATE TRIGGER TRIGGER_UPDATE_LUGAR_TIPO_FK_LUGAR_REGION
BEFORE UPDATE OF tipo, fk_lugar, region ON LUGAR
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR();
	
-- PRUEBAS

--INSERT INTO LUGAR (nombre,tipo,region,fk_lugar) VALUES ('prueba_pais','pais',null,null);
--INSERT INTO LUGAR (nombre,tipo,region,fk_lugar) VALUES ('prueba_ciudad','ciudad',null,1);
--
--select * from LUGAR;




-- A. Trigger para verificar fk_lugar_ciudad y fk_lugar_pais en CLIENTE, ESTACION, OFICINA_PRINCIPAL, PERSONAL_INTELIGENCIA

-- CLIENTE

CREATE OR REPLACE FUNCTION TRIGGER_FUNCTION_CLIENTE()
RETURNS TRIGGER AS $$
DECLARE

	fk_lugar_temp_va CLIENTE.fk_lugar_pais%type ;
	lugar_tipo_va LUGAR.tipo%type ;

BEGIN

	if (new.fk_lugar_pais is NOT NULL) then
	
		fk_lugar_temp_va = new.fk_lugar_pais;
	
		select tipo into lugar_tipo_va from LUGAR where id = fk_lugar_temp_va;
	
		if (lugar_tipo_va = 'pais') then
			return new;
		end if;
		
	end if;
	

	raise exception 'Debe ingresar un país de registro para el cliente';
	return null;

	
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS TRIGGER_INSERT_CLIENTE ON CLIENTE CASCADE;	
DROP TRIGGER IF EXISTS TRIGGER_UPDATE_CLIENTE ON CLIENTE CASCADE;

CREATE TRIGGER TRIGGER_INSERT_CLIENTE
BEFORE INSERT ON CLIENTE 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_FUNCTION_CLIENTE();

CREATE TRIGGER TRIGGER_UPDATE_CLIENTE
BEFORE UPDATE OF fk_lugar_pais ON CLIENTE
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_FUNCTION_CLIENTE();
	

-- PRUEBAS 
--
--INSERT INTO cliente (nombre_empresa, pagina_web, exclusivo, telefonos, contactos, fk_lugar_pais) VALUES
--('prueba', 'mexicaso.org.ve' ,true, ARRAY[CAST((0,0) as telefono_ty)],  ARRAY[ ROW('', '', '', '', '', ROW(0,0))]::contacto_ty[], 1);
--
--UPDATE CLIENTE set fk_lugar_pais = 11;
--
--select * from lugar where tipo = 'ciudad';












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
