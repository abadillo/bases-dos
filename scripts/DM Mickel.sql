-- Se crean tablas Dim con los mismos cambos de las tablas iniciales?
-- Tabla lugar o region?
-- fechac en las tablas solo dim?
-- Oficina Principal o Estaciones?

---------------------------------- TABLAS DIMENSION -------------------------------

DROP TABLE IF EXISTS DimLugar CASCADE;

CREATE TABLE DimLugar (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar integer,
    fechac TIMESTAMP NOT NULL,

    CONSTRAINT LUGAR_PK PRIMARY KEY (id),
    CONSTRAINT LUGAR_LUGAR_FK FOREIGN KEY (fk_lugar) REFERENCES LUGAR (id),
    CONSTRAINT LUGAR_CH_tipo CHECK ( tipo IN ('ciudad', 'pais') ),
    CONSTRAINT LUGAR_CH_region CHECK ( region IN ('europa', 'africa', 'america_sur', 'america_norte', 'asia', 'oceania') )
);




DROP TABLE IF EXISTS TIEMPO CASCADE;

CREATE TABLE TIEMPO (

    id serial NOT NULL,
    semestre SMALLINT NOT NULL,
    anio numeric(4) NOT NULL,

    CONSTRAINT TIEMPO_PK PRIMARY KEY (id),
    CONSTRAINT SEMESTRE_CHECK CHECK (semestre = 1 or semestre = 2)

);


INSERT INTO TIEMPO (semestre, anio) VALUES 
    (1,2034), 
    (2,2034), 
    (1,2035), 
    (2,2035), 
    (1,2036), 
    (2,2036)
    ;


DROP TABLE IF EXISTS DimOFICINA_PRINCIPAL CASCADE;

CREATE TABLE DimOFICINA_PRINCIPAL (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    sede boolean NOT NULL,
    fk_director_area integer ,
    fk_director_ejecutivo integer ,
    fk_lugar_ciudad integer NOT NULL,
    fechac TIMESTAMP NOT NULL,

    CONSTRAINT OFICINA_PRINCIPAL_PK PRIMARY KEY (id),
    CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe FOREIGN KEY (fk_director_area) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe_2 FOREIGN KEY (fk_director_ejecutivo) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT OFICINA_PRINCIPAL_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id)
);



------------------------------------------ TABLAS FACT -----------------------------------


-- Sería ideal contar con información sobre los puntos anteriores, como por ejemplo, cuál es el tema con 
-- mayor demanda (tema en el que la mayor cantidad de clientes ha adquirido piezas de inteligencia), 
-- cuál es el cliente más activo (que compra más frecuentemente). Esta información se debería 
-- presentar por región semestral y anualmente. 


-- Desempeño AII

DROP TABLE IF EXISTS DESEMPEÑO_AII CASCADE;

CREATE TABLE Desempeño_AII (
    id_tiempo integer,
    id_lugar integer,
    clienteMasActivo_Semestre VARCHAR(50),
    clienteMasActivo_Year VARCHAR(50),
    temaMayorDemanda_Semestre VARCHAR(50),
    temaMayorDemanda_Year VARCHAR(50)

)




--------------------------------------------------------------------------------


--Para la AII es importante tener información confiable relacionada con el desempeño de sus 
--empleados: productividad2 de los analistas y agentes de campo por año, País, Oficina. La medida 
--debe ser calculada de manera directa para el empleado y promedio para oficinas y países. En 
--cualquier momento en el que el cálculo de la productividad sea inferior al 65% anual se debe resaltar 
--ese resultado con el color rojo.
--Como muchos hechos crudos vienen de informantes e implican pagos, se debe llevar un control 
--sobre la eficacia de esos tratos – o sea para un informante dado poder saber el % de su eficacia (en 
--qué proporción los hechos crudos aportados por tal informante se han convertido en piezas de 
--inteligencia). Esta medida se genera semestralmente y se usa en combinación con la productividad 
--de los agentes

-- Productividad_Eficacia

DROP TABLE IF EXISTS PRODUCTIVIDAD_EFICACIA CASCADE;

CREATE TABLE PRODUCTIVIDAD_EFICACIA (
    id_tiempo integer,
    id_lugar integer,
    id_informante integer,
    id_oficina integer,
    id_personal integer,
    %EficaciaInformante numeric (6,3),
    %ProdPromedioAgentesPais numeric (6,3),
    %ProdPromedioAnalistasPais numeric (6,3),
    %ProdPromedioAgentesOficina numeric (6,3),
    %ProdPromedioAnalistasOficina numeric (6,3),
    %ProdGeneralAgente numeric (6,3),
    %ProdGeneralAnalista numeric (6,3)
)