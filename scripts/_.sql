
--DROP FUNCTION VER_CLIENTE;

CREATE OR REPLACE FUNCTION VER_CLIENTE (id_cliente in integer)
RETURNS CLIENTE
LANGUAGE sql
AS $$  
 	SELECT * FROM CLIENTE WHERE id = id_cliente; 
$$;
--
--
--select VER_CLIENTE(8);

--DROP FUNCTION VER_CLIENTE;

CREATE OR REPLACE FUNCTION VER_CLIENTES ()
RETURNS setof CLIENTE
LANGUAGE sql
AS $$  
 	SELECT * FROM CLIENTE; 
$$;
--
--
--select VER_CLIENTE(8);




-- DROP PROCEDURE IF EXISTS CREAR_CLIENTE CASCADE;


CREATE OR REPLACE PROCEDURE CREAR_CLIENTE (nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, fk_lugar_pais in integer)
LANGUAGE plpgsql
AS $$  
DECLARE

	cliente_reg CLIENTE%ROWTYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_CLIENTE ( % ) ------', NOW();
	
	-------------////////
	
	INSERT INTO CLIENTE (
		nombre_empresa,
		pagina_web, 
		exclusivo, 
		telefonos, 
		contactos,
		fk_lugar_pais
	
	) VALUES (
		nombre_empresa_va,
		pagina_web_va, 
		exclusivo_va, 
		ARRAY [telefono_va], 
		ARRAY [contacto_va],
		fk_lugar_pais

	) RETURNING * INTO cliente_reg;

   RAISE INFO 'CLIENTE CREADO CON EXITO!';
   RAISE INFO 'Datos del cliente: %', cliente_reg ; 



END $$;


-- CALL CREAR_CLIENTE('nombre_empresa','pagina_web', true,CREAR_TELEFONO(0212,2847213), CREAR_CONTACTO('gabriel','alberto','manrique','ulacio','calle_tal',0414,0176620), 5);
-- SELECT * FROM VER_CLIENTES(); 


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_CLIENTE (id_cliente IN INTEGER)
LANGUAGE plpgsql
AS $$  
DECLARE

	cliente_reg CLIENTE%ROWTYPE;
    --	oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
	-- tipo_va CLIENTE.tipo%TYPE := 'cliente';
    numero_registro_compra integer;
	area_interes_reg area_interes%ROWTYPE;
	
BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_CLIENTE ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO cliente_reg FROM CLIENTE WHERE id = id_cliente;

	IF (cliente_reg IS NULL) THEN
		RAISE INFO 'El cliente no existe';
		RAISE EXCEPTION 'El cliente no existe';
	END IF;

    SELECT count(*) INTO numero_registro_compra FROM ADQUISICION WHERE fk_cliente = id_cliente;

    IF (numero_registro_compra) THEN
        RAISE EXCEPTION 'No se puede borrar el cliente ya que hay registro de venta que dependen de el';
    END IF;
	
	SELECT * INTO area_interes_reg FROM area_interes
	WHERE fk_cliente = cliente_reg.id;
	
	IF (area_interes_reg IS NOT NULL) THEN
		RAISE EXCEPTION 'No se puede borrar el cliente ya que hay un registro de area interes que depende del cliente';
	END IF;
	
	DELETE FROM CLIENTE WHERE id = id_cliente; 
	
   RAISE INFO 'CLIENTE ELIMINADO CON EXITO!';
 

END $$;

-- CALL eliminar_cliente(11);
-- SELECT * FROM cliente ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ACTUALIZAR_CLIENTE (id_cliente IN integer, nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, id_lugar in integer)
LANGUAGE plpgsql
AS $$  
DECLARE

	cliente_reg CLIENTE%ROWTYPE;

BEGIN 

	RAISE INFO ' ';
	RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ACTUALIZAR_CLIENTE ( % ) ------', NOW();
	

	-------------////////
	SELECT * INTO cliente_reg FROM cliente WHERE id = id_cliente;

	IF (cliente_reg IS NULL) THEN
		RAISE INFO 'El cliente no existe';
		RAISE EXCEPTION 'El cliente no existe';
	END IF;

	IF (contacto_va IS NULL) THEN
		RAISE INFO 'El cliente no tiene contacto';
		RAISE EXCEPTION 'El cliente no tiene contacto';

	-------------////////
	
	UPDATE CLIENTE SET 
	
		nombre_empresa = nombre_empresa_va,
		pagina_web = pagina_web_va, 
		exclusivo = exclusivo_va,  
		telefonos = ARRAY[telefono_va],
        contactos = ARRAY [contacto_va],
		fk_lugar_pais = id_lugar; 
		
	WHERE id = id_cliente
	RETURNING * INTO cliente_reg;

   RAISE INFO 'CLIENTE ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del cliente: %', cliente_reg ; 



END $$;

(id_cliente IN integer, nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, id_lugar in integer)
CALL actualizar_cliente (2,'nombre_empresa','pagina_web',false,CREAR_TELEFONO(0212,2847213),null, 5);
-- SELECT * FROM cliente ej order by id desc; 



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------




