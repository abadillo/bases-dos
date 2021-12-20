CREATE TABLE LUGAR 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     nombre 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     tipo 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     region 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     LUGAR_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;

COMMENT ON COLUMN LUGAR.tipo IS 'pais, ciudad' 
;