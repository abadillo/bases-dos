
-- Equipo 9 – 2034 a 2036

--// METRICAS 
-- 1.    Desempeño de empleado(s) 
-- 2.    Control sobre la eficacia
-- 3.    Clasificación por temas 
-- 4.    Cliente más activo

--// ASPECTOS RUBRICA

-- 1. Demostración de la extracción de información – llenado del área intermedia. (6 pts)
-- 2. Demostración de la construcción de los indicadores o métricas – llenado de las tablas de hechos (6 pts)
-- 3. Visualización de los indicadores o métricas – visualización parametrizada y explicación. La explicación adecuada se deriva del modelo estrella implementado. (6 pts)


--EUROPA ('Ofi. Ginebra', true, 2, 1, 38),   -- 1
--AMERICA_NORTE ('Ofi. Washington', false, 4, null, 40),    --2
--AMERICA_SUR ('Ofi. Buenos Aires', false, 5, null, 19),  -- 3
--ASIA ('Ofi. Singapur', false, 6, null, 42),  -- 4
--AFRICA ('Ofi. El Cairo', false, 8, null, 44),  -- 5
--OCEANIA ('Ofi. Sidney', false, 10, null, 34), -- 6


CALL EXTRACCION_DESEMPENO_AII(); -- metricas 3 y 4 - copia de tablas fuente a t1

CALL TRANSFORMACION_T2_DESEMPENO_AII();  -- metricas 3 y 4 - transformacion ( copia y tranformacion de tablas t1 a t2 )

CALL TRANSFORMACION_T3_DESEMPENO_AII('2035',0);  -- metricas 3 y 4 anual
CALL TRANSFORMACION_T3_DESEMPENO_AII('2035',1);   -- metricas 3 y 4 semestral 



CALL EXTRACCION_A_T1_PRODUCTIVIDAD_EFICACIA(); -- metricas 1 y 2 - copia de tablas fuente a t1 


select * from CLAS_TEMA;
select * from T1_CLAS_TEMA;

INSERT INTO clas_tema (nombre, descripcion, topico) VALUES
('prueba', 'prueba', 'paises'),
('prueba2l', 'prueba2', 'individuos');






-- SELECT sin distinct -- metrica tema

SELECT c.fk_region_oficina, p.fk_clas_tema, t.nombre 
from t2_cliente c, t2_adquisicion a, t2_pieza_inteligencia p, t2_clas_tema t
WHERE p.id = a.fk_pieza_inteligencia AND a.fk_cliente = c.id AND p.fk_clas_tema = t.id
--AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
ORDER BY c.fk_region_oficina ASC;

-- SELECTS sin distinct -- metrica cliente

SELECT c.fk_region_oficina, c.id, c.nombre_empresa, count(a.id) as numero_compras 
from t2_cliente c, t2_adquisicion a 
WHERE c.id = a.fk_cliente 
-- AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
GROUP BY c.id, c.nombre_empresa 
ORDER BY c.fk_region_oficina ASC, numero_compras DESC;



CALL TRANSFORMACION_T3_DESEMPENO_AII('2034',0); 
CALL TRANSFORMACION_T3_DESEMPENO_AII('2034',1);  
CALL TRANSFORMACION_T3_DESEMPENO_AII('2034',2);   

CALL TRANSFORMACION_T3_DESEMPENO_AII('2035',0); 
CALL TRANSFORMACION_T3_DESEMPENO_AII('2035',1);  
CALL TRANSFORMACION_T3_DESEMPENO_AII('2035',2);

CALL TRANSFORMACION_T3_DESEMPENO_AII('2036',0); 
CALL TRANSFORMACION_T3_DESEMPENO_AII('2036',1);  
CALL TRANSFORMACION_T3_DESEMPENO_AII('2036',2);


select * from T3_DESEMPEÑO_AII;