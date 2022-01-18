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

CREATE OR REPLACE PROCEDURE PROCEDIMIENTO_VALIDAR_FAMILIARES(primer_nombre varchar, primer_apellido varchar, segundo_apellido varchar,fecha_nacimiento timestamp, parentesco varchar)
LANGUAGE PLPGSQL
AS $$
DECLARE
	fecha_va integer;

BEGIN

	fecha_va = fu_obtener_edad (fecha_nacimiento::DATE, NOW()::DATE);
	
	IF (primer_nombre IS NULL OR primer_nombre = ' ') THEN
		RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE FAMILIAR';
	END IF;
	
	IF ((primer_apellido IS NULL OR primer_apellido = ' ') AND (segundo_apellido IS NULL OR segundo_apellido = ' ')) THEN
		RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
	END IF;
	
	IF (fecha_va < 26) THEN
		RAISE INFO 'NO ES LA EDAD PERMITIDA PARA SER FAMILIAR DE UN PERSONAL DE INTELIGENCIA, MINIMO DEBE TENER 26 AÑOS DE EDAD';		
		RAISE EXCEPTION 'NO ES LA EDAD PERMITIDA PARA SER FAMILIAR DE UN PERSONAL DE INTELIGENCIA, MINIMO DEBE TENER 26 AÑOS DE EDAD';		
		
	ELSIF (fecha_va > 100) THEN
		RAISE INFO 'EDAD: %', fecha_va;
		RAISE EXCEPTION 'NO ES POSIBLE EL INGRESO DE EDAD';
	END IF;		
	
	IF (parentesco = ' ' OR parentesco IS NULL) THEN
		RAISE EXCEPTION 'EL FAMILIAR DEBE TENER UN PARENTESCO CON EL PERSONAL DE INTELIGENCIA ';
	END IF;

END

$$;

CREATE OR REPLACE PROCEDURE VALIDAR_TELEFONO (codigo numeric(10), numero NUMERIC(15))
LANGUAGE plpgsql
AS $$ 
BEGIN

	IF (codigo IS NULL OR codigo = 0) THEN
		RAISE EXCEPTION 'El codigo del telefono no puede ser nulo';
	END IF;

	IF (numero IS NULL OR numero = 0) THEN
		RAISE EXCEPTION 'El numero del telefono no puede ser nulo';
	END IF;
	
END $$;
DROP PROCEDURE VALIDAR_TELEFONO (NUMERIC, NUMERIC)


CREATE OR REPLACE FUNCTION CREAR_TELEFONO (codigo numeric(10), numero NUMERIC(15))
RETURNS telefono_ty
LANGUAGE plpgsql
AS $$ 
BEGIN

	IF (codigo IS NULL OR codigo = 0) THEN
		RAISE EXCEPTION 'El codigo del telefono no puede ser nulo';
	END IF;

	IF (numero IS NULL OR numero = 0) THEN
		RAISE EXCEPTION 'El numero del telefono no puede ser nulo';
	END IF;

 	RETURN ROW(codigo,numero)::telefono_ty; 

END $$;
DROP FUNCTION CREAR_TELEFONO(NUMERIC,NUMERIC)

CREATE OR REPLACE FUNCTION FUNCION_INSERTAR_IDENTIFICACION (documento varchar, pais varchar)
RETURNS identificacion_ty
LANGUAGE PLPGSQL
AS $$

BEGIN 
	
	IF (documento IS NULL OR documento = ' ') THEN
		RAISE INFO 'NUMERO DE ID DE DOCUMENTO ESTA VACIO';
	END IF;
	
	IF (pais IS NULL OR pais = ' ') THEN
		RAISE INFO 'EL PAIS DEL DOCUMENTO DE INDENTIFICACION ESTA VACIO';			
	END IF;
	
	
	RETURN ROW(documento,pais)::identificacion_ty;

END
$$;


CREATE OR REPLACE FUNCTION CREAR_NIVEL_EDUCATIVO (pregra varchar, postgrado_tip varchar, postgrado_titulo varchar)
RETURNS nivel_educativo_ty
LANGUAGE PLPGSQL
AS 
$$
BEGIN
	IF (pregra IS NULL OR pregra = ' ') THEN
		RAISE EXCEPTION 'EL PERSONAL NO TIENE NIVEL DE PREGRADO';
	END IF;
	
	IF (postgrado_tip IS NULL OR postgrado = ' ') THEN
		RAISE EXCEPTION 'EL PERSONAL NO TIENE TIPO DE POSTGRADO';
	END IF;
	
	IF (postgreado_titulo IS NULL OR postgreado_titulo = ' ') THEN
		RAISE EXCEPTION ' EL PERSONAL NO TIENE TITULO DE POSTGRADO';
	END IF;
	
	RETURN ROW(pregra,postgrado_tip,postgreado_titulo)::nivel_educativo_ty;
END
$$;

CREATE OR REPLACE FUNCTION TRIGGER_INSERT_PERSONAL()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	personal_reg personal_inteligencia%rowtype;
	i integer;
BEGIN
	
	----INFORMACION A INSERTAR EN PERSONAL INTELIGENCIA
	
	RAISE INFO 'INFORMACION DEL PERSONAL(NOMBRE COMPLETO Y EDAD): %, %, %, %, %',new.primer_nombre, new.segundo_nombre, new.primer_apellido, new.segundo_apellido, fu_obtener_edad (new.fecha_nacimiento::DATE, NOW()::DATE);
	RAISE INFO 'INFORMACION DEL PRIMER FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, % ',new.familiares[1].primer_nombre, new.familiares[1].segundo_nombre, new.familiares[1].primer_apellido, new.familiares[1].segundo_apellido,fu_obtener_edad (new.familiares[1].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[1].parentesco, CREAR_TELEFONO(new.familiares[1].telefono.codigo,new.familiares[1].telefono.numero);
	RAISE INFO 'INFORMACION DEL SEGUNDO FAMILIAR (NOMBRE COMPLETO, EDAD, PARENTESCO Y TELEFONO): %, %, %, %, %, %, %',new.familiares[2].primer_nombre, new.familiares[2].segundo_nombre, new.familiares[2].primer_apellido, new.familiares[2].segundo_apellido,fu_obtener_edad (new.familiares[2].fecha_nacimiento::DATE, NOW()::DATE), new.familiares[2].parentesco, CREAR_TELEFONO(new.familiares[2].telefono.codigo,new.familiares[2].telefono.numero);
	
	
	
	----VALIDACION DE LAS IDENTIFICACIONES -----
	RAISE INFO '%', new.identificaciones;
	
	----CICLO PARA INSERTAR TODAS LAS IDENTIFICACIONES QUE TENGA EL PERSONAL DE INTELIGENCIA----
	i=2;
	WHILE (i <=5 ) LOOP
		---VALIDA SI TIENE UNA IDENTIFICACION MINIMO---
		IF (FUNCION_INSERTAR_IDENTIFICACION(new.identificaciones[1].documento_identidad,new.identificaciones[1].pais) IS NULL) THEN

			RAISE EXCEPTION 'EL PERSONAL DE INTELIGENCIA DEBE TENER IDENTIFICACION';

		END IF; 	
		---IDENTIFICA SI TIENE MAS DE UNA IDENTIFICACION---
		IF(new.identificaciones[i].documento_identidad IS NULL AND new.identificaciones[i].pais IS NULL) THEN
		
			RAISE INFO 'EL PERSONAL DE INTELIGENCIA NO TIENE IDENTIFICACION %', i;
			
		ELSIF (new.identificaciones[i].documento_identidad IS NOT NULL AND new.identificaciones[i].pais IS NOT NULL) THEN
		
			CALL FUNCION_INSERTAR_IDENTIFICACION(new.identificaciones[1].documento_identidad,new.identificaciones[1].pais);
		
		END IF;			
		i=i+1;
	END LOOP;
		
	---NIVEL EDUCATIVO DEL PERSONAL DE INTELIGENCIA---
	
	
	
	
		   
	

	---- VALIDAR LA FECHA DEL PERSONAL DE INTELIGENCIA MAYOR DE 26 AÑOS ------
		IF (FUNCION_EDAD(new.fecha_nacimiento) IS  NULL) THEN
	---MENOR DE 26 AÑOS
			RAISE EXCEPTION 'NO ES PERMITIDO LA EDAD DEL PERSONAL';
			RETURN NULL;		

		ELSE
	---MAYOR DE 26 AÑOS		
			RAISE INFO 'EDAD PERMITIDA PARA INGRESO DE PERSONAL';
			
			
	-----VALIDACION DEL FAMILIAR ---------
	
		---VALIDACION DEL PRIMER FAMILIAR: NOMBRE COMPLETO, EDAD >26, PARENTESCO Y EL TELEFONO
			CALL PROCEDIMIENTO_VALIDAR_FAMILIARES(new.familiares[1].primer_nombre, new.familiares[1].primer_apellido, new.familiares[1].segundo_apellido, new.familiares[1].fecha_nacimiento, new.familiares[1].parentesco);
			CALL VALIDAR_TELEFONO (new.familiares[1].telefono.codigo,new.familiares[1].telefono.numero);
		
		
		---VALIDACION DEL SEGUNDO FAMILIAR: NOMBRE COMPLETO, EDAD >26, PARENTESCO Y EL TELEFONO
		---EL PERSONAL DE INTELIGENCIA DEBE TENER DOS FAMILIARES
			IF (new.familiares[2] IS NULL ) THEN
				RAISE EXCEPTION 'DEBE TENER DOS FAMILIARES EL PERSONAL DE INTELIGENCIA A INSERTAR';			
			ELSE
				CALL PROCEDIMIENTO_VALIDAR_FAMILIARES(new.familiares[2].primer_nombre, new.familiares[2].primer_apellido, new.familiares[2].segundo_apellido, new.familiares[2].fecha_nacimiento, new.familiares[2].parentesco);
				CALL VALIDAR_TELEFONO(new.familiares[2].telefono.codigo,new.familiares[2].telefono.numero);
			END IF;			
		
			RETURN NEW;
		END IF;
END
$$;

INSERT INTO personal_inteligencia (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, altura_cm, peso_kg, color_ojos, vision, class_seguridad, fotografia, huella_retina, huella_digital, telefono, licencia_manejo, idiomas, familiares, identificaciones, nivel_educativo, aliases, fk_lugar_ciudad) VALUES
('Florentina','Mariluz','Landa','Heredia','1993-03-05',189,66,'verde claro','20/25','top_secret','personal_inteligencia_data/foto.png','personal_inteligencia_data/huella_digital.png','personal_inteligencia_data/huella_retina.png',ROW(58,4145866510) ,ROW('75518194','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Araceli',null,'Alcantara','Candelaria','1960-06-01','tío',ROW(58,4145335249) ), ROW('Calixtrato','Vicente','Quintanilla','Estrada','1960-06-01','hermano',ROW(58,4142583859) )]::familiar_ty[], ARRAY[ ROW('31656053','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Economía','Máster','Finanzas')]::nivel_educativo_ty[],null,'10');

DROP FUNCTION TRIGGER_INSERT_PERSONAL()

CREATE TRIGGER TRIGGER_INSERT_PERSONAL
BEFORE INSERT ON personal_inteligencia
FOR EACH ROW EXECUTE FUNCTION TRIGGER_INSERT_PERSONAL()

DROP TRIGGER TRIGGER_INSERT_PERSONAL ON personal_inteligencia




