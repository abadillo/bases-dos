CREATE OR REPLACE FUNCTION CREAR_ARRAY_IDIOMAS (idiomas varchar array[6])
RETURNS varchar
LANGUAGE PLPGSQL
AS $$
DECLARE
	i integer;
BEGIN
	i=0;
	
	--IF ()
	
	WHILE (i <=6 ) LOOP
		
		IF (idiomas[i] IS NULL OR idiomas[i] = ' ') THEN
				RAISE EXCEPTION 'NO TIENE IDIOMA';
		END IF;
	END LOOP;
END
$$;

--- FUNCION OBTENER EDAD---

CREATE OR REPLACE FUNCTION fu_obtener_edad(pd_fecha_ini DATE, pd_fecha_fin DATE)
RETURNS INTEGER
LANGUAGE 'plpgsql' 
AS $$

BEGIN

	RETURN FLOOR(((DATE_PART('YEAR',pd_fecha_fin)-DATE_PART('YEAR',pd_fecha_ini))* 372 + (DATE_PART('MONTH',pd_fecha_fin) - DATE_PART('MONTH',pd_fecha_ini))*31 + (DATE_PART('DAY',pd_fecha_fin)-DATE_PART('DAY',pd_fecha_ini)))/372);
	
END

$$;



--SELECT fu_obtener_edad ('1993-03-05',NOW()::DATE)

--- FUNCION VALIDAR EDAD ---
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

---CREAR FAMILIAR ---

CREATE OR REPLACE FUNCTION CREAR_FAMILIAR (primer_nombre varchar,segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar,fecha_nacimiento timestamp, parentesco varchar, codigo numeric, numero numeric)
RETURNS familiar_ty
LANGUAGE PLPGSQL
AS $$
DECLARE
	fecha_va integer;
	telefono telefono_ty;
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
	
	telefono = CREAR_TELEFONO(codigo,numero);
	
	RETURN ROW(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,fecha_nacimiento, parentesco,telefono)::familiar_ty;
	
END

$$;
			   
--SELECT CREAR_FAMILIAR ('Gabriel','alberto,','manrique','ulacio','1960-06-01','tio',0414,0176620);

---CREAR IDENTIFICACION-----

CREATE OR REPLACE FUNCTION CREAR_IDENTIFICACION (documento varchar, pais varchar)
RETURNS identificacion_ty
LANGUAGE PLPGSQL
AS $$
DECLARE

	i integer;
	
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

--- CREAR NIVEL EDUCATIVO ----

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



