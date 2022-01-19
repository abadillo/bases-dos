
---- 	TRIGGER PARA VALIDAR LOS ARCOS EXCLUSIVOS ---------


CREATE OR REPLACE FUNCTION TRIGGER_INSERT_UPDATE_INFORMANTE()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE 

	informante_check_reg informante%rowtype;
	
BEGIN
	---SI EL TRIGGER ES DISPARADO POR INSERT ---
 	IF (TG_OP = 'INSERT') THEN
        
		---- VALIDACIONES DE NOMBRE CLAVE DE INFORMANTE ---

		IF(new.nombre_clave IS NULL OR new.nombre_clave = '') THEN
			RAISE INFO 'Ingrese un nombre clave para el informante';
			RAISE EXCEPTION 'Ingrese un nombre clave para el informante';
			RETURN NULL;
		END IF;
		--- BUSQUEDA DE LOS DATOS DEL INFORMANTE CON EL NOMBRE CLAVE ---
		
		SELECT * INTO informante_check_reg FROM informante 
		WHERE nombre_clave = new.nombre_clave;

		RAISE INFO 'DATOS DE INFORMANTE %:', informante_check_reg;
		--- SI EXISTE EL NOMBRE CLAVE DEL INFORMANTE NO INSERTA ---
		IF (informante_check_reg.id IS NOT NULL) THEN
			RAISE INFO 'El nombre clave que ingresó ya se encuentra en uso';
			RAISE EXCEPTION 'El nombre clave que ingresó ya se encuentra en uso: %', new.nombre_clave;
			RETURN NULL;
		END IF;		
		--- FUNCION VALIDAR ARCO EXCLUSIVO ---
		CALL VALIDAR_ARCO_EXCLUSIVO();
		
		RAISE INFO 'INFORMANTE CREADO CON EXITO!';
		RAISE INFO 'Datos del informante: %', NEW ; 
		--- RETURN NEW = INSERTA EL REGISTRO---
		RETURN NEW;

	--- SI EL TRIGGER ES DISPARADO POR UPDATE ---
	ELSIF (TG_OP = 'UPDATE') THEN
		
		---- VALIDACIONES DE NOMBRE CLAVE DE INFORMANTE ---

		IF(new.nombre_clave IS NULL OR new.nombre_clave = '') THEN
			RAISE INFO 'Ingrese un nombre clave para el informante';
			RAISE EXCEPTION 'Ingrese un nombre clave para el informante';
			RETURN NULL;
		END IF;
		
		
		SELECT * INTO informante_check_reg FROM informante 
		WHERE nombre_clave = new.nombre_clave;

		RAISE INFO 'DATOS DE INFORMANTE %:', informante_check_reg;
		--- SI EXISTE EL NOMBRE CLAVE DEL INFORMANTE NO INSERTA ---
		IF (informante_check_reg.id IS NOT NULL) THEN
			RAISE INFO 'El nombre clave que ingresó ya se encuentra en uso';
			RAISE EXCEPTION 'El nombre clave que ingresó ya se encuentra en uso: %', new.nombre_clave;
			RETURN NULL;
		END IF;		
		--- FUNCION VALIDAR ARCO EXCLUSIVO ---
		CALL VALIDAR_ARCO_EXCLUSIVO();


		RAISE INFO 'INFORMANTE CREADO CON EXITO!';
		RAISE INFO 'Datos del informante: %', NEW ; 
		--- RETURN NEW = INSERTA EL REGISTRO---
		RETURN NEW;

	END IF;
	
END
$$;


CREATE TRIGGER TRIGGER_INSERT_UPDATE_INFORMANTE
BEFORE INSERT OR UPDATE ON INFORMANTE
FOR EACH ROW 
EXECUTE FUNCTION TRIGGER_INSERT_UPDATE_INFORMANTE();  --SIEMPRE FOR EACH ROW



-- DROP TRIGGER trigger_VALIDAR_ARCO_EXCLUSIVO on informante
-- INSERT INTO informante (nombre_clave, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado, fk_empleado_jefe_confidente, fk_personal_inteligencia_confidente, fk_fecha_inicio_confidente, fk_estacion_confidente, fk_oficina_principal_confidente) VALUES
-- ('Ameamezersalica', 2, '2021-03-09 07:00:00', 1, 1, 11, null, null, null, null)












-- -/=/- ARCHIVO TRIGGER_INSERT_UPDATE_CRUDO_PIEZA.sql -/=/- 

-- --////-- TABLA CRUDO_PIEZA
-- -/TRIGGER_INSERT_UPDATE_CRUDO_PIEZA BEFORE INSERT OR UPDATE FOR EACH ROW TRIGGER_CRUDO_PIEZA();


CREATE OR REPLACE FUNCTION TRIGGER_UPDATE_INSERT_CRUDO()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE


BEGIN
	
	--- SI EL TRIGGER ES DISPARADO POR INSERT ---
	IF (TG_OP = 'INSERT') THEN
		--- VALIDACIÓN DE TODOS LOS ATRIBUTOS DEL CRUDO ---
		IF (new.contenido_va IS NULL OR new.contenido_va = '') THEN
			RAISE INFO 'Debe ingresar el contenido del crudo que quiere crear';
			RAISE EXCEPTION 'Debe ingresar el contenido del crudo que quiere crear';
		END IF;  

		IF (new.tipo_contenido_va != 'texto' AND new.tipo_contenido_va != 'imagen' AND tipo_contenido_va != 'sonido' AND tipo_contenido_va != 'video') THEN
			RAISE INFO 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video), %', tipo_contenido_va;
			RAISE EXCEPTION 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video)';
		END IF;   	

		IF (new.fuente_va != 'abierta' AND new.fuente_va != 'secreta' AND fuente_va != 'tecnica') THEN
			RAISE INFO 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
			RAISE EXCEPTION 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
		END IF;  

		IF (new.resumen_va IS NULL OR new.resumen_va = '') THEN
			RAISE INFO 'Debe ingresar el resumen del crudo que quiere crear';
			RAISE EXCEPTION 'Debe ingresar el resumen del crudo que quiere crear';
		END IF;   

		IF (new.valor_apreciacion_va IS NOT NULL AND new.valor_apreciacion_va <= 0) THEN
			RAISE INFO 'El valor de apreciacion del crudo debe ser mayor a 0$';
			RAISE EXCEPTION 'El valor de apreciacion del crudo debe ser mayor a 0$';
		END IF; 

		IF (new.nivel_confiabilidad_inicial_va IS NULL OR new.nivel_confiabilidad_inicial_va < 0 OR nivel_confiabilidad_inicial_va > 100 ) THEN
			RAISE INFO 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
			RAISE EXCEPTION 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
		END IF; 
		
		IF (new.cant_analistas_verifican_va IS NULL OR new.cant_analistas_verifican_va < 2) THEN	
			RAISE INFO 'Debe ingresar un número valido de analistas requeridos para la verificación';
			RAISE EXCEPTION 'Debe ingresar un número valido de analistas requeridos para la verificación';
		END IF;   
		
			
		CALL VALIDAR_EXIT_TEMA(id_tema);
		--- RETURN NEW = INSERTA EL REGISTRO---
		RETURN NEW;

	
	ELSIF (TG_OP = 'UPDATE') THEN


		IF (new.contenido_va IS NULL OR new.contenido_va = '') THEN
			RAISE INFO 'Debe ingresar el contenido del crudo que quiere crear';
			RAISE EXCEPTION 'Debe ingresar el contenido del crudo que quiere crear';
		END IF;  

		IF (new.tipo_contenido_va != 'texto' AND new.tipo_contenido_va != 'imagen' AND tipo_contenido_va != 'sonido' AND tipo_contenido_va != 'video') THEN
			RAISE INFO 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video), %', tipo_contenido_va;
			RAISE EXCEPTION 'Debe ingresar un tipo de contenido valido (texto, imagen, sonido, video)';
		END IF;   	

		IF (new.fuente_va != 'abierta' AND new.fuente_va != 'secreta' AND fuente_va != 'tecnica') THEN
			RAISE INFO 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
			RAISE EXCEPTION 'Debe ingresar un tipo de fuente valido (abierta, secreta, tecnica)';
		END IF;  

		IF (new.resumen_va IS NULL OR new.resumen_va = '') THEN
			RAISE INFO 'Debe ingresar el resumen del crudo que quiere crear';
			RAISE EXCEPTION 'Debe ingresar el resumen del crudo que quiere crear';
		END IF;   

		IF (new.valor_apreciacion_va IS NOT NULL AND new.valor_apreciacion_va <= 0) THEN
			RAISE INFO 'El valor de apreciacion del crudo debe ser mayor a 0$';
			RAISE EXCEPTION 'El valor de apreciacion del crudo debe ser mayor a 0$';
		END IF; 

		IF (new.nivel_confiabilidad_inicial_va IS NULL OR new.nivel_confiabilidad_inicial_va < 0 OR nivel_confiabilidad_inicial_va > 100 ) THEN
			RAISE INFO 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
			RAISE EXCEPTION 'El nivel de confiabilidad del crudo debe estar entre el rango de 0 y 100';
		END IF; 
		
		IF (new.cant_analistas_verifican_va IS NULL OR new.cant_analistas_verifican_va < 2) THEN	
			RAISE INFO 'Debe ingresar un número valido de analistas requeridos para la verificación';
			RAISE EXCEPTION 'Debe ingresar un número valido de analistas requeridos para la verificación';
		END IF;   


		CALL VALIDAR_EXIT_TEMA(id_tema);

		RETURN NEW;

	END IF;

END
$$;

---DROP FUNCTION TRIGGER_INSERT_CRUDO()

CREATE TRIGGER TRIGGER_UPDATE_INSERT_CRUDO
BEFORE INSERT OR UPDATE ON CRUDO
FOR EACH ROW EXECUTE FUNCTION TRIGGER_UPDATE_INSERT_CRUDO()

---DROP TRIGGER TRIGGER_INSERT_CRUDO ON crudo

------SELECT * FROM CRUDO
----INSERT INTO crudo (contenido, tipo_contenido, resumen, fuente, valor_apreciacion, nivel_confiabilidad_inicial, nivel_confiabilidad_final, fecha_obtencion, fecha_verificacion_final, cant_analistas_verifican, fk_clas_tema, fk_informante, fk_estacion_pertenece, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente) VALUES
----('crudo_contenido/texto2.txt', 'texto', 'Conflictos entre paises por poder II', 'abierta', 600, 90, 90 , '2019-03-05 01:00:00', null, 2, 1, null, 1, 1, 1, 1, '2020-01-05 01:00:00', 1);

----SELECT * FROM HIST_CARGO where fecha_inicio='2034-01-05 01:00:00' 
----	AND fk_personal_inteligencia_agente = 17
----	AND fk_estacion_agente= 5
----	AND fk_oficina_principal_agente = 2















----TRIGGER PARA VALIDAR EL INSERT DEL CLIENTE----

CREATE OR REPLACE FUNCTION TRIGGER_CLIENTE ()
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
		CALL VALIDAR_TIPO_LUGAR(new.fk_lugar_pais,'pais');
		
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
		CALL VALIDAR_TIPO_LUGAR(new.fk_lugar_pais,'pais');
		
		RAISE INFO 'SE INSERTÓ EL CLIENTE';
		
		RETURN new;	
	
	END IF;
	
	RETURN NULL;
	

END

$$;

--INSERT INTO cliente (nombre_empresa, pagina_web, exclusivo, telefonos, contactos, fk_lugar_pais) VALUES
--('mexicaso', 'mexicaso.org.ve' ,true, ARRAY[CAST((58,4126909353) as telefono_ty), CAST((58,4165420879)as telefono_ty)],  ARRAY[ ROW('Eloisa', 'Petronila', 'Nolasco', 'White', '91 Sage Ave. Colorado Springs, CO 80911',  ROW(58,4121705701)), ROW('Nicolas', 'Abelardo', 'Tafoya', 'Peralta', '8370 Euclid Lane Harrisburg, PA 17109', ROW(58,4127728311))]::contacto_ty[], 4);


-- DROP FUNCTION TRIGGER_CLIENTE()

-- DROP TRIGGER TRIGGER_CLIENTE on cliente

CREATE TRIGGER TRIGGER_CLIENTE
BEFORE INSERT OR UPDATE OR DELETE on CLIENTE
FOR EACH ROW EXECUTE FUNCTION TRIGGER_CLIENTE();









-- -/=/- ARCHIVO TRIGGER_UPDATE_PIEZA_REGISTRADA.sql -/=/- 

-- --////-- TABLA PIEZA_INTELIGENCIA
-- -/TRIGGER_UPDATE_PIEZA_REGISTRADA BEFORE UPDATE FOR EACH ROW TRIGGER_ACUALIZACION_PIEZA();









-------------------------------//////////////////------------------------------------

CREATE OR REPLACE FUNCTION TRIGGER_INSERT_UPDATE_CRUDO_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
	crudo_reg CRUDO%ROWTYPE;
	crudo_pieza_reg CRUDO_PIEZA%ROWTYPE;
	
	-- nivel_confiabilidad_va CRUDO.nivel_confiabilidad_final%ROWTYPE;
		
BEGIN
	---SI EL TRIGGER ES DISPARADO POR INSERT---
	IF (TG_OP = 'INSERT') THEN
        
		SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza AND precio_base IS NULL;
		RAISE INFO 'datos de la pieza de inteligencia %', pieza_reg;

		SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo;
		RAISE INFO 'datos del crudo: %', crudo_reg;
		
		SELECT * INTO crudo_pieza_reg FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza AND fk_crudo = id_crudo;
		RAISE INFO 'datos de crudo_pieza: %', crudo_pieza_reg;
	
		--------

		IF (pieza_reg IS NULL) THEN
			RAISE INFO 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
			RAISE EXCEPTION 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
		END IF;   
	
		IF (crudo_reg IS NULL) THEN
			RAISE INFO 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
			RAISE EXCEPTION 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
		END IF;   	
	
		IF (crudo_pieza_reg IS NOT NULL) THEN
			RAISE INFO 'El crudo que intenta asociar ya está asociado a esta pieza';
			RAISE EXCEPTION 'El crudo que intenta asociar ya está asociado a esta pieza';
		END IF;   	
	
		IF ( VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo) != crudo_reg.cant_analistas_verifican ) THEN
			RAISE INFO 'El crudo que ingresó no ha sido verificado';
			RAISE EXCEPTION 'El crudo que ingresó no ha sido verificado';
		END IF;   	

		IF (crudo_reg.nivel_confiabilidad_final < 85 ) THEN
			RAISE INFO 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
			RAISE EXCEPTION 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
		END IF;   	

		RETURN NEW;

	---SI EL TRIGGER ES DISPARADO POR UPDATE---
	ELSIF (TG_OP = 'UPDATE') THEN

		SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza AND precio_base IS NULL;
		RAISE INFO 'datos de la pieza de inteligencia %', pieza_reg;

		SELECT * INTO crudo_reg FROM CRUDO WHERE id = id_crudo;
		RAISE INFO 'datos del crudo: %', crudo_reg;
		
		SELECT * INTO crudo_pieza_reg FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza AND fk_crudo = id_crudo;
		RAISE INFO 'datos de crudo_pieza: %', crudo_pieza_reg;
	
		--------

		IF (pieza_reg IS NULL) THEN
			RAISE INFO 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
			RAISE EXCEPTION 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
		END IF;   
	
		IF (crudo_reg IS NULL) THEN
			RAISE INFO 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
			RAISE EXCEPTION 'El crudo que ingresó no esta registrado o no cumple con los requerimientos necesarios';
		END IF;   	
	
		IF (crudo_pieza_reg IS NOT NULL) THEN
			RAISE INFO 'El crudo que intenta asociar ya está asociado a esta pieza';
			RAISE EXCEPTION 'El crudo que intenta asociar ya está asociado a esta pieza';
		END IF;   	
	
		IF ( VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo) != crudo_reg.cant_analistas_verifican ) THEN
			RAISE INFO 'El crudo que ingresó no ha sido verificado';
			RAISE EXCEPTION 'El crudo que ingresó no ha sido verificado';
		END IF;   	

		IF (crudo_reg.nivel_confiabilidad_final < 85 ) THEN
			RAISE INFO 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
			RAISE EXCEPTION 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 porciento )';
		END IF;   	

		RETURN NEW;


	END IF;

	


END $$;
---------ELIMINACION DE LA FUNCION------
---DROP FUNCTION TRIGGER_CRUDO_PIEZA()

---------CREACION DEL TRIGGER-----
CREATE TRIGGER TRIGGER_INSERT_UPDATE_CRUDO_PIEZA
BEFORE INSERT OR UPDATE ON CRUDO_PIEZA
FOR EACH ROW EXECUTE FUNCTION TRIGGER_INSERT_UPDATE_CRUDO_PIEZA();

---------ELIMINACION DEL TRIGGER-----
---DROP TRIGGER TRIGGER_CRUDO_PIEZA

---PRUEBA ---------------------------
---INSERT INTO crudo_pieza (fk_pieza_inteligencia, fk_crudo )
---VALUES (1,19)






-------------------------------//////////////////------------------------------------



CREATE OR REPLACE FUNCTION TRIGGER_UPDATE_PIEZA()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
	
	pieza pieza_inteligencia%rowtype;
	
BEGIN

	---SELECT PARA BUSCAR LAS PIEZAS VENDIDAS EN LA TABLA ADQUISICION
	---PUEDE SER VENDIDA VARIAS VECES LA PIEZA
	
	SELECT * INTO pieza
	FROM PIEZA_INTELIGENCIA p, ADQUISICION a
	WHERE p.id = a.fk_pieza_inteligencia
	AND p.id = old.id;
	
	IF (old.precio_base IS NOT NULL) THEN
		RAISE INFO 'DATOS DE LA PIEZA DE INTELIGENCIA: %',pieza;
		RAISE EXCEPTION 'LA PIEZA DE INTELIGENCIA HA SIDO REGISTRADA';	
		return null;
	ELSE
		RAISE INFO 'SE ACTUALIZO LA PIEZA DE INTELIGENCIA';
		RETURN new;
	END IF;


END
$$;





----------------CREACION DEL TRIGGER --------------------
CREATE TRIGGER TRIGGER_UPDATE_PIEZA
BEFORE UPDATE ON PIEZA_INTELIGENCIA
FOR EACH ROW EXECUTE FUNCTION TRIGGER_UPDATE_PIEZA();
















CREATE OR REPLACE FUNCTION TRIGGER_CLAS_TEMA()
RETURNS TRIGGER LANGUAGE PLPGSQL
AS $$
DECLARE
	pieza_reg record;
	crudo_reg record;
	temas_esp record;
	area_interes record;
BEGIN
	
	IF(TG_OP = 'INSERT') THEN
	
		IF(new.nombre IS NULL OR new.nombre = '')THEN
			RAISE EXCEPTION 'EL NOMBRE DEL TEMA ESTA VACIO';
		END IF;
		IF(new.descripcion IS NULL OR new.descripcion = '') THEN
			RAISE EXCEPTION 'LA DESCRIPCION DEL TEMA ESTA VACIO';
		END IF;
		CASE topico
			WHEN 'paises' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'individuos' THEN
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'eventos' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'empresas' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
		END CASE;

		RETURN NEW; 
	
	ELSIF (TG_OP = 'UPDATE') THEN
		
		IF(new.nombre IS NULL OR new.nombre = '')THEN
			RAISE EXCEPTION 'EL NOMBRE DEL TEMA ESTA VACIO';
		END IF;
		IF(new.descripcion IS NULL OR new.descripcion = '') THEN
			RAISE EXCEPTION 'LA DESCRIPCION DEL TEMA ESTA VACIO';
		END IF;
		CASE new.topico
			WHEN 'paises' THEN 
				RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'individuos' 
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'eventos'
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
			WHEN 'empresas'
				THEN RAISE EXCEPTION 'ERROR EN EL TOPICO (paises, individuos, eventos, empresas)';
		END CASE;

		RETURN NEW; 
	ELSIF (TG_OP = 'DELETE') THEN
		--- VALIDACION RAPIDA DE LOS FK DE LA CLASIFICACION PIEZA EN LAS OTRAS TABLAS ANTES DE ELIMINAR ----
		--- PERSONAL_INTELIGENCIA, CRUDO, CLAS_TEMA, TEMAS_ESP ---
		
		SELECT id INTO  pieza_reg FROM pieza_inteligencia
		WHERE fk_clas_tema  =  new.id;
		
		SELECT id INTO crudo_reg FROM crudo
		WHERE fk_clas_tema = new.id;
		
		SELECT fk_clas_tema INTO temas_esp FROM clas_tema
		WHERE fk_clas_tema = new.id;
		
		SELECT fk_clas_tema INTO area_interes FROM area_interes
		WHERE fk_clas_tema = new.id;
		
		IF (pieza_reg IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UNA PIEZA DE INTELIGENCIA';
		END IF;
		
		IF (crudo_reg IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN CRUDO';
		END IF;
		
		IF (temas_esp IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN TEMA ESPECIFICO DE UN PERSONAL DE INTELIGENCIA';
		END IF;
		
		IF (area_interes IS NOT NULL) THEN
			RAISE EXCEPTION 'NO SE PUEDE ELIMINAR EL TEMA, ESTE ESTÁ VINCULADO A UN AREA DE INTERES DE UN CLIENTE';
		END IF;
		
		RETURN OLD;
	END IF;	
END 
$$;

-- DROP FUNCTION TRIGGER_CLAS_TEMA()

CREATE TRIGGER TRIGGER_CLAS_TEMA
BEFORE INSERT OR UPDATE ON clas_tema
FOR EACH ROW EXECUTE FUNCTION TRIGGER_CLAS_TEMA();

-- DROP TRIGGER TRIGGER_CLAS_TEMA