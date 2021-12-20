
CREATE TABLE LUGAR (
    id serial NOT NULL,
    nombre varchar(50) NOT NULL,
    tipo varchar(50) NOT NULL, -- 'pais, ciudad'
    region varchar(50),
    fk_lugar NOT NULL ,

    CONSTRAINT LUGAR_PK PRIMARY KEY (id),
    CONSTRAINT LUGAR_LUGAR_FK FOREIGN KEY (fk_lugar) REFERENCES LUGAR (id),
    CONSTRAINT LUGAR_CH_tipo CHECK ( tipo IN ('Ciudad', 'Pais') ),
    CONSTRAINT LUGAR_CH_region CHECK ( region IN ('Europa', 'Africa', 'America del Sur', 'America del Norte', 'Asia', 'Oceania') )
);


CREATE TABLE CLIENTE (
    id serial NOT NULL,
    nombre_empresa varchar(100) NOT NULL,
    pagina_web varchar(100) NOT NULL,
    exclusivo boolean NOT NULL,
    telefonos telefono_ty[3] NOT NULL,
    contactos contacto_ty[3] NOT NULL,
    fk_lugar_pais integer NOT NULL,
    
    CONSTRAINT CLIENTE_PK PRIMARY KEY (id),
    CONSTRAINT CLIENTE_LUGAR_FK FOREIGN KEY (fk_lugar_pais) REFERENCES LUGAR (id)
);



CREATE TABLE EMPLEADO_JEFE (
    id serial NOT NULL,
    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50) ,
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,
    telefono telefono_ty,
    tipo varchar(50) NOT NULL, -- 'director_area, jefe, director_ejecutivo'
    fk_empleado_jefe integer NOT NULL,

    CONSTRAINT EMPLEADO_JEFE_PK PRIMARY KEY (id),
    CONSTRAINT EMPLEADO_JEFE_FK FOREIGN KEY (fk_empleado_jefe) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT EMPLEADO_JEFE_CH_tipo CHECK ( tipo IN ('director_area', 'jefe', 'director_ejecutivo') )
);

CREATE TABLE OFICINA_PRINCIPAL (
    id serial NOT NULL,
    nombre varchar(50) NOT NULL,
    sede boolean NOT NULL,
    fk_director_area integer NOT NULL,
    fk_director_ejecutivo integer NOT NULL,
    fk_lugar_ciudad integer NOT NULL ,

    CONSTRAINT OFICINA_PRINCIPAL_PK PRIMARY KEY (id),
    CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe FOREIGN KEY (fk_director_area) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT OFICINA_PRINCIPAL_fk_empleado_jefe_2 FOREIGN KEY (fk_director_ejecutivo) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT OFICINA_PRINCIPAL_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id)
);



CREATE TABLE ESTACION (
    id serial NOT NULL,
    nombre varchar(50) NOT NULL,
    fk_oficina_principal integer NOT NULL,
    fk_empleado_jefe integer NOT NULL,
    fk_lugar_ciudad integer NOT NULL,

    CONSTRAINT ESTACION_PK PRIMARY KEY (id, fk_oficina_principal),
    CONSTRAINT ESTACION_OFICINA_PRINCIPAL_FK FOREIGN KEY (fk_oficina_principal) REFERENCES OFICINA_PRINCIPAL (id),
    CONSTRAINT ESTACION_fk_empleado_jefe FOREIGN KEY (fk_empleado_jefe) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT ESTACION_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id)
    
);

CREATE TABLE CUENTA (
    año datetime NOT NULL,
    presupuesto numeric(20) NOT NULL,
    fk_estacion integer NOT NULL,
    fk_oficina_principal integer NOT NULL,

    CONSTRAINT CUENTA_PK PRIMARY KEY (fk_estacion, fk_oficina_principal, año),
    CONSTRAINT CUENTA_ESTACION_FK FOREIGN KEY (fk_estacion, fk_oficina_principal) REFERENCES ESTACION (id, fk_oficina_principal)
);

CREATE TABLE PERSONAL_INTELIGENCIA (
    id serial NOT NULL,
    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50) ,
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,
    clasificacion NOT NULL,
    "telefono_(_-->telefono_ty_)" NOT NULL,
    "identificaciones_(_-->_identificacion_va_)" NOT NULL,
    fotografia NOT NULL,
    huella_retina NOT NULL,
    huella_digital,
    altura NOT NULL,
    peso NOT NULL,
    color_ojos NOT NULL,
    vision NOT NULL,
    "nivel_educativo_(_->_nivel_educativo_va_)" NOT NULL,
    "idiomas_(_->_idiomas_va_)" NOT NULL,
    "familiares_(_-->_familiar_va_)" NOT NULL,
    ESTACION_id integer NOT NULL,
    "licencia_manejo_(_->_licencia_ty_)",
    class_seguridad NOT NULL,
    "aliases_(_-->_alias_nt_)",
    fk_estacion_oficina_principal integer NOT NULL,
    fk_lugar NOT NULL 

    CONSTRAINT PERSONAL_INTELIGENCIA_PK PRIMARY KEY (id),

    CONSTRAINT PERSONAL_INTELIGENCIA_ESTACION_FK FOREIGN KEY (ESTACION_id,
    fk_estacion_oficina_principal) REFERENCES ESTACION (id,
    fk_oficina_principal),
    CONSTRAINT PERSONAL_INTELIGENCIA_LUGAR_FK FOREIGN KEY (fk_lugar) REFERENCES LUGAR (id);



    -- PERSONAL_INTELIGENCIA.clasificacion IS 'check ("Agente de campo", "Analista")' ;

    -- PERSONAL_INTELIGENCIA.class_seguridad IS 'check ("Top secret","Confidencial", "No clasificado")' ;
);


CREATE TABLE INTENTO_NO_AUTORIZADO (
    id serial NOT NULL,
    fecha NOT NULL,
    id_pieza NOT NULL,
    id_empleado NOT NULL,
    PERSONAL_INTELIGENCIA_id NOT NULL ,

    CONSTRAINT INTENTO_NO_AUTORIZADO_PK PRIMARY KEY (PERSONAL_INTELIGENCIA_id, id),
    CONSTRAINT INTENTO_NO_AUTORIZADO_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (PERSONAL_INTELIGENCIA_id) REFERENCES PERSONAL_INTELIGENCIA (id)
);


CREATE TABLE CLAS_TEMA (
    id serial NOT NULL,
    nombre NOT NULL,
    descripcion NOT NULL,
    topico NOT NULL, -- 'paises, individuos, eventos, empresas' 

   
    CONSTRAINT CLAS_TEMA_PK PRIMARY KEY (id)
);

CREATE TABLE AREA_INTERES (
    CLAS_TEMA_id integer NOT NULL,
    CLIENTE_id integer NOT NULL,


    CONSTRAINT AREA_INTERES_CLAS_TEMA_FK FOREIGN KEY (CLAS_TEMA_id) REFERENCES CLAS_TEMA (id),
    CONSTRAINT AREA_INTERES_CLIENTE_FK FOREIGN KEY (CLIENTE_id) REFERENCES CLIENTE (id).
    CONSTRAINT AREA_INTERES_PK PRIMARY KEY (CLAS_TEMA_id, CLIENTE_id),
);

CREATE TABLE TEMAS_ESP (
    PERSONAL_INTELIGENCIA_id integer NOT NULL,
    CLAS_TEMA_id integer NOT NULL,

    CONSTRAINT TEMAS_ESP_PK PRIMARY KEY (PERSONAL_INTELIGENCIA_id, CLAS_TEMA_id),

    CONSTRAINT TEMAS_ESP_CLAS_TEMA_FK FOREIGN KEY (CLAS_TEMA_id) REFERENCES CLAS_TEMA (id),
    CONSTRAINT TEMAS_ESP_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (PERSONAL_INTELIGENCIA_id) REFERENCES PERSONAL_INTELIGENCIA (id)

);



CREATE TABLE HIST_CARGO (
    fecha_inicio NOT NULL,
    fecha_fin,
    cargo NOT NULL, -- 'analista agente'
    PERSONAL_INTELIGENCIA_id integer NOT NULL,
    ESTACION_id integer NOT NULL,
    fk_estacion_oficina_principal NOT NULL ,

    CONSTRAINT HIST_CARGO_PK PRIMARY KEY (fecha_inicio, PERSONAL_INTELIGENCIA_id, ESTACION_id, fk_estacion_oficina_principal),

    CONSTRAINT HIST_CARGO_ESTACION_FK FOREIGN KEY (ESTACION_id,
    fk_estacion_oficina_principal) REFERENCES ESTACION (id,
    fk_oficina_principal),
    CONSTRAINT HIST_CARGO_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (PERSONAL_INTELIGENCIA_id) REFERENCES PERSONAL_INTELIGENCIA (id)
);


CREATE TABLE INFORMANTE (
    id serial NOT NULL,
    nombre_clave unique NOT NULL,
    fecha_inicio NOT NULL,
    id1 NOT NULL,
    id11 NOT NULL,
    id111 NOT NULL,
    fk_empleado_jefe,

    CONSTRAINT INFORMANTE_PK PRIMARY KEY (id)

    CONSTRAINT Arc_2 CHECK (   (  (fecha_inicio IS NOT NULL) AND 
        (id1 IS NOT NULL) AND 
        (id11 IS NOT NULL) AND 
        (id111 IS NOT NULL) AND 
        (fk_empleado_jefe IS NULL) ) OR 
       (  (fk_empleado_jefe IS NOT NULL) AND 
        (fecha_inicio IS NULL)  AND 
        (id1 IS NULL)  AND 
        (id11 IS NULL)  AND 
        (id111 IS NULL) )  ) 

    CONSTRAINT INFORMANTE_fk_empleado_jefe FOREIGN KEY (fk_empleado_jefe) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT INFORMANTE_HIST_CARGO_FK FOREIGN KEY (fecha_inicio,
    id1,
    id11,
    id111) REFERENCES HIST_CARGO (fecha_inicio,
    PERSONAL_INTELIGENCIA_id,
    ESTACION_id,
    fk_estacion_oficina_principal),
    CONSTRAINT INFORMANTE_HIST_CARGO_FKv1 FOREIGN KEY (fecha_inicio,
    id1,
    id11,
    id111) REFERENCES HIST_CARGO (fecha_inicio,
    PERSONAL_INTELIGENCIA_id,
    ESTACION_id,
    fk_estacion_oficina_principal)

);

CREATE TABLE TRANSACCION_PAGO (
    id serial NOT NULL,
    fecha NOT NULL,
    monto_pago NOT NULL,
    CRUDO_id,
    INFORMANTE_id NOT NULL ,

    CONSTRAINT TRANSACCION_PAGO_PK PRIMARY KEY (INFORMANTE_id, id),
    CONSTRAINT TRANSACCION_PAGO_INFORMANTE_FK FOREIGN KEY (INFORMANTE_id) REFERENCES INFORMANTE (id)
);

CREATE TABLE CRUDO (
    id serial NOT NULL,
    contenido NOT NULL, -- 'text, imagen, sonido, video' 
    tipo_contenido NOT NULL,
    resumen NOT NULL,
    fuente NOT NULL, -- 'abierta, secreta, tecnica'
    valor_apreciacion,
    nivel_confiabilidad_inicial NOT NULL,
    nivel_confiabilidad_final,
    fecha_obtencion NOT NULL,
    fecha_verificacion_final,
    cant_analistas_verifican NOT NULL,
    id1 NOT NULL,
    id11 NOT NULL,
    TRANSACCION_PAGO_id,
    CLAS_TEMA_id integer NOT NULL,
    HIST_CARGO_fecha_inicio NOT NULL,
    HIST_CARGO_PERSONAL_INTELIGENCIA_id integer NOT NULL,
    id13 NOT NULL,

    CONSTRAINT CRUDO_PK PRIMARY KEY (id),

    CONSTRAINT CRUDO_CLAS_TEMA_FK FOREIGN KEY (CLAS_TEMA_id) REFERENCES CLAS_TEMA (id),
    CONSTRAINT CRUDO_ESTACION_FK FOREIGN KEY (id13,
    id11) REFERENCES ESTACION (id,
    fk_oficina_principal),
    CONSTRAINT CRUDO_HIST_CARGO_FK FOREIGN KEY (HIST_CARGO_fecha_inicio,
    HIST_CARGO_PERSONAL_INTELIGENCIA_id,
    id13,
    id11) REFERENCES HIST_CARGO (fecha_inicio,
    PERSONAL_INTELIGENCIA_id,
    ESTACION_id,
    fk_estacion_oficina_principal),
    CONSTRAINT CRUDO_INFORMANTE_FK FOREIGN KEY (id1) REFERENCES INFORMANTE (id)


);

CREATE TABLE ANALISTA_CRUDO (
    id serial NOT NULL,
    fecha NOT NULL,
    nivel_confiabilidad NOT NULL,
    CRUDO_id integer NOT NULL,
    HIST_CARGO_fecha_inicio NOT NULL,
    HIST_CARGO_PERSONAL_INTELIGENCIA_id integer NOT NULL,
    HIST_CARGO_ESTACION_id integer NOT NULL,
    HIST_CARGO_ESTACION_id1 NOT NULL ,

    CONSTRAINT ANALISTA_CRUDO_CRUDO_FK FOREIGN KEY (CRUDO_id) REFERENCES CRUDO (id),

    CONSTRAINT ANALISTA_CRUDO_HIST_CARGO_FK FOREIGN KEY (HIST_CARGO_fecha_inicio,
    HIST_CARGO_PERSONAL_INTELIGENCIA_id,
    HIST_CARGO_ESTACION_id,
    HIST_CARGO_ESTACION_id1) REFERENCES HIST_CARGO (fecha_inicio,
    PERSONAL_INTELIGENCIA_id,
    ESTACION_id,
    fk_estacion_oficina_principal),

    CONSTRAINT ANALISTA_CRUDO_PK PRIMARY KEY (CRUDO_id, id, HIST_CARGO_fecha_inicio, HIST_CARGO_PERSONAL_INTELIGENCIA_id, HIST_CARGO_ESTACION_id, HIST_CARGO_ESTACION_id1)
);


CREATE TABLE PIEZA_INTELIGENCIA (
    id serial NOT NULL,
    fecha_creacion,
    nivel_confiabilidad,
    precio_base,
    class_seguridad NOT NULL,
    CLAS_TEMA_id integer NOT NULL,
    HIST_CARGO_fecha_inicio NOT NULL,
    HIST_CARGO_PERSONAL_INTELIGENCIA_id integer NOT NULL,
    HIST_CARGO_ESTACION_id integer NOT NULL,
    HIST_CARGO_ESTACION_id1 NOT NULL ,

    CONSTRAINT PIEZA_INTELIGENCIA_PK PRIMARY KEY (id),

    CONSTRAINT PIEZA_INTELIGENCIA_CLAS_TEMA_FK FOREIGN KEY (CLAS_TEMA_id) REFERENCES CLAS_TEMA (id),
    CONSTRAINT PIEZA_INTELIGENCIA_HIST_CARGO_FK FOREIGN KEY (HIST_CARGO_fecha_inicio,
    HIST_CARGO_PERSONAL_INTELIGENCIA_id,
    HIST_CARGO_ESTACION_id,
    HIST_CARGO_ESTACION_id1) REFERENCES HIST_CARGO (fecha_inicio,
    PERSONAL_INTELIGENCIA_id,
    ESTACION_id,
    fk_estacion_oficina_principal)

    -- PIEZA_INTELIGENCIA.class_seguridad IS ' check ("Top secret","Confidencial", "No clasificado")'
);


CREATE TABLE CRUDO_PIEZA (
    PIEZA_INTELIGENCIA_id integer NOT NULL,
    CRUDO_id NOT NULL ,

    CONSTRAINT CRUDO_PIEZA_PK PRIMARY KEY (PIEZA_INTELIGENCIA_id, CRUDO_id),
    CONSTRAINT CRUDO_PIEZA_PIEZA_INTELIGENCIA_FK FOREIGN KEY (PIEZA_INTELIGENCIA_id) REFERENCES PIEZA_INTELIGENCIA (id),
    CONSTRAINT CRUDO_PIEZA_CRUDO_FK FOREIGN KEY (CRUDO_id) REFERENCES CRUDO (id)
);



CREATE TABLE ADQUISICION (
    id serial NOT NULL,
    fecha_venta NOT NULL,
    CLIENTE_id integer NOT NULL,
    PIEZA_INTELIGENCIA_id integer NOT NULL,
    precio_vendido NOT NULL,

    CONSTRAINT ADQUISICION_PK PRIMARY KEY (CLIENTE_id, PIEZA_INTELIGENCIA_id, id),

    CONSTRAINT ADQUISICION_CLIENTE_FK FOREIGN KEY (CLIENTE_id) REFERENCES CLIENTE (id),
    CONSTRAINT ADQUISICION_PIEZA_INTELIGENCIA_FK FOREIGN KEY (PIEZA_INTELIGENCIA_id) REFERENCES PIEZA_INTELIGENCIA (id)
);








































































----------------------------------------





CREATE TABLE ALT_ADQUISICION (
    id serial NOT NULL,
    fecha_venta NOT NULL,
    precio_vendido NOT NULL,
    id_cliente NOT NULL,
    ALT_PIEZA_INTELIGENCIA_id NOT NULL 
);

ALTER TABLE ALT_ADQUISICION ADD       CONSTRAINT ALT_ADQUISICION_PK PRIMARY KEY (ALT_PIEZA_INTELIGENCIA_id, id);

CREATE TABLE ALT_ANALISTA_CRUDO (
    id serial NOT NULL,
    fecha NOT NULL,
    nivel_confiabilidad NOT NULL,
    ALT_HIST_CARGO_fecha_inicio NOT NULL,
    ALT_CRUDO_id NOT NULL 
);

ALTER TABLE ALT_ANALISTA_CRUDO ADD       CONSTRAINT ALT_ANALISTA_CRUDO_PK PRIMARY KEY (id, ALT_HIST_CARGO_fecha_inicio, ALT_CRUDO_id);

CREATE TABLE ALT_CRUDO (
    id serial NOT NULL,
    ALT_HIST_CARGO_fecha_inicio NOT NULL,
    fuente NOT NULL,
    id_informante,
    monto_pago_informante NOT NULL,
    fecha_pago_informante,
    id_estacion 
);

COMMENT ON COLUMN ALT_CRUDO.fuente IS 'abierta, secreta, tecnica' ;

ALTER TABLE ALT_CRUDO ADD       CONSTRAINT ALT_CRUDO_PK PRIMARY KEY (id);

CREATE TABLE ALT_CRUDO_PIEZA (
    ALT_PIEZA_INTELIGENCIA_id integer NOT NULL,
    ALT_CRUDO_id NOT NULL 
);

ALTER TABLE ALT_CRUDO_PIEZA ADD       CONSTRAINT ALT_CRUDO_PIEZA_PK PRIMARY KEY (ALT_PIEZA_INTELIGENCIA_id, ALT_CRUDO_id);

CREATE TABLE ALT_HIST_CARGO (
    fecha_inicio NOT NULL,
    fecha_fin,
    cargo NOT NULL,
    id_personal,
    id_estacion 
);

COMMENT ON COLUMN ALT_HIST_CARGO.cargo IS 'analista
agente' ;

ALTER TABLE ALT_HIST_CARGO ADD       CONSTRAINT ALT_HIST_CARGO_PK PRIMARY KEY (fecha_inicio);

CREATE TABLE ALT_PIEZA_INTELIGENCIA (
    ALT_HIST_CARGO_fecha_inicio NOT NULL,
    id NOT NULL 
);

ALTER TABLE ALT_PIEZA_INTELIGENCIA ADD       CONSTRAINT ALT_PIEZA_INTELIGENCIA_PK PRIMARY KEY (id);


ALTER TABLE ALT_ADQUISICION 
    ADD       CONSTRAINT ALT_ADQUISICION_ALT_PIEZA_INTELIGENCIA_FK FOREIGN KEY (ALT_PIEZA_INTELIGENCIA_id) REFERENCES ALT_PIEZA_INTELIGENCIA (id);

ALTER TABLE ALT_ANALISTA_CRUDO 
    ADD       CONSTRAINT ALT_ANALISTA_CRUDO_ALT_CRUDO_FK FOREIGN KEY (ALT_CRUDO_id) REFERENCES ALT_CRUDO (id);

ALTER TABLE ALT_ANALISTA_CRUDO 
    ADD       CONSTRAINT ALT_ANALISTA_CRUDO_ALT_HIST_CARGO_FK FOREIGN KEY (ALT_HIST_CARGO_fecha_inicio) REFERENCES ALT_HIST_CARGO (fecha_inicio);

ALTER TABLE ALT_CRUDO 
    ADD       CONSTRAINT ALT_CRUDO_ALT_HIST_CARGO_FK FOREIGN KEY (ALT_HIST_CARGO_fecha_inicio) REFERENCES ALT_HIST_CARGO (fecha_inicio);

ALTER TABLE ALT_CRUDO_PIEZA 
    ADD       CONSTRAINT ALT_CRUDO_PIEZA_ALT_CRUDO_FK FOREIGN KEY (ALT_CRUDO_id) REFERENCES ALT_CRUDO (id);

ALTER TABLE ALT_CRUDO_PIEZA 
    ADD       CONSTRAINT ALT_CRUDO_PIEZA_ALT_PIEZA_INTELIGENCIA_FK FOREIGN KEY (ALT_PIEZA_INTELIGENCIA_id) REFERENCES ALT_PIEZA_INTELIGENCIA (id);

ALTER TABLE ALT_PIEZA_INTELIGENCIA 
    ADD       CONSTRAINT ALT_PIEZA_INTELIGENCIA_ALT_HIST_CARGO_FK FOREIGN KEY (ALT_HIST_CARGO_fecha_inicio) REFERENCES ALT_HIST_CARGO (fecha_inicio);
