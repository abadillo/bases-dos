CALL EXTRACCION_DESEMPENO_AII();


select * from T1_CLAS_TEMA;

INSERT INTO clas_tema (nombre, descripcion, topico) VALUES
('prueba', 'prueba', 'paises'),
('prueba2l', 'prueba2', 'individuos');


SELECT o.id, o.nombre, NOW(), ( SELECT b.region FROM T1_LUGAR a, T1_LUGAR b WHERE o.fk_lugar_ciudad = a.id AND a.fk_lugar = b.id ) FROM T1_OFICINA_PRINCIPAL o;


CALL transformacion_t2_desempeno_aii();


SELECT id, nombre_empresa, pagina_web, (SELECT id_oficina FROM T2_REGION_OFICINA oe WHERE oe.nombre_region = ( SELECT region FROM T1_LUGAR WHERE id = c.fk_lugar_pais ) ) FROM T1_CLIENTE c

select * from t2_region_oficina ro, t2_cliente c where c.fk_region_oficina = ro.id_oficina ;


select * from t2_cliente tc ;

TRUNCATE t2_cliente CASCADE;

CALL transformacion_t3_desempeno_aii_dimensiones('2035',1);

select * from t3_tiempo 

CALL transformacion_t3_desempeno_aii('2035',0);

CALL transformacion_t3_desempeno_aii('2035',2);

select * from T3_DESEMPEÑO_AII;


SELECT c.fk_region_oficina, p.fk_clas_tema, t.nombre 
from t2_cliente c, t2_adquisicion a, t2_pieza_inteligencia p, t2_clas_tema t
WHERE p.id = a.fk_pieza_inteligencia AND a.fk_cliente = c.id AND p.fk_clas_tema = t.id
--AND a.fecha_hora_venta BETWEEN año_timestamp_ini AND año_timestamp_fin
ORDER BY c.fk_region_oficina ASC;

 
