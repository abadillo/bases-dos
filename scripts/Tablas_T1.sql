

CREATE TABLE LUGAR_TI (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar integer ,

    CONSTRAINT LUGAR_PK PRIMARY KEY (id),
    CONSTRAINT LUGAR_LUGAR_FK FOREIGN KEY (fk_lugar) REFERENCES LUGAR_TI (id),
    CONSTRAINT LUGAR_CH_tipo CHECK ( tipo IN ('ciudad', 'pais') ),
    CONSTRAINT LUGAR_CH_region CHECK ( region IN ('europa', 'africa', 'america_sur', 'america_norte', 'asia', 'oceania') )
);

CREATE TABLE AREA_INTERES (

    fk_clas_tema integer NOT NULL,
    fk_cliente integer NOT NULL

----CONSTRAINT AREA_INTERES_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),
----CONSTRAINT AREA_INTERES_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES CLIENTE (id),
----CONSTRAINT AREA_INTERES_PK PRIMARY KEY (fk_clas_tema, fk_cliente)
);

CREATE TABLE CLIENTE_TI (

    id serial NOT NULL,

    nombre_empresa varchar(100) NOT NULL,
    pagina_web varchar(100) NOT NULL,
    exclusivo boolean NOT NULL,
    
    fk_lugar_pais integer NOT NULL,
    
    CONSTRAINT CLIENTE_PK PRIMARY KEY (id)
----CONSTRAINT CLIENTE_LUGAR_FK FOREIGN KEY (fk_lugar_pais) REFERENCES LUGAR (id)
);


CREATE TABLE OFICINA_PRINCIPAL_TI (

    id serial NOT NULL,

    nombre varchar(50) NOT NULL,
    
    fk_director_area integer ,
    fk_director_ejecutivo integer ,
    fk_lugar_ciudad integer NOT NULL ,

    CONSTRAINT OFICINA_PRINCIPAL_PK PRIMARY KEY (id)
----CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe FOREIGN KEY (fk_director_area) REFERENCES EMPLEADO_JEFE (id),
----CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe_2 FOREIGN KEY (fk_director_ejecutivo) REFERENCES EMPLEADO_JEFE (id),
----CONSTRAINT OFICINA_PRINCIPAL_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id)
);

CREATE TABLE CLAS_TEMA (

    id serial NOT NULL,

    nombre varchar(255) NOT NULL,
    descripcion varchar(500) NOT NULL,
    topico varchar(50) NOT NULL, -- 'paises, individuos, eventos, empresas' 

    CONSTRAINT CLAS_TEMA_PK PRIMARY KEY (id),

    CONSTRAINT CLAS_TEMA_CH_topico CHECK ( topico IN ('paises', 'individuos', 'eventos', 'empresas') )    
);


CREATE TABLE ADQUISICION (

    id serial NOT NULL,

    fecha_hora_venta timestamp NOT NULL,
    precio_vendido numeric(20) NOT NULL,

    fk_cliente integer NOT NULL,
    fk_pieza_inteligencia integer NOT NULL,
    
    CONSTRAINT ADQUISICION_PK PRIMARY KEY (id, fk_cliente, fk_pieza_inteligencia)

----CONSTRAINT ADQUISICION_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES CLIENTE (id),
----CONSTRAINT ADQUISICION_PIEZA_INTELIGENCIA_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES PIEZA_INTELIGENCIA (id)
);

