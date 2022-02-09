CALL EXTRACCION_DESEMPENO_AII(); -- metricas 3 y 4 - copia de tablas fuente a t1

CALL TRANSFORMACION_T2_DESEMPENO_AII();  -- metricas 3 y 4 - transformacion ( copia y tranformacion de tablas t1 a t2 )

CALL TRANSFORMACION_T3_DESEMPENO_AII('2035',0);  -- metricas 3 y 4 anual

CALL TRANSFORMACION_T3_DESEMPENO_AII('2035',1);   -- metricas 3 y 4 semestral 



CALL EXTRACCION_A_T1_PRODUCTIVIDAD_EFICACIA(); -- metricas 1 y 2 - copia de tablas fuente a t1


select * from T1_CLAS_TEMA;

INSERT INTO clas_tema (nombre, descripcion, topico) VALUES
('prueba', 'prueba', 'paises'),
('prueba2l', 'prueba2', 'individuos');







SELECT o.id, o.nombre, NOW(), ( SELECT b.region FROM T1_LUGAR a, T1_LUGAR b WHERE o.fk_lugar_ciudad = a.id AND a.fk_lugar = b.id ) FROM T1_OFICINA_PRINCIPAL o;


SELECT id, nombre_empresa, pagina_web, (SELECT id_oficina FROM T2_REGION_OFICINA oe WHERE oe.nombre_region = ( SELECT region FROM T1_LUGAR WHERE id = c.fk_lugar_pais ) ) FROM T1_CLIENTE c

select * from t2_region_oficina ro, t2_cliente c where c.fk_region_oficina = ro.id_oficina ;


select * from t2_cliente tc ;

TRUNCATE t2_cliente CASCADE;


select * from t3_tiempo 

CALL transformacion_t3_desempeno_aii('2035',0);

CALL transformacion_t3_desempeno_aii('2035',1);

select * from T3_DESEMPEÑO_AII;




-- SELECTS sin distinct -- metricas 3 y 4

SELECT c.fk_region_oficina, p.fk_clas_tema, t.nombre 
from t2_cliente c, t2_adquisicion a, t2_pieza_inteligencia p, t2_clas_tema t
WHERE p.id = a.fk_pieza_inteligencia AND a.fk_cliente = c.id AND p.fk_clas_tema = t.id
--AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
ORDER BY c.fk_region_oficina ASC;


SELECT c.fk_region_oficina, c.id, c.nombre_empresa, count(a.id) as numero_compras 
from t2_cliente c, t2_adquisicion a 
WHERE c.id = a.fk_cliente 
-- AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
GROUP BY c.id, c.nombre_empresa 
ORDER BY c.fk_region_oficina ASC, numero_compras DESC;
 

