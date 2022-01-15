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
-- LLAMADA:     SELECT * FROM INTENTOS_NO_AUTORIZADOS(10);



--------------------------------------- LISTA DE INFORMANTES ----------------------------------------

/*  Es importante que otro empleado de All pueda acceder a la lista de informantes de un agente.    */


