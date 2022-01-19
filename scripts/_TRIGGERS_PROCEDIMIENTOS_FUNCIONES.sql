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

-/ CREAR_TELEFONO (codigo numeric(10), numero NUMERIC(15)) RETURNS telefono_ty

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




-/=/- ARCHIVO PROCEDIMIENTOS_JEFE_ESTACION.sql -/=/- 

-/ VER_TODOS_PERSONAL_INTELIGENCIA_SIN_CARGO ()
-/ VER_TODOS_PERSONAL_INTELIGENCIA_CON_CARGO (id_empleado_acceso in integer)
-/ VER_PERSONAL_INTELIGENCIA_SIN_CARGO (id_personal_inteligencia in integer)
-/ VER_PERSONAL_INTELIGENCIA_CON_CARGO (id_empleado_acceso in integer, id_personal_inteligencia in integer)
-/ VER_HISTORICO_CARGO_PERSONAL_INTELIGENCIA (id_empleado_acceso in integer, id_personal_inteligencia in integer)
-/ VER_CUENTA_ESTACION (id_empleado_acceso in integer, id_estacion in INTEGER)
-/ VER_LISTA_INFORMANTES_EMPLEADO_CONFIDENTE (id_empleado_acceso in integer)
-/ VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (id_personal_inteligencia in integer)




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




-/=/- ARCHIVO PROCEDIMIENTOS_DIRECTOR_AREA.sql -/=/-

--REVISAR-/ VALIDAR_ACESSO_DE_DIR_AREA(id_empleado_acceso in integer, id_jefe_estacion in integer)

-/ CREAR_JEFE_ESTACION (id_empleado_acceso in integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
-/ ACTUALIZAR_JEFE_ESTACION (id_empleado_acceso IN integer, id_jefe_estacion IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE)
-/ ELIMINAR_JEFE_ESTACION (id_empleado_acceso IN INTEGER, id_jefe_estacion IN INTEGER)

--REVISAR-/ VALIDAR_ACESSO_DE_DIR_AREA_A_ESTACION(id_empleado_acceso in integer, id_estacion in integer)

-/ CREAR_ESTACION (id_empleado_acceso IN integer, nombre_va IN ESTACION.nombre%TYPE, id_ciudad IN ESTACION.fk_lugar_ciudad%TYPE, id_jefe_estacion IN ESTACION.fk_jefe_estacion%TYPE)
-/ ELIMINAR_ESTACION (id_empleado_acceso IN integer, id_estacion IN INTEGER)
-/ ACTUALIZAR_ESTACION (id_empleado_acceso IN integer, nombre_va IN ESTACION.nombre%TYPE, id_ciudad IN ESTACION.fk_lugar_ciudad%TYPE, id_jefe_estacion IN ESTACION.fk_empleado_jefe%TYPE)


-- MANEJO DE PRESUPUESTO ( CUENTA )

-/  ASIGNACION_PRESUPUESTO (id_empleado_acceso integer, estacion_va integer, presupuesto_va numeric)

-- MANEJO DE CLIENTES 

-/ 

-- MANEJO DE TEMAS 

-- MANEJO DE TEMAS DE CLIENTES 


-- MANEJO DE LUGARES


-/=/- ARCHIVO PROCEDIMIENTOS_JEFE_ESTACION.sql -/=/- 

-/ ELIMINAR_PERSONAL_INTELIGENCIA (id_empleado_acceso IN INTEGER, id_personal_inteligencia IN INTEGER)
-/ CERRAR_HIST_CARGO (id_empleado_acceso in integer, id_personal_inteligencia IN integer)
-/ ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO (id_empleado_acceso in integer, id_personal_inteligencia IN integer, id_estacion in integer, cargo_va IN HIST_CARGO.cargo%TYPE)