---FUNCION OBTENER EDAD---
CREATE OR REPLACE FUNCTION fu_obtener_edad(pd_fecha_ini DATE, pd_fecha_fin DATE)
RETURNS INTEGER
LANGUAGE 'plpgsql' 
AS $$

BEGIN

	RETURN FLOOR(((DATE_PART('YEAR',pd_fecha_fin)-DATE_PART('YEAR',pd_fecha_ini))* 372 + (DATE_PART('MONTH',pd_fecha_fin) - DATE_PART('MONTH',pd_fecha_ini))*31 + (DATE_PART('DAY',pd_fecha_fin)-DATE_PART('DAY',pd_fecha_ini)))/372);
	
END

$$;

DROP FUNCTION fu_obtener_edad(date, date)


---VALIDAR LA EDAD ----
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

DROP FUNCTION CREAR_ALIAS(varchar, varchar, varchar, varchar,  bytea, timestamp, varchar, numeric, varchar, varchar, timestamp)

SELECT CREAR_ALIAS('Bertrudis','Viviana','Sanchez','Serna','personal_inteligencia_data/foto.png','1993-09-21','Argentina',39794059,'marrón oscuro','Tucson, AZ 85718','2035-04-09 07:00:00')
