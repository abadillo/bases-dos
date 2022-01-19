CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_personal_inteligencia_confidente = id_personal_inteligencia; 
$$;

-- SELECT * FROM VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_CONFIDENTE(11);

-- SELECT * from informante;


-------------------------/////////////////////-----------------------





CREATE OR REPLACE FUNCTION VER_LISTA_INFORMANTES_PERSONAL_INTELIGENCIA_AGENTE (id_personal_inteligencia in integer)
RETURNS setof INFORMANTE
LANGUAGE sql
AS $$  
 	
    SELECT * FROM INFORMANTE WHERE fk_personal_inteligencia_encargado = id_personal_inteligencia; 
$$;


--------------------------///////////////////////-----------------------------



-------------------------/////////////////////-----------------------