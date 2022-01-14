-- La información recolectada por los agentes de campo se indexa (fecha más reciente)


CREATE INDEX crudo_fecha_obtencion_mas_reciente ON CRUDO ( fecha_obtencion DESC );

CREATE INDEX crudo_fecha_verificacion_final_mas_reciente ON CRUDO ( fecha_verificacion_final DESC );

-- Select * from crudo ORDER BY fecha_obtencion DESC;
