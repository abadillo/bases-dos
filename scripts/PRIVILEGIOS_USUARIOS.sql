
----------///////////- ASIGNACION DE PRIVILEGIOS SOBRE OBJETO A LOS ROLES Y USUARIOS FINALES  -- EJECUTAR COMO DEV -///////////----------



-- MANTENIMIENTO = CREACIÓN, ELIMINACIÓN Y MODIFICACIÓN. 

-- PROCEDIMIENTOS DE MANTENIMIENTO PARA CADA NIVEL DE LA ORGANIZACIÓN.

-- DIRECTOR EJECUTIVO -> MANTENER OFICINAS Y DIRECTORES AREA.
-- DIRECTOR ÁREA -> MANTENER ESTACIONES Y JEFES DE ESTACIONES.
-- JEFE ESTACIÓN -> MANTENER ESTACIÓN Y PERSONAL INTELIGENCIA.


-- PRIVILEGIOS A ROL: DIRECTOR EJECUTIVO
GRANT SELECT ON VISTA_DIRECTORES_AREA TO ROL_DIRECTOR_EJECUTIVO;
GRANT SELECT ON VISTA_OFICINAS TO ROL_DIRECTOR_EJECUTIVO;
GRANT SELECT ON VISTA_CUENTA_AII TO ROL_DIRECTOR_EJECUTIVO;

-- PRIVILEGIOS A ROL: DIRECTOR EJECUTIVO




-- PRIVILEGIOS A USUARIOS: DIRECTORES DE AREA

-- dir_area_2_dublin
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_DUBLIN TO dir_area_2_dublin;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_DUBLIN TO dir_area_2_dublin;

-- dir_area_3_amsterdam
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_AMSTERDAM TO dir_area_3_amsterdam;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_AMSTERDAM TO dir_area_3_amsterdam;

-- dir_area_4_nuuk
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_NUUK TO dir_area_4_nuuk;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_NUUK TO dir_area_4_nuuk;

-- dir_area_5_buenos_aires
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_BUENOS_AIRES TO dir_area_5_buenos_aires;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_BUENOS_AIRES TO dir_area_5_buenos_aires;

-- dir_area_6_taipei
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_TAIPEI TO dir_area_6_taipei;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_TAIPEI TO dir_area_6_taipei;

-- dir_area_7_kuala_lumpur
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_KUALA_LUMPUR TO dir_area_7_kuala_lumpur;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_KUALA_LUMPUR TO dir_area_7_kuala_lumpur;

-- dir_area_8_kampala
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_KAMPALA TO dir_area_8_kampala;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_KAMPALA TO dir_area_8_kampala;

-- dir_area_9_harare
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_HARARE TO dir_area_9_harare;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_HARARE TO dir_area_9_harare;

-- dir_area_10_sidney
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_SIDNEY TO dir_area_10_sidney;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_SIDNEY TO dir_area_10_sidney;

-- dir_area_38_ginebra
GRANT SELECT ON VISTA_ESTACIONES_CON_JEFE_OFICINA_GINEBRA TO dir_area_38_ginebra;
GRANT SELECT ON VISTA_CUENTAS_AII_OFICINA_GINEBRA TO dir_area_38_ginebra;




--GRANT SELECT ON EMPLEADO_JEFE TO ROL_EMPLEADO_JEFE;



----------///////////- 

-- PROBAR CON DISTINTOS USUARIOS.



-- SOLO EL USUARIO admin01 y dev01 PUEDE CREAR TABLAS
--create table empleado_jefe (id integer);
--
---- SOLO EL USUARIO 
--select * from empleado_jefe ;

