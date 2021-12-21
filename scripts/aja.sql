-- FALTAN LAS ULTIMAS TABLAS ALT


DROP TABLE LUGAR CASCADE;
DROP TABLE CLIENTE CASCADE;
DROP TABLE EMPLEADO_JEFE CASCADE;
DROP TABLE OFICINA_PRINCIPAL CASCADE;
DROP TABLE ESTACION CASCADE;
DROP TABLE CUENTA CASCADE;
DROP TABLE PERSONAL_INTELIGENCIA CASCADE;
DROP TABLE INTENTO_NO_AUTORIZADO CASCADE;
DROP TABLE CLAS_TEMA CASCADE;
DROP TABLE AREA_INTERES CASCADE;
DROP TABLE TEMAS_ESP CASCADE;
DROP TABLE HIST_CARGO CASCADE;
DROP TABLE INFORMANTE CASCADE;
DROP TABLE TRANSACCION_PAGO CASCADE;
DROP TABLE CRUDO CASCADE;
DROP TABLE ANALISTA_CRUDO CASCADE;
DROP TABLE PIEZA_INTELIGENCIA CASCADE;
DROP TABLE CRUDO_PIEZA CASCADE;
DROP TABLE ADQUISICION CASCADE;


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

    CONSTRAINT CUENTA_PK PRIMARY KEY (año, fk_estacion, fk_oficina_principal),
    CONSTRAINT CUENTA_ESTACION_FK FOREIGN KEY (fk_estacion, fk_oficina_principal) REFERENCES ESTACION (id, fk_oficina_principal)
);

CREATE TABLE PERSONAL_INTELIGENCIA (

    id serial NOT NULL,

    primer_nombre varchar(50) NOT NULL,
    segundo_nombre varchar(50) ,
    primer_apellido varchar(50) NOT NULL,
    segundo_apellido varchar(50) NOT NULL,
    fecha_nacimiento datetime NOT NULL,
    altura_cm numeric(5) NOT NULL,
    peso_kg numeric(5) NOT NULL,
    color_ojos varchar(20) NOT NULL,
    vision varchar(20) NOT NULL,
    class_seguridad varchar(50) NOT NULL,


    --LOBS
    fotografia bytea NOT NULL,
    huella_retina bytea NOT NULL,
    huella_digital bytea NOT NULL,
       
    --TDAs
    telefono telefono_ty NOT NULL,
    licencia_manejo licencia_ty,
    
    --varray
    idiomas varchar(50)[6] NOT NULL,
    familiares familiar_ty[2] NOT NULL,
    identificaciones identificacion_ty[5] NOT NULL,
    
    --nested tables
    nivel_educativo nivel_educativo_ty[] NOT NULL,
    aliases aliases_ty[],
    
    --foreign keys 
    fk_estacion integer NOT NULL,
    fk_oficina_principal integer NOT NULL,
    fk_lugar_ciudad NOT NULL,


    CONSTRAINT PERSONAL_INTELIGENCIA_PK PRIMARY KEY (id),

    CONSTRAINT PERSONAL_INTELIGENCIA_ESTACION_FK FOREIGN KEY (fk_estacion, fk_oficina_principal ) REFERENCES ESTACION (id, fk_oficina_principal),
    CONSTRAINT PERSONAL_INTELIGENCIA_LUGAR_FK FOREIGN KEY (fk_lugar_ciudad) REFERENCES LUGAR (id),

    CONSTRAINT PERSONAL_INTELIGENCIA_CH_class_seguridad CHECK ( class_seguridad IN ('top_secret', 'confidencial', 'no_clasificado') )
    
);


CREATE TABLE INTENTO_NO_AUTORIZADO (

    id serial NOT NULL,

    fecha_hora datetime NOT NULL,
    
    id_pieza integer NOT NULL,
    id_empleado integer NOT NULL,
    
    fk_personal_inteligencia integer NOT NULL ,

    CONSTRAINT INTENTO_NO_AUTORIZADO_PK PRIMARY KEY (id, fk_personal_inteligencia),
    CONSTRAINT INTENTO_NO_AUTORIZADO_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES PERSONAL_INTELIGENCIA (id)
);


CREATE TABLE CLAS_TEMA (

    id serial NOT NULL,

    nombre varchar(255) NOT NULL,
    descripcion varchar(500) NOT NULL,
    topico varchar(50) NOT NULL, -- 'paises, individuos, eventos, empresas' 

    CONSTRAINT CLAS_TEMA_PK PRIMARY KEY (id),

    CONSTRAINT CLAS_TEMA_CH_topico CHECK ( topico IN ('paises', 'individuos', 'eventos', 'empresas') )    
);

CREATE TABLE AREA_INTERES (

    fk_clas_tema integer NOT NULL,
    fk_cliente integer NOT NULL,

    CONSTRAINT AREA_INTERES_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),
    CONSTRAINT AREA_INTERES_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES CLIENTE (id),
    CONSTRAINT AREA_INTERES_PK PRIMARY KEY (fk_clas_tema, fk_cliente)
);

CREATE TABLE TEMAS_ESP (

    fk_personal_inteligencia integer NOT NULL,
    fk_clas_tema integer NOT NULL,

    CONSTRAINT TEMAS_ESP_PK PRIMARY KEY (fk_personal_inteligencia, fk_clas_tema),

    CONSTRAINT TEMAS_ESP_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),
    CONSTRAINT TEMAS_ESP_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES PERSONAL_INTELIGENCIA (id)
);

CREATE TABLE HIST_CARGO (
    
    fecha_inicio datetime NOT NULL,
    fecha_fin datetime,
    cargo varchar(20) NOT NULL, -- 'analista agente'
    fk_personal_inteligencia integer NOT NULL,
    fk_estacion integer NOT NULL,
    fk_oficina_principal NOT NULL,

    CONSTRAINT HIST_CARGO_PK PRIMARY KEY (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT HIST_CARGO_ESTACION_FK FOREIGN KEY (fk_estacion, fk_oficina_principal) REFERENCES ESTACION (id, fk_oficina_principal),
    CONSTRAINT HIST_CARGO_PERSONAL_INTELIGENCIA_FK FOREIGN KEY (fk_personal_inteligencia) REFERENCES PERSONAL_INTELIGENCIA (id),

    CONSTRAINT HIST_CARGO_CH_cargo CHECK ( cargo IN ('analista', 'agente') )    
);


CREATE TABLE INFORMANTE (

    id serial NOT NULL,

    nombre_clave varchar(100) unique NOT NULL,
    

    -- agente de campo encargado del informante
    fk_personal_inteligencia_encargado integer NOT NULL,    
    fk_fecha_inicio_encargado datetime NOT NULL,
    fk_estacion_encargado integer NOT NULL,
    fk_oficina_principal_encargado integer NOT NULL,


    -- personal_inteligencia o empleado confidente. Con arco 
    fk_empleado_jefe_confidente integer,
    
    fk_personal_inteligencia_confidente integer,
    fk_fecha_inicio_confidente datetime,
    fk_estacion_confidente integer,
    fk_oficina_principal_confidente integer,

    
    CONSTRAINT INFORMANTE_PK PRIMARY KEY (id),

    CONSTRAINT AR_confidente CHECK ( 
        ((fk_fecha_inicio_confidente IS NOT NULL) AND (fk_personal_inteligencia_confidente IS NOT NULL) AND (fk_estacion_confidente IS NOT NULL) AND 
        (fk_oficina_principal_confidente IS NOT NULL) AND (fk_empleado_jefe_confidente IS NULL)) 
        
        OR 
       
        ((fk_empleado_jefe_confidente IS NOT NULL) AND (fk_fecha_inicio_confidente IS NULL) AND (fk_personal_inteligencia_confidente IS NULL) AND (fk_estacion_confidente IS NULL) AND 
        (fk_oficina_principal_confidente IS NULL))  
    ),

    CONSTRAINT INFORMANTE_fk_empleado_jefe FOREIGN KEY (fk_empleado_jefe_confidente) REFERENCES EMPLEADO_JEFE (id),
    CONSTRAINT INFORMANTE_HIST_CARGO_encargado FOREIGN KEY (fk_fecha_inicio_encargado, fk_personal_inteligencia_encargado, fk_estacion_encargado, fk_oficina_principal_encargado) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),
    CONSTRAINT INFORMANTE_HIST_CARGO_confidente FOREIGN KEY (fk_fecha_inicio_confidente, fk_personal_inteligencia_confidente, fk_estacion_confidente, fk_oficina_principal_confidente) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal)

);

CREATE TABLE TRANSACCION_PAGO (

    id serial NOT NULL,

    fecha_hora datetime NOT NULL,
    monto_pago numeric(20) NOT NULL,
    
    fk_crudo integer,
    fk_informante integer NOT NULL,

    CONSTRAINT TRANSACCION_PAGO_PK PRIMARY KEY (id, fk_informante),
    CONSTRAINT TRANSACCION_PAGO_CRUDO_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO (id),
    CONSTRAINT TRANSACCION_PAGO_INFORMANTE_FK FOREIGN KEY (fk_informante) REFERENCES INFORMANTE (id)
);

CREATE TABLE CRUDO (

    id serial NOT NULL,

    contenido bytea NOT NULL, -- 'text, imagen, sonido, video' 
    tipo_contenido varchar(20) NOT NULL,
    resumen varchar(1000) NOT NULL,
    fuente varchar(20) NOT NULL, -- 'abierta, secreta, tecnica'
    valor_apreciacion numeric(20),
    nivel_confiabilidad_inicial datetime NOT NULL,
    nivel_confiabilidad_final datetime,
    fecha_obtencion datetime NOT NULL,
    fecha_verificacion_final datetime,
    cant_analistas_verifican numeric(5) NOT NULL,

    fk_clas_tema integer NOT NULL,
    fk_informante integer,

    --estacion a donde pertence
    fk_estacion_pertenece integer NOT NULL,
    fk_oficina_principal_pertenece integer NOT NULL,

    --agente encargado
    fk_estacion_agente integer NOT NULL,
    fk_oficina_principal_agente integer NOT NULL,
    fk_fecha_inicio_agente datetime NOT NULL,
    fk_personal_inteligencia_agente integer NOT NULL,

    CONSTRAINT CRUDO_PK PRIMARY KEY (id),

    CONSTRAINT CRUDO_ESTACION_FK FOREIGN KEY (fk_estacion_pertenece, fk_oficina_principal_pertenece) REFERENCES ESTACION (id, fk_oficina_principal),

    CONSTRAINT CRUDO_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_agente, fk_personal_inteligencia_agente, fk_estacion_agente, fk_oficina_principal_agente) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT CRUDO_INFORMANTE_FK FOREIGN KEY (fk_informante) REFERENCES INFORMANTE (id),
    CONSTRAINT CRUDO_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),

    CONSTRAINT CRUDO_CH_tipo_contenido CHECK ( tipo_contenido IN ('texto', 'imagen', 'sonido', 'video') ),
    CONSTRAINT CRUDO_CH_fuente CHECK ( fuente IN ('abierta', 'secreta', 'tecnica') )    

);

CREATE TABLE ANALISTA_CRUDO (

    id serial NOT NULL,

    fecha_hora datetime NOT NULL,
    nivel_confiabilidad numeric(5) NOT NULL,

    fk_crudo integer NOT NULL,

    -- fks de hist_cargo
    fk_fecha_inicio_analista datetime NOT NULL,
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_estacion_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL ,

    CONSTRAINT ANALISTA_CRUDO_PK PRIMARY KEY (id, fk_crudo, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista),

    CONSTRAINT ANALISTA_CRUDO_CRUDO_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO (id),
    CONSTRAINT ANALISTA_CRUDO_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal),

    CONSTRAINT ANALISTA_CRUDO_CH_nivel_confiabilidad CHECK ( nivel_confiabilidad >= 0 AND nivel_confiabilidad <= 100 )    

);


CREATE TABLE PIEZA_INTELIGENCIA (

    id serial NOT NULL,

    fecha_creacion datetime,
    nivel_confiabilidad numeric(5), 
    precio_base numeric(20),
    class_seguridad varchar(50) NOT NULL,
    
    --fks hist_cargo
    fk_fecha_inicio_analista datetime NOT NULL,
    fk_personal_inteligencia_analista integer NOT NULL,
    fk_estacion_analista integer NOT NULL,
    fk_oficina_principal_analista integer NOT NULL,

    fk_clas_tema integer NOT NULL,

    CONSTRAINT PIEZA_INTELIGENCIA_PK PRIMARY KEY (id),
    
    CONSTRAINT PIEZA_INTELIGENCIA_HIST_CARGO_FK FOREIGN KEY (fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion, fk_oficina_principal) REFERENCES HIST_CARGO (fecha_inicio, fk_personal_inteligencia, fk_estacion, fk_oficina_principal)

    CONSTRAINT PIEZA_INTELIGENCIA_CLAS_TEMA_FK FOREIGN KEY (fk_clas_tema) REFERENCES CLAS_TEMA (id),
    
    CONSTRAINT PIEZA_INTELIGENCIA_CH_class_seguridad CHECK ( class_seguridad IN ('top_secret', 'confidencial', 'no_clasificado') ),
    CONSTRAINT PIEZA_INTELIGENCIA_CH_nivel_confiabilidad CHECK ( nivel_confiabilidad >= 0 AND nivel_confiabilidad <= 100 )    
);


CREATE TABLE CRUDO_PIEZA (
    fk_pieza_inteligencia integer NOT NULL,
    fk_crudo integer NOT NULL,

    CONSTRAINT CRUDO_PIEZA_PK PRIMARY KEY (fk_pieza_inteligencia, fk_crudo),
    CONSTRAINT CRUDO_PIEZA_PIEZA_INTELIGENCIA_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES PIEZA_INTELIGENCIA (id),
    CONSTRAINT CRUDO_PIEZA_CRUDO_FK FOREIGN KEY (fk_crudo) REFERENCES CRUDO (id)
);



CREATE TABLE ADQUISICION (

    id serial NOT NULL,

    fecha_hora_venta datetime NOT NULL,
    precio_vendido numeric(20) NOT NULL,

    fk_cliente integer NOT NULL,
    fk_pieza_inteligencia integer NOT NULL,
    
    CONSTRAINT ADQUISICION_PK PRIMARY KEY (id, fk_cliente, fk_pieza_inteligencia),

    CONSTRAINT ADQUISICION_CLIENTE_FK FOREIGN KEY (fk_cliente) REFERENCES CLIENTE (id),
    CONSTRAINT ADQUISICION_PIEZA_INTELIGENCIA_FK FOREIGN KEY (fk_pieza_inteligencia) REFERENCES PIEZA_INTELIGENCIA (id)
);








































































----------------------------------------





CREATE TABLE ALT_ADQUISICION (

    id serial NOT NULL,

    fecha_venta NOT NULL,
    precio_vendido NOT NULL,
    id_cliente NOT NULL,
    ALT_fk_pieza_inteligencia NOT NULL 
);

ALTER TABLE ALT_ADQUISICION ADD       CONSTRAINT ALT_ADQUISICION_PK PRIMARY KEY (ALT_fk_pieza_inteligencia, id);

CREATE TABLE ALT_ANALISTA_CRUDO (

    id serial NOT NULL,

    fecha NOT NULL,
    nivel_confiabilidad NOT NULL,
    ALT_HIST_CARGO_fecha_inicio NOT NULL,
    ALT_ fk_crudo NOT NULL 
);

ALTER TABLE ALT_ANALISTA_CRUDO ADD       CONSTRAINT ALT_ANALISTA_CRUDO_PK PRIMARY KEY (id, ALT_HIST_CARGO_fecha_inicio, ALT_ fk_crudo);

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
    ALT_fk_pieza_inteligencia integer NOT NULL,
    ALT_ fk_crudo NOT NULL 
);

ALTER TABLE ALT_CRUDO_PIEZA ADD       CONSTRAINT ALT_CRUDO_PIEZA_PK PRIMARY KEY (ALT_fk_pieza_inteligencia, ALT_ fk_crudo);

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
    ADD       CONSTRAINT ALT_ADQUISICION_ALT_PIEZA_INTELIGENCIA_FK FOREIGN KEY (ALT_fk_pieza_inteligencia) REFERENCES ALT_PIEZA_INTELIGENCIA (id);

ALTER TABLE ALT_ANALISTA_CRUDO 
    ADD       CONSTRAINT ALT_ANALISTA_CRUDO_ALT_CRUDO_FK FOREIGN KEY (ALT_ fk_crudo) REFERENCES ALT_CRUDO (id);

ALTER TABLE ALT_ANALISTA_CRUDO 
    ADD       CONSTRAINT ALT_ANALISTA_CRUDO_ALT_HIST_CARGO_FK FOREIGN KEY (ALT_HIST_CARGO_fecha_inicio) REFERENCES ALT_HIST_CARGO (fecha_inicio);

ALTER TABLE ALT_CRUDO 
    ADD       CONSTRAINT ALT_CRUDO_ALT_HIST_CARGO_FK FOREIGN KEY (ALT_HIST_CARGO_fecha_inicio) REFERENCES ALT_HIST_CARGO (fecha_inicio);

ALTER TABLE ALT_CRUDO_PIEZA 
    ADD       CONSTRAINT ALT_CRUDO_PIEZA_ALT_CRUDO_FK FOREIGN KEY (ALT_ fk_crudo) REFERENCES ALT_CRUDO (id);

ALTER TABLE ALT_CRUDO_PIEZA 
    ADD       CONSTRAINT ALT_CRUDO_PIEZA_ALT_PIEZA_INTELIGENCIA_FK FOREIGN KEY (ALT_fk_pieza_inteligencia) REFERENCES ALT_PIEZA_INTELIGENCIA (id);

ALTER TABLE ALT_PIEZA_INTELIGENCIA 
    ADD       CONSTRAINT ALT_PIEZA_INTELIGENCIA_ALT_HIST_CARGO_FK FOREIGN KEY (ALT_HIST_CARGO_fecha_inicio) REFERENCES ALT_HIST_CARGO (fecha_inicio);
