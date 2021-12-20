CREATE TABLE PIEZA_INTELIGENCIA 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     fecha_creacion 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     nivel_confiabilidad 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     precio_base 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     class_seguridad 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     CLAS_TEMA_id 
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
                    NOT NULL 
    )
;

COMMENT ON COLUMN PIEZA_INTELIGENCIA.class_seguridad IS ' check ("Top secret" , "Confidencial", "No clasificado")' 
;