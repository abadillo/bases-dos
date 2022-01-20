

--agente_est_amsterdam PASSWORD 'agente_est_amsterdam_aii'   -- id estacion = 4   -- id_personal = 16
--agente_est_roterdam PASSWORD 'agente_est_roterdam_aii'     -- id estacion = 5
--agente_est_haarlam PASSWORD 'agente_est_haarlam_aii'	     -- id estacion = 6


select current_user;

4. Demostración de la implementación de los requerimientos del
sistema de bases de datos transaccional referidos al proceso de
venta de piezas de inteligencia – construcción de piezas de
inteligencia y venta a clientes, incluyendo la seguridad
correspondiente (roles, cuentas con privilegios para poder ejecutar
los programas y reportes).


-- usuarios

--/ CALL registro_informante(:nombre_clave_va, :id_agente_campo, :id_empleado_jefe_confidente, :id_personal_inteligencia_confidente) 
CALL registro_informante('informante_prueba', 16, 15, null);

--/ call ver_lista_informantes_personal_inteligencia_agente(:id_personal_inteligencia) 
SELECT * FROM  ver_lista_informantes_personal_inteligencia_agente(16) ;

--SELECT * FROM  ver_lista_informantes_empleado_confidente(15) ;


INSERT INTO clas_tema (nombre, descripcion , topico ) VALUES ('nombre_tema', 'descripcion_tema','paises');



-- / SECURITY DEFINER



