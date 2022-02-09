
------------------------ DESEMPEÑO AII ---------------------------------

-- Llamada al procedimiento que llena las tablas T1 de la metrica de desempeno (cliente y tema +)
CALL EXTRACCION_DESEMPENO_AII();
-- Afecta: T1_LUGAR, T1_CLAS_TEMA, T1_CLIENTE, 
--      T1_PIEZA_INTELIGENCIA, T1_ADQUISICION.

-- Llenar T2 de T1 en Desempeno AII
CALL TRANSFORMACION_T2_DESEMPENO_AII ();
-- Afecta: T2_REGION_OFICINA (de T1_LUGAR)
--          T2_CLIENTE, T2_CLAS_TEMA, T2_PIEZA
--          T2_ADQUISICION

-- Llenado de T2 a T3 en Desempeno AII
CALL TRANSFORMACION_T3_DESEMPENO_AII (año IN varchar, semestre IN integer);
-- Llama a TRANSFORMACION_T3_DESEMPENO_AII_DIMENSIONES (año IN varchar, semestre IN integer)
-- Afecta: 
--
--
--
--
--