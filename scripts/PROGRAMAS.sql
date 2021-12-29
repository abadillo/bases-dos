--DROP TRIGGER modif_producto ON producto;
--ALTER TABLE producto ENABLE TRIGGER insert_producto;
--ALTER TABLE producto DISABLE TRIGGER insert_producto;
--ALTER TABLE producto ENABLE TRIGGER all;
--ALTER TABLE producto DISABLE TRIGGER ALL;

DROP TRIGGER IF EXISTS MODIF_EMPLEADO_JEFE ON EMPLEADO_JEFE CASCADE;



-- A. Triggers para validar las jerarquías en empleado_jefe, en lugar (si aplica); para validar tipo ciudad o país si aplica;


CREATE OR REPLACE function VERIF_JERARQUIA_EMPLEADO_JEFE()
RETURNS TRIGGER AS $$
DECLARE  

	fk_empleado_jefe_va EMPLEADO_JEFE.fk_empleado_jefe%type,
	jefe_va EMPLEADO_JEFE := NULL ;
	director_ejecutivo_va EMPLEADO_JEFE := NULL ;

BEGIN
	
	-- VALIDACION DE JEREAQUIA DE JEFES
	
	if (new.fk_empleado_jefe is NOT NULL) then
	
		fk_empleado_jefe_va = new.fk_empleado_jefe;
	
		select * into jefe_va from EMPLEADO_JEFE where id = fk_empleado_jefe_va;
	end if;
	

	case new.tipo
		when 'director_ejecutivo' then 
		
			select * into director_ejecutivo_va from EMPLEADO_JEFE where tipo = 'director_ejecutivo';
	 
			if (director_ejecutivo_va is NOT NULL) then 
				raise exception 'Solo puede haber un solo director ejecutivo';
				return null;
			end if;
			
		
			if (jefe_va is null) then
				return new;
			else 
				raise exception 'El director ejecutivo no tiene jefe';
				return null;	
			end if;	
		
		
		
		when 'director_area' then
		
			if (jefe_va.tipo = 'director_ejecutivo') then
				return new;
			else 
				raise exception 'El jefe de un director de area debe ser el director ejecutivo';
				return null;	
				
			end if;
	
		when 'jefe' then
		
			if (jefe_va.tipo = 'director_area') then
				return new;
			else 
				raise exception 'El jefe de jefe de estación debe ser un director de area';
				return null;	
				
			end if;
		
		else 
			return new;
	end case;

	
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER INSERT_EMPLEADO_JEFE 
BEFORE INSERT ON EMPLEADO_JEFE 
FOR EACH ROW
EXECUTE PROCEDURE VERIF_JERARQUIA_EMPLEADO_JEFE();

CREATE TRIGGER UPDATE_EMPLEADO_JEFE_TIPO
BEFORE UPDATE OF tipo ON EMPLEADO_JEFE
FOR EACH ROW
EXECUTE PROCEDURE VERIF_JERARQUIA_EMPLEADO_JEFE();
	

-- PRUEBAS

INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_ejecutivo', 2);


INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_area', 11);


INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'jefe', 11);


select * from empleado_jefe ej order by id desc  limit 5;


--
-- PONER FKS DE EMPLEADO JEFE COMO = 0 IF NULL





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







--drop function fallos cascade
--drop function verif_hora cascade
