ALTER TABLE TRANSACCION_PAGO 
    ADD CONSTRAINT TRANSACCION_PAGO_INFORMANTE_FK FOREIGN KEY
    ( 
     INFORMANTE_id
    ) 
    REFERENCES INFORMANTE 
    ( 
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    ENFORCED ENABLE QUERY OPTIMIZATION 
;