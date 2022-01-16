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




----------------------------------- INFORMACION DE SUS INFORMANTES -------------------------------------

/*  Se debe llevar un control sobre la eficacioa de estos tratos.
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

-- DROP FUNCTION INTENTOS_NO_AUTORIZADOS CASCADE;

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



-- DROP FUNCTION LISTA_INFORMANTES CASCADE;

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
