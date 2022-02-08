-- jefe_est_14_amsterdam PASSWORD 'jefe_est_14_amsterdam_aii'    -- id empleado_jefe = 14    -- id estacion = 4


-- agente_est_amsterdam PASSWORD 'agente_est_amsterdam_aii'   -- id estacion = 4   -- id_personal = 16/confidencial
-- agente_est_roterdam PASSWORD 'agente_est_roterdam_aii'     -- id estacion = 5
-- agente_est_haarlam PASSWORD 'agente_est_haarlam_aii'	     -- id estacion = 6



select current_user;


-- SOY AGENTE 16 , ESTACION 4

--/ CALL registro_informante(:nombre_clave_va, :id_agente_campo, :id_empleado_jefe_confidente, :id_personal_inteligencia_confidente) 
CALL registro_informante('informante_prueba', 16, 15, null);

--CALL registro_informante('Manuelitaaa', 20, null, 3);


--/ call ver_lista_informantes_personal_inteligencia_agente(:id_personal_inteligencia) 
SELECT * FROM  ver_lista_informantes_personal_inteligencia_agente(16);

--SELECT * FROM  ver_lista_informantes_empleado_confidente(15) ;

--call registro_crudo_con_informante(:id_informante, :monto_pago_va, :id_agente_campo, :id_tema, :contenido_va, :tipo_contenido_va, :resumen_va, :valor_apreciacion_va, :nivel_confiabilidad_inicial_va, :cant_analistas_verifican_va) 
CALL registro_crudo_con_informante(22, 30, 16, 2, formato_archivo_a_bytea('/ruta'), 'texto', 'resumen de crudo prueba ', 30, 55, 2);


--CALL registro_crudo_sin_informante(:id_agente_campo, :id_tema, :contenido_va, :tipo_contenido_va, :resumen_va, :fuente_va, :valor_apreciacion_va, :nivel_confiabilidad_inicial_va, :cant_analistas_verifican_va) 
--CALL registro_crudo_sin_informante(16, 3, formato_archivo_a_bytea('/ruta'), 'otro', 'resumen de crudo prueba sin informante', 'secreta', -5, 120, 1);
CALL registro_crudo_sin_informante(16, 3, formato_archivo_a_bytea('/ruta'), 'texto', 'resumen de crudo prueba sin informante 2', 'tecnica', 100, 80, 2);

SELECT * FROM VER_LISTA_CRUDOS_PERSONAL(16);






--////////////-


-- analista_est_amsterdam PASSWORD 'analista_est_amsterdam_aii'     -- id estacion = 4  -- id_personal = 13/top_secret , 15/no_clasificado
-- analista_est_roterdam PASSWORD 'analista_est_roterdam_aii'     -- id estacion = 5	-- id_personal = 17/top_secret
-- analista_est_haarlam PASSWORD 'analista_est_haarlam_aii'      -- id estacion = 6		-- id_personal = 21/top_secret, 23/no_clasificado


-- CAMBIO A ANALISTA PARA VERIFICAR 

-- SOY ANALISTA 13, ESTACION 4

--call verificar_crudo(:id_analista, :id_crudo, :nivel_confiabilidad_va) 
--CALL VERIFICAR_CRUDO ( 13, 32, 80);
-- PROBAR CON ROL DE AGENTE 

-- ESTE NO DA PQ EL ANALISTA ES DE LA MISMA ESTACION QUE EL CRUDO
--CALL VERIFICAR_CRUDO ( 13, 32, 80);

-- SOY ANALISTA 17, ESTACION 5
CALL VERIFICAR_CRUDO ( 17, 33, 80);
-- SI SE CORRE DOS VECES NO SE PUEDE VERIFICAR POR EL MISMO ANALISTA

-- SOY ANALISTA 21, ESTACION 6
CALL VERIFICAR_CRUDO ( 21, 33, 95);

-- SOY ANALISTA 23, ESTACION 6
CALL VERIFICAR_CRUDO( 23, 32, 90); 

-- FALTAN MAS VERIFICACIONES
CALL CERRAR_CRUDO(33);

--------//////---


-- SOY ANALISTA 21, ESTACION 6
CALL VERIFICAR_CRUDO ( 21, 31, 95);

-- SOY ANALISTA 17, ESTACION 5
CALL VERIFICAR_CRUDO ( 17, 31, 80);

CALL CERRAR_CRUDO(31);

---- CRUDO CERRADO - AHORA CREAR PIEZA 


SELECT * FROM ver_lista_crudos_estacion(4);

select * from crudo_pieza;
------------///////---------

-- SOY  ANALISTA -- id estacion = 4  -- id_personal = 13
--call registro_verificacion_pieza_inteligencia(:id_analista_encargado, :descripcion, :id_crudo_base) 
--CALL REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA(13,'descripcion pieza',30);



CALL REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA(13,'descripcion pieza',31);


---------//////// QUITE TRIGGER_INSERT_UPDATE_CRUDO_PIEZA /////////--------------------

-- SOY jefe_est_14_amsterdam -- id empleado_jefe = 14    -- id estacion = 4
--call ver_lista_piezas_estacion(:id_estacion);
SELECT * FROM VER_LISTA_PIEZAS_ESTACION(4);
SELECT * FROM INTENTOS_NO_AUTORIZADOS (4);


-- SOY  AGENTE --id_estacion = 4 -- id_personal = 16/confidencial
--select ver_datos_pieza(:id_pieza, :id_personal_inteligencia) 
SELECT * FROM VER_DATOS_PIEZA(28,16);


-- SOY  ANALISTA --id_estacion = 4 -- id_personal = 13/top_secret
--select ver_datos_pieza(:id_pieza, :id_personal_inteligencia) 
SELECT * FROM VER_DATOS_PIEZA(28,13);




----------------///////////-------------

--call agregar_crudo_a_pieza(:id_crudo, :id_pieza) 

CALL AGREGAR_CRUDO_A_PIEZA(33,28);



--call certificar_pieza(:id_pieza, :precio_base_va) 
CALL CERTIFICAR_PIEZA(28,150);
SELECT * FROM VER_DATOS_PIEZA(28,13);

UPDATE pieza_inteligencia SET fk_clas_tema = 1 where id = 28;

SELECT * FROM ver_clientes();

--CALL REGISTRO_VENTA (id_pieza, id_cliente, precio_vendido_va)
CALL REGISTRO_VENTA(6,5,300);


SELECT * FROM VER_DATOS_PIEZA(28,7);

select * from adquisicion;
select * from pieza_inteligencia pi2;
SELECT * FROM pieza_inteligencia_alt;
SELECT * FROM crudo_alt;
SELECT * FROM crudo;

