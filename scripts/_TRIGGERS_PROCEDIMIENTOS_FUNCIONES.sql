--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\


-//-//-//-//- TRIGGERS -//-//-//-//-


-/=/- ARCHIVO TRIGGERS.sql -/=/- 

--////-- TABLA EMPLEADO_JEFE

-/ TRIGGER_INSERT_EMPLEADO_JEFE BEFORE INSERT FOR EACH ROW TRIGGER_EMPLEADO_JEFE();
-/ TRIGGER_UPDATE_EMPLEADO_JEFE BEFORE UPDATE FOR EACH ROW TRIGGER_EMPLEADO_JEFE();
-/ TRIGGER_DELETE_EMPLEADO_JEFE BEFORE DELETE FOR EACH ROW TRIGGER_EMPLEADO_JEFE();


--////-- TABLA CLIENTE





--//-//-- OFICINA_PRINCIPAL

-/ TRIGGER_INSERT_OFICINA_PRINCIPAL BEFORE INSERT FOR EACH ROW TRIGGER_OFICINA_PRINCIPAL();
-/ TRIGGER_UPDATE_OFICINA_PRINCIPAL BEFORE UPDATE FOR EACH ROW TRIGGER_OFICINA_PRINCIPAL();
-/ TRIGGER_DELETE_OFICINA_PRINCIPAL BEFORE DELETE FOR EACH ROW TRIGGER_OFICINA_PRINCIPAL();

--//-//-- LUGAR
--//-//-- ESTACION
--//-//-- CUENTA
--//-//-- PERSONAL_INTELIGENCIA
--//-//-- INTENTO_NO_AUTORIZADO
--//-//-- CLAS_TEMA
--//-//-- AREA_INTERES
--//-//-- TEMAS_ESP
--//-//-- HIST_CARGO
--//-//-- INFORMANTE
--//-//-- TRANSACCION_PAGO
--//-//-- CRUDO
--//-//-- ANALISTA_CRUDO
--//-//-- PIEZA_INTELIGENCIA
--//-//-- CRUDO_PIEZA
--//-//-- ADQUISICION
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




--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\
--/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\


-//-//-//-//- PROCEDIMIENTOS -//-//-//-//-


-/=/- ARCHIVO PROCEDIMIENTOS_DIRECTOR_EJECUTIVO.sql -/=/- 

-/ CREAR_DIRECTOR_AREA (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)
-/ ELIMINAR_DIRECTOR_AREA (id_director_area IN INTEGER)
-/ ACTUALIZAR_DIRECTOR_AREA (id_director_area IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)

-/ CREAR_OFICINA_PRINCIPAL (nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)
-/ ELIMINAR_OFICINA_PRINCIPAL (id_oficina IN INTEGER)
-/ ACTUALIZAR_OFICINA_PRINCIPAL (id_oficina IN integer, nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)


-/=/- ARCHIVO VALIDACIONES_TRIGGER.sql -/=/- 

-/ VALIDAR_JERARQUIA_EMPLEADO_JEFE (id_empleado_sup IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
-/ VALIDAR_TIPO_EMPLEADO_JEFE(id_empleado IN integer, tipo_va IN EMPLEADO_JEFE.tipo%TYPE)
-/ VALIDAR_TIPO_LUGAR(id_lugar IN integer, tipo_va IN LUGAR.tipo%TYPE)
