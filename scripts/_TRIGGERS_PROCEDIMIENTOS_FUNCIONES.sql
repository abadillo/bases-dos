--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\


-//-//-//-//- TRIGGERS -//-//-//-//-

 
-/=/- ARCHIVO TRIGGERS.sql -/=/-    -/=/- ARCHIVO TRIGGERS_GAB.sql -/=/- 


--////-- TABLA EMPLEADO_JEFE
-/ TRIGGER_EMPLEADO_JEFE BEFORE INSERT OR UPDATE OR DELETE ON EMPLEADO_JEFE FOR EACH ROW TRIGGER_EMPLEADO_JEFE();

--////-- TABLA CLIENTE
-/ TRIGGER_CLIENTE BEFORE INSERT OR UPDATE OR DELETE ON CLIENTE FOR EACH ROW TRIGGER_CLIENTE();

--//-//-- OFICINA_PRINCIPAL
-/ TRIGGER_OFICINA_PRINCIPAL BEFORE INSERT OR UPDATE OR DELETE FOR EACH ROW TRIGGER_OFICINA_PRINCIPAL();


--//-//-- PERSONAL_INTELIGENCIA
-/ TRIGGER_INSERT_UPDATE_PERSONAL_INTELIGENCIA BEFORE INSERT OR UPDATE ON PERSONAL_INTELIGENCIA FOR EACH ROW TRIGGER_PERSONAL_INTELIGENCIA()


--//-//-- INFORMANTE
-/ TRIGGER_INSERT_UPDATE_INFORMANTE BEFORE INSERT OR UPDATE FOR EACH ROW TRIGGER_INSERT_UPDATE_INFORMANTE();


--//-//-- CRUDO
-/ TRIGGER_UPDATE_INSERT_CRUDO BEFORE INSERT OR UPDATE FOR EACH ROW TRIGGER_UPDATE_INSERT_CRUDO()


--//-//-- PIEZA_INTELIGENCIA
-/ TRIGGER_UPDATE_PIEZA BEFORE UPDATE ON PIEZA_INTELIGENCIA FOR EACH ROW TRIGGER_UPDATE_PIEZA();


--//-//-- CRUDO_PIEZA
-/ TRIGGER_INSERT_UPDATE_CRUDO_PIEZA BEFORE INSERT OR UPDATE FOR EACH ROW TRIGGER_INSERT_UPDATE_CRUDO_PIEZA();


--//-//-- ADQUISICION
-/ TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION AFTER INSERT FOR EACH ROW TRIGGER_REGISTRO_TEMAS_CLIENTE_ADQUISICION();

--//-//-- LUGAR
-/ TRIGGER_INSERT_LUGAR BEFORE INSERT OR UPDATE ON LUGAR FOR EACH ROW TRIGGER_FUNCTION_VERIF_JERARQUIA_LUGAR();


--//-//-- ESTACION
--//-//-- CUENTA
--//-//-- INTENTO_NO_AUTORIZADO
--//-//-- CLAS_TEMA
--//-//-- AREA_INTERES
--//-//-- TEMAS_ESP
--//-//-- HIST_CARGO
--//-//-- TRANSACCION_PAGO
--//-//-- ANALISTA_CRUDO
--//-//-- HIST_CARGO_ALT
--//-//-- INFORMANTE_ALT
--//-//-- TRANSACCION_PAGO_ALT
--//-//-- CRUDO_ALT
--//-//-- ANALISTA_CRUDO_ALT
--//-//-- PIEZA_INTELIGENCIA_ALT
--//-//-- CRUDO_PIEZA_ALT
--//-//-- ADQUISICION_ALT




--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\


-//-//-//-//- FUNCIONES -//-//-//-//-


-/=/- ARCHIVO PROCEDIMIENTOS_DIRECTOR_EJECUTIVO.sql -/=/- 

-/ VER_DIRECTOR_AREA (id_director_area in integer) RETURNS EMPLEADO_JEFE
-/ VER_DIRECTORES_AREA () RETURNS setof EMPLEADO_JEFE

-/ VER_LUGAR (id_lugar in integer) RETURNS LUGAR
-/ VER_LUGARES () RETURNS setof LUGAR

-/ VER_OFICINA (id_oficina in integer) RETURNS OFICINA_PRINCIPAL
-/ VER_OFICINAS () RETURNS setof OFICINA_PRINCIPAL

-/ VER_DIRECTOR_EJECUTIVO (id_director_ejecutivo in integer)
-/ VER_DIRECTORES_EJECUTIVOS ()




-/=/- ARCHIVO PROCEDIMIENTOS_DIRECTOR_AREA.sql -/=/-

-/ VER_JEFE_E (id_empleado_acceso in integer, id_jefe in integer)
-/ VER_JEFES_E (id_empleado_acceso in integer)
-/ VER_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
-/ VER_ESTACIONES (id_empleado_acceso in integer)
-/ VER_PRESUPUESTO_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
-/ VER_CLIENTE (id_cliente in integer)
-/ VER_CLIENTES ()
-/ 



-/=/- ARCHIVO PROCEDIMIENTOS_JEFE_ESTACION.sql -/=/- 

-/ VER_TODOS_PERSONAL_INTELIGENCIA_SIN_CARGO () RETURNS setof PERSONAL_INTELIGENCIA
-/ VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO (id_empleado_acceso in integer) RETURNS setof PERSONAL_INTELIGENCIA
-/ VER_PERSONAL_INTELIGENCIA_SIN_CARGO (id_personal_inteligencia in integer) RETURNS PERSONAL_INTELIGENCIA
-/ VER_PERSONAL_INTELIGENCIA_CON_CARGO (id_empleado_acceso in integer, id_personal_inteligencia in integer) RETURNS PERSONAL_INTELIGENCIA
-/ VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia in integer) RETURNS setof HIST_CARGO
-/ VER_CUENTA_ESTACION_JEFE_ESTACION (id_empleado_acceso in integer, id_estacion in INTEGER) RETURNS setof CUENTA
-/ VER_LISTA_INFORMANTES_EMPLEADO_CONFIDENTE (id_empleado_acceso in integer)


-/=/- ARCHIVO PROCEDIMIENTOS_TYPE.sql -/=/- 



-/=/- ARCHIVO PROCEDIMIENTOS_PERSONAL_INTELIGENCIA.sql.sql -/=/- 

-/ VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
-/ VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
-/ REGISTRO_INFORMANTE (nombre_clave_va IN INFORMANTE.nombre_clave%TYPE, id_agente_campo IN integer, id_empleado_jefe_confidente IN integer, id_personal_inteligencia_confidente IN integer)
-/ REGISTRO_CRUDO_SIN_INFORMANTE (id_agente_campo IN integer, id_tema IN integer, contenido_va IN CRUDO.contenido%TYPE, tipo_contenido_va IN CRUDO.tipo_contenido%TYPE, resumen_va IN CRUDO.resumen%TYPE, fuente_va IN CRUDO.fuente%TYPE, valor_apreciacion_va IN CRUDO.valor_apreciacion%TYPE, nivel_confiabilidad_inicial_va IN CRUDO.nivel_confiabilidad_inicial%TYPE, cant_analistas_verifican_va IN CRUDO.cant_analistas_verifican%TYPE )
-/ REGISTRO_CRUDO_CON_INFORMANTE ( id_informante IN integer, monto_pago_va IN TRANSACCION_PAGO.monto_pago%TYPE, id_agente_campo IN integer, id_tema IN integer, contenido_va IN CRUDO.contenido%TYPE, tipo_contenido_va IN CRUDO.tipo_contenido%TYPE, resumen_va IN CRUDO.resumen%TYPE, valor_apreciacion_va IN CRUDO.valor_apreciacion%TYPE, nivel_confiabilidad_inicial_va IN CRUDO.nivel_confiabilidad_inicial%TYPE, cant_analistas_verifican_va IN CRUDO.cant_analistas_verifican%TYPE )
LANGUAGE plpgsql
-/ REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (id_analista_encargado IN integer, descripcion IN PIEZA_INTELIGENCIA.descripcion%TYPE, id_crudo_base IN integer)
-/ AGREGAR_CRUDO_A_PIEZA (id_crudo IN integer, id_pieza IN integer)
-/ CERTIFICAR_PIEZA (id_pieza IN integer, precio_base_va IN PIEZA_INTELIGENCIA.precio_base%TYPE)
-/ VER_DATOS_PIEZA (id_pieza IN integer, id_personal_inteligencia IN integer)
RETURNS setof PIEZA_INTELIGENCIA
-/ ELIMINACION_REGISTROS_VENTA_EXCLUSIVA ( id_pieza IN integer ) 
-/ VALIDAR_VENTA_EXCLUSIVA ( id_pieza IN integer ) 
 RETURNS boolean
-/ REGISTRO_VENTA (id_pieza IN integer, id_cliente IN integer, precio_vendido_va IN ADQUISICION.precio_vendido%TYPE)
-/ ANALISTA_VERIFICO_CRUDO ( id_crudo IN integer, id_analista IN integer ) 
-/ ANALISTA_PUEDE_VERIFICA_CRUDO ( id_crudo IN integer, id_analista IN integer ) 
-/ VERIFICAR_CRUDO ( id_analista IN integer, id_crudo IN integer, nivel_confiabilidad_va IN ANALISTA_CRUDO.nivel_confiabilidad%TYPE )
-/ CERRAR_CRUDO ( id_crudo IN integer )




--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\


-//-//-//-//- PROCEDIMIENTOS -//-//-//-//-



-/=/- ARCHIVO VALIDACIONES_TRIGGER.sql -/=/- 

-/ VALIDAR_JERARQUIA_EMPLEADO_JEFE (id_empleado_sup IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
-/ VALIDAR_TIPO_EMPLEADO_JEFE(id_empleado IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
-/ VALIDAR_TIPO_LUGAR(id_lugar IN integer, tipo_va IN LUGAR.tipo%TYPE)
-/ VALIDAR_ARCO_EXCLUSIVO()
-/ VALIDAR_EXIT_TEMA(id_tema IN integer)
-/ VALIDAR_CANT_ANALISTAS_VERIFICAN_CRUDO ( id_crudo IN integer ) 



-/=/- ARCHIVO PROCEDIMIENTOS_DIRECTOR_EJECUTIVO.sql -/=/- 

-/ CREAR_DIRECTOR_AREA (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)
-/ ELIMINAR_DIRECTOR_AREA (id_director_area IN INTEGER)
-/ ACTUALIZAR_DIRECTOR_AREA (id_director_area IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)

-/ CREAR_OFICINA_PRINCIPAL (nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)
-/ ELIMINAR_OFICINA_PRINCIPAL (id_oficina IN INTEGER)
-/ ACTUALIZAR_OFICINA_PRINCIPAL (id_oficina IN integer, nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)

-/ CREAR_DIRECTOR_EJECUTIVO (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
-/ ELIMINAR_DIRECTOR_EJECUTIVO (id_director_ejecutivo IN INTEGER)
-/ ACTUALIZAR_DIRECTOR_EJECUTIVO (id_director_ejecutivo IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)

-/ CAMBIAR_ROL_EMPLEADO (id_empleado IN integer, id_jefe in integer, cargo in integer)

-/ CREAR_LUGAR (nombre_va IN LUGAR.nombre%TYPE, tipo_va in LUGAR.tipo%TYPE, region_va in LUGAR.region%TYPE, id_lugar_sup IN LUGAR.fk_lugar%TYPE)
-/ ELIMINAR_LUGAR (id_lugar IN INTEGER)
-/ ACTUALIZAR_LUGAR (id_lugar IN integer,nombre_va IN LUGAR.nombre%TYPE, tipo_va in LUGAR.tipo%TYPE, region_va in LUGAR.region%TYPE, id_lugar_sup IN LUGAR.fk_lugar%TYPE)




-/=/- ARCHIVO PROCEDIMIENTOS_DIRECTOR_AREA.sql -/=/-

-- / - REVISAR
-/ VALIDAR_ACESSO_DIR_AREA_ESTACION (id_empleado_acceso in integer, id_estacion in integer)
-/ VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(id_empleado_acceso in integer, id_jefe_estacion in integer)


-/ CREAR_JEFE_ESTACION (id_empleado_acceso in integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
-/ ACTUALIZAR_JEFE_ESTACION (id_empleado_acceso IN integer, id_jefe_estacion IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
-/ ELIMINAR_JEFE_ESTACION (id_empleado_acceso IN INTEGER, id_jefe_estacion IN INTEGER)

-/ CREAR_ESTACION (id_empleado_acceso IN integer, nombre_va IN ESTACION.nombre%TYPE, id_ciudad IN ESTACION.fk_lugar_ciudad%TYPE, id_jefe_estacion IN ESTACION.fk_jefe_estacion%TYPE)
-/ ELIMINAR_ESTACION (id_empleado_acceso IN integer, id_estacion IN INTEGER)
-/ ACTUALIZAR_ESTACION (id_empleado_acceso IN integer, nombre_va IN ESTACION.nombre%TYPE, id_ciudad IN ESTACION.fk_lugar_ciudad%TYPE, id_jefe_estacion IN ESTACION.fk_empleado_jefe%TYPE)

-/  ASIGNACION_PRESUPUESTO (id_empleado_acceso integer, estacion_va integer, presupuesto_va numeric)

-/ CREAR_CLIENTE (nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, id_lugar in integer)
-/ ELIMINAR_CLIENTE (id_cliente IN INTEGER)
-/ ACTUALIZAR_CLIENTE (id_cliente IN integer, nombre_empresa_va IN CLIENTE.nombre_empresa%TYPE, pagina_web_va IN CLIENTE.pagina_web%TYPE, exclusivo_va IN CLIENTE.exclusivo%TYPE, telefono_va IN telefono_ty, contacto_va IN contacto_ty, id_lugar in integer)

- / ASIGNAR_TEMA_CLIENTE (tema_id integer,cliente_id integer)


-- MANEJO DE TEMAS





-/=/- ARCHIVO PROCEDIMIENTOS_JEFE_ESTACION.sql -/=/- 

-/ ELIMINAR_PERSONAL_INTELIGENCIA (id_empleado_acceso IN INTEGER, id_personal_inteligencia IN INTEGER)
-/ CERRAR_HIST_CARGO (id_empleado_acceso in integer, id_personal_inteligencia IN integer)
-/ ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO (id_empleado_acceso in integer, id_personal_inteligencia IN integer, id_estacion in integer, cargo_va IN HIST_CARGO.cargo%TYPE)

-/ ASIGNAR_TEMA_ANALISTA (id_empleado_acceso integer, tema_id integer, analista_id integer)

-/ VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA ( id_empleado_acceso in integer, id_personal_inteligencia in integer)
-/ VALIDAR_ACESSO_EMPLEADO_ESTACION ( id_empleado_acceso in integer, id_estacion in integer)

-/ CREAR_PERSONAL_INTELIGENCIA ( primer_nombre_va IN PERSONAL_INTELIGENCIA.primer_nombre%TYPE, segundo_nombre_va IN PERSONAL_INTELIGENCIA.segundo_nombre%TYPE, primer_apellido_va IN PERSONAL_INTELIGENCIA.primer_apellido%TYPE, segundo_apellido_va IN PERSONAL_INTELIGENCIA.segundo_apellido%TYPE, fecha_nacimiento_va IN PERSONAL_INTELIGENCIA.fecha_nacimiento%TYPE, altura_cm_va IN PERSONAL_INTELIGENCIA.altura_cm%TYPE, peso_kg_va IN PERSONAL_INTELIGENCIA.peso_kg%TYPE, color_ojos_va IN PERSONAL_INTELIGENCIA.color_ojos%TYPE, vision_va IN PERSONAL_INTELIGENCIA.vision%TYPE, class_seguridad_va IN PERSONAL_INTELIGENCIA.class_seguridad%TYPE, fotografia_va IN PERSONAL_INTELIGENCIA.fotografia%TYPE, huella_retina_va IN PERSONAL_INTELIGENCIA.huella_retina%TYPE, huella_digital_va IN PERSONAL_INTELIGENCIA.huella_digital%TYPE, telefono_va IN PERSONAL_INTELIGENCIA.telefono%TYPE, licencia_manejo_va IN PERSONAL_INTELIGENCIA.licencia_manejo%TYPE,idiomas_va IN PERSONAL_INTELIGENCIA.idiomas%TYPE, familiar_1_va IN familiar_ty, familiar_2_va IN familiar_ty, identificacion_1_va IN identificacion_ty, nivel_educativo_1_va IN nivel_educativo_ty, id_ciudad IN PERSONAL_INTELIGENCIA.fk_lugar_ciudad%TYPE )

-/ ACTUALIZAR_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer,id_personal_inteligencia in integer,primer_nombre_va IN PERSONAL_INTELIGENCIA.primer_nombre%TYPE, segundo_nombre_va IN PERSONAL_INTELIGENCIA.segundo_nombre%TYPE, primer_apellido_va IN PERSONAL_INTELIGENCIA.primer_apellido%TYPE, segundo_apellido_va IN PERSONAL_INTELIGENCIA.segundo_apellido%TYPE, fecha_nacimiento_va IN PERSONAL_INTELIGENCIA.fecha_nacimiento%TYPE, altura_cm_va IN PERSONAL_INTELIGENCIA.altura_cm%TYPE, peso_kg_va IN PERSONAL_INTELIGENCIA.peso_kg%TYPE, color_ojos_va IN PERSONAL_INTELIGENCIA.color_ojos%TYPE, vision_va IN PERSONAL_INTELIGENCIA.vision%TYPE, class_seguridad_va IN PERSONAL_INTELIGENCIA.class_seguridad%TYPE, fotografia_va IN PERSONAL_INTELIGENCIA.fotografia%TYPE, huella_retina_va IN PERSONAL_INTELIGENCIA.huella_retina%TYPE, huella_digital_va IN PERSONAL_INTELIGENCIA.huella_digital%TYPE, telefono_va IN PERSONAL_INTELIGENCIA.telefono%TYPE, licencia_manejo_va IN PERSONAL_INTELIGENCIA.licencia_manejo%TYPE,idiomas_va IN PERSONAL_INTELIGENCIA.idiomas%TYPE, familiar_1_va IN familiar_ty, familiar_2_va IN familiar_ty, identificacion_1_va IN identificacion_ty, nivel_educativo_1_va IN nivel_educativo_ty, id_ciudad IN PERSONAL_INTELIGENCIA.fk_lugar_ciudad%TYPE)

-/ ELIMINAR_PERSONAL_INTELIGENCIA (id_empleado_acceso IN INTEGER, id_personal_inteligencia IN INTEGER)
-/ ASIGNAR_TEMA_ANALISTA (id_empleado_acceso integer, tema_id integer, analista_id integer)

-/ CAMBIAR_ROL_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia IN integer, cargo_va IN HIST_CARGO.cargo%TYPE)





-/=/- ARCHIVO PROCEDIMIENTOS_PERSONAL_INTELIGENCIA.sql.sql -/=/- 

-/ VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (id_personal_inteligencia in integer)





-/=/- ARCHIVO PROCEDIMIENTOS_TYPE.sql -/=/- 

-/ CREAR_TELEFONO (codigo numeric(10), numero NUMERIC(15))
-/ CREAR_LICENCIA (numero varchar, pais varchar)
-/ CREAR_FAMILIAR (primer_nombre varchar,segundo_nombre varchar, primer_apellido varchar, segundo_apellido varchar,fecha_nacimiento timestamp, parentesco varchar, codigo numeric, numero numeric)
-/ CREAR_IDENTIFICACION (documento varchar, pais varchar)
-/ CREAR_NIVEL_EDUCATIVO (pregrado_titulo varchar, postgrado_tipo varchar, postgrado_titulo varchar)
-/ CREAR_ARRAY_IDIOMAS (idioma_1 IN varchar(50),idioma_2 IN varchar(50),idioma_3 IN varchar(50),idioma_4 IN varchar(50),idioma_5 IN varchar(50),idioma_6 IN varchar(50))





--- FALTA:

-- PROCEDIMIENTO DE DESPIDO / RENUNCIA
-- REVISAR TRIGGERS DE COPIA ALT
-- IMPORTANTE! AGREGAR VALIDACION DE ACCESO DE PERSONAL INTELIGENCIA Y REVISAR TODOS LOS PROCESOS DEL PUNTO 3 Y 4 DE LA RUBRICA 
-- IMPORTANTE! ASIGNAR PERMISOS DE FUNCIONES CON LOS ROLES. PROBAR CADA ROL Y CADA PROCEDIMIENTO 
-- MANEJO DE OO
