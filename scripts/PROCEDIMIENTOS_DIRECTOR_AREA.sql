
CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso in integer, id_jefe_estacion in integer)
AS $$
DECLARE

  dir_area_reg EMPLEADO_JEFE%ROWTYPE;
  jefe_estacion_reg EMPLEADO_JEFE%ROWTYPE;
  oficina_dir_reg OFICINA_PRINCIPAL%ROWTYPE;
  estacion_reg ESTACION%ROWTYPE;

BEGIN

  SELECT * INTO dir_area_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_acceso;

  IF (dir_area_reg IS NULL OR dir_area_reg.tipo != 'director_area') THEN
    RAISE EXCEPTION 'El empleado no un director de area o no existe';
  END IF;

  SELECT * INTO jefe_estacion_reg FROM EMPLEADO_JEFE WHERE id = id_jefe_estacion AND tipo = 'jefe';
  SELECT * INTO estacion_reg FROM ESTACION WHERE fk_empleado_jefe = id_jefe_estacion;
  SELECT * INTO oficina_dir_reg FROM OFICINA_PRINCIPAL WHERE fk_director_area = id_empleado_acceso; 

  IF (estacion_reg.fk_oficina_principal != oficina_dir_reg.id AND jefe_estacion_reg.fk_empleado_jefe != id_empleado_acceso) THEN
    RAISE EXCEPTION 'No tiene acesso a esta informacion';
  END IF;
    
END;
$$ LANGUAGE plpgsql;


-- CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION()

-----------------------------///////////////-------------------------------


--DROP FUNCTION VER_JEFE_ESTACION;

CREATE OR REPLACE FUNCTION VER_JEFE_E (id_empleado_acceso in integer, id_jefe in integer)
RETURNS EMPLEADO_JEFE
AS $$
DECLARE 

  jefe_estacion EMPLEADO_JEFE%ROWTYPE;
  -- empleado_dir_acceso EMPLEADO_JEFE%ROWTYPE; 
  -- oficina_dir_acceso OFICINA_PRINCIPAL%ROWTYPE;

BEGIN

  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, id_jefe);

  SELECT * INTO jefe_estacion FROM EMPLEADO_JEFE WHERE id = id_jefe AND tipo = 'jefe';

  RETURN jefe_estacion;

END;
$$ LANGUAGE plpgsql;

--select * from empleado_jefe

-- SELECT VER_JEFE_E(2,20);

------


CREATE OR REPLACE FUNCTION VER_JEFES_E (id_empleado_acceso in integer)
RETURNS setof EMPLEADO_JEFE
AS $$
BEGIN
   
  RETURN QUERY (
    
    SELECT ej.* FROM EMPLEADO_JEFE ej WHERE ej.fk_empleado_jefe = id_empleado_acceso
    UNION
    SELECT ej.* FROM EMPLEADO_JEFE ej, ESTACION e WHERE 
      ej.id = e.fk_empleado_jefe AND e.fk_oficina_principal IN 
      ( SELECT id FROM OFICINA_PRINCIPAL op WHERE op.fk_director_area = id_empleado_acceso ) 
  
  );
    

END;
$$ LANGUAGE plpgsql;
--

--SELECT VER_JEFES_E(2);



----------------------------------//////////////////////-------------------------



-- DROP PROCEDURE IF EXISTS CREAR_JEFE_ESTACION CASCADE;


CREATE OR REPLACE PROCEDURE CREAR_JEFE_ESTACION (id_empleado_acceso in integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

  empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

  tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';

BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_JEFE_ESTACION ( % ) ------', NOW();
  

  -------------////////
  
  INSERT INTO EMPLEADO_JEFE (
    primer_nombre,
    segundo_nombre, 
    primer_apellido, 
    segundo_apellido, 
    telefono,
    tipo,
    fk_empleado_jefe 
  
  ) VALUES (
    primer_nombre_va,
    segundo_nombre_va, 
    primer_apellido_va, 
    segundo_apellido_va, 
    telefono_va,
    tipo_va,
    id_empleado_acceso 

  ) RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'JEFE DE ESTACION CREADO CON EXITO!';
   RAISE INFO 'Datos del jefe de estacion: %', empleado_jefe_reg ; 

END $$;


-- CALL CREAR_JEFE_ESTACION(2,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213));
-- -- SELECT * FROM empleado_jefe ej order by id desc; 
-- SELECT VER_JEFES_E(2);
-- select * from empleado_jefe;
-- CALL VER_JEFE_E(2);



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_JEFE_ESTACION (id_empleado_acceso IN INTEGER, id_jefe_estacion IN INTEGER)
LANGUAGE plpgsql
AS $$  
DECLARE


empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--  oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
  tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';
  numero_estaciones_dep integer;

BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_JEFE_ESTACION ( % ) ------', NOW();
  
  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, id_jefe_estacion);

  -------------////////
  SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_jefe_estacion;

  IF (empleado_jefe_reg IS NULL) THEN
    RAISE INFO 'El empleado no existe';
    RAISE EXCEPTION 'El empleado no existe';
  END IF;

  IF (empleado_jefe_reg.tipo != tipo_va) THEN
    RAISE INFO 'El empleado no es un jefe de estacion';
    RAISE EXCEPTION 'El empleado no es un jefe de estacion';
  END IF;


  SELECT count(*) INTO numero_estaciones_dep FROM ESTACION WHERE fk_empleado_jefe = id_jefe_estacion;

  IF ( numero_estaciones_dep > 0 ) THEN

    RAISE EXCEPTION 'No se puede eliminar al jefe de estacion ya que ninguna estacion puede quedar sin jefe ';
  END IF;


  UPDATE ESTACION SET fk_empleado_jefe = null WHERE fk_empleado_jefe = id_jefe_estacion;
  UPDATE EMPLEADO_JEFE SET fk_empleado_jefe = null WHERE fk_empleado_jefe = id_jefe_estacion;

  DELETE FROM EMPLEADO_JEFE WHERE id = id_jefe_estacion; 
  
   RAISE INFO 'JEFE DE ESTACION ELIMINADO CON EXITO!';
 

END $$;


--SELECT VER_JEFES_E(2);
--CALL eliminar_jefe_estacion(2,44);



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ACTUALIZAR_JEFE_ESTACION (id_empleado_acceso IN integer, id_jefe_estacion IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

  empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;

  tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';


BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ACTUALIZAR_JEFE_ESTACION ( % ) ------', NOW();
  
  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso, id_jefe_estacion);

  
  -------------////////
  SELECT * INTO empleado_jefe_reg FROM empleado_jefe WHERE id = id_jefe_estacion;

  IF (empleado_jefe_reg IS NULL) THEN
    RAISE INFO 'El empleado no existe';
    RAISE EXCEPTION 'El empleado no existe';
  END IF;

  IF (empleado_jefe_reg.tipo != tipo_va) THEN
    RAISE INFO 'El empleado no es un jefe de estacion';
    RAISE EXCEPTION 'El empleado no es un jefe de estacion';
  END IF;
  

  -------------////////
  
  UPDATE EMPLEADO_JEFE SET 
  
    primer_nombre = primer_nombre_va,
    segundo_nombre = segundo_nombre_va, 
    primer_apellido = primer_apellido_va,  
    segundo_apellido = segundo_apellido_va, 
    telefono = telefono_va,
    fk_empleado_jefe = id_empleado_acceso 
    
  WHERE id = id_jefe_estacion
  RETURNING * INTO empleado_jefe_reg;

   RAISE INFO 'JEFE DE ESTACION ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del jefe de estacion: %', empleado_jefe_reg ; 



END $$;


-- SELECT VER_JEFES_E(2);
-- CALL actualizar_jefe_estacion (1,11,'nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
-- -- SELECT * FROM empleado_jefe ej order by id desc; 




-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------

  

CREATE OR REPLACE PROCEDURE VALIDAR_ACESSO_DIR_AREA_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
AS $$
DECLARE

  dir_area_reg EMPLEADO_JEFE%ROWTYPE;  
  oficina_dir_reg OFICINA_PRINCIPAL%ROWTYPE;
  estacion_reg ESTACION%ROWTYPE;

BEGIN

  SELECT * INTO dir_area_reg FROM EMPLEADO_JEFE WHERE id = id_empleado_acceso;


IF (dir_area_reg IS NULL OR dir_area_reg.tipo != 'director_area') THEN
    RAISE EXCEPTION 'El empleado no un director de area o no existe';
  END IF;

  SELECT * INTO estacion_reg FROM ESTACION WHERE id = id_estacion;
  SELECT * INTO oficina_dir_reg FROM OFICINA_PRINCIPAL WHERE fk_director_area = id_empleado_acceso; 

  IF (estacion_reg.fk_oficina_principal != oficina_dir_reg.id) THEN
    RAISE EXCEPTION 'No tiene acesso a esta informacion';
  END IF;
    
END;
$$ LANGUAGE plpgsql;





--DROP FUNCTION VER_ESTACION;

CREATE OR REPLACE FUNCTION VER_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
RETURNS ESTACION
LANGUAGE plpgsql
AS $$  
DECLARE 

  estacion_reg ESTACION%ROWTYPE;
BEGIN
  CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso, id_estacion);

   SELECT * INTO estacion_reg FROM ESTACION WHERE id = id_estacion; 

  RETURN estacion_reg;
END $$;
--
--
-- select * from VER_ESTACION(2,112);

--DROP FUNCTION VER_ESTACIONES;

CREATE OR REPLACE FUNCTION VER_ESTACIONES (id_empleado_acceso in integer)
RETURNS setof ESTACION
LANGUAGE sql
AS $$  
   SELECT * FROM ESTACION WHERE fk_oficina_principal IN (SELECT id FROM OFICINA_PRINCIPAL WHERE fk_director_area = id_empleado_acceso); 
$$;
--
--
-- select * FROM VER_ESTACIONES(2);
-- select * from oficina_principal where fk_director_area = 3;



-------------------------//////////////---------------------------------------------//////////////--------------------


CREATE OR REPLACE FUNCTION VER_CUENTA_ESTACION_DIR_AREA (id_empleado_acceso in integer, id_estacion in INTEGER)
RETURNS setof CUENTA
LANGUAGE plpgsql
AS $$  
DECLARE 
  cuenta_reg CUENTA%ROWTYPE;
BEGIN
   
  CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso, id_estacion);
    
  RETURN QUERY 
    SELECT * FROM CUENTA WHERE fk_estacion = id_estacion; 

  -- RETURN cuenta_reg;

END $$;

-- SELECT * FROM VER_CUENTA_ESTACION_DIR_AREA(3,5);
-- SELECT * FROM estacion;



-------------------------//////////////---------------------------------------------//////////////--------------------





-- DROP PROCEDURE IF EXISTS CREAR_ESTACION CASCADE;

CREATE OR REPLACE PROCEDURE CREAR_ESTACION (id_empleado_acceso IN integer, nombre_va IN ESTACION.nombre%TYPE, id_ciudad IN ESTACION.fk_lugar_ciudad%TYPE, id_jefe_estacion IN ESTACION.fk_empleado_jefe%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

  estacion_reg ESTACION%ROWTYPE;
  oficina_reg OFICINA_PRINCIPAL%ROWTYPE;

  -- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';

BEGIN 

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_ESTACION ( % ) ------', NOW();
  
  -------------////////
  
  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso,id_jefe_estacion);

  SELECT * INTO oficina_reg WHERE fk_director_area = id_empleado_acceso;

  INSERT INTO ESTACION (
    nombre,

    fk_oficina_principal,
    fk_empleado_jefe,
    fk_lugar_ciudad
  
  ) VALUES (

    nombre_va,
    id_jefe_estacion,
    oficina_reg.id,
    id_ciudad 

  ) RETURNING * INTO estacion_reg;

   RAISE INFO 'ESTACION CREADA CON EXITO';
   RAISE INFO 'Datos de la estacion creada %', estacion_reg ; 


END $$;


-- CALL CREAR_ESTACION('prueba',20, 2);
-- SELECT * FROM estacion order by id desc; 
-- select * from lugar where id = 2;
-- select * from EMPLEADO_JEFE where id = 20;



-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


CREATE OR REPLACE PROCEDURE ELIMINAR_ESTACION (id_empleado_acceso IN integer, id_estacion IN INTEGER)
LANGUAGE plpgsql
AS $$  
DECLARE

  -- empleado_jefe_reg EMPLEADO_JEFE%ROWTYPE;
--  estacion_reg ESTACION%ROWTYPE;
  -- tipo_va EMPLEADO_JEFE.tipo%TYPE := 'jefe';

BEGIN 

  CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso,id_estacion);

  RAISE INFO ' ';
  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO ELIMINAR_ESTACION ( % ) ------', NOW();
  
  DELETE FROM ESTACION WHERE id = id_estacion; 
  
     RAISE INFO 'ESTACION ELIMINADA CON EXITO!';
 

END $$;



-- CALL ELIMINAR_ESTACION(15);


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/

CREATE OR REPLACE PROCEDURE ACTUALIZAR_ESTACION (id_empleado_acceso IN integer, nombre_va IN ESTACION.nombre%TYPE, id_ciudad IN ESTACION.fk_lugar_ciudad%TYPE, id_jefe_estacion IN ESTACION.fk_empleado_jefe%TYPE)
LANGUAGE plpgsql
AS $$  
DECLARE

  estacion_reg ESTACION%ROWTYPE;
  oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
 
BEGIN 

  RAISE INFO '------ EJECUCION DEL PROCEDIMINETO CREAR_ESTACION ( % ) ------', NOW();
  

  CALL VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso,id_jefe_estacion);

  SELECT * INTO oficina_reg FROM oficina_principal WHERE fk_director_area = id_empleado_acceso;

  IF (oficina_reg IS NULL) THEN
    RAISE INFO 'La oficina no existe';
    RAISE EXCEPTION 'La oficina no existe';
  END IF;


  SELECT * INTO estacion_reg FROM ESTACION WHERE id = id_estacion;

  IF (estacion_reg IS NULL) THEN
    RAISE INFO 'La estacion no existe';
    RAISE EXCEPTION 'La estacion no existe';
  END IF;


  UPDATE ESTACION SET 
    nombre = nombre_va,
    fk_oficina_principal = id_jefe_estacion,
    fk_empleado_jefe = oficina_reg.id,
    fk_lugar_ciudad = id_ciudad
  
  WHERE id = id_estacion
  RETURNING * INTO estacion_reg;
  
  -------------////////


   RAISE INFO 'ESTACION MODIFICADA CON EXITO';
   RAISE INFO 'Datos de la estacion modificada %', estacion_reg ; 



END $$;


-- select VER_ESTACIONES();
-- CALL ACTUALIZAR_ESTACION (13,'nombre1',false, 21, 9, null);
-- select * from empleado_jefe where id = 9;
-- select * from lugar where id = 20;
-- SELECT * FROM empleado_jefe ej order by id desc; 

-- select VER_DIRECTORES_AREA();


-------/-------/-------/-------/-------/-------///////////////-------/-------/-------/-------/-------/-------/


-- CAMBIAR ROL DE DIRECTOR AREA A JEFE 


-- SELECCIONAR, CREAR, MODIFICAR y ELIMINAR OFICINAS






------------------------////////////////---------------------------



CREATE OR REPLACE PROCEDURE ASIGNACION_PRESUPUESTO (id_empleado_acceso integer, estacion_va integer, presupuesto_va numeric)
LANGUAGE PLPGSQL
AS $$
DECLARE   

  estacion_reg estacion%rowtype;
  oficina_reg oficina_principal%rowtype;
  jefe_reg empleado_jefe%rowtype;
  cuenta_reg CUENTA%ROWTYPE;
  
BEGIN 
  
    RAISE INFO '------ EJECUCION DEL PROCEDIMINETO PARA ASIGNAR PRESUPUESTO EN ESTACIONES ( % ) ------', NOW();
    
    ---PROCEDIMIENTO QUE VALIDA SI EL DIRECTOR DE AREA TIENE ACCESO A LA ESTACION---
    
    CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso, estacion_va);
    
    ---SE VALIDA QUE EL DIRECCTOR DE AREA PERTENESCA A LA OFICINA_PRINCIPAL---
    SELECT * INTO oficina_reg FROM oficina_principal WHERE fk_director_area = id_empleado_acceso; ---MIRAR 
    
    ---SE VALIDA SI LA OFICINA EXISTE--
    
    IF (oficina_reg IS NULL) THEN
      RAISE INFO 'La oficina no existe';
      RAISE EXCEPTION 'La oficina no existe';
    END IF;
  
    SELECT * INTO estacion_reg FROM estacion WHERE id = estacion_va;
    
    IF (estacion_reg IS NULL) THEN
      RAISE INFO 'La estacion no existe';
      RAISE EXCEPTION 'La estacion no existe';
    END IF;
    

    select * into cuenta_reg from cuenta where 
      año = NOW()::DATE
      and fk_estacion = estacion_va;


    IF (cuenta_reg IS NULL) THEN
      
      INSERT INTO cuenta (
        año,
        presupuesto,
        fk_estacion,
        fk_oficina_principal    
        
      ) VALUES (
        NOW()::DATE, 
        presupuesto_va,
        estacion_va,
        oficina_reg.id
      );  

    ELSE 

      UPDATE cuenta SET 
        presupuesto = presupuesto_va
      WHERE 
        año = NOW()::DATE and 
        fk_estacion = estacion_va;

    END IF;

END
$$;


-- CALL ASIGNACION_PRESUPUESTO(2, 2, 5000);
-- select * from cuenta where fk_estacion = 2;

-- PROCEDIMIENTO DE DIRECTOR DE AREA, 
-- ASIGNAR LOS PRESUPUESTOS DE ESTACIONES,
-- REFERENCIA:: ACTUALIZAR ESTACIÓN,
-- VALIDAR QUE EL DIRECTOR TENGA ACCESO,
-- id_empleado_acceso, ES EL ID DEL DIRECTOR DE AREA.


CREATE OR REPLACE FUNCTION VER_PRESUPUESTO_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
RETURNS setof CUENTA
LANGUAGE plpgsql
AS $$  

BEGIN
  CALL VALIDAR_ACESSO_DIR_AREA_ESTACION(id_empleado_acceso, id_estacion);

   RETURN QUERY
     SELECT * FROM CUENTA WHERE fk_estacion = id_estacion; 

END $$;

-- select * from VER_PRESUPUESTO_ESTACION(3,4);
-- select * from cuenta where fk_estacion = 4;






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
    --  oficina_reg OFICINA_PRINCIPAL%ROWTYPE;
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

    IF (numero_registro_compra IS NOT NULL) THEN
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
    END IF;

  -------------////////
  
  UPDATE CLIENTE SET 
  
    nombre_empresa = nombre_empresa_va,
    pagina_web = pagina_web_va, 
    exclusivo = exclusivo_va,  
    telefonos = ARRAY[telefono_va],
        contactos = ARRAY [contacto_va],
    fk_lugar_pais = id_lugar
    
  WHERE id = id_cliente
  RETURNING * INTO cliente_reg;

   RAISE INFO 'CLIENTE ACTUALIZADO CON EXITO!';
   RAISE INFO 'Datos del cliente: %', cliente_reg ; 



END $$;

-- (id_cliente IN integer, nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, id_lugar in integer)
-- CALL actualizar_cliente (2,'nombre_empresa','pagina_web',false,CREAR_TELEFONO(0212,2847213),null, 5);
-- -- SELECT * FROM cliente ej order by id desc; 



--------------------//////////////////--------------------



-- DROP PROCEDURE ASIGNAR_TEMA_CLIENTE;


CREATE OR REPLACE PROCEDURE ASIGNAR_TEMA_CLIENTE (tema_id integer,cliente_id integer)
LANGUAGE PLPGSQL
AS $$
DECLARE 

  tema_reg CLAS_TEMA%ROWTYPE;
  cliente_reg CLIENTE%ROWTYPE;

  area_interes_exit AREA_INTERES%ROWTYPE;

BEGIN 
  
  SELECT * INTO tema_reg FROM CLAS_TEMA WHERE id = tema_id;
  
  ---VALIDACION SI EL TEMA ES NULO---    
  IF (tema_reg IS NULL) THEN
    
    RAISE EXCEPTION 'No existe el tema';
  END IF;


  SELECT * INTO cliente_reg FROM CLIENTE WHERE id = cliente_id;
  
  ---VALIDACION SI EL TEMA ES NULO---    
  IF (cliente_reg IS NULL) THEN
    
    RAISE EXCEPTION 'No existe el cliente';
  END IF;


  SELECT * INTO area_interes_exit FROM AREA_INTERES WHERE fk_clas_tema = tema_id and fk_cliente = cliente_id;
    
  ---VALIDACION SI EL TEMA ES NULO---    
  IF (area_interes_exit IS NOT NULL) THEN
    
    RAISE EXCEPTION 'Ya el tema fue asignado';
  END IF;


  INSERT INTO AREA_INTERES (
    fk_clas_tema,
    fk_cliente        
  ) VALUES (
    tema_id, 
    cliente_id          
  );
  

  RAISE INFO 'SE INSERTO EN EL CLIENTE CON EL ID: % Y EL NOMBRE: %, EL TEMA CON ID: % Y NOMBRE: %', cliente_reg.id, cliente_reg.nombre_empresa, tema_reg.id, tema_reg.nombre;   
    
END
$$;

-- call ASIGNAR_TEMA_CLIENTE (2, 10);
-- select * from AREA_INTERES;