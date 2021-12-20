CREATE TABLE CRUDO 
    (
     id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     contenido 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     tipo_contenido 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     resumen 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     fuente 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     valor_apreciacion 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     nivel_confiabilidad_inicial 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     nivel_confiabilidad_final 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     fecha_obtencion 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     fecha_verificacion_final 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     cant_analistas_verifican 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     INFORMANTE_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     ESTACION_OFICINA_PRINCIPAL_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     TRANSACCION_PAGO_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     CLAS_TEMA_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     HIST_CARGO_fecha_inicio 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     HIST_CARGO_PERSONAL_INTELIGENCIA_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     ESTACION_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;

COMMENT ON COLUMN CRUDO.tipo_contenido IS 'text, imagen, sonido, video' 
;

COMMENT ON COLUMN CRUDO.fuente IS 'abierta, secreta, tecnica' 
;
CREATE UNIQUE INDEX CRUDO__IDX
    ON CRUDO 
    ( 
     INFORMANTE_id ASC ,
     TRANSACCION_PAGO_id ASC 
    ) 
    PCTFREE 10 
    LEVEL2 PCTFREE 10 
    DISALLOW REVERSE SCANS 
;