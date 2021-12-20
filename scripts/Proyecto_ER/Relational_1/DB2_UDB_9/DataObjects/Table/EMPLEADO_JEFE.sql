CREATE TABLE EMPLEADO_JEFE 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     primer_nombre 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     segundo_nombre 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     primer_apellido 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     segundo_apellido 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     "telefono_(_->_telefono_ty_)" 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     EMPLEADO_JEFE_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     tipo 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;

COMMENT ON COLUMN EMPLEADO_JEFE.tipo IS 'director_area, jefe, director_ejecutivo' 
;