CREATE TABLE ALT_HIST_CARGO 
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
     id_personal 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     id_estacion 
--  ERROR: Datatype UNKNOWN is not allowed 
                    
    )
;

COMMENT ON COLUMN ALT_HIST_CARGO.cargo IS 'analista
agente' 
;