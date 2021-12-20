CREATE TABLE ALT_CRUDO 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     ALT_HIST_CARGO_fecha_inicio 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     fuente 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     id_informante 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     monto_pago_informante 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     fecha_pago_informante 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     id_estacion 
--  ERROR: Datatype UNKNOWN is not allowed 
                    
    )
;

COMMENT ON COLUMN ALT_CRUDO.fuente IS 'abierta, secreta, tecnica' 
;