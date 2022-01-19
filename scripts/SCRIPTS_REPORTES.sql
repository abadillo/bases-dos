
------------------------------- FONDOS DE ALL Y APORTE DE ESTACION ------------------------------------------
--LISTO
/*  El Director Ejecutivo debe poder consultar en cualquier momento de cuantos fondos dispone la All.
    Asi como cada Jefe de Estacion debe poder saber a tiempo las ganancias netas anuales de cada estacion.
*/


DROP TYPE IF EXISTS REPORTE_BALANCE CASCADE;

CREATE TYPE REPORTE_BALANCE as (pago_informantes int, pago_informantes_alt int, total_informantes int,
                                piezas_vendidas int, piezas_vendidas_exclusivas int, total_piezas int,
                                presupuesto_estaciones int, total_balance int
                                );


DROP FUNCTION IF EXISTS SUMAR_PAGO_INFORMANTES CASCADE;
DROP FUNCTION IF EXISTS SUMAR_PAGO_INFORMANTES_ALT CASCADE;

DROP FUNCTION IF EXISTS SUMAR_PIEZAS CASCADE;
DROP FUNCTION IF EXISTS SUMAR_PIEZAS_ALT CASCADE;

DROP FUNCTION IF EXISTS SUMAR_PRESUPUESTO CASCADE;

DROP FUNCTION IF EXISTS FONDOS_ALL_Y_APORTE_ESTACION CASCADE;


CREATE OR REPLACE FUNCTION SUMAR_PAGO_INFORMANTES (estacion int) --CHECK
RETURNS int 
    AS $$
	DECLARE
	resultado int;
    BEGIN
    IF (estacion>0) THEN
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO t
        WHERE t.fk_informante IN (SELECT i.id FROM INFORMANTE i WHERE i.fk_estacion_encargado = estacion)
        AND t.fecha_hora BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO t)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION SUMAR_PAGO_INFORMANTES_ALT (estacion int) --CHECK
RETURNS int 
    AS $$
	DECLARE
	resultado int;
    BEGIN
    IF (estacion>0) THEN
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO_ALT t
        WHERE t.fk_informante IN (SELECT i.id FROM INFORMANTE i WHERE i.fk_estacion_encargado = estacion)
        AND t.fecha_hora BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO_ALT t)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION SUMAR_PIEZAS (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION a
        WHERE a.fk_pieza_inteligencia IN 
            (SELECT cp.fk_pieza_inteligencia FROM CRUDO_PIEZA cp WHERE cp.fk_pieza_inteligencia IN 
                (SELECT p.id FROM PIEZA_INTELIGENCIA p WHERE p.fk_personal_inteligencia_analista IN
                    (SELECT pa.id FROM PERSONAL_INTELIGENCIA pa WHERE pa.fk_lugar_ciudad IN 
                        (SELECT e.fk_lugar_ciudad FROM ESTACION e WHERE e.id = estacion)
                    )
                )
            )
        AND a.fecha_hora_venta BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION a)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION SUMAR_PIEZAS_ALT (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION_ALT a
        WHERE a.fk_pieza_inteligencia IN 
            (SELECT cp.fk_pieza_inteligencia FROM CRUDO_PIEZA cp WHERE cp.fk_pieza_inteligencia IN 
                (SELECT p.id FROM PIEZA_INTELIGENCIA p WHERE p.fk_personal_inteligencia_analista IN
                    (SELECT pa.id FROM PERSONAL_INTELIGENCIA pa WHERE pa.fk_lugar_ciudad IN 
                        (SELECT e.fk_lugar_ciudad FROM ESTACION e WHERE e.id = estacion)
                    )
                )
            )
        AND a.fecha_hora_venta BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION_ALT a)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION SUMAR_PRESUPUESTO (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT c.presupuesto as presupuesto_estacion FROM CUENTA c
        WHERE c.fk_estacion = estacion 
        AND c.año BETWEEN RESTA_1_YEAR_DATE(NOW()::date) AND NOW()::date
        LIMIT 1)::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(c.presupuesto),0) FROM CUENTA c)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;

-- - - - - - - --

-- Estacion 0 hace referencia a toda All (Fondos totales de ALL)
CREATE OR REPLACE FUNCTION FONDOS_ALL_Y_APORTE_ESTACION (estacion int)
RETURNS REPORTE_BALANCE
    AS $$
    DECLARE resultado REPORTE_BALANCE;
	BEGIN
	resultado.pago_informantes = SUMAR_PAGO_INFORMANTES(estacion);
	resultado.pago_informantes_alt = SUMAR_PAGO_INFORMANTES_ALT(estacion);
	resultado.total_informantes = resultado.pago_informantes + resultado.pago_informantes_alt;
	
    
    resultado.piezas_vendidas = SUMAR_PIEZAS(estacion);
	resultado.piezas_vendidas_exclusivas = SUMAR_PIEZAS_ALT(estacion);
	resultado.total_piezas = resultado.piezas_vendidas + resultado.piezas_vendidas_exclusivas;

    resultado.presupuesto_estaciones = SUMAR_PRESUPUESTO(estacion);

    resultado.total_balance = resultado.total_piezas + resultado.presupuesto_estaciones - resultado.total_informantes;
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql;


-- LLAMADA:     SELECT * FROM FONDOS_ALL_Y_APORTE_ESTACION(0);




-------------------------------------- BALANCE GENERAL --------------------------------------------

/*  Los jefes de las estaciones y los directores correspondientes monitorean el uso de este presupuesto a traves de
    revisiones trimestrales y al final del año.
    Cada estacion debe generar un informe con su balance:
        Pago otorgado (Presupuesto). -- BG
        Fecha. -- RBG (Trimestral y otro reporte anual)
        --------------- REPORTE PARTE 2 -------------------
        Hecho crudo recolectado. 
        Pieza de Inteligencia que lo utiliza (si aplica).
        Valor de la pieza.
        ---------------------------------------------------
        Ganancia o perdida alcanzada (TOTAL) --
    Y los totales generales:
        Total pagado. (A INFORMANTES) --
        Total obtenido por ventas de las piezas de inteligencia logradas por estos hechos aportados por informantes. --
*/



DROP TYPE IF EXISTS REPORTE_BALANCE_GENERAL CASCADE;

CREATE TYPE REPORTE_BALANCE_GENERAL as 
    (fecha_inicio date, fecha_fin date, pago_informantes int, pago_informantes_alt int, 
    total_informantes int, piezas_vendidas int, piezas_vendidas_exclusivas int, total_piezas int, 
    presupuesto_estaciones int, total_balance int
    );


DROP FUNCTION IF EXISTS SUMAR_PAGO_INFORMANTES_TRIMESTRAL CASCADE;
DROP FUNCTION IF EXISTS SUMAR_PAGO_INFORMANTES_ALT_TRIMESTRAL CASCADE;

DROP FUNCTION IF EXISTS SUMAR_PIEZAS_TRIMESTRAL CASCADE;
DROP FUNCTION IF EXISTS SUMAR_PIEZAS_ALT_TRIMESTRAL CASCADE;

DROP FUNCTION IF EXISTS SUMAR_PRESUPUESTO_TRIMESTRAL CASCADE;

DROP FUNCTION IF EXISTS FONDOS_ALL_Y_APORTE_ESTACION_TRIMESTRAL CASCADE;


CREATE OR REPLACE FUNCTION SUMAR_PAGO_INFORMANTES_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
	DECLARE
	resultado int;
    BEGIN
    IF (estacion>0) THEN
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO t
        WHERE t.fk_informante IN (SELECT i.id FROM INFORMANTE i WHERE i.fk_estacion_encargado = estacion)
        AND t.fecha_hora BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO t)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION SUMAR_PAGO_INFORMANTES_ALT_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
	DECLARE
	resultado int;
    BEGIN
    IF (estacion>0) THEN
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO_ALT t
        WHERE t.fk_informante IN (SELECT i.id FROM INFORMANTE i WHERE i.fk_estacion_encargado = estacion)
        AND t.fecha_hora BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(t.monto_pago),0) as pago_informantes FROM TRANSACCION_PAGO_ALT t)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION SUMAR_PIEZAS_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION a
        WHERE a.fk_pieza_inteligencia IN 
            (SELECT cp.fk_pieza_inteligencia FROM CRUDO_PIEZA cp WHERE cp.fk_pieza_inteligencia IN 
                (SELECT p.id FROM PIEZA_INTELIGENCIA p WHERE p.fk_personal_inteligencia_analista IN
                    (SELECT pa.id FROM PERSONAL_INTELIGENCIA pa WHERE pa.fk_lugar_ciudad IN 
                        (SELECT e.fk_lugar_ciudad FROM ESTACION e WHERE e.id = estacion)
                    )
                )
            )
        AND a.fecha_hora_venta BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION a)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION SUMAR_PIEZAS_ALT_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION_ALT a
        WHERE a.fk_pieza_inteligencia IN 
            (SELECT cp.fk_pieza_inteligencia FROM CRUDO_PIEZA cp WHERE cp.fk_pieza_inteligencia IN 
                (SELECT p.id FROM PIEZA_INTELIGENCIA p WHERE p.fk_personal_inteligencia_analista IN
                    (SELECT pa.id FROM PERSONAL_INTELIGENCIA pa WHERE pa.fk_lugar_ciudad IN 
                        (SELECT e.fk_lugar_ciudad FROM ESTACION e WHERE e.id = estacion)
                    )
                )
            )
        AND a.fecha_hora_venta BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp
        )::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(a.precio_vendido),0) as precio_venta_pieza FROM ADQUISICION_ALT a)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION SUMAR_PRESUPUESTO_TRIMESTRAL (estacion int) --CHECK
RETURNS int 
    AS $$
    DECLARE
	resultado int;
    BEGIN
    IF (estacion > 0) THEN
        resultado = (SELECT c.presupuesto as presupuesto_estacion FROM CUENTA c
        WHERE c.fk_estacion = estacion 
        AND c.año BETWEEN RESTA_3_MESES_DATE(NOW()::date) AND NOW()::date 
        LIMIT 1)::int;
    ELSE 
        resultado = (SELECT COALESCE(SUM(c.presupuesto),0) FROM CUENTA c)::int;
    END IF;
	RETURN resultado;
    END
$$ LANGUAGE plpgsql;




DROP FUNCTION IF EXISTS BALANCE_GENERAL_TRIMESTRAL CASCADE;

CREATE OR REPLACE FUNCTION BALANCE_GENERAL_TRIMESTRAL (estacion int)
RETURNS REPORTE_BALANCE_GENERAL
    AS $$
    DECLARE    resultado REPORTE_BALANCE_GENERAL;
	BEGIN
    resultado.presupuesto_estaciones = SUMAR_PRESUPUESTO_TRIMESTRAL(estacion);
    resultado.fecha_inicio = (RESTA_3_MESES_DATE(NOW()::date))::date;
    resultado.fecha_fin = NOW()::date;
    resultado.pago_informantes = SUMAR_PAGO_INFORMANTES_TRIMESTRAL(estacion);
    resultado.pago_informantes_alt = SUMAR_PAGO_INFORMANTES_ALT_TRIMESTRAL(estacion); 
    resultado.total_informantes = resultado.pago_informantes_alt + resultado.pago_informantes;
    resultado.piezas_vendidas = SUMAR_PIEZAS_TRIMESTRAL(estacion);
    resultado.piezas_vendidas_exclusivas = SUMAR_PIEZAS_ALT_TRIMESTRAL(estacion);
    resultado.total_piezas = resultado.piezas_vendidas + resultado.piezas_vendidas_exclusivas;
    resultado.total_balance = resultado.total_piezas + resultado.presupuesto_estaciones 
                                - resultado.total_informantes;
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql;



DROP FUNCTION IF EXISTS BALANCE_GENERAL_TRIMESTRAL_PARTE2 CASCADE;

CREATE OR REPLACE FUNCTION BALANCE_GENERAL_TRIMESTRAL_PARTE2 (estacion int)
RETURNS TABLE (id_crudo int, id_pieza int, costo_pieza int)
    AS $$
    SELECT cp.fk_crudo, cp.fk_pieza_inteligencia, p.precio_base FROM CRUDO_PIEZA cp, PIEZA_INTELIGENCIA p
    WHERE cp.fk_pieza_inteligencia = p.id AND cp.fk_crudo IN 
        (SELECT c.id FROM CRUDO c WHERE c.fk_estacion_pertenece = estacion 
            AND c.id IN (SELECT t.fk_crudo FROM TRANSACCION_PAGO t 
                WHERE t.fecha_hora BETWEEN RESTA_3_MESES(NOW()::timestamp) AND NOW()::timestamp))  
$$ LANGUAGE SQL;

----------------

DROP FUNCTION IF EXISTS BALANCE_GENERAL_ANUAL CASCADE;

CREATE OR REPLACE FUNCTION BALANCE_GENERAL_ANUAL (estacion int)
RETURNS REPORTE_BALANCE_GENERAL
    AS $$
     DECLARE    resultado REPORTE_BALANCE_GENERAL;
	BEGIN
    resultado.presupuesto_estaciones = SUMAR_PRESUPUESTO(estacion);
    resultado.fecha_inicio = (RESTA_1_YEAR_DATE(NOW()::date))::date;
    resultado.fecha_fin = NOW()::date;
    resultado.pago_informantes = SUMAR_PAGO_INFORMANTES(estacion);
    resultado.pago_informantes_alt = SUMAR_PAGO_INFORMANTES_ALT(estacion); 
    resultado.total_informantes = resultado.pago_informantes_alt + resultado.pago_informantes;
    resultado.piezas_vendidas = SUMAR_PIEZAS(estacion);
    resultado.piezas_vendidas_exclusivas = SUMAR_PIEZAS_ALT(estacion);
    resultado.total_piezas = resultado.piezas_vendidas + resultado.piezas_vendidas_exclusivas;
    resultado.total_balance = resultado.total_piezas + resultado.presupuesto_estaciones 
                                - resultado.total_informantes;
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql;



DROP FUNCTION IF EXISTS BALANCE_GENERAL_ANUAL_PARTE2 CASCADE;

CREATE OR REPLACE FUNCTION BALANCE_GENERAL_ANUAL_PARTE2 (estacion int)
RETURNS TABLE (id_crudo int, id_pieza int, costo_pieza int)
    AS $$
    SELECT cp.fk_crudo, cp.fk_pieza_inteligencia, p.precio_base FROM CRUDO_PIEZA cp, PIEZA_INTELIGENCIA p
    WHERE cp.fk_pieza_inteligencia = p.id AND cp.fk_crudo IN 
        (SELECT c.id FROM CRUDO c WHERE c.fk_estacion_pertenece = estacion 
            AND c.id IN (SELECT t.fk_crudo FROM TRANSACCION_PAGO t 
                WHERE t.fecha_hora BETWEEN RESTA_1_YEAR(NOW()::timestamp) AND NOW()::timestamp))  
$$ LANGUAGE SQL;



----------------------------------- INFORMACION DE SUS INFORMANTES -------------------------------------
-- LISTO
/*  Se debe llevar un control sobre la eficacia de estos tratos.
    Saber el % de su eficacia, en proporcion de los hechos crudos aportados por tal informante y se han convertido
    en piezas de inteligencia.
    Esta medida se genera semestralmente y se usa en combinacion con la productividad de los agentes.
*/

-- 

DROP TYPE IF EXISTS INFORMACION_INFORMANTE CASCADE;

CREATE TYPE INFORMACION_INFORMANTE as 
    (   nombre_clave varchar(50), agente_encargado int, id_estacion int, nombre_estacion varchar(50), 
        crudos int, piezas int, crudos_alt int, piezas_alt int, 
        total_crudos int, total_piezas int, crudos_usados int, eficacia numeric(20,4)
                                );


DROP FUNCTION IF EXISTS INFORMACION_INFORMANTES CASCADE;

CREATE OR REPLACE FUNCTION INFORMACION_INFORMANTES (informante int)
RETURNS INFORMACION_INFORMANTE
    AS $$
    DECLARE resultado INFORMACION_INFORMANTE;
	BEGIN
	resultado.nombre_clave = (SELECT i.nombre_clave FROM INFORMANTE i WHERE i.id = informante LIMIT 1)::varchar(50);
    resultado.agente_encargado = (SELECT i.fk_personal_inteligencia_encargado FROM INFORMANTE i 
                                    WHERE i.id = informante LIMIT 1):: int;
    resultado.id_estacion = (SELECT i.fk_estacion_encargado FROM INFORMANTE i WHERE i.id = informante LIMIT 1)::int;
    resultado.nombre_estacion = (SELECT e.nombre FROM ESTACION e 
                                    WHERE e.id = resultado.id_estacion LIMIT 1)::varchar(50);

    resultado.crudos = (SELECT COUNT(c.id) FROM CRUDO c WHERE c.fk_informante = informante
                            AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                        )::int;
    resultado.piezas = (SELECT COUNT(cp.fk_pieza_inteligencia) FROM CRUDO_PIEZA cp 
                                WHERE cp.fk_crudo IN (SELECT c.id FROM CRUDO c WHERE c.fk_informante = informante
                                    AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                                    )
                            )::int;

    resultado.crudos_alt = (SELECT COUNT(c.id) FROM CRUDO_ALT c WHERE c.fk_informante = informante
                            AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                            )::int;
    resultado.piezas_alt = (SELECT COUNT(cp.fk_pieza_inteligencia) FROM CRUDO_PIEZA_ALT cp 
                                WHERE cp.fk_crudo IN (SELECT c.id FROM CRUDO_ALT c
                                                        WHERE c.fk_informante = informante
                                                        AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                                                        )
                            )::int;


    resultado.crudos_usados = ((SELECT COUNT(c.id) FROM CRUDO c WHERE c.fk_informante = informante AND c.id IN 
                                (SELECT cp.fk_crudo FROM CRUDO_PIEZA cp WHERE cp.fk_crudo = c.id)
                                AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                                )::int)
                            + ((SELECT COUNT(c.id) FROM CRUDO c WHERE c.fk_informante = informante AND c.id IN 
                                (SELECT cp.fk_crudo FROM CRUDO_PIEZA_ALT cp WHERE cp.fk_crudo = c.id)
                                AND c.id NOT IN (SELECT cp.fk_crudo FROM CRUDO_PIEZA cp WHERE cp.fk_crudo = c.id)
                                AND c.fecha_obtencion BETWEEN RESTA_6_MESES(NOW()::timestamp) AND NOW()::timestamp
                                )::int);


    resultado.total_crudos = resultado.crudos + resultado.crudos_alt;
    resultado.total_piezas = resultado.piezas + resultado.piezas_alt;
    IF resultado.total_crudos > 0 THEN
    resultado.eficacia = ((resultado.crudos_usados * 100) / resultado.total_crudos):: NUMERIC(20,4);
    ELSE
        resultado.eficacia = 0;
    END IF;
    RETURN resultado; 
	END
$$ LANGUAGE plpgsql;

-- SELECT * FROM INFORMACION_INFORMANTES (1);



------------------------------- INTENTOS NO AUTORIZADOS ------------------------------------
--LISTO
/*  Cuando algun empleado trate de acceder a una pieza de inteligencia se debe quedar registrado y emitir una alerta
    al jefe de la estacion.
    Cada semana se debe emitir el reporte para el jefe de su estacion.
*/

DROP FUNCTION IF EXISTS INTENTOS_NO_AUTORIZADOS CASCADE;

CREATE OR REPLACE FUNCTION INTENTOS_NO_AUTORIZADOS (estacion int)
RETURNS TABLE(  primer_nombre varchar(50), segundo_nombre2 varchar(50), primer_apellido varchar(50), 
                segundo_apellido varchar(50), id_Empleado integer, id_Pieza integer, 
                clasificacion_Pieza varchar(50), fecha TIMESTAMP) 
    AS $$
        SELECT p.primer_nombre, p.segundo_nombre, p.primer_apellido, p.segundo_apellido, p.id,
                    pz.id, pz.class_seguridad, i.fecha_hora
            FROM PERSONAL_INTELIGENCIA p, INTENTO_NO_AUTORIZADO i, PIEZA_INTELIGENCIA pz 
            WHERE p.id = i.fk_personal_inteligencia AND pz.id = i.id_pieza AND p.id IN 
                (SELECT DISTINCT hc.fk_personal_inteligencia from HIST_CARGO hc, ESTACION e WHERE 
                    e.id=3 AND e.id = hc.fk_estacion)
$$ LANGUAGE SQL;


-- PARAMETRO:  id de la estacion.
-- LLAMADA:     SELECT * FROM INTENTOS_NO_AUTORIZADOS(3);



--------------------------------------- LISTA DE INFORMANTES ----------------------------------------
-- LISTO
/*  Es importante que otro empleado de All pueda acceder a la lista de informantes de un agente.    */
--LISTO


DROP FUNCTION IF EXISTS LISTA_INFORMANTES CASCADE;

CREATE OR REPLACE FUNCTION LISTA_INFORMANTES (agente int)
RETURNS TABLE(  nombre_clave varchar(50), agente_encargado int, fecha_inicio_agente timestamp, id_estacion_agente int,
                oficina_principal_agente int, id_jefe_confidente integer, id_confidente int, 
                fecha_inicio_confidente timestamp, id_estacion_confidente int, oficina_principal_confidente int
                ) 
    AS $$
    SELECT  i.nombre_clave, i.fk_personal_inteligencia_encargado, i.fk_fecha_inicio_encargado, i.fk_estacion_encargado,
            i.fk_oficina_principal_encargado, i.fk_empleado_jefe_confidente, i.fk_personal_inteligencia_confidente, 
            i.fk_fecha_inicio_confidente, i.fk_estacion_confidente, i.fk_oficina_principal_confidente 
        FROM PERSONAL_INTELIGENCIA e, INFORMANTE i
        WHERE e.id = agente AND e.id = i.fk_personal_inteligencia_encargado
$$ LANGUAGE SQL;

-- PARAMETRO:  fk_personal_inteligencia_encargado (id del agente o confidente)
-- LLAMADA:     SELECT * FROM LISTA_INFORMANTES(13);
