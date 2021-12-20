ALTER TABLE ALT_CRUDO 
    ADD CONSTRAINT ALT_CRUDO_ALT_HIST_CARGO_FK FOREIGN KEY
    ( 
     ALT_HIST_CARGO_fecha_inicio
    ) 
    REFERENCES ALT_HIST_CARGO 
    ( 
     fecha_inicio
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    ENFORCED ENABLE QUERY OPTIMIZATION 
;