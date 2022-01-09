-- DROP FUNCTION IF EXISTS NUMERO_ANALISTAS_VERIFICAN_CRUDO CASCADE;

-- CREATE OR REPLACE FUNCTION NUMERO_ANALISTAS_VERIFICAN_CRUDO ( id_crudo IN integer ) 
-- RETURNS integer
-- LANGUAGE PLPGSQL 
-- AS $$
-- DECLARE 

-- 	numero_analistas_va integer;	

-- BEGIN 
	
-- 	SELECT count(*) INTO numero_analistas_va FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo;
	
-- 	RETURN numero_analistas_va;
	
-- END $$;


-- -------------////////.........^^^^^^^^^^^^^^^^^^^^^..........\\\\\\\\\\-------------



-- DROP FUNCTION IF EXISTS ANALISTA_VERIFICO_CRUDO CASCADE;

-- CREATE OR REPLACE FUNCTION ANALISTA_VERIFICO_CRUDO ( id_crudo IN integer, id_analista IN integer ) 
-- RETURNS boolean
-- LANGUAGE PLPGSQL 
-- AS $$
-- DECLARE 

-- 	registro record;

-- BEGIN 
	
-- 	SELECT * INTO registro FROM ANALISTA_CRUDO WHERE fk_crudo = id_crudo AND fk_personal_inteligencia_analista = id_analista;
	
-- 	IF (registro IS NULL) THEN
-- 		RETURN false;
-- 	END IF;

-- 	RETURN true;
	
-- END $$;




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

		-- IF (VALIDAR_VENTA_EXCLUSIVA(id_pieza))


	ELSE


		INSERT INTO ADQUISICION (fecha_hora_venta,precio_vendido,fk_cliente,fk_pieza_inteligencia) VALUES (
		
			fecha_hora_venta_va,
			precio_vendido_va,
			cliente_reg.id,
			pieza_reg.id
			
		);
	
	
		SELECT * INTO adquisicion_reg FROM ADQUISICION WHERE fk_cliente = id_cliente AND fk_pieza_inteligencia = id_pieza; 
   

	END IF;

	
 	

	---- FALTA IF DE VENTA EXCLUSIVA

 	-------------///////////--------------	
 

   RAISE INFO 'VENTA EXITOSA!';
   RAISE INFO 'Datos de la venta: %', adquisicion_reg ; 


END $$;


CALL REGISTRO_VENTA( 1,  1, 100.0 );

select * from adquisicion a 

-- select c.id as id_cliente, c.exclusivo, p.id as id_pieza, p.precio_base, a.*, ((a.precio_vendido - p.precio_base)/(p.precio_base))*100 as porcentaje_recargo from adquisicion a, cliente c, PIEZA_INTELIGENCIA p where a.fk_cliente = c.id AND a.fk_pieza_inteligencia = p.id;


