
--------------------------///////////////////////-----------------------------
 

-- 4. Demostración de la implementación de los requerimientos del sistema de bases de datos transaccional 
-- referidos al proceso de venta de piezas de inteligencia – construcción de piezas de inteligencia y 
-- venta a clientes, incluyendo la seguridad correspondiente (roles, cuentas con privilegios para poder 
-- ejecutar los programas y reportes).


-- El analista responsable5 por la
-- construcción de la pieza la certifica fijándole un precio aproximado, el cual será exacto luego de la
-- negociación en la cual es vendida – debe haber registro del precio final alcanzado. Sólo los analistas
-- fijan el precio base de las piezas de inteligencia. Una pieza de inteligencia registrada no puede ser
-- alterada

-- Muchos de los clientes son muy sensibles con respecto a la absoluta exclusividad de la información
-- que compran. Ellos desean ser los únicos compradores no importando que el precio en estos casos
-- sea mucho más alto (una pieza de inteligencia de venta exclusiva tiene al menos el 45% de recargo
-- de su precio base).Para estos casos hay que asegurarse que dichas piezas de inteligencia no se
-- pueden volver a vender y también se debería saber quiénes son los clientes que exigen las ventas
-- exclusivas para otras oportunidades de negocio.


-- Registro_Venta (4) – pedir cliente, pieza, ver si es cliente exclusivo y si aplica la pieza si no cancelar. 
-- Si está bien generar el registro, y si la venta es exclusiva proceder a guardar la info y luego eliminar 
-- de las tablas originales.

--------------------------///////////////////////-----------------------------





-- DROP PROCEDURE IF EXISTS REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA CASCADE;

CREATE OR REPLACE PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (id_analista_encargado IN integer, descripcion IN PIEZA_INTELIGENCIA.descripcion%TYPE, id_crudo_base IN integer)
LANGUAGE plpgsql
AS $$  
DECLARE

	id_pieza integer;

    fecha_creacion_va PIEZA_INTELIGENCIA.fecha_creacion%TYPE;
    class_seguridad_va PIEZA_INTELIGENCIA.class_seguridad%TYPE;

    analista_encargado_reg PERSONAL_INTELIGENCIA%ROWTYPE;
   	hist_cargo_reg HIST_CARGO%ROWTYPE;
	crudo_base_reg CRUDO%ROWTYPE;
     
    pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA ( % ) ------', NOW();
	
	-------------///////////--------------	


    SELECT * INTO analista_encargado_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_analista_encargado;
    RAISE INFO 'datos de persona inteligencia: %', analista_encargado_reg;
   
   	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_analista_encargado AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo: %', hist_cargo_reg;

	SELECT * INTO crudo_base_reg FROM CRUDO WHERE id = id_crudo_base;
    RAISE INFO 'datos del crudo base: %', crudo_base_reg;
    
   --------

   	IF (hist_cargo_reg IS NULL) THEN
   		RAISE INFO 'El analista que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El analista que ingresó no existe o ya no trabaja en AII';
   	END IF;   	
  	
   
	IF (hist_cargo_reg.cargo != 'analista') THEN
		RAISE INFO 'El analista que ingresó no es un analista en su cargo actual';
		RAISE EXCEPTION 'El analista que ingresó no es un analista en su cargo actual';
	END IF;

	IF (crudo_base_reg IS NULL) THEN
   		RAISE INFO 'El crudo que ingresó no está registrado o no cumple con los requerimientos necesarios';
  		RAISE EXCEPTION 'El crudo que ingresó no está registrado o no cumple con los requerimientos necesarios';
   	END IF;   	
  
   	IF ( VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO(id_crudo_base) != crudo_base_reg.cant_analistas_verifican ) THEN
   		RAISE INFO 'El crudo que ingresó no ha sido verificado';
  		RAISE EXCEPTION 'El crudo que ingresó no ha sido verificado';
   	END IF;   	

	IF (ANALISTA_VERIFICO_CRUDO(id_crudo_base, id_analista_encargado) = true) THEN
   		RAISE INFO 'La pieza no puede tener ningun crudo verificado por el analista encargado';
  		RAISE EXCEPTION 'La pieza no puede tener ningun crudo verificado por el analista encargado';
   	END IF; 

	IF (hist_cargo_reg.fk_estacion != crudo_base_reg.fk_estacion_pertenece) THEN
		RAISE INFO 'El analista no pertenece a la misma estación que el crudo';
  		RAISE EXCEPTION 'El analista no pertenece a la misma estación que el crudo';
	END IF;

   	IF (crudo_base_reg.nivel_confiabilidad_final <= 85 ) THEN
   		RAISE INFO 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 )';
  		RAISE EXCEPTION 'El crudo que ingresó no tiene el nivel de confiabilidad necesario ( > 85 )';
   	END IF;   	
   
	fecha_creacion_va = NOW();
	class_seguridad_va = analista_encargado_reg.class_seguridad;
 
 	

 	-------------///////////--------------	
 

    INSERT INTO PIEZA_INTELIGENCIA (fecha_creacion,descripcion,class_seguridad,fk_fecha_inicio_analista,fk_personal_inteligencia_analista,fk_estacion_analista,fk_oficina_principal_analista,fk_clas_tema) VALUES (
   	
    	fecha_creacion_va,
    	descripcion,
    	class_seguridad_va,
   		hist_cargo_reg.fecha_inicio,
   		hist_cargo_reg.fk_personal_inteligencia,
   		hist_cargo_reg.fk_estacion,
   		hist_cargo_reg.fk_oficina_principal,
   		
    	crudo_base_reg.fk_clas_tema
    ) RETURNING id INTO id_pieza;
   
   
   SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
   
   RAISE INFO 'PIEZA CREADA CON EXITO!';
   RAISE INFO 'Datos de la pieza creada: %', pieza_reg ; 

	-------------///////////--------------	

	INSERT INTO CRUDO_PIEZA (fk_pieza_inteligencia, fk_crudo) VALUES (
   		id_pieza,
   		id_crudo_base
    );
   
   	RAISE INFO 'CRUDO DE ID = %, FUE AGREGADO A LA PIEZA ID = % EXITOSAMENTE', id_crudo_base, id_pieza;
 

END $$;


--CALL REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA( 1 , 'descripcion pieza prueba', 1 );



-----------------------------===========$$$$$$$$$$///////////////|\\\\\\\\\\\\\\\$$$$$$$$$$===========-------------------------------------------



--DROP PROCEDURE IF EXISTS AGREGAR_CRUDO_A_PIEZA CASCADE;

CREATE OR REPLACE PROCEDURE AGREGAR_CRUDO_A_PIEZA (id_crudo IN integer, id_pieza IN integer)
LANGUAGE plpgsql
AS $$  
DECLARE

	crudo_pieza_reg CRUDO_PIEZA%ROWTYPE;
    
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO AGREGAR_CRUDO_A_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	


 

	INSERT INTO CRUDO_PIEZA (fk_pieza_inteligencia, fk_crudo) VALUES (
   		pieza_reg.id,
   		crudo_reg.id
    );
   
   	RAISE INFO 'CRUDO DE ID = %, FUE AGREGADO A LA PIEZA ID = % EXITOSAMENTE', id_crudo, id_pieza;
 

END $$;


COMMIT;



-----------------------------===========$$$$$$$$$$///////////////|\\\\\\\\\\\\\\\$$$$$$$$$$===========-------------------------------------------



-- DROP PROCEDURE IF EXISTS CERTIFICAR_PIEZA CASCADE;


CREATE OR REPLACE PROCEDURE CERTIFICAR_PIEZA (id_pieza IN integer, precio_base_va IN PIEZA_INTELIGENCIA.precio_base%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
	
	numero_crudos_va integer;
	nivel_confiabilidad_promedio_va PIEZA_INTELIGENCIA.nivel_confiabilidad%TYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CERTIFICAR_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	


	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza AND precio_base IS NULL;
    RAISE INFO 'datos de la pieza de inteligencia %', pieza_reg;


	IF (pieza_reg IS NULL) THEN
   		RAISE INFO 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
  		RAISE EXCEPTION 'La pieza que ingresó no esta registrado o no cumple con los requerimientos necesarios';
   	END IF;   
 
	IF (precio_base_va < 1) THEN
   		RAISE INFO 'El precio base no puede negativo ni igual a 0$';
  		RAISE EXCEPTION 'El precio base no puede negativo ni igual a 0$';
   	END IF;  

   
   
   	SELECT count(*), sum(c.nivel_confiabilidad_final)/count(*) INTO numero_crudos_va, nivel_confiabilidad_promedio_va FROM CRUDO_PIEZA cp, CRUDO c WHERE cp.fk_crudo = c.id AND cp.fk_pieza_inteligencia = id_pieza;
	RAISE INFO 'numero de crudos en la pieza (id = %): %', id_pieza, numero_crudos_va;


   	IF (numero_crudos_va < 1) THEN
   		RAISE INFO 'La pieza no tiene ningun crudo asociado';
  		RAISE EXCEPTION 'La pieza no tiene ningun crudo asociado';
   	END IF;   	
   
    IF (nivel_confiabilidad_promedio_va < 85) THEN
   		RAISE INFO 'No se cumple un nivel de confiabilidad promedio de 85 porciento';
  		RAISE EXCEPTION 'No se cumple un nivel de confiabilidad promedio de 85 porciento';
   	END IF;  
  
   
   -------------///////////--------------	
	
	UPDATE PIEZA_INTELIGENCIA SET 
		nivel_confiabilidad = nivel_confiabilidad_promedio_va, 
		precio_base = precio_base_va
	;
   
   	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
   
   	RAISE INFO 'PIEZA CERTIFICADA CON EXITO!';
   	RAISE INFO 'Datos de la pieza certificada: %', pieza_reg ; 
	
 

END $$;



-- CALL CERTIFICAR_PIEZA( 37, 1 );

-- VALIDAR CON EL ID DEL ANALISTA 



----------------------------------///////////////////----------------------------


-- DROP FUNCTION IF EXISTS VER_DATOS_PIEZA CASCADE;


CREATE OR REPLACE FUNCTION VER_DATOS_PIEZA (id_pieza IN integer, id_personal_inteligencia IN integer)
RETURNS setof PIEZA_INTELIGENCIA
LANGUAGE plpgsql
AS $$  
DECLARE

	pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
   	
    personal_inteligencia_reg PERSONAL_INTELIGENCIA%ROWTYPE;
   	hist_cargo_reg HIST_CARGO%ROWTYPE;
   
    id_empleado_va integer;
	
	fecha_hora_va INTENTO_NO_AUTORIZADO.fecha_hora%TYPE;

BEGIN 

	fecha_hora_va = NOW();

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DE LA FUNCION VER_DATOS_PIEZA ( % ) ------', NOW();
	
	-------------///////////--------------	

    SELECT * INTO personal_inteligencia_reg FROM PERSONAL_INTELIGENCIA WHERE id = id_personal_inteligencia;
    RAISE INFO 'datos de persona inteligencia: %', personal_inteligencia_reg;
   
   	SELECT * INTO hist_cargo_reg FROM HIST_CARGO WHERE fk_personal_inteligencia = id_personal_inteligencia AND fecha_fin IS NULL; 
   	RAISE INFO 'datos de hist_cargo: %', hist_cargo_reg;

   --------
    
	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
	-- RAISE INFO 'dato de la pieza: %', pieza_reg ; 



   	IF (hist_cargo_reg IS NULL OR personal_inteligencia_reg IS NULL) THEN
   		RAISE INFO 'El personal inteligencia que ingresó no existe o ya no trabaja en AII';
  		RAISE EXCEPTION 'El personal inteligencia que ingresó no existe o ya no trabaja en AII';
   	END IF;   	

	IF (pieza_reg IS NULL) THEN
   		RAISE INFO 'La pieza que ingresó no exite';
  		RAISE EXCEPTION 'La pieza que ingresó no exite';
   	END IF;  

	
    IF (personal_inteligencia_reg.class_seguridad = 'top_secret') THEN 
        RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    END IF;

    IF (personal_inteligencia_reg.class_seguridad = 'confidencial' AND (pieza_reg.class_seguridad = 'confidencial' OR pieza_reg.class_seguridad = 'no_clasificado')) THEN
       RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    END IF;

    IF (personal_inteligencia_reg.class_seguridad = 'no_clasificado' AND pieza_reg.class_seguridad = 'no_clasificado') THEN
        RETURN QUERY 
			SELECT * FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;
    END IF;

   
 	------///- 
   
   	SELECT fk_empleado_jefe INTO id_empleado_va FROM ESTACION WHERE id = hist_cargo_reg.fk_estacion ; 
   	RAISE INFO 'id del jefe de la estacion del personal inteligencia: %', id_empleado_va;
   
    INSERT INTO INTENTO_NO_AUTORIZADO (
        fecha_hora,
        id_pieza,
        id_empleado,
        fk_personal_inteligencia
    ) VALUES (
        fecha_hora_va,
        id_pieza,
        id_empleado_va,
        hist_cargo_reg.fk_personal_inteligencia
    );
	
	
   
END $$;



-- SELECT VER_DATOS_PIEZA(2,10);
-- SELECT id_pieza,fk_personal_inteligencia FROM intento_no_autorizado ina order by fecha_hora desc;



-------------------------///////////////////////////////------------------------------



-- DROP FUNCTION IF EXISTS VALIDAR_VENTA_EXCLUSIVA CASCADE;

 CREATE OR REPLACE FUNCTION VALIDAR_VENTA_EXCLUSIVA ( id_pieza IN integer ) 
 RETURNS boolean
 LANGUAGE PLPGSQL 
 AS $$
 DECLARE 

-- 	curdos_en_pieza_int integer;
-- 	curdos_en_pieza_int integer;
	
 	numero_piezas_compartidas integer := 0;
 	numero_veces_pieza_vendida integer := 0;
 
 
 BEGIN 
	 
	SELECT COUNT(*) INTO numero_veces_pieza_vendida FROM ADQUISICION WHERE fk_pieza_inteligencia = id_pieza;

	RAISE INFO 'Número de veces en las que se ha vendido la pieza a verificar %', numero_veces_pieza_vendida; 

	IF (numero_veces_pieza_vendida != 0) THEN
 		RETURN false;
 	END IF;
 
    -----------////// 
	
	SELECT COUNT( DISTINCT fk_pieza_inteligencia) INTO numero_piezas_compartidas FROM CRUDO_PIEZA WHERE fk_crudo IN (SELECT fk_crudo FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza);

	RAISE INFO 'Número de piezas que contienen los crudos de la pieza a verificar %', numero_piezas_compartidas; 	

 	IF (numero_piezas_compartidas != 1) THEN
 		RETURN false;
 	END IF;

 
 	RETURN true;
	
 END $$;


-------------------------------------///////////////////////----------------------------------



DROP PROCEDURE IF EXISTS REGISTRO_VENTA CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_VENTA (id_pieza IN integer, id_cliente IN integer, precio_vendido_va IN ADQUISICION.precio_vendido%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

    pieza_reg PIEZA_INTELIGENCIA%ROWTYPE;
   	cliente_reg CLIENTE%ROWTYPE;
	
	adquisicion_reg ADQUISICION%ROWTYPE;

	fecha_hora_venta_va ADQUISICION.fecha_hora_venta%TYPE;

BEGIN 

	fecha_hora_venta_va = NOW();


	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_VENTA ( % ) ------', NOW();
	
	-------------///////////--------------	

	SELECT * INTO cliente_reg FROM CLIENTE WHERE id = id_cliente;
    RAISE INFO 'datos del cliente: %', cliente_reg;
    
	SELECT * INTO pieza_reg FROM PIEZA_INTELIGENCIA WHERE id = id_pieza; 
	RAISE INFO 'dato de la pieza: %', pieza_reg ; 

   --------

   	IF (cliente_reg IS NULL) THEN
   		RAISE INFO 'El cliente que ingresó no existe';
  		RAISE EXCEPTION 'El cliente que ingresó no existe';
   	END IF;   	
  	
	IF (pieza_reg IS NULL) THEN
   		RAISE INFO 'La pieza que ingresó no exite';
  		RAISE EXCEPTION 'La pieza que ingresó no exite';
   	END IF;   	

	IF (pieza_reg.precio_base IS NULL OR pieza_reg.nivel_confiabilidad IS NULL) THEN
   		RAISE INFO 'La pieza que intenta vender no ha sido certificada';
  		RAISE EXCEPTION 'La pieza que intenta vender no ha sido certificada';
   	END IF;   	

	IF (precio_vendido_va < 1) THEN
		RAISE INFO 'El precio de venta no puede negativo ni igual a 0$';
  		RAISE EXCEPTION 'El precio de venta no puede negativo ni igual a 0$';
	END IF;
  

	IF (cliente_reg.exclusivo = TRUE) THEN

		IF ( (precio_vendido_va - pieza_reg.precio_base)/(pieza_reg.precio_base) < 0.45) THEN
			RAISE INFO 'El precio de venta de una pieza exclusiva tiene un recargo del 45 porciento sobre el precio base de la pieza ( $% ), es decir, $% o más', pieza_reg.precio_base , 1.45*pieza_reg.precio_base ;
			RAISE EXCEPTION 'El precio de venta de una pieza exclusiva tiene un recargo del 45 porciento sobre el precio base de la pieza ( $% ), es decir, $% o más', pieza_reg.precio_base , 1.45*pieza_reg.precio_base ;
		END IF;

		
		IF (VALIDAR_VENTA_EXCLUSIVA(id_pieza) IS TRUE) THEN 
		
			INSERT INTO ADQUISICION (fecha_hora_venta,precio_vendido,fk_cliente,fk_pieza_inteligencia) VALUES (
		
				fecha_hora_venta_va,
				precio_vendido_va,
				cliente_reg.id,
				pieza_reg.id
			
			) RETURNING * INTO adquisicion_reg;
		
		
			RAISE INFO 'VENTA EXCLUSIVA EXITOSA!';
	  		RAISE INFO 'Datos de la venta: %', adquisicion_reg ; 
	  	
	  		CALL REGISTRO_TEMA_VENTA(id_cliente,id_tema);

	  		SELECT ELIMINACION_REGISTROS_VENTA_EXCLUSIVA(pieza_reg.id);	
			
		
		ELSE
		
			RAISE INFO 'No es posible la venta de esta pieza de forma exclusiva, debido a que la pieza ya fue vendida; o contiene algun(os) crudo(s) que pertenece(n) a otra(s) pieza(s); o porque la pieza no continene ningun crudo' ;
			RAISE EXCEPTION 'No es posible la venta de esta pieza de forma exclusiva, debido a que la pieza ya fue vendida; o contiene algun(os) crudo(s) que pertenece(n) a otra(s) pieza(s); o porque la pieza no continene ningun crudo' ;
		
		
		END IF;
	
	ELSE


		INSERT INTO ADQUISICION (fecha_hora_venta,precio_vendido,fk_cliente,fk_pieza_inteligencia) VALUES (
		
			fecha_hora_venta_va,
			precio_vendido_va,
			cliente_reg.id,
			pieza_reg.id
			
		) RETURNING * INTO adquisicion_reg;
	
		CALL REGISTRO_TEMA_VENTA(id_cliente,id_tema);

		RAISE INFO 'VENTA EXITOSA!';
   		RAISE INFO 'Datos de la venta: %', adquisicion_reg ; 	
	
	END IF;
 	
 

END $$;


--CALL REGISTRO_VENTA( 1,  1, 10000.0 );

--select * from adquisicion a 

-- select c.id as id_cliente, c.exclusivo, p.id as id_pieza, p.precio_base, a.*, ((a.precio_vendido - p.precio_base)/(p.precio_base))*100 as porcentaje_recargo from adquisicion a, cliente c, PIEZA_INTELIGENCIA p where a.fk_cliente = c.id AND a.fk_pieza_inteligencia = p.id;


