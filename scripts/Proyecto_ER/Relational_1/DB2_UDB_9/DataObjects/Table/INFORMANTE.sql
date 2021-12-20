CREATE TABLE INFORMANTE 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     nombre_clave 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     HIST_CARGO_fecha_inicio 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     HIST_CARGO_PERSONAL_INTELIGENCIA_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     HIST_CARGO_ESTACION_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     HIST_CARGO_ESTACION_id1 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     EMPLEADO_JEFE_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    
    )
;
ALTER TABLE INFORMANTE 
    ADD CONSTRAINT Arc_2 CHECK ( 
        (  (HIST_CARGO_fecha_inicio IS NOT NULL) AND 
         (HIST_CARGO_PERSONAL_INTELIGENCIA_id IS NOT NULL) AND 
         (HIST_CARGO_ESTACION_id IS NOT NULL) AND 
         (HIST_CARGO_ESTACION_id1 IS NOT NULL) AND 
         (EMPLEADO_JEFE_id IS NULL) ) OR 
        (  (EMPLEADO_JEFE_id IS NOT NULL) AND 
         (HIST_CARGO_fecha_inicio IS NULL)  AND 
         (HIST_CARGO_PERSONAL_INTELIGENCIA_id IS NULL)  AND 
         (HIST_CARGO_ESTACION_id IS NULL)  AND 
         (HIST_CARGO_ESTACION_id1 IS NULL) )  ) 
;

COMMENT ON COLUMN INFORMANTE.nombre_clave IS 'unique' 
;