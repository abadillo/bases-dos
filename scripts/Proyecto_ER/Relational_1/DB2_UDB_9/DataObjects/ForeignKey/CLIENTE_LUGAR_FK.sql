ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_LUGAR_FK FOREIGN KEY
    ( 
     LUGAR_id
    ) 
    REFERENCES LUGAR 
    ( 
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    ENFORCED ENABLE QUERY OPTIMIZATION 
;