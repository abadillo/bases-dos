CREATE TABLE CLAS_TEMA 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     nombre 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     descripcion 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     topico 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;

COMMENT ON COLUMN CLAS_TEMA.topico IS 'paises
individuos
eventos
empresas' 
;