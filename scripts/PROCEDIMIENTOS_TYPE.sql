
CREATE OR REPLACE FUNCTION FU_OBTENER_EDAD(pd_fecha_ini DATE, pd_fecha_fin DATE)
RETURNS INTEGER
LANGUAGE 'plpgsql' 
AS $$
BEGIN

	RETURN FLOOR(((DATE_PART('YEAR',pd_fecha_fin)-DATE_PART('YEAR',pd_fecha_ini))* 372 + (DATE_PART('MONTH',pd_fecha_fin) - DATE_PART('MONTH',pd_fecha_ini))*31 + (DATE_PART('DAY',pd_fecha_fin)-DATE_PART('DAY',pd_fecha_ini)))/372);
	
END
$$;




--- FUNCION VALIDAR EDAD ---
CREATE OR REPLACE FUNCTION FUNCION_EDAD(fecha_nacimiento date)
RETURNS BOOLEAN
LANGUAGE PLPGSQL
AS $$
DECLARE
	
	fecha_va integer;
		
BEGIN
	
	fecha_va = FU_OBTENER_EDAD (fecha_nacimiento, NOW()::DATE);
	
	IF (fecha_va < 26 ) THEN
	
		RAISE INFO 'NO ES LA EDAD PERMITIDA PARA SER UN PERSONAL DE INTELIGENCIA, MINIMO DEBES TENER 26 AÑOS DE EDAD';		
		-- RAISE EXCEPTION 'NO ES LA EDAD PERMITIDA PARA SER UN PERSONAL DE INTELIGENCIA, MINIMO DEBES TENER 26 AÑOS DE EDAD';		
		RETURN FALSE;
		
	ELSIF ( fecha_va > 80 ) THEN
	
		RAISE INFO 'EDAD: %', fecha_va;
		-- RAISE EXCEPTION 'NO ES POSIBLE EN EL RANGO DE EDADES';
		RETURN FALSE;
		
	ELSE 		
	
		RETURN TRUE;
		
	END IF;
END
$$;


-- IF (FUNCION_EDAD('2000-12-12') = true) THEN



CREATE OR REPLACE FUNCTION CREAR_CONTACTO (primer_nombre varchar,segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar, direccion varchar, codigo numeric, numero numeric)
RETURNS contacto_ty
LANGUAGE PLPGSQL
AS $$
DECLARE
	
	telefono telefono_ty;
BEGIN

	IF (primer_nombre IS NULL OR primer_nombre = ' ') THEN
		RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE CONTACTO';
	END IF;
	
	IF ((primer_apellido IS NULL OR primer_apellido = ' ') AND (segundo_apellido IS NULL OR segundo_apellido = ' ')) THEN
		RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
	END IF;
	
	IF (direccion = ' ' OR direccion IS NULL) THEN
		RAISE EXCEPTION 'EL CONTACTO DEBE DIRECCION';
	END IF;
	
	telefono = CREAR_TELEFONO(codigo,numero);
	
	RETURN ROW(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, direccion, telefono)::contacto_ty;
	
END $$;
			   
-- SELECT CREAR_CONTACTO ('Gabriel','alberto,','manrique','ulacio','Av La vega, calle sur',0414,0176620);



---INSERTAR EN EL ARRAY DE ALIAS TIPO ALIAS_TY ---
CREATE OR REPLACE FUNCTION CREAR_ALIAS(primer_nombre varchar, segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar, foto bytea, fecha timestamp, pais varchar, documento numeric, color_ojos varchar, direccion varchar, ultimo_uso timestamp)
RETURNS alias_ty[]
LANGUAGE PLPGSQL
AS $$
DECLARE
	ATRIBUTOS_ALIAS alias_ty;
	ALIASES alias_ty[];
BEGIN
	
		RAISE INFO 'EL ALIAS ES UNA IDENTIFICACIÓN FALSA DEL AGENTE DE CAMPO, PROCURE INSERTAR LA INFORMACIÓN COMPLETA';
		
	---- VALIDAR LA FECHA DEL PERSONAL DE INTELIGENCIA MAYOR DE 26 AÑOS ------
		IF (FUNCION_EDAD(fecha::DATE) IS  NULL) THEN	
	---MENOR DE 26 AÑOS
			RAISE EXCEPTION 'NO ES PERMITIDO LA EDAD DEL PERSONAL';
			RETURN NULL;		

		ELSE
	
			---MAYOR DE 26 AÑOS		
			RAISE INFO 'EDAD PERMITIDA PARA INGRESO DE PERSONAL';	
			
			---VALIDACION DEL NOMBRE COMPELTO---
			
			IF (primer_nombre IS NULL OR primer_nombre = ' ')THEN
				RAISE EXCEPTION 'ALIAS NO TIENE PRIMER NOMBRE';
			END IF;

			IF ((primer_apellido IS NULL OR primer_apellido = ' ') AND (segundo_apellido IS NULL OR segundo_apellido = ' ')) THEN
				RAISE EXCEPTION 'EL ALIAS DEBE TENER LOS DOS APELLIDOS COMPLETOS';
			END IF;
		
			---VALIDACIÓN DE FOTO IDENTIDAD---
			
			IF	(foto IS NULL ) THEN
				RAISE EXCEPTION 'EL ALIAS DEBE TENER UNA FOTO';
			END IF;
		
			---VALIDACIÓN DEL COUMENTO DE IDENTIDAD ---
			
			IF (documento IS NULL) THEN
				RAISE EXCEPTION 'ALIAS, NUMERO DE ID DE DOCUMENTO ESTA VACIO';
			END IF;

			IF (pais IS NULL OR pais = ' ') THEN
				RAISE EXCEPTION 'ALIAS,EL PAIS DEL DOCUMENTO DE INDENTIFICACION ESTA VACIO';			
			END IF;
			
			---VALIDACIÓN DEL COLOR DE OJOS ---
			
			IF (color_ojos IS NULL OR color_ojos = ' ')THEN
				RAISE EXCEPTION 'DEBE TENER COLOR DE OJOS EL ALIAS';
			END IF;
			
			---VALIDACIÓN DE DIRECCION, ES VARCHAR ---
			
			IF (direccion IS NULL OR direccion = '') THEN
				RAISE EXCEPTION 'EL ALIAS DEBE TENER UNA DIRECCION';
			END IF;
			
			ATRIBUTOS_ALIAS = ROW(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, foto, fecha, pais, documento, color_ojos, direccion, ultimo_uso)::alias_ty;			
			
			ALIASES = array_append(ALIASES,ATRIBUTOS_ALIAS);
			
		RETURN ALIASES;
		
		END IF;		

END

$$;

-- DROP FUNCTION CREAR_ALIAS(varchar, varchar, varchar, varchar,  bytea, timestamp, varchar, numeric, varchar, varchar, timestamp)

-- SELECT CREAR_ALIAS('Bertrudis','Viviana','Sanchez','Serna','personal_inteligencia_data/foto.png','1993-09-21','Argentina',39794059,'marrón oscuro','Tucson, AZ 85718','2035-04-09 07:00:00')
-- SELECT CREAR_ALIAS('Bertrudis','Viviana','Sanchez','Serna',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1993-09-21','Argentina',39794059,'marrón oscuro','Tucson, AZ 85718','2035-04-09 07:00:00')




----CREAR TELEFONOO ----

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


-- SELECT CREAR_TELEFONO(0212,20121312);
---CREAR LICENCIA ----


CREATE OR REPLACE FUNCTION CREAR_LICENCIA (numero varchar, pais varchar)
RETURNS licencia_ty
LANGUAGE PLPGSQL
AS $$
BEGIN
	IF (numero IS NULL OR numero = ' ') THEN
		RAISE EXCEPTION 'EL NUMERO DE LA LICENCIA ES NULO';
	END IF;
	
	IF (pais IS NULL OR pais = ' ') THEN
		RAISE EXCEPTION 'LA LICENCIA DEBE TENER UN PAIS';
	END IF;
	RETURN ROW(numero,pais)::licencia_ty;

END
$$;

-- SELECT CREAR_LICENCIA('1233992432','Uganda');

---CREAR FAMILIAR ---

CREATE OR REPLACE FUNCTION CREAR_FAMILIAR (primer_nombre varchar,segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar,fecha_nacimiento timestamp, parentesco varchar, codigo numeric, numero numeric)
RETURNS familiar_ty
LANGUAGE PLPGSQL
AS $$
DECLARE
	fecha_va integer;
	telefono telefono_ty;
BEGIN

	fecha_va = FU_OBTENER_EDAD (fecha_nacimiento::DATE, NOW()::DATE);
		
	IF (primer_nombre IS NULL OR primer_nombre = ' ') THEN
		RAISE EXCEPTION 'NO TIENE PRIMER NOMBRE FAMILIAR';
	END IF;
	
	IF ((primer_apellido IS NULL OR primer_apellido = ' ') AND (segundo_apellido IS NULL OR segundo_apellido = ' ')) THEN
		RAISE EXCEPTION 'NO TIENE LOS DOS APELLIDOS COMPLETOS';
	END IF;
	
	IF (fecha_va < 18) THEN
		RAISE INFO 'NO ES LA EDAD PERMITIDA PARA SER FAMILIAR DE UN PERSONAL DE INTELIGENCIA, MINIMO DEBE TENER 26 AÑOS DE EDAD';		
		RAISE EXCEPTION 'NO ES LA EDAD PERMITIDA PARA SER FAMILIAR DE UN PERSONAL DE INTELIGENCIA, MINIMO DEBE TENER 26 AÑOS DE EDAD';		
		
	ELSIF (fecha_va > 120) THEN
		RAISE INFO 'EDAD: %', fecha_va;
		RAISE EXCEPTION 'NO ES POSIBLE EL INGRESO DE EDAD';
	END IF;		
	
	IF (parentesco = ' ' OR parentesco IS NULL) THEN
		RAISE EXCEPTION 'EL FAMILIAR DEBE TENER UN PARENTESCO CON EL PERSONAL DE INTELIGENCIA ';
	END IF;
	
	telefono = CREAR_TELEFONO(codigo,numero);
	
	RETURN ROW(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,fecha_nacimiento, parentesco, telefono)::familiar_ty;
	
END
$$;
			   
-- SELECT CREAR_FAMILIAR ('Gabriel','alberto,','manrique','ulacio','1960-06-01','tio',0414,0176620);

---CREAR IDENTIFICACION-----

CREATE OR REPLACE FUNCTION CREAR_IDENTIFICACION (documento varchar, pais varchar)
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

-- select CREAR_IDENTIFICACION('0213120431','Australia');
-- select ver_lugares();

--- CREAR NIVEL EDUCATIVO ----

CREATE OR REPLACE FUNCTION CREAR_NIVEL_EDUCATIVO (pregrado_titulo varchar, postgrado_tipo varchar, postgrado_titulo varchar)
RETURNS nivel_educativo_ty
LANGUAGE PLPGSQL
AS 
$$
BEGIN
	IF (pregrado_titulo IS NULL OR pregrado_titulo = ' ') THEN
		RAISE EXCEPTION 'EL PERSONAL NO TIENE NIVEL DE PREGRADO';
	END IF;
	
	-- IF (postgrado_tipo IS NULL OR postgrado = ' ') THEN
	-- 	RAISE EXCEPTION 'EL PERSONAL NO TIENE TIPO DE POSTGRADO';
	-- END IF;
	
	-- IF (postgreado_titulo IS NULL OR postgreado_titulo = ' ') THEN
	-- 	RAISE EXCEPTION ' EL PERSONAL NO TIENE TITULO DE POSTGRADO';
	-- END IF;
	
	RETURN ROW(pregrado_titulo,postgrado_tipo,postgrado_titulo)::nivel_educativo_ty;
END
$$;



-- select CREAR_NIVEL_EDUCATIVO('Economía', 'Master', 'Finanzas');
-- select CREAR_NIVEL_EDUCATIVO('Ingeniería Industrial',null,null);
-- select CREAR_NIVEL_EDUCATIVO('Ingeniería Informática',null,null);



---------------//////////////----------------////////////////---------------------




CREATE OR REPLACE FUNCTION CREAR_ARRAY_IDIOMAS (idioma_1 IN varchar(50),idioma_2 IN varchar(50),idioma_3 IN varchar(50),idioma_4 IN varchar(50),idioma_5 IN varchar(50),idioma_6 IN varchar(50))
RETURNS varchar(50)[] 
LANGUAGE plpgsql
AS $$
DECLARE

    idiomas_va varchar(50)[];

BEGIN

    IF (    idioma_1 IS NOT NULL AND idioma_1 != '' 
        AND idioma_2 IS NOT NULL AND idioma_2 != '' 
        AND idioma_3 IS NOT NULL AND idioma_3 != '' 
        AND idioma_4 IS NOT NULL AND idioma_4 != '' ) THEN 

        idiomas_va = array_append(idiomas_va, idioma_1);
        idiomas_va = array_append(idiomas_va, idioma_2);
        idiomas_va = array_append(idiomas_va, idioma_3);
        idiomas_va = array_append(idiomas_va, idioma_4);

    ELSE 

        RAISE EXCEPTION 'Los cuatro primeros elementos nos pueden ser nulos ni vacios';

    END IF;

    IF (    idioma_5 IS NOT NULL AND idioma_5 != '' 
        AND idioma_6 IS NOT NULL AND idioma_6 != '' ) THEN 

        idiomas_va = array_append(idiomas_va, idioma_5);
        idiomas_va = array_append(idiomas_va, idioma_6);
    END IF;

	RETURN idiomas_va;

END $$;

-- SELECT CREAR_ARRAY_IDIOMAS('español','italiano','chino','portugués',null,null);

---------------------//////////////----------------////////////////----------------------------------


