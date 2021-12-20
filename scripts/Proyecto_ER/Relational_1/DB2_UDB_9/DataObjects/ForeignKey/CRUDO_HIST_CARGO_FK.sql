ALTER TABLE CRUDO 
    ADD CONSTRAINT CRUDO_HIST_CARGO_FK FOREIGN KEY
    ( 
     HIST_CARGO_fecha_inicio,
     HIST_CARGO_PERSONAL_INTELIGENCIA_id,
     ESTACION_id,
     ESTACION_OFICINA_PRINCIPAL_id
    ) 
    REFERENCES HIST_CARGO 
    ( 
     fecha_inicio,
     PERSONAL_INTELIGENCIA_id,
     ESTACION_id,
     ESTACION_id1
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    ENFORCED ENABLE QUERY OPTIMIZATION 
;