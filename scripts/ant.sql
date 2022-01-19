-- ROLES 

-- CREATE USER agente_est_amsterdam WITH ENCRYPTED PASSWORD 'agente_est_amsterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 4
-- CREATE USER agente_est_roterdam WITH ENCRYPTED PASSWORD 'agente_est_roterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 5
-- CREATE USER agente_est_haarlam WITH ENCRYPTED PASSWORD 'agente_est_haarlam_aii' CONNECTION LIMIT 20;     -- id estacion = 6

-- CREATE USER analista_est_amsterdam WITH ENCRYPTED PASSWORD 'analista_est_amsterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 4
-- CREATE USER analista_est_roterdam WITH ENCRYPTED PASSWORD 'analista_est_roterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 5
-- CREATE USER analista_est_haarlam WITH ENCRYPTED PASSWORD 'analista_est_haarlam_aii' CONNECTION LIMIT 20;     -- id estacion = 6



-- 4. Demostración de la implementación de los requerimientos del
-- sistema de bases de datos transaccional referidos al proceso de
-- venta de piezas de inteligencia – construcción de piezas de
-- inteligencia y venta a clientes, incluyendo la seguridad
-- correspondiente (roles, cuentas con privilegios para poder ejecutar
-- los programas y reportes).


-- GRANT EXECUTE ON PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (integer, varchar, integer) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
-- GRANT EXECUTE ON FUNCTION VER_DATOS_PIEZA (integer, integer) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
-- GRANT EXECUTE ON PROCEDURE AGREGAR_CRUDO_A_PIEZA ( integer, integer ) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
-- GRANT EXECUTE ON PROCEDURE REGISTRO_VENTA (integer, integer, numeric) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
-- GRANT EXECUTE ON PROCEDURE CERTIFICAR_PIEZA (integer, numeric) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
-- GRANT EXECUTE ON PROCEDURE ELIMINACION_REGISTROS_VENTA_EXCLUSIVA ( integer )  TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
-- GRANT EXECUTE ON FUNCTION VALIDAR_VENTA_EXCLUSIVA ( integer )  TO ROL_AGENTE_CAMPO, ROL_ANALISTA;



--/ CAMBIAR A agente_est_amsterdam
--/- REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (id_analista_encargado IN integer, descripcion IN PIEZA_INTELIGENCIA.descripcion%TYPE, id_crudo_base IN integer)

CALL REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA( 1 , 'descripcion pieza prueba', 1 );


--CALL AGREGAR_CRUDO_A_PIEZA( id_pieza, id_crudo , id_analista);

--CALL AGREGAR_CRUDO_A_PIEZA( 9, 10 , 11);


--CALL CERTIFICAR_PIEZA( 37, 1 );


--CALL REGISTRO_VENTA( 1,  1, 10000.0 );






