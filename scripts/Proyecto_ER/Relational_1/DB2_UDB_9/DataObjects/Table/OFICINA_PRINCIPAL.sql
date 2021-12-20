CREATE TABLE OFICINA_PRINCIPAL 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     nombre 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     EMPLEADO_JEFE_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     tipo 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     LUGAR_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;

COMMENT ON COLUMN OFICINA_PRINCIPAL.tipo IS 'sede si, no' 
;
CREATE UNIQUE INDEX OFICINA_PRINCIPAL__IDX
    ON OFICINA_PRINCIPAL 
    ( 
     EMPLEADO_JEFE_id ASC 
    ) 
    PCTFREE 10 
    LEVEL2 PCTFREE 10 
    DISALLOW REVERSE SCANS 
;