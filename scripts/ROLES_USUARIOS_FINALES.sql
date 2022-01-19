----------///////////- CREACION DE ROLES Y USUARIOS FINALES --- EJECUTAR COMO DBA ///////////----------

-- ROLES

CREATE ROLE ROL_DIRECTOR_EJECUTIVO;
CREATE ROLE ROL_DIRECTOR_AREA;
CREATE ROLE ROL_JEFE_ESTACION;
CREATE ROLE ROL_ANALISTA;
CREATE ROLE ROL_AGENTE_CAMPO;



-- USUARIOS DIRECTOR EJECUTIVO
CREATE USER dir_ejec_1_ginebra WITH ENCRYPTED PASSWORD 'dir_ejec_1_ginebra_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 1    -- id oficina = 10


-- USUARIOS DIRECTOR DE AREA

CREATE USER dir_area_2_dublin WITH ENCRYPTED PASSWORD 'dir_area_2_dublin_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 2    -- id oficina = 1
CREATE USER dir_area_3_amsterdam WITH ENCRYPTED PASSWORD 'dir_area_3_amsterdam_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 3    -- id oficina = 2
CREATE USER dir_area_4_nuuk WITH ENCRYPTED PASSWORD 'dir_area_4_nuuk_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 4    -- id oficina = 3
CREATE USER dir_area_5_buenos_aires WITH ENCRYPTED PASSWORD 'dir_area_5_buenos_aires_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 5    -- id oficina = 4
CREATE USER dir_area_6_taipei WITH ENCRYPTED PASSWORD 'dir_area_6_taipei_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 6    -- id oficina = 5
CREATE USER dir_area_7_kuala_lumpur WITH ENCRYPTED PASSWORD 'dir_area_7_kuala_lumpur_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 7    -- id oficina = 6
CREATE USER dir_area_8_kampala WITH ENCRYPTED PASSWORD 'dir_area_8_kampala_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 8    -- id oficina = 7
CREATE USER dir_area_9_harare WITH ENCRYPTED PASSWORD 'dir_area_9_harare_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 9    -- id oficina = 8
CREATE USER dir_area_10_sidney WITH ENCRYPTED PASSWORD 'dir_area_10_sidney_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 10    -- id oficina = 9
CREATE USER dir_area_38_ginebra WITH ENCRYPTED PASSWORD 'dir_area_38_ginebra_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 38    -- id oficina = 10



-- USUARIOS JEFE ESTACION 

CREATE USER jefe_est_11_dublin WITH ENCRYPTED PASSWORD 'jefe_est_11_dublin_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 11    -- id estacion = 1
CREATE USER jefe_est_12_cork WITH ENCRYPTED PASSWORD 'jefe_est_12_cork_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 12    -- id estacion = 2
CREATE USER jefe_est_13_galway WITH ENCRYPTED PASSWORD 'jefe_est_13_galway_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 13    -- id estacion = 3
CREATE USER jefe_est_14_amsterdam WITH ENCRYPTED PASSWORD 'jefe_est_14_amsterdam_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 14    -- id estacion = 4
CREATE USER jefe_est_15_roterdam WITH ENCRYPTED PASSWORD 'jefe_est_15_roterdam_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 15    -- id estacion = 5
CREATE USER jefe_est_16_haarlam WITH ENCRYPTED PASSWORD 'jefe_est_16_haarlam_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 16    -- id estacion = 6
CREATE USER jefe_est_17_nuuk WITH ENCRYPTED PASSWORD 'jefe_est_17_nuuk_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 17    -- id estacion = 7
CREATE USER jefe_est_18_qaqortoq WITH ENCRYPTED PASSWORD 'jefe_est_18_qaqortoq_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 18    -- id estacion = 8
CREATE USER jefe_est_19_sisimiut WITH ENCRYPTED PASSWORD 'jefe_est_19_sisimiut_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 19    -- id estacion = 9
CREATE USER jefe_est_20_buenos_aires WITH ENCRYPTED PASSWORD 'jefe_est_20_buenos_aires_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 20    -- id estacion = 10
CREATE USER jefe_est_21_ciudad_de_cordoba WITH ENCRYPTED PASSWORD 'jefe_est_21_ciudad_de_cordoba_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 21    -- id estacion = 11
CREATE USER jefe_est_22_rosario WITH ENCRYPTED PASSWORD 'jefe_est_22_rosario_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 22    -- id estacion = 12
CREATE USER jefe_est_23_taipei WITH ENCRYPTED PASSWORD 'jefe_est_23_taipei_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 23    -- id estacion = 13
CREATE USER jefe_est_24_tainan WITH ENCRYPTED PASSWORD 'jefe_est_24_tainan_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 24    -- id estacion = 14
CREATE USER jefe_est_25_kaohsiung WITH ENCRYPTED PASSWORD 'jefe_est_25_kaohsiung_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 25    -- id estacion = 15
CREATE USER jefe_est_26_kuala_lumpur WITH ENCRYPTED PASSWORD 'jefe_est_26_kuala_lumpur_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 26    -- id estacion = 16
CREATE USER jefe_est_27_malaca WITH ENCRYPTED PASSWORD 'jefe_est_27_malaca_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 27    -- id estacion = 17
CREATE USER jefe_est_28_pulau_pinang WITH ENCRYPTED PASSWORD 'jefe_est_28_pulau_pinang_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 28    -- id estacion = 18
CREATE USER jefe_est_29_kampala WITH ENCRYPTED PASSWORD 'jefe_est_29_kampala_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 29    -- id estacion = 19
CREATE USER jefe_est_30_entebbe WITH ENCRYPTED PASSWORD 'jefe_est_30_entebbe_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 30    -- id estacion = 20
CREATE USER jefe_est_31_kasese WITH ENCRYPTED PASSWORD 'jefe_est_31_kasese_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 31    -- id estacion = 21
CREATE USER jefe_est_32_harare WITH ENCRYPTED PASSWORD 'jefe_est_32_harare_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 32    -- id estacion = 22
CREATE USER jefe_est_33_bulawayo WITH ENCRYPTED PASSWORD 'jefe_est_33_bulawayo_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 33    -- id estacion = 23
CREATE USER jefe_est_34_chitungwiza WITH ENCRYPTED PASSWORD 'jefe_est_34_chitungwiza_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 34    -- id estacion = 24
CREATE USER jefe_est_35_sidney WITH ENCRYPTED PASSWORD 'jefe_est_35_sidney_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 35    -- id estacion = 25
CREATE USER jefe_est_36_perth WITH ENCRYPTED PASSWORD 'jefe_est_36_perth_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 36    -- id estacion = 26
CREATE USER jefe_est_37_gold_coast WITH ENCRYPTED PASSWORD 'jefe_est_37_gold_coast_aii' CONNECTION LIMIT 5;    -- id empleado_jefe = 37    -- id estacion = 27



-- USUARIOS AGENTE - UN USUARIO POR ESTACION


CREATE USER agente_est_dublin WITH ENCRYPTED PASSWORD 'agente_est_dublin_aii' CONNECTION LIMIT 20;     -- id estacion = 1
CREATE USER agente_est_cork WITH ENCRYPTED PASSWORD 'agente_est_cork_aii' CONNECTION LIMIT 20;     -- id estacion = 2
CREATE USER agente_est_galway WITH ENCRYPTED PASSWORD 'agente_est_galway_aii' CONNECTION LIMIT 20;     -- id estacion = 3
CREATE USER agente_est_amsterdam WITH ENCRYPTED PASSWORD 'agente_est_amsterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 4
CREATE USER agente_est_roterdam WITH ENCRYPTED PASSWORD 'agente_est_roterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 5
CREATE USER agente_est_haarlam WITH ENCRYPTED PASSWORD 'agente_est_haarlam_aii' CONNECTION LIMIT 20;     -- id estacion = 6
CREATE USER agente_est_nuuk WITH ENCRYPTED PASSWORD 'agente_est_nuuk_aii' CONNECTION LIMIT 20;     -- id estacion = 7
CREATE USER agente_est_qaqortoq WITH ENCRYPTED PASSWORD 'agente_est_qaqortoq_aii' CONNECTION LIMIT 20;     -- id estacion = 8
CREATE USER agente_est_sisimiut WITH ENCRYPTED PASSWORD 'agente_est_sisimiut_aii' CONNECTION LIMIT 20;     -- id estacion = 9
CREATE USER agente_est_buenos_aires WITH ENCRYPTED PASSWORD 'agente_est_buenos_aires_aii' CONNECTION LIMIT 20;     -- id estacion = 10
CREATE USER agente_est_ciudad_de_cordoba WITH ENCRYPTED PASSWORD 'agente_est_ciudad_de_cordoba_aii' CONNECTION LIMIT 20;     -- id estacion = 11
CREATE USER agente_est_rosario WITH ENCRYPTED PASSWORD 'agente_est_rosario_aii' CONNECTION LIMIT 20;     -- id estacion = 12
CREATE USER agente_est_taipei WITH ENCRYPTED PASSWORD 'agente_est_taipei_aii' CONNECTION LIMIT 20;     -- id estacion = 13
CREATE USER agente_est_tainan WITH ENCRYPTED PASSWORD 'agente_est_tainan_aii' CONNECTION LIMIT 20;     -- id estacion = 14
CREATE USER agente_est_kaohsiung WITH ENCRYPTED PASSWORD 'agente_est_kaohsiung_aii' CONNECTION LIMIT 20;     -- id estacion = 15
CREATE USER agente_est_kuala_lumpur WITH ENCRYPTED PASSWORD 'agente_est_kuala_lumpur_aii' CONNECTION LIMIT 20;     -- id estacion = 16
CREATE USER agente_est_malaca WITH ENCRYPTED PASSWORD 'agente_est_malaca_aii' CONNECTION LIMIT 20;     -- id estacion = 17
CREATE USER agente_est_pulau_pinang WITH ENCRYPTED PASSWORD 'agente_est_pulau_pinang_aii' CONNECTION LIMIT 20;     -- id estacion = 18
CREATE USER agente_est_kampala WITH ENCRYPTED PASSWORD 'agente_est_kampala_aii' CONNECTION LIMIT 20;     -- id estacion = 19
CREATE USER agente_est_entebbe WITH ENCRYPTED PASSWORD 'agente_est_entebbe_aii' CONNECTION LIMIT 20;     -- id estacion = 20
CREATE USER agente_est_kasese WITH ENCRYPTED PASSWORD 'agente_est_kasese_aii' CONNECTION LIMIT 20;     -- id estacion = 21
CREATE USER agente_est_harare WITH ENCRYPTED PASSWORD 'agente_est_harare_aii' CONNECTION LIMIT 20;     -- id estacion = 22
CREATE USER agente_est_bulawayo WITH ENCRYPTED PASSWORD 'agente_est_bulawayo_aii' CONNECTION LIMIT 20;     -- id estacion = 23
CREATE USER agente_est_chitungwiza WITH ENCRYPTED PASSWORD 'agente_est_chitungwiza_aii' CONNECTION LIMIT 20;     -- id estacion = 24
CREATE USER agente_est_sidney WITH ENCRYPTED PASSWORD 'agente_est_sidney_aii' CONNECTION LIMIT 20;     -- id estacion = 25
CREATE USER agente_est_perth WITH ENCRYPTED PASSWORD 'agente_est_perth_aii' CONNECTION LIMIT 20;     -- id estacion = 26
CREATE USER agente_est_gold_coast WITH ENCRYPTED PASSWORD 'agente_est_gold_coast_aii' CONNECTION LIMIT 20;     -- id estacion = 27



-- USUARIOS ANALISTA - UN USUARIO POR ESTACION

CREATE USER analista_est_dublin WITH ENCRYPTED PASSWORD 'analista_est_dublin_aii' CONNECTION LIMIT 20;     -- id estacion = 1
CREATE USER analista_est_cork WITH ENCRYPTED PASSWORD 'analista_est_cork_aii' CONNECTION LIMIT 20;     -- id estacion = 2
CREATE USER analista_est_galway WITH ENCRYPTED PASSWORD 'analista_est_galway_aii' CONNECTION LIMIT 20;     -- id estacion = 3
CREATE USER analista_est_amsterdam WITH ENCRYPTED PASSWORD 'analista_est_amsterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 4
CREATE USER analista_est_roterdam WITH ENCRYPTED PASSWORD 'analista_est_roterdam_aii' CONNECTION LIMIT 20;     -- id estacion = 5
CREATE USER analista_est_haarlam WITH ENCRYPTED PASSWORD 'analista_est_haarlam_aii' CONNECTION LIMIT 20;     -- id estacion = 6
CREATE USER analista_est_nuuk WITH ENCRYPTED PASSWORD 'analista_est_nuuk_aii' CONNECTION LIMIT 20;     -- id estacion = 7
CREATE USER analista_est_qaqortoq WITH ENCRYPTED PASSWORD 'analista_est_qaqortoq_aii' CONNECTION LIMIT 20;     -- id estacion = 8
CREATE USER analista_est_sisimiut WITH ENCRYPTED PASSWORD 'analista_est_sisimiut_aii' CONNECTION LIMIT 20;     -- id estacion = 9
CREATE USER analista_est_buenos_aires WITH ENCRYPTED PASSWORD 'analista_est_buenos_aires_aii' CONNECTION LIMIT 20;     -- id estacion = 10
CREATE USER analista_est_ciudad_de_cordoba WITH ENCRYPTED PASSWORD 'analista_est_ciudad_de_cordoba_aii' CONNECTION LIMIT 20;     -- id estacion = 11
CREATE USER analista_est_rosario WITH ENCRYPTED PASSWORD 'analista_est_rosario_aii' CONNECTION LIMIT 20;     -- id estacion = 12
CREATE USER analista_est_taipei WITH ENCRYPTED PASSWORD 'analista_est_taipei_aii' CONNECTION LIMIT 20;     -- id estacion = 13
CREATE USER analista_est_tainan WITH ENCRYPTED PASSWORD 'analista_est_tainan_aii' CONNECTION LIMIT 20;     -- id estacion = 14
CREATE USER analista_est_kaohsiung WITH ENCRYPTED PASSWORD 'analista_est_kaohsiung_aii' CONNECTION LIMIT 20;     -- id estacion = 15
CREATE USER analista_est_kuala_lumpur WITH ENCRYPTED PASSWORD 'analista_est_kuala_lumpur_aii' CONNECTION LIMIT 20;     -- id estacion = 16
CREATE USER analista_est_malaca WITH ENCRYPTED PASSWORD 'analista_est_malaca_aii' CONNECTION LIMIT 20;     -- id estacion = 17
CREATE USER analista_est_pulau_pinang WITH ENCRYPTED PASSWORD 'analista_est_pulau_pinang_aii' CONNECTION LIMIT 20;     -- id estacion = 18
CREATE USER analista_est_kampala WITH ENCRYPTED PASSWORD 'analista_est_kampala_aii' CONNECTION LIMIT 20;     -- id estacion = 19
CREATE USER analista_est_entebbe WITH ENCRYPTED PASSWORD 'analista_est_entebbe_aii' CONNECTION LIMIT 20;     -- id estacion = 20
CREATE USER analista_est_kasese WITH ENCRYPTED PASSWORD 'analista_est_kasese_aii' CONNECTION LIMIT 20;     -- id estacion = 21
CREATE USER analista_est_harare WITH ENCRYPTED PASSWORD 'analista_est_harare_aii' CONNECTION LIMIT 20;     -- id estacion = 22
CREATE USER analista_est_bulawayo WITH ENCRYPTED PASSWORD 'analista_est_bulawayo_aii' CONNECTION LIMIT 20;     -- id estacion = 23
CREATE USER analista_est_chitungwiza WITH ENCRYPTED PASSWORD 'analista_est_chitungwiza_aii' CONNECTION LIMIT 20;     -- id estacion = 24
CREATE USER analista_est_sidney WITH ENCRYPTED PASSWORD 'analista_est_sidney_aii' CONNECTION LIMIT 20;     -- id estacion = 25
CREATE USER analista_est_perth WITH ENCRYPTED PASSWORD 'analista_est_perth_aii' CONNECTION LIMIT 20;     -- id estacion = 26
CREATE USER analista_est_gold_coast WITH ENCRYPTED PASSWORD 'analista_est_gold_coast_aii' CONNECTION LIMIT 20;     -- id estacion = 27















----------///////////- ASIGNACION DE ROLES A USUARIOS USUARIOS FINALES --- EJECUTAR COMO DBA ///////////----------

GRANT ROL_DIRECTOR_EJECUTIVO TO dir_ejec_1_ginebra;

GRANT ROL_DIRECTOR_AREA TO
    dir_area_2_dublin,
    dir_area_3_amsterdam,
    dir_area_4_nuuk,
    dir_area_5_buenos_aires,
    dir_area_6_taipei,
    dir_area_7_kuala_lumpur,
    dir_area_8_kampala,
    dir_area_9_harare,
    dir_area_10_sidney,
    dir_area_38_ginebra
;

GRANT ROL_JEFE_ESTACION TO 
    jefe_est_11_dublin,
    jefe_est_12_cork,
    jefe_est_14_amsterdam,
    jefe_est_15_roterdam,
    jefe_est_16_haarlam,
    jefe_est_17_nuuk,
    jefe_est_18_qaqortoq,
    jefe_est_19_sisimiut,
    jefe_est_20_buenos_aires,
    jefe_est_21_ciudad_de_cordoba,
    jefe_est_22_rosario,
    jefe_est_23_taipei,
    jefe_est_24_tainan,
    jefe_est_25_kaohsiung,
    jefe_est_26_kuala_lumpur,
    jefe_est_27_malaca,
    jefe_est_28_pulau_pinang,
    jefe_est_29_kampala,
    jefe_est_30_entebbe,
    jefe_est_31_kasese,
    jefe_est_32_harare,
    jefe_est_33_bulawayo,
    jefe_est_34_chitungwiza,
    jefe_est_35_sidney,
    jefe_est_36_perth,
    jefe_est_37_gold_coast
;


GRANT ROL_AGENTE_CAMPO TO 

    agente_est_dublin,
    agente_est_cork,
    agente_est_galway,
    agente_est_amsterdam,
    agente_est_roterdam,
    agente_est_haarlam,
    agente_est_nuuk,
    agente_est_qaqortoq,
    agente_est_sisimiut,
    agente_est_buenos_aires,
    agente_est_ciudad_de_cordoba,
    agente_est_rosario,
    agente_est_taipei,
    agente_est_tainan,
    agente_est_kaohsiung,
    agente_est_kuala_lumpur,
    agente_est_malaca,
    agente_est_pulau_pinang,
    agente_est_kampala,
    agente_est_entebbe,
    agente_est_kasese,
    agente_est_harare,
    agente_est_bulawayo,
    agente_est_chitungwiza,
    agente_est_sidney,
    agente_est_perth,
    agente_est_gold_coast
;


GRANT ROL_ANALISTA TO 

    analista_est_dublin,
    analista_est_cork,
    analista_est_galway,
    analista_est_amsterdam,
    analista_est_roterdam,
    analista_est_haarlam,
    analista_est_nuuk,
    analista_est_qaqortoq,
    analista_est_sisimiut,
    analista_est_buenos_aires,
    analista_est_ciudad_de_cordoba,
    analista_est_rosario,
    analista_est_taipei,
    analista_est_tainan,
    analista_est_kaohsiung,
    analista_est_kuala_lumpur,
    analista_est_malaca,
    analista_est_pulau_pinang,
    analista_est_kampala,
    analista_est_entebbe,
    analista_est_kasese,
    analista_est_harare,
    analista_est_bulawayo,
    analista_est_chitungwiza,
    analista_est_sidney,
    analista_est_perth,
    analista_est_gold_coast
;









----------///////////- ASIGNACION DE PRIVILEGIOS SOBRE OBJETO A LOS ROLES Y USUARIOS FINALES  -- EJECUTAR COMO DEV -///////////----------




GRANT USAGE ON SCHEMA public TO ROL_DIRECTOR_EJECUTIVO, ROL_DIRECTOR_AREA, ROL_JEFE_ESTACION, ROL_AGENTE_CAMPO,ROL_ANALISTA;


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





-----------------------------////////--------///////---------\\\\\\\\---------\\\\\\\\\-----------------------------

------------------------------ ///////// DIRECTOR AREA ///////- ------------------





-- 2. Demostración de la implementación de los requerimientos del
-- sistema de bases de datos transaccional referidos al proceso de
-- mantenimiento de empleados y estructura organizacional de la AII,
-- incluyendo la seguridad correspondiente (roles, cuentas con
-- privilegios para poder ejecutar los programas y reportes).


-- ROL_DIRECTOR_EJECUTIVO

GRANT SELECT ON TABLE EMPLEADO_JEFE TO ROL_DIRECTOR_EJECUTIVO;


GRANT EXECUTE ON FUNCTION VER_DIRECTOR_AREA(integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_DIRECTORES_AREA () TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_LUGAR (integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_LUGARES () TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_OFICINA (integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_OFICINAS () TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_DIRECTOR_EJECUTIVO (integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON FUNCTION VER_DIRECTORES_EJECUTIVOS () TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CREAR_DIRECTOR_AREA (varchar, varchar, varchar, varchar, telefono_ty, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ELIMINAR_DIRECTOR_AREA (INTEGER) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_DIRECTOR_AREA (integer, varchar, varchar, varchar, varchar, telefono_ty, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CREAR_OFICINA_PRINCIPAL (varchar, boolean, int, int, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ELIMINAR_OFICINA_PRINCIPAL (INTEGER) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_OFICINA_PRINCIPAL (integer, varchar, boolean, int, int, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CREAR_DIRECTOR_EJECUTIVO (varchar, varchar, varchar, varchar, telefono_ty) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ELIMINAR_DIRECTOR_EJECUTIVO (INTEGER) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_DIRECTOR_EJECUTIVO (integer, varchar, varchar, varchar, varchar, telefono_ty) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CAMBIAR_ROL_EMPLEADO (integer, integer, integer) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE CREAR_LUGAR (varchar, varchar, varchar, int) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ELIMINAR_LUGAR (INTEGER) TO ROL_DIRECTOR_EJECUTIVO;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_LUGAR (integer, varchar, varchar, varchar, int) TO ROL_DIRECTOR_EJECUTIVO;




-- ROL_DIRECTOR_AREA

GRANT EXECUTE ON FUNCTION VER_JEFE_E(INTEGER,INTEGER) TO ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_JEFES_E(INTEGER) TO ROL_DIRECTOR_AREA;

GRANT EXECUTE ON FUNCTION VER_JEFE_E (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_JEFES_E (INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_ESTACIONES (INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_PRESUPUESTO_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_CLIENTE (INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON FUNCTION VER_CLIENTES () TO  ROL_DIRECTOR_AREA;

GRANT EXECUTE ON PROCEDURE VALIDAR_ACESSO_DIR_AREA_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE VALIDAR_ACESSO_DIR_AREA_JEFE_ESTACION(INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;

GRANT EXECUTE ON PROCEDURE CREAR_JEFE_ESTACION (INTEGER, VARCHAR, VARCHAR, VARCHAR, VARCHAR, telefono_ty) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_JEFE_ESTACION ( INTEGER, INTEGER, VARCHAR, VARCHAR, VARCHAR, VARCHAR, telefono_ty) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ELIMINAR_JEFE_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;

GRANT EXECUTE ON PROCEDURE CREAR_ESTACION (INTEGER, VARCHAR, INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ELIMINAR_ESTACION (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_ESTACION (INTEGER, VARCHAR, INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;

GRANT EXECUTE ON PROCEDURE ASIGNACION_PRESUPUESTO (INTEGER, INTEGER, NUMERIC) TO  ROL_DIRECTOR_AREA;

GRANT EXECUTE ON PROCEDURE CREAR_CLIENTE (VARCHAR, VARCHAR, BOOLEAN, telefono_ty, contacto_ty, INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ELIMINAR_CLIENTE (INTEGER) TO  ROL_DIRECTOR_AREA;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_CLIENTE (INTEGER, VARCHAR, VARCHAR, BOOLEAN, telefono_ty, contacto_ty, INTEGER) TO  ROL_DIRECTOR_AREA;

GRANT EXECUTE ON PROCEDURE ASIGNAR_TEMA_CLIENTE (INTEGER, INTEGER) TO  ROL_DIRECTOR_AREA;



-- ROL EMPLEADO_JEFE

GRANT EXECUTE ON PROCEDURE ELIMINAR_PERSONAL_INTELIGENCIA (INTEGER, INTEGER) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE CERRAR_HIST_CARGO (integer, integer) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE ASIGNAR_TRANSFERIR_ESTACION_EMPLEADO (integer, integer, integer, varchar) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE ASIGNAR_TEMA_ANALISTA (integer, integer, integer) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE VALIDAR_ACESSO_EMPLEADO_PERSONAL_INTELIGENCIA ( integer, integer) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE VALIDAR_ACESSO_EMPLEADO_ESTACION (integer, integer) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE CREAR_PERSONAL_INTELIGENCIA (varchar, varchar, varchar, varchar, date, numeric(5), numeric(5), varchar, varchar, varchar, bytea, bytea, bytea, telefono_ty, licencia_ty,varchar(50)[], familiar_ty, familiar_ty, identificacion_ty, nivel_educativo_ty, int) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE ACTUALIZAR_PERSONAL_INTELIGENCIA (integer, integer, varchar, varchar, varchar, varchar, date, numeric(5), numeric(5), varchar, varchar, varchar, bytea, bytea, bytea, telefono_ty, licencia_ty,varchar(50)[], familiar_ty, familiar_ty, identificacion_ty, nivel_educativo_ty, int) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE ELIMINAR_PERSONAL_INTELIGENCIA (INTEGER, INTEGER) TO ROL_JEFE_ESTACION;
GRANT EXECUTE ON PROCEDURE CAMBIAR_ROL_PERSONAL_INTELIGENCIA (integer, integer, varchar) TO ROL_JEFE_ESTACION;


-- 3. Demostración de la implementación de los requerimientos del
-- sistema de bases de datos transaccional referidos al proceso de
-- venta de piezas – actividades de recolección y verificación de
-- hechos crudos y manejo de informantes, incluyendo la seguridad
-- correspondiente (roles, cuentas con privilegios para poder ejecutar
-- los programas y reportes).



-- ROL_ANALISTA Y ROL_AGENTE

GRANT EXECUTE ON FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (integer) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (integer) TO ROL_AGENTE_CAMPO;

GRANT EXECUTE ON PROCEDURE REGISTRO_INFORMANTE (varchar, integer, integer,integer) TO ROL_AGENTE_CAMPO;
GRANT EXECUTE ON PROCEDURE REGISTRO_CRUDO_SIN_INFORMANTE ( integer, integer, bytea, varchar,  varchar, varchar, numeric, numeric, numeric) TO ROL_AGENTE_CAMPO;
GRANT EXECUTE ON PROCEDURE REGISTRO_CRUDO_CON_INFORMANTE ( integer, numeric , integer, integer, bytea, varchar,  varchar, numeric, numeric, numeric ) TO ROL_AGENTE_CAMPO;

GRANT EXECUTE ON FUNCTION ANALISTA_VERIFICO_CRUDO ( integer, integer )  TO  ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION ANALISTA_PUEDE_VERIFICA_CRUDO ( integer, integer )  TO  ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE VERIFICAR_CRUDO ( integer, integer, numeric) TO  ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE CERRAR_CRUDO ( integer ) TO  ROL_ANALISTA;






-- 4. Demostración de la implementación de los requerimientos del
-- sistema de bases de datos transaccional referidos al proceso de
-- venta de piezas de inteligencia – construcción de piezas de
-- inteligencia y venta a clientes, incluyendo la seguridad
-- correspondiente (roles, cuentas con privilegios para poder ejecutar
-- los programas y reportes).




GRANT EXECUTE ON PROCEDURE REGISTRO_VERIFICACION_PIEZA_INTELIGENCIA (integer, varchar, integer) TO ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION VER_DATOS_PIEZA (integer, integer) TO ROL_AGENTE_CAMPO, ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE AGREGAR_CRUDO_A_PIEZA ( integer, integer ) TO ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE REGISTRO_VENTA (integer, integer, numeric) TO ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE CERTIFICAR_PIEZA (integer, numeric) TO ROL_ANALISTA;
GRANT EXECUTE ON PROCEDURE ELIMINACION_REGISTROS_VENTA_EXCLUSIVA ( integer )  TO ROL_ANALISTA;
GRANT EXECUTE ON FUNCTION VALIDAR_VENTA_EXCLUSIVA ( integer )  TO ROL_ANALISTA;