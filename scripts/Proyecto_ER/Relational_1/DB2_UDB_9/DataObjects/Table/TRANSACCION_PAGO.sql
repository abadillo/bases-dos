CREATE TABLE TRANSACCION_PAGO 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     fecha 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     monto_pago 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     CRUDO_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     INFORMANTE_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;
CREATE UNIQUE INDEX TRANSACCION_PAGO__IDX
    ON TRANSACCION_PAGO 
    ( 
     CRUDO_id ASC 
    ) 
    PCTFREE 10 
    LEVEL2 PCTFREE 10 
    DISALLOW REVERSE SCANS 
;