ALTER TABLE PIEZA_INTELIGENCIA 
    ADD CONSTRAINT PIEZA_INTELIGENCIA_CLAS_TEMA_FK FOREIGN KEY
    ( 
     CLAS_TEMA_id
    ) 
    REFERENCES CLAS_TEMA 
    ( 
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    ENFORCED ENABLE QUERY OPTIMIZATION 
;