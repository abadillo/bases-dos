

-- A. Triggers para validar las jerarquías en empleado_jefe

CREATE OR REPLACE function TRIGGER_EMPLEADO_JEFE()
RETURNS TRIGGER AS $$
BEGIN
	
	IF (TG_OP = 'DELETE') THEN
        
		--/
		RETURN OLD;

	ELSIF (TG_OP = 'UPDATE') THEN
		
		IF (new.tipo = old.tipo ) THEN
			RAISE INFO 'El cargo nuevo y el cargo viejo son iguales';
        	RAISE EXCEPTION 'El cargo nuevo y el cargo viejo son iguales';
		END IF;

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

CREATE TRIGGER TRIGGER_EMPLEADO_JEFE 
BEFORE INSERT OR UPDATE OR DELETE ON EMPLEADO_JEFE 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_EMPLEADO_JEFE();


-- CREATE TRIGGER TRIGGER_DELETE_EMPLEADO_JEFE
-- BEFORE DELETE EMPLEADO_JEFE
-- FOR EACH ROW
-- EXECUTE PROCEDURE TRIGGER_EMPLEADO_JEFE();
	

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


	IF (new.fk_lugar is NOT NULL) then
	
		fk_lugar_temp_va = new.fk_lugar;
	
		select * into lugar_superior_registro from LUGAR where id = fk_lugar_temp_va;
	END IF;
	

	case new.tipo
	
		when 'pais' then 
					
			IF (lugar_superior_registro is null and new.region is not null) then
				RETURN new;
			ELSE 
				RAISE EXCEPTION 'La referencia a la región del país es solo a través del atributo "region"';
				RETURN null;	
			END IF;	
		
		when 'ciudad' then
		
			IF (lugar_superior_registro.tipo = 'pais' and new.region is null) then
				RETURN new;
			ELSE 
				RAISE EXCEPTION 'Las ciudades no tiene región asignada y deben referenciar a un país';
				RETURN null;	
				
			END IF;
			
		ELSE 
			RETURN null;
	end case;

	
END;
$$ LANGUAGE plpgsql;


-- DROP TRIGGER IF EXISTS TRIGGER_INSERT_LUGAR ON LUGAR CASCADE;	
-- DROP TRIGGER IF EXISTS TRIGGER_UPDATE_LUGAR_TIPO_FK_LUGAR_REGION ON LUGAR CASCADE;


CREATE TRIGGER TRIGGER_INSERT_LUGAR 
BEFORE INSERT OR UPDATE ON LUGAR 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR();

	
-- -- PRUEBAS

-- --INSERT INTO LUGAR (nombre,tipo,region,fk_lugar) VALUES ('prueba_pais','pais',null,null);
-- --INSERT INTO LUGAR (nombre,tipo,region,fk_lugar) VALUES ('prueba_ciudad','ciudad',null,1);
-- --
-- --select * from LUGAR;



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

CREATE TRIGGER TRIGGER_OFICINA_PRINCIPAL
BEFORE INSERT OR UPDATE OR DELETE ON OFICINA_PRINCIPAL 
FOR EACH ROW
EXECUTE PROCEDURE TRIGGER_OFICINA_PRINCIPAL();

	
---------------------////////////////-----------------------


CREATE OR REPLACE FUNCTION TRIGGER_PERSONAL_INTELIGENCIA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE

	personal_reg personal_inteligencia%rowtype;
	i integer;

BEGIN
	
	----INFORMACION A INSERTAR EN PERSONAL INTELIGENCIA
	
	IF (TG_OP = 'DELETE') THEN
        
		--/
		RETURN OLD;

	ELSIF (TG_OP = 'UPDATE') THEN

		IF (new.primer_nombre = '') THEN
			RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE';
		END IF;
		
		IF ((new.primer_apellido = '') OR (new.segundo_apellido = '')) THEN
			RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
		END IF;

		IF (new.peso_kg <= 0 OR new.altura_cm <= 0 ) THEN
			RAISE EXCEPTION 'Ni el peso ni la altura pueden ser negativos ni cero';
		END IF;


		---- VALIDAR LA FECHA DEL PERSONAL DE INTELIGENCIA MAYOR DE 26 AÑOS ------
		IF (FUNCION_EDAD(new.fecha_nacimiento) = FALSE) THEN
		---MENOR DE 26 AÑOS
			RAISE EXCEPTION 'NO ES PERMITIDO LA EDAD DEL PERSONAL';
			RETURN NULL;		
		END IF;
		
		---MAYOR DE 26 AÑOS		
		RAISE INFO 'EDAD PERMITIDA PARA INGRESO DE PERSONAL';
		
		-----VALIDACION DEL FAMILIAR ---------

		---EL PERSONAL DE INTELIGENCIA DEBE TENER DOS FAMILIARES
		IF (new.familiares[2] IS NULL OR new.familiares[1] IS NULL ) THEN
			RAISE EXCEPTION 'DEBE TENER DOS FAMILIARES EL PERSONAL DE INTELIGENCIA A INSERTAR';			
			RETURN NULL;		
		END IF;			


		-- RAISE INFO 'INFORMACION DEL PERSONAL(NOMBRE COMPLETO Y EDAD): %, %, %, %, %',new.primer_nombre, new.segundo_nombre, new.primer_apellido, new.segundo_apellido, fu_obtener_edad (new.fecha_nacimiento::DATE, NOW()::DATE);
		
		-- RAISE INFO 'INFORMACION DEL PRIMER FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, % ',new.familiares[1].primer_nombre, new.familiares[1].segundo_nombre, new.familiares[1].primer_apellido, new.familiares[1].segundo_apellido,fu_obtener_edad (new.familiares[1].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[1].parentesco, new.familiares[1].telefono;

		-- RAISE INFO 'INFORMACION DEL SEGUNDO FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, %',new.familiares[2].primer_nombre, new.familiares[2].segundo_nombre, new.familiares[2].primer_apellido, new.familiares[2].segundo_apellido,fu_obtener_edad (new.familiares[2].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[2].parentesco, new.familiares[2].telefono;

		RETURN NEW;


	ELSIF (TG_OP = 'INSERT') THEN


		IF (new.primer_nombre = '') THEN
			RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE';
		END IF;
		
		IF ((new.primer_apellido = '') OR (new.segundo_apellido = '')) THEN
			RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
		END IF;

		IF (new.peso_kg <= 0 OR new.altura_cm <= 0 ) THEN
			RAISE EXCEPTION 'Ni el peso ni la altura pueden ser negativos ni cero';
		END IF;


		---- VALIDAR LA FECHA DEL PERSONAL DE INTELIGENCIA MAYOR DE 26 AÑOS ------
		IF (FUNCION_EDAD(new.fecha_nacimiento) = FALSE) THEN
		---MENOR DE 26 AÑOS
			RAISE EXCEPTION 'NO ES PERMITIDO LA EDAD DEL PERSONAL';
			RETURN NULL;		
		END IF;
		
		---MAYOR DE 26 AÑOS		
		RAISE INFO 'EDAD PERMITIDA PARA INGRESO DE PERSONAL';
		
		-----VALIDACION DEL FAMILIAR ---------

		---EL PERSONAL DE INTELIGENCIA DEBE TENER DOS FAMILIARES
		IF (new.familiares[2] IS NULL OR new.familiares[1] IS NULL ) THEN
			RAISE EXCEPTION 'DEBE TENER DOS FAMILIARES EL PERSONAL DE INTELIGENCIA A INSERTAR';			
			RETURN NULL;		
		END IF;			


		RAISE INFO 'INFORMACION DEL PERSONAL(NOMBRE COMPLETO Y EDAD): %, %, %, %, %',new.primer_nombre, new.segundo_nombre, new.primer_apellido, new.segundo_apellido, fu_obtener_edad (new.fecha_nacimiento::DATE, NOW()::DATE);
		
		RAISE INFO 'INFORMACION DEL PRIMER FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, % ',new.familiares[1].primer_nombre, new.familiares[1].segundo_nombre, new.familiares[1].primer_apellido, new.familiares[1].segundo_apellido,fu_obtener_edad (new.familiares[1].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[1].parentesco, new.familiares[1].telefono;

		RAISE INFO 'INFORMACION DEL SEGUNDO FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, %',new.familiares[2].primer_nombre, new.familiares[2].segundo_nombre, new.familiares[2].primer_apellido, new.familiares[2].segundo_apellido,fu_obtener_edad (new.familiares[2].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[2].parentesco, new.familiares[2].telefono;

		RETURN NEW;


	END IF;


	RETURN NULL;

END
$$;


-- INSERT INTO personal_inteligencia (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, altura_cm, peso_kg, color_ojos, vision, class_seguridad, fotografia, huella_retina, huella_digital, telefono, licencia_manejo, idiomas, familiares, identificaciones, nivel_educativo, aliases, fk_lugar_ciudad) VALUES
-- ('Florentina','Mariluz','Landa','Heredia','1993-03-05',189,66,'verde claro','20/25','top_secret','personal_inteligencia_data/foto.png','personal_inteligencia_data/huella_digital.png','personal_inteligencia_data/huella_retina.png',ROW(58,4145866510) ,ROW('75518194','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Araceli',null,'Alcantara','Candelaria','1960-06-01','tío',ROW(58,4145335249) ), ROW('Calixtrato','Vicente','Quintanilla','Estrada','1960-06-01','hermano',ROW(58,4142583859) )]::familiar_ty[], ARRAY[ ROW('31656053','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Economía','Máster','Finanzas')]::nivel_educativo_ty[],null,'10');

-- DROP FUNCTION TRIGGER_PERSONAL_INTELIGENCIA();

CREATE TRIGGER TRIGGER_INSERT_UPDATE_PERSONAL_INTELIGENCIA
BEFORE INSERT OR UPDATE ON PERSONAL_INTELIGENCIA
FOR EACH ROW EXECUTE FUNCTION TRIGGER_PERSONAL_INTELIGENCIA();


-- DROP TRIGGER TRIGGER_INSERT_UPDATE_PERSONAL_INTELIGENCIA ON PERSONAL_INTELIGENCIA



--------------------------------/\/\/\/\/\/\/\/\///\/\/\//\/\//\/\/\\\/-----------------------------



CREATE OR REPLACE FUNCTION TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
	area_interes_reg AREA_INTERES%ROWTYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL TRIGGER TRIGGER_REGISTRO_TEMAS_CLEINTE_ADQUISICION ( % ) ------', NOW();
	
	-------------///////////--------------	

	RAISE INFO 'datos de la aquisicion: %', new;

	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = new.fk_pieza_inteligencia;
    RAISE INFO 'datos de la pieza: %', area_interes_reg;

	SELECT * INTO area_interes_reg FROM AREA_INTERES WHERE fk_clas_tema = pieza_reg.fk_clas_tema AND fk_cliente = new.fk_cliente ;
    RAISE INFO 'datos del AREA_INTERES: %', area_interes_reg;


	IF (area_interes_reg IS NULL) THEN
   
		INSERT INTO AREA_INTERES (
			fk_clas_tema, 
			fk_cliente
		) VALUES (

			pieza_reg.fk_clas_tema, 
			new.fk_cliente 
		
		) RETURNING * INTO area_interes_reg;


		RAISE INFO 'REGISTRO AREA_INTERES!';
		RAISE INFO 'Datos de area_intereses: %', area_interes_reg ; 
	  	
	ELSE
		RAISE INFO 'AREA_INTERESES YA REGISTRADA';
	

	END IF;	
 
	RETURN NULL;

END $$;

----DROP PROCEDURE TRIGGER_COPIA_ADQUISICION(integer)

CREATE TRIGGER TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION
AFTER INSERT ON ADQUISICION
FOR EACH ROW EXECUTE FUNCTION TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION();
