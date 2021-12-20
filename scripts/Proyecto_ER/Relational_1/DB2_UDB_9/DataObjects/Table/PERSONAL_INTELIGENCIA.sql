CREATE TABLE PERSONAL_INTELIGENCIA 
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
     clasificacion 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     "telefono_(_-->telefono_ty_)" 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     "identificaciones_(_-->_identificacion_va_)" 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     fotografia 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     huella_retina 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     huella_digital 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     altura 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     peso 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     color_ojos 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     vision 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     "nivel_educativo_(_->_nivel_educativo_va_)" 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     "idiomas_(_->_idiomas_va_)" 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     "familiares_(_-->_familiar_va_)" 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     ESTACION_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     "licencia_manejo_(_->_licencia_ty_)" 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     class_seguridad 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     "aliases_(_-->_alias_nt_)" 
--  ERROR: Datatype UNKNOWN is not allowed 
                    , 
     ESTACION_id1 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL , 
     LUGAR_id 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
;

COMMENT ON COLUMN PERSONAL_INTELIGENCIA.clasificacion IS 'check ("Agente de campo", "Analista")' 
;

COMMENT ON COLUMN PERSONAL_INTELIGENCIA.class_seguridad IS 'check ("Top secret" , "Confidencial", "No clasificado")' 
;