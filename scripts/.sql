

-- DIR EJECUTIVO 

CALL CREAR(


-/ VER_LUGAR (id_lugar in integer) RETURNS LUGAR
-/ VER_LUGARES () RETURNS setof LUGAR

-/ VER_OFICINA (id_oficina in integer) RETURNS OFICINA_PRINCIPAL
-/ VER_OFICINAS () RETURNS setof OFICINA_PRINCIPAL


-/ CREAR_DIRECTOR_AREA (primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)
-/ ELIMINAR_DIRECTOR_AREA (id_director_area IN INTEGER)
-/ ACTUALIZAR_DIRECTOR_AREA (id_director_area IN integer, primer_nombre_va IN EMPLEADO_JEFE.primer_nombre%TYPE, segundo_nombre_va IN EMPLEADO_JEFE.segundo_nombre%TYPE, primer_apellido_va IN EMPLEADO_JEFE.primer_apellido%TYPE, segundo_apellido_va IN EMPLEADO_JEFE.segundo_apellido%TYPE, telefono_va IN EMPLEADO_JEFE.telefono%TYPE, id_jefe IN EMPLEADO_JEFE.fk_empleado_jefe%TYPE)

-/ CREAR_OFICINA_PRINCIPAL (nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)
-/ ELIMINAR_OFICINA_PRINCIPAL (id_oficina IN INTEGER)
-/ ACTUALIZAR_OFICINA_PRINCIPAL (id_oficina IN integer, nombre_va IN OFICINA_PRINCIPAL.nombre%TYPE, sede_va IN OFICINA_PRINCIPAL.sede%TYPE, id_ciudad IN OFICINA_PRINCIPAL.fk_lugar_ciudad%TYPE, id_director_area IN OFICINA_PRINCIPAL.fk_director_area%TYPE, id_director_ejecutivo IN OFICINA_PRINCIPAL.fk_director_ejecutivo%TYPE)




SELECT * FROM VER_LUGARES();

CALL CREAR_DIRECTOR_AREA('nombre1','nombre2','apellido1','apellido2',CREAR_TELEFONO(0212,2847213), 5);
SELECT * FROM VER_DIRECTORES_AREA ();


CALL ACTUALIZAR_DIRECTOR_AREA (39,'nombre1_Z','nombre2_Z','apellido1','apellido2',CREAR_TELEFONO(0214,2847213), 1);
SELECT * FROM VER_DIRECTOR_AREA (39);

-- FALTA PROCEDIMIENTOS PARA MODIFICAR EL TELEFONO SIN ACTUALIZAR TODO LO DEMAS 


CALL CREAR_OFICINA_PRINCIPAL('oficina_prueba',false,30,39,null);
SELECT * FROM VER_OFICINAS();

CALL ACTUALIZAR_OFICINA_PRINCIPAL(11,'oficina_prueba_z', false, 30, 39, null);
SELECT * FROM VER_OFICINA(11);




