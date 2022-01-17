-------------------------------------- BALANCE GENERAL --------------------------------------------

/*  Los jefes de las estaciones y los directores correspondientes monitorean el uso de este presupuesto a traves de
    revisiones trimestrales y al final del año.
    Cada estacion debe generar un informe con su balance:
        Pago otorgado.
        Fecha.
        Hechos crudo recolectados.
        Pieza de Inteligencia que lo utiliza (si aplica).
        Valor de la pieza.
        Ganancia o perdida alcanzada
    Y los totales generales:
        Total pagado.
        Total obtenido por ventas de las piezas de inteligencia logradas por estos hechos aportados por informantes.
*/




------------------------------- FONDOS DE ALL Y APORTE DE ESTACION ------------------------------------------

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



----------------------------------- INFORMACION DE SUS INFORMANTES -------------------------------------

/*  Se debe llevar un control sobre la eficacia de estos tratos.
    Saber el % de su eficacia, en proporcion de los hechos crudos aportados por tal informante y se han convertido
    en piezas de inteligencia.
    Los precios base para registro e informes de desempeño son en dolares.
    Se debe saber la fecha de:
        Obtencion del crudo.
        Verificacion de dicho crudo.
        Pago a informante.
        Contruccion de la pieza.
        Venta de la pieza.
    Esta medida se genera semestralmente y se usa en combinacion con la productividad de los agentes.
*/



-- DROP FUNCTION INFORMACION_INFORMANTES CASCADE;
--NO
CREATE OR REPLACE FUNCTION INFORMACION_INFORMANTES ()
RETURNS TABLE(  id_informante int, nombre_clave varchar(50), agente_encargado int, crudo int, pieza int) 
    AS $$
    SELECT  i.id, i.nombre_clave, i.fk_personal_inteligencia_encargado, c.id, cp.fk_pieza_inteligencia,
            (COUNT(a.fk_pieza_inteligencia) + COUNT (aa.fk_pieza_inteligencia)/(COUNT()))
        FROM    PERSONAL_INTELIGENCIA e, INFORMANTE i, PIEZA_INTELIGENCIA p, CRUDO c, CRUDO_PIEZA cp, ADQUISICION a
                ADQUISICION_ALT aa
        WHERE   e.id = i.fk_personal_inteligencia_encargado AND i.id = c.fk_informante AND c.id = cp.fk_crudo
                AND (   cp.fk_pieza_inteligencia = a.fk_pieza_inteligencia 
                        OR cp.fk_pieza_inteligencia = aa.fk_pieza_inteligencia  ) --SI EL ID ESTA EN ADQUICISION Y ALT
                AND 

		GROUP BY i.id, c.id, cp.fk_pieza_inteligencia
		ORDER BY i.id
$$ LANGUAGE SQL;

-- LLAMADA:     SELECT * FROM INFORMACION_INFORMANTES();





------------------------------- INTENTOS NO AUTORIZADOS ------------------------------------

/*  Cuando algun empleado trate de acceder a una pieza de inteligencia se debe quedar registrado y emitir una alerta
    al jefe de la estacion.
    Cada semana se debe emitir el reporte para el jefe de su estacion.
*/

DROP FUNCTION IF EXISTS INTENTOS_NO_AUTORIZADOS CASCADE;

CREATE OR REPLACE FUNCTION INTENTOS_NO_AUTORIZADOS (lugar int)
RETURNS TABLE(  primer_nombre varchar(50), segundo_nombre2 varchar(50), primer_apellido varchar(50), 
                segundo_apellido varchar(50), id_Empleado integer, id_Pieza integer, Clasificacion_Pieza varchar(50)) 
    AS $$
    SELECT  e.primer_nombre, e.segundo_nombre, e.primer_apellido, e.segundo_apellido, e.id as EmpleadoID, 
                    p.id as PiezaID, p.class_seguridad as NivelPieza
        FROM PERSONAL_INTELIGENCIA e, PIEZA_INTELIGENCIA p, INTENTO_NO_AUTORIZADO i
        WHERE e.fk_lugar_ciudad = lugar AND e.id = i.fk_personal_inteligencia AND i.id_pieza = p.id 
        AND i.fecha_hora BETWEEN RESTA_7_DIAS(NOW()::timestamp) AND NOW()::timestamp;
$$ LANGUAGE SQL;

-- PARAMETRO: fk_lugar_ciudad (id del lugar de la estacion)
-- LLAMADA:     SELECT * FROM INTENTOS_NO_AUTORIZADOS(19);



--------------------------------------- LISTA DE INFORMANTES ----------------------------------------

/*  Es importante que otro empleado de All pueda acceder a la lista de informantes de un agente.    */



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
