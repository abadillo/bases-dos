-- DE DIRECTOR EJECUTIVO

CREATE OR REPLACE VIEW VISTA_DIRECTORES_AREA AS
    SELECT * FROM EMPLEADO_JEFE WHERE tipo = 'director_area';

CREATE OR REPLACE VIEW VISTA_OFICINAS AS
    SELECT * FROM OFICINA_PRINCIPAL;

CREATE OR REPLACE VIEW VISTA_CUENTA_AII AS 
	SELECT * FROM CUENTA;


-- DE DIRECTOR AREA

-- OFICINA Dublin id 1
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_DUBLIN AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 1 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_DUBLIN AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 1 AND c.fk_estacion = e.id;


-- OFICINA Amsterdam id 2
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_AMSTERDAM AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 2 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_AMSTERDAM AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 2 AND c.fk_estacion = e.id;


-- OFICINA Nuuk id 3
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_NUUK AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 3 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_NUUK AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 3 AND c.fk_estacion = e.id;


-- OFICINA Buenos_Aires id 4
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_BUENOS_AIRES AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 4 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_BUENOS_AIRES AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 4 AND c.fk_estacion = e.id;


-- OFICINA Taipei id 5
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_TAIPEI AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 5 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_TAIPEI AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 5 AND c.fk_estacion = e.id;


-- OFICINA Kuala_Lumpur id 6
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_KUALA_LUMPUR AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 6 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_KUALA_LUMPUR AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 6 AND c.fk_estacion = e.id;


-- OFICINA Kampala id 7
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_KAMPALA AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 7 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_KAMPALA AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 7 AND c.fk_estacion = e.id;


-- OFICINA Harare id 8
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_HARARE AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 8 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_HARARE AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 8 AND c.fk_estacion = e.id;


-- OFICINA Sidney id 9
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_SIDNEY AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 9 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_SIDNEY AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 9 AND c.fk_estacion = e.id;


-- OFICINA Ginebra id 10
CREATE OR REPLACE VIEW VISTA_ESTACIONES_CON_JEFE_OFICINA_GINEBRA AS
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, ej.id AS id_jefe_estacion, ej.primer_nombre AS nombre_jefe_estacion, ej.primer_apellido AS apellido_jefe_estacion, ej.telefono AS telefono_jefe_estacion, l.nombre AS ciudad_estacion, ll.nombre AS pais_estacion FROM ESTACION e, EMPLEADO_JEFE ej, LUGAR l, LUGAR ll WHERE e.fk_oficina_principal = 10 AND e.fk_empleado_jefe = ej.id AND e.fk_lugar_ciudad = l.id AND l.fk_lugar = ll.id;

CREATE OR REPLACE VIEW VISTA_CUENTAS_AII_OFICINA_GINEBRA AS 
	SELECT e.id AS id_estacion, e.nombre AS nombre_estacion, c.año AS año_presupuesto, '$' || c.presupuesto AS presupuesto_estacion FROM CUENTA c, ESTACION e WHERE c.fk_oficina_principal = 10 AND c.fk_estacion = e.id;



-- DE JEFE ESTACION 

