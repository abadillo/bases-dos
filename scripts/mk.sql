-- Agente 16 Amsterdan
-- Analista 17
-- Analista NO VERIFICACION 13 Amsterdam

-- CREATE USER agente_est_amsterdam WITH ENCRYPTED PASSWORD 'agente_est_amsterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 4
-- CREATE USER analista_est_amsterdam WITH ENCRYPTED PASSWORD 'analista_est_amsterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 4
-- CREATE USER analista_est_roterdam WITH ENCRYPTED PASSWORD 'analista_est_roterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 5


--ID personal
-- Elimina pieza exclusiva vendida y lo manda a alt
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA ( id_pieza)

-- CREAR LUGAR
CALL CREAR_LUGAR (nombre_va IN LUGAR.nombre%TYPE, tipo_va in LUGAR.tipo%TYPE, region_va in LUGAR.region%TYPE, 
            id_lugar_sup IN LUGAR.fk_lugar%TYPE)

--ELIMINAR LUGAR
CALL ELIMINAR_LUGAR (id_lugar IN INTEGER)

-- ACTUALIZAR LUGAR
CALL ACTUALIZAR_LUGAR (id_lugar IN integer,nombre_va IN LUGAR.nombre%TYPE, tipo_va in LUGAR.tipo%TYPE, 
                        region_va in LUGAR.region%TYPE, id_lugar_sup IN LUGAR.fk_lugar%TYPE)


-- VER DIRECTOR AREA
CALL VER_DIRECTOR_AREA (id_director_area in integer)


--CREAR DIRECTOR AREA
CALL CREAR_DIRECTOR_AREA (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)

-- CAMBIAR ROL DE EMPLEADO
CALL CAMBIAR_ROL_EMPLEADO (id_empleado IN integer, id_jefe in integer, cargo in integer)

-- CREAR PERSONAL_INTELIGENCIA
CREAR_PERSONAL_INTELIGENCIA (

    primer_nombre_va IN PERSONAL_INTELIGENCIA.primer_nombre%TYPE, 
    segundo_nombre_va IN PERSONAL_INTELIGENCIA.segundo_nombre%TYPE, 
    primer_apellido_va IN PERSONAL_INTELIGENCIA.primer_apellido%TYPE, 
    segundo_apellido_va IN PERSONAL_INTELIGENCIA.segundo_apellido%TYPE, 
    fecha_nacimiento_va IN PERSONAL_INTELIGENCIA.fecha_nacimiento%TYPE, 
    altura_cm_va IN PERSONAL_INTELIGENCIA.altura_cm%TYPE, 
    peso_kg_va IN PERSONAL_INTELIGENCIA.peso_kg%TYPE, 
    color_ojos_va IN PERSONAL_INTELIGENCIA.color_ojos%TYPE, 
    vision_va IN PERSONAL_INTELIGENCIA.vision%TYPE, 
    class_seguridad_va IN PERSONAL_INTELIGENCIA.class_seguridad%TYPE, 

    fotografia_va IN PERSONAL_INTELIGENCIA.fotografia%TYPE, 
    huella_retina_va IN PERSONAL_INTELIGENCIA.huella_retina%TYPE, 
    huella_digital_va IN PERSONAL_INTELIGENCIA.huella_digital%TYPE, 

    telefono_va IN PERSONAL_INTELIGENCIA.telefono%TYPE, 
    licencia_manejo_va IN PERSONAL_INTELIGENCIA.licencia_manejo%TYPE,

    idiomas_va IN PERSONAL_INTELIGENCIA.idiomas%TYPE, 
    familiar_1_va IN familiar_ty, 
    familiar_2_va IN familiar_ty, 
    
    identificacion_1_va IN identificacion_ty, 
    
    nivel_educativo_1_va IN nivel_educativo_ty, 

    id_ciudad IN PERSONAL_INTELIGENCIA.fk_lugar_ciudad%TYPE
)


-- CAMBIAR ROL
CAMBIAR_ROL_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia IN integer, 
                                    cargo_va IN HIST_CARGO.cargo%TYPE)

-- ELIMINAR REGISTROS DE INFORMANTES DE UN PERSONAL
ELIMINACION_REGISTROS_INFORMANTE ( id_personal_inteligencia IN integer )


-- DESPIDO DE UN PERSONAL
DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia IN integer)


-- INFORMANTES DEL CONFIDENTE
SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (id_personal_inteligencia in integer)

-- INFORMANTES DEL PERSONAL
SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (id_personal_inteligencia in integer)

-- REGISTRAR INFORMANTE
REGISTRO_INFORMANTE (nombre_clave_va IN INFORMANTE.nombre_clave%TYPE, id_agente_campo IN integer, 
                id_empleado_jefe_confidente IN integer, id_personal_inteligencia_confidente IN integer)


-- REGISTRAR CRUDO SECRETO
REGISTRO_CRUDO_SIN_INFORMANTE (id_agente_campo IN integer, id_tema IN integer, 
        contenido_va IN CRUDO.contenido%TYPE, tipo_contenido_va IN CRUDO.tipo_contenido%TYPE, 
        resumen_va IN CRUDO.resumen%TYPE, fuente_va IN CRUDO.fuente%TYPE, 
        valor_apreciacion_va IN CRUDO.valor_apreciacion%TYPE, 
        nivel_confiabilidad_inicial_va IN CRUDO.nivel_confiabilidad_inicial%TYPE, 
        cant_analistas_verifican_va IN CRUDO.cant_analistas_verifican%TYPE )


-- REGISTRO CRUDO CON INFORMANTE (NO SECRETO)
REGISTRO_CRUDO_CON_INFORMANTE ( id_informante IN integer, monto_pago_va IN TRANSACCION_PAGO.monto_pago%TYPE, 
            id_agente_campo IN integer, id_tema IN integer, contenido_va IN CRUDO.contenido%TYPE, 
            tipo_contenido_va IN CRUDO.tipo_contenido%TYPE, resumen_va IN CRUDO.resumen%TYPE, 
            valor_apreciacion_va IN CRUDO.valor_apreciacion%TYPE, 
            nivel_confiabilidad_inicial_va IN CRUDO.nivel_confiabilidad_inicial%TYPE, 
            cant_analistas_verifican_va IN CRUDO.cant_analistas_verifican%TYPE )


-- VERIFICAR CRUDO
VERIFICAR_CRUDO ( id_analista IN integer, id_crudo IN integer, 
                    nivel_confiabilidad_va IN ANALISTA_CRUDO.nivel_confiabilidad%TYPE )

-- CERRAR CRUDO (VERIFICA EL CRUDO, QUE CUMPLA CON LAS CONDICIONES PARA CERRARLO Y NO VOLVER A MODIFICARLO)
CERRAR_CRUDO ( id_crudo IN integer )


-- CREA PIEZA
REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (id_analista_encargado IN integer, 
        descripcion IN PIEZA_INTELIGENCIA.descripcion%TYPE, id_crudo_base IN integer)


-- VER PIEZA
VER_DATOS_PIEZA (id_pieza IN integer, id_personal_inteligencia IN integer)

-- VENTA DE PIEZA
REGISTRO_VENTA (id_pieza IN integer, id_cliente IN integer, 
            precio_vendido_va IN ADQUISICION.precio_vendido%TYPE)


-----------------------------------------------------

-- RUTA


-- Agente 16 Amsterdan
-- Analista 17
-- Analista NO VERIFICACION 13 Amsterdam

-- CREATE USER agente_est_amsterdam WITH ENCRYPTED PASSWORD 'agente_est_amsterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 4
-- CREATE USER analista_est_amsterdam WITH ENCRYPTED PASSWORD 'analista_est_amsterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 4
-- CREATE USER analista_est_roterdam WITH ENCRYPTED PASSWORD 'analista_est_roterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 5

-- INFORMANTE
-- SELECT * FROM INFORMANTE; -- PERMISO DENEGADO
-- SELECT * FROM PERSONAL_INTELIGENCIA;
-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (17);
-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (20);
-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (17);
-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (20);
-- CALL registro_informante('Manuelitaaa', 20, 3, null);
-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (20);
-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (20);

--CREAR CRUDO
-- registro_crudo_con_informante(:id_informante, :monto_pago_va,
--			:id_agente_campo,  :id_tema,  :contenido_va,  :tipo_contenido_va,
--			:resumen_va, :valor_apreciacion_va, :nivel_confiabilidad_inicial_va, :cant_analistas_verifican_va);

-- CALL registro_crudo_con_informante (23, 200, 20, 4, 'crudo_contenido/texto2.txt', 'texto','Ejemplo conflicto', 550, 88, 2);
-- SELECT * FROM VER_LISTA_CRUDOS_PERSONAL (20);

-- SELECT * FROM VER_LISTA_CRUDOS_PERSONAL (20);

-- ANALISTA----
-- VERIFICAR CRUDO
--VERIFICAR_CRUDO ( id_analista IN integer, id_crudo IN integer, nivel_confiabilidad_va IN ANALISTA_CRUDO.nivel_confiabilidad%TYPE )

-- CALL verificar_crudo(17, 30, 90); -- ERROR AL YA ESTAR VERIFICADO.
-- CALL verificar_crudo(15, 30, 90); -- ANALIZADO 1.
-- CALL verificar_crudo(17, 30, 90); -- ANALIZADO 2 -- ERROR ANALISTA DE LA MISMA ESTACION.
-- CALL verificar_crudo(21, 30, 99); -- ANALIZADO 2.
-- CALL verificar_crudo(23, 30, 91); -- ANALIZADO 3. ERROR CRUDO YA VERIFICADO
-- CALL CERRAR_CRUDO ( 30 );
-- PASAR A AGENTE PARA CONFIRMAR



-- JEFE ESTACION

-- ELIMINAR EMPLEADOS
-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (20); -- MOSTRAR INFORMANTES DEL EMPLEADO
-- CALL DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia IN integer)
-- CALL DESPIDO_RENUNCIA_PERSONAL_INTELIGENCIA (15, 20);



