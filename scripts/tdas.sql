DROP TYPE nivel_educativo_ty CASCADE;
DROP TYPE alias_ty CASCADE;
DROP TYPE identificacion_ty CASCADE;
DROP TYPE licencia_ty CASCADE;
DROP TYPE telefono_ty CASCADE;
DROP TYPE familiar_ty CASCADE;
DROP TYPE contacto_ty CASCADE;


CREATE TYPE nivel_educativo_ty as (

    pregrado_titulo varchar(50),
    postgrado_tipo varchar(50),
    postgrado_titulo varchar(50)
);

CREATE TYPE alias_ty as (

    primer_nombre varchar(50),
    segundo_nombre varchar(50),
    primer_apellido varchar(50),
    segundo_apellido varchar(50),
    foto bytea,
    fecha_nacimiento timestamp,
    pais varchar(50),
    documento_identidad numeric(10),    
    color_ojos varchar(50),
    direccion varchar(255),
    ultimo_uso timestamp
);


CREATE TYPE identificacion_ty as (

	documento_identidad varchar(50),
	pais varchar(50)
);

CREATE TYPE licencia_ty as (

	numero varchar(50),
	pais varchar(50)
);

CREATE TYPE telefono_ty as (

	codigo numeric(10),
	numero numeric(15)
);

CREATE TYPE familiar_ty as (

    primer_nombre varchar(50),
    segundo_nombre varchar(50),
    primer_apellido varchar(50),
    segundo_apellido varchar(50),
    fecha_nacimiento timestamp,
    parentesco varchar(50),
    telefono telefono_ty
);

CREATE TYPE contacto_ty as (

    primer_nombre varchar(50),
	segundo_nombre varchar(50),
	primer_apellido varchar(50),
	segundo_apellido varchar(50),	
    direccion varchar(255),

    telefono telefono_ty
);