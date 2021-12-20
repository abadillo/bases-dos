CREATE TABLE ESTACION 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     nombre 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     OFICINA_PRINCIPAL_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     EMPLEADO_JEFE_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     LUGAR_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;
CREATE UNIQUE INDEX ESTACION__IDX
    ON ESTACION 
    ( 
     EMPLEADO_JEFE_id ASC 
    ) 
    PCTFREE 10 
    LEVEL2 PCTFREE 10 
    DISALLOW REVERSE SCANS 
;