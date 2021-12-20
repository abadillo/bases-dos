ALTER TABLE CRUDO 
    ADD CONSTRAINT CRUDO_TRANSACCION_PAGO_FK FOREIGN KEY
    ( 
     INFORMANTE_id,
     TRANSACCION_PAGO_id
    ) 
    REFERENCES TRANSACCION_PAGO 
    ( 
     INFORMANTE_id,
     id
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    ENFORCED ENABLE QUERY OPTIMIZATION 
;