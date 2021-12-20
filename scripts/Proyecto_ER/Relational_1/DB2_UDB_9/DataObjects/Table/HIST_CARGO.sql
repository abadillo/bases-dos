CREATE TABLE HIST_CARGO 
    (
     fecha_inicio 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     fecha_fin 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     cargo 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     PERSONAL_INTELIGENCIA_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     ESTACION_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     ESTACION_id1 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;

COMMENT ON COLUMN HIST_CARGO.cargo IS 'analista
agente' 
;