

-- agente_est_amsterdam PASSWORD 'agente_est_amsterdam_aii'   -- id estacion = 4   -- id_personal = 16
-- agente_est_roterdam PASSWORD 'agente_est_roterdam_aii'     -- id estacion = 5
-- agente_est_haarlam PASSWORD 'agente_est_haarlam_aii'	     -- id estacion = 6

-- analista_est_amsterdam PASSWORD 'analista_est_amsterdam_aii'     -- id estacion = 4  -- id_personal = 13, 15
-- analista_est_roterdam PASSWORD 'analista_est_roterdam_aii'     -- id estacion = 5
-- analista_est_haarlam PASSWORD 'analista_est_haarlam_aii'      -- id estacion = 6


select current_user;

4. Demostración de la implementación de los requerimientos del
sistema de bases de datos transaccional referidos al proceso de
venta de piezas de inteligencia – construcción de piezas de
inteligencia y venta a clientes, incluyendo la seguridad
correspondiente (roles, cuentas con privilegios para poder ejecutar
los programas y reportes).


-- SOY AGENTE 16 , ESTACION 4

--/ CALL registro_informante(:nombre_clave_va, :id_agente_campo, :id_empleado_jefe_confidente, :id_personal_inteligencia_confidente) 
CALL registro_informante('informante_prueba', 16, 15, null);

--/ call ver_lista_informantes_personal_inteligencia_agente(:id_personal_inteligencia) 
SELECT * FROM  ver_lista_informantes_personal_inteligencia_agente(16) ;

--SELECT * FROM  ver_lista_informantes_empleado_confidente(15) ;

--call registro_crudo_con_informante(:id_informante, :monto_pago_va, :id_agente_campo, :id_tema, :contenido_va, :tipo_contenido_va, :resumen_va, :valor_apreciacion_va, :nivel_confiabilidad_inicial_va, :cant_analistas_verifican_va) 
CALL registro_crudo_con_informante(22, 30, 16, 2, formato_archivo_a_bytea('/ruta'), 'texto', 'resumen de crudo prueba 1', 30, 55, 3);


--CALL registro_crudo_sin_informante(:id_agente_campo, :id_tema, :contenido_va, :tipo_contenido_va, :resumen_va, :fuente_va, :valor_apreciacion_va, :nivel_confiabilidad_inicial_va, :cant_analistas_verifican_va) 
--CALL registro_crudo_sin_informante(16, 3, formato_archivo_a_bytea('/ruta'), 'otro', 'resumen de crudo prueba sin informante', 'secreta', -5, 120, 1);
CALL registro_crudo_sin_informante(16, 3, formato_archivo_a_bytea('/ruta'), 'texto', 'resumen de crudo prueba sin informante', 'tecnica', 100, 80, 2);

SELECT * FROM VER_LISTA_CRUDOS_PERSONAL(16);



-- CAMBIO A ANALISTA PARA VERIFICAR 

-- SOY ANALISTA 13, ESTACION 4

--call verificar_crudo(:id_analista, :id_crudo, :nivel_confiabilidad_va) 
CALL VERIFICAR_CRUDO ( 13, 33, 80);


















