CREATE OR REPLACE FUNCTION fu_obtener_edad(pd_fecha_ini DATE, pd_fecha_fin DATE)
RETURNS INTEGER
LANGUAGE 'plpgsql' 
AS $$

BEGIN

	RETURN FLOOR(((DATE_PART('YEAR',pd_fecha_fin)-DATE_PART('YEAR',pd_fecha_ini))* 372 + (DATE_PART('MONTH',pd_fecha_fin) - DATE_PART('MONTH',pd_fecha_ini))*31 + (DATE_PART('DAY',pd_fecha_fin)-DATE_PART('DAY',pd_fecha_ini)))/372);
	
END

$$;

DROP FUNCTION fu_obtener_edad(date, date)

SELECT fu_obtener_edad ('1993-03-05',NOW()::DATE)


CREATE OR REPLACE FUNCTION FUNCION_EDAD(fecha_nacimiento date)
RETURNS BOOLEAN
LANGUAGE PLPGSQL
AS $$
DECLARE
	
	fecha_va integer;
		
BEGIN
	
	fecha_va = fu_obtener_edad (fecha_nacimiento, NOW()::DATE);
	
	IF (fecha_va < 26  ) THEN
		RAISE INFO 'NO ES LA EDAD PERMITIDA PARA SER UN PERSONAL DE INTELIGENCIA, MINIMO DEBES TENER 26 AÑOS DE EDAD';		
		RAISE EXCEPTION 'NO ES LA EDAD PERMITIDA PARA SER UN PERSONAL DE INTELIGENCIA, MINIMO DEBES TENER 26 AÑOS DE EDAD';		
		RETURN NULL;
	ELSIF (fecha_va > 80) THEN
		RAISE INFO 'EDAD: %', fecha_va;
		RAISE EXCEPTION 'NO ES POSIBLE EN EL RANGO DE EDADES';
		RETURN NULL;
	ELSE 			
		RETURN TRUE;
	END IF;
END
$$;

CREATE OR REPLACE PROCEDURE PROCEDIMIENTO_FAMILIARES (primer_nombre varchar, segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar, fecha_nacimiento timestamp,parentesco varchar,telefono telefono_ty )



CREATE OR REPLACE FUNCTION TRIGGER_INSERT_PERSONAL()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	personal_reg personal_inteligencia%rowtype;
	
BEGIN
	----INFORMACION A INSERTAR EN PERSONAL INTELIGENCIA
	RAISE INFO 'INFORMACION DEL PERSONAL: %',new;
	RAISE INFO 'FAMILIARES %',new.familiares[1];
		
	IF (FUNCION_EDAD(new.fecha_nacimiento) IS NOT NULL) THEN	
		RAISE INFO 'EDAD PERMITIDA PARA INGRESO DE PERSONAL';
		RAISE INFO 'EDAD A INGRESAR : %', fecha_va;
		RETURN NEW;
		
	ELSE 
		RAISE EXCEPTION 'NO ES PERMITIDO LA EDAD DEL PERSONAL';
		RETURN NULL;		
	END IF;

END
$$;

INSERT INTO personal_inteligencia (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, altura_cm, peso_kg, color_ojos, vision, class_seguridad, fotografia, huella_retina, huella_digital, telefono, licencia_manejo, idiomas, familiares, identificaciones, nivel_educativo, aliases, fk_lugar_ciudad) VALUES
('Florentina','Mariluz','Landa','Heredia','2003-03-05',189,66,'verde claro','20/25','top_secret','personal_inteligencia_data/foto.png','personal_inteligencia_data/huella_digital.png','personal_inteligencia_data/huella_retina.png',ROW(58,4145866510) ,ROW('75518194','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Araceli',null,'Alcantara','Candelaria','1960-06-01','tío',ROW(58,4145335249) ), ROW('Calixtrato','Vicente','Quintanilla','Estrada','1960-06-01','hermano',ROW(58,4142583859) )]::familiar_ty[], ARRAY[ ROW('31656053','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Economía','Máster','Finanzas')]::nivel_educativo_ty[],null,'10');

DROP FUNCTION TRIGGER_INSERT_PERSONAL()

CREATE TRIGGER TRIGGER_INSERT_PERSONAL
BEFORE INSERT ON personal_inteligencia
FOR EACH ROW EXECUTE FUNCTION TRIGGER_INSERT_PERSONAL()

DROP TRIGGER TRIGGER_INSERT_PERSONAL ON personal_inteligencia




