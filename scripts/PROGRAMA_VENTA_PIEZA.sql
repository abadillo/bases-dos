

DROP FUNCTION IF EXISTS ELIMINACION_REGISTROS_VENTA_EXCLUSIVA CASCADE;

CREATE OR REPLACE FUNCTION ELIMINACION_REGISTROS_VENTA_EXCLUSIVA ( id_pieza IN integer ) 
RETURNS void
LANGUAGE PLPGSQL 
AS $$

DECLARE 

	id_crudos_asociados integer[] ;	

BEGIN 

	id_crudos_asociados := ARRAY( 
		SELECT fk_crudo FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza
	);

	RAISE INFO 'IDs de crudos de la pieza %: %', id_pieza, id_crudos_asociados;

	DELETE FROM ADQUISICION WHERE fk_pieza_inteligencia = id_pieza;

	DELETE FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = id_pieza;

	DELETE FROM PIEZA_INTELIGENCIA WHERE id = id_pieza;

	DELETE FROM TRANSACCION_PAGO WHERE fk_crudo = ANY(id_crudos_asociados);

	DELETE FROM ANALISTA_CRUDO WHERE fk_crudo = ANY(id_crudos_asociados);

	DELETE FROM CRUDO WHERE id = ANY(id_crudos_asociados);


END $$;



--
--
--select * from adquisicion a where id = 1;
--select * from adquisicion_alt aa where id = 1;
--
--select * from crudo_pieza cp where fk_pieza_inteligencia = 1;
--select * from crudo_pieza_alt cpa where fk_pieza_inteligencia = 1;
--
--select * from pieza_inteligencia pi2 where id = 1;
--SELECT * from pieza_inteligencia_alt where id = 1;
--
--SELECT * from transaccion_pago tp where fk_crudo in	(SELECT fk_crudo FROM CRUDO_PIEZA WHERE fk_pieza_inteligencia = 1);
--SELECT * from transaccion_pago_alt tp;
--
--SELECT * FROM informante_alt ia ;
--
--select * from analista_crudo_alt ac ;
--select * from analista_crudo ac ;
--
--Select * from crudo_alt;
--
--SELECT ELIMINACION_REGISTROS_VENTA_EXCLUSIVA(1);



--------------------------///////////////////////-----------------------------
 



DROP FUNCTION IF EXISTS VALIDAR_VENTA_EXCLUSIVA CASCADE;

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







--------------------------///////////////////////-----------------------------





DROP PROCEDURE IF EXISTS REGISTRO_TEMA_VENTA CASCADE;


CREATE OR REPLACE PROCEDURE REGISTRO_TEMA_VENTA (id_cliente IN integer, id_tema IN integer)
LANGUAGE plpgsql
AS $$  
DECLARE

    area_interes_reg AREA_INTERES%ROWTYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO REGISTRO_TEMA_VENTA ( % ) ------', NOW();
	
	-------------///////////--------------	

	SELECT * INTO area_interes_reg FROM AREA_INTERES WHERE fk_clas_tema = id_tema AND fk_cliente = id_cliente ;
    RAISE INFO 'datos del AREA_INTERES: %', area_interes_reg;
    

	IF (area_interes_reg IS NULL) THEN
   
	
		INSERT INTO AREA_INTERES (
			fk_clas_tema, 
			fk_cliente
		) VALUES (

			id_tema, 
			id_cliente
		
		) RETURNING * INTO area_interes_reg;


		RAISE INFO 'REGISTRO AREA_INTERES!';
		RAISE INFO 'Datos de area_intereses: %', area_interes_reg ; 
	  	
	ELSE
		RAISE INFO 'AREA_INTERESES YA REGISTRADA';
	

	END IF;	
 

END $$;


--CALL registro_tema_venta (1,6);
--select * from area_interes ai ;




