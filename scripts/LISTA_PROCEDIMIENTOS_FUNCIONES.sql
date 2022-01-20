CALL actualizar_cliente(:id_cliente,:nombre_empresa_va,:pagina_web_va,:exclusivo_va,:telefono_va,:contacto_va,:id_lugar);

CALL actualizar_director_area(:id_director_area,:primer_nombre_va,:segundo_nombre_va,:primer_apellido_va,:segundo_apellido_va,:telefono_va,:id_jefe);

CALL actualizar_director_ejecutivo(:id_director_ejecutivo,:primer_nombre_va,:segundo_nombre_va,:primer_apellido_va,:segundo_apellido_va,:telefono_va);

CALL actualizar_estacion(:id_empleado_acceso,:nombre_va,:id_ciudad,:id_jefe_estacion);

CALL actualizar_jefe_estacion(:id_empleado_acceso,:id_jefe_estacion,:primer_nombre_va,:segundo_nombre_va,:primer_apellido_va,:segundo_apellido_va,:telefono_va);

CALL actualizar_lugar(:id_lugar,:nombre_va,:tipo_va,:region_va,:id_lugar_sup);

CALL actualizar_oficina_principal(:id_oficina,:nombre_va,:sede_va,:id_ciudad,:id_director_area,:id_director_ejecutivo);

CALL actualizar_personal_inteligencia(:id_empleado_acceso,:id_personal_inteligencia,:primer_nombre_va,:segundo_nombre_va,:primer_apellido_va,:segundo_apellido_va,:fecha_nacimiento_va,:altura_cm_va,:peso_kg_va,:color_ojos_va,:vision_va,:class_seguridad_va,:fotografia_va,:huella_retina_va,:huella_digital_va,:telefono_va,:licencia_manejo_va,:idiomas_va,:familiar_1_va,:familiar_2_va,:identificacion_1_va,:nivel_educativo_1_va,:id_ciudad);

CALL agregar_crudo_a_pieza(:id_crudo,:id_pieza);

SELECT analista_puede_verifica_crudo(:id_crudo,:id_analista);

SELECT analista_verifico_crudo(:id_crudo,:id_analista);

CALL asignacion_presupuesto(:id_empleado_acceso,:estacion_va,:presupuesto_va);

CALL asignar_tema_analista(:id_empleado_acceso,:tema_id,:analista_id);

CALL asignar_tema_cliente(:tema_id,:cliente_id);

CALL asignar_transferir_estacion_empleado(:id_empleado_acceso,:id_personal_inteligencia,:id_estacion,:cargo_va);

SELECT balance_general_anual(:estacion);

SELECT balance_general_anual_parte2(:estacion);

SELECT balance_general_trimestral(:estacion);

SELECT balance_general_trimestral_parte2(:estacion);

CALL cambiar_rol_empleado(:id_empleado,:id_jefe,:cargo);

CALL cambiar_rol_personal_inteligencia(:id_empleado_acceso,:id_personal_inteligencia,:cargo_va);

CALL cerrar_crudo(:id_crudo);

CALL cerrar_hist_cargo(:id_empleado_acceso,:id_personal_inteligencia);

CALL certificar_pieza(:id_pieza,:precio_base_va);

SELECT crear_alias(:primer_nombre,:segundo_nombre,:primer_apellido,:segundo_apellido,:foto,:fecha,:pais,:documento,:color_ojos,:direccion,:ultimo_uso);

SELECT crear_array_idiomas(:idioma_1,:idioma_2,:idioma_3,:idioma_4,:idioma_5,:idioma_6);

CALL crear_cliente(:nombre_empresa_va,:pagina_web_va,:exclusivo_va,:telefono_va,:contacto_va,:fk_lugar_pais);

SELECT crear_contacto(:primer_nombre,:segundo_nombre,:primer_apellido,:segundo_apellido,:direccion,:codigo,:numero);

CALL crear_director_area(:primer_nombre_va,:segundo_nombre_va,:primer_apellido_va,:segundo_apellido_va,:telefono_va,:id_jefe);

CALL crear_director_ejecutivo(:primer_nombre_va,:segundo_nombre_va,:primer_apellido_va,:segundo_apellido_va,:telefono_va);

CALL crear_estacion(:id_empleado_acceso,:nombre_va,:id_ciudad,:id_jefe_estacion);

SELECT crear_familiar(:primer_nombre,:segundo_nombre,:primer_apellido,:segundo_apellido,:fecha_nacimiento,:parentesco,:codigo,:numero);

SELECT crear_identificacion(:documento,:pais);

CALL crear_jefe_estacion(:id_empleado_acceso,:primer_nombre_va,:segundo_nombre_va,:primer_apellido_va,:segundo_apellido_va,:telefono_va);

SELECT crear_licencia(:numero,:pais);

CALL crear_lugar(:nombre_va,:tipo_va,:region_va,:id_lugar_sup);

SELECT crear_nivel_educativo(:pregrado_titulo,:postgrado_tipo,:postgrado_titulo);

CALL crear_oficina_principal(:nombre_va,:sede_va,:id_ciudad,:id_director_area,:id_director_ejecutivo);

CALL crear_personal_inteligencia(:primer_nombre_va,:segundo_nombre_va,:primer_apellido_va,:segundo_apellido_va,:fecha_nacimiento_va,:altura_cm_va,:peso_kg_va,:color_ojos_va,:vision_va,:class_seguridad_va,:fotografia_va,:huella_retina_va,:huella_digital_va,:telefono_va,:licencia_manejo_va,:idiomas_va,:familiar_1_va,:familiar_2_va,:identificacion_1_va,:nivel_educativo_1_va,:id_ciudad);

SELECT crear_telefono(:codigo,:numero);

CALL crear_tema(:nombre_va,:descripcion_va,:topico_va);

CALL despido_renuncia_personal_inteligencia(:id_empleado_acceso,:id_personal_inteligencia);

CALL eliminacion_registros_informante(:id_personal_inteligencia);

CALL eliminacion_registros_venta_exclusiva(:id_pieza);

CALL eliminar_cliente(:id_cliente);

CALL eliminar_director_area(:id_director_area);

CALL eliminar_director_ejecutivo(:id_director_ejecutivo);

CALL eliminar_estacion(:id_empleado_acceso,:id_estacion);

CALL eliminar_jefe_estacion(:id_empleado_acceso,:id_jefe_estacion);

CALL eliminar_lugar(:id_lugar);

CALL eliminar_oficina_principal(:id_oficina);

CALL eliminar_personal_inteligencia(:id_empleado_acceso,:id_personal_inteligencia);

SELECT fondos_all_y_aporte_estacion(:estacion);

SELECT formato_archivo_a_bytea(:ruta_archivo);

SELECT fu_obtener_edad(:pd_fecha_ini,:pd_fecha_fin);

SELECT funcion_edad(:fecha_nacimiento);

SELECT informacion_informantes(:informante);

SELECT intentos_no_autorizados(:estacion);

SELECT lista_informantes(:agente);

CALL procedimiento_copia_informante(:id_informante);

CALL registro_crudo_con_informante(:id_informante,:monto_pago_va,:id_agente_campo,:id_tema,:contenido_va,:tipo_contenido_va,:resumen_va,:valor_apreciacion_va,:nivel_confiabilidad_inicial_va,:cant_analistas_verifican_va);

CALL registro_crudo_sin_informante(:id_agente_campo,:id_tema,:contenido_va,:tipo_contenido_va,:resumen_va,:fuente_va,:valor_apreciacion_va,:nivel_confiabilidad_inicial_va,:cant_analistas_verifican_va);

CALL registro_informante(:nombre_clave_va,:id_agente_campo,:id_empleado_jefe_confidente,:id_personal_inteligencia_confidente);

CALL registro_venta(:id_pieza,:id_cliente,:precio_vendido_va);

CALL registro_verificacion_pieza_inteligencia(:id_analista_encargado,:descripcion,:id_crudo_base);

SELECT resta_14_fecha(:fecha);

SELECT resta_14_fecha_hora(:fecha);

SELECT resta_1_year(:fecha);

SELECT resta_1_year_date(:fecha);

SELECT resta_3_meses(:fecha);

SELECT resta_3_meses_date(:fecha);

SELECT resta_6_meses(:fecha);

SELECT resta_7_dias(:fecha);

SELECT sumar_pago_informantes(:estacion);

SELECT sumar_pago_informantes_alt(:estacion);

SELECT sumar_pago_informantes_alt_trimestral(:estacion);

SELECT sumar_pago_informantes_trimestral(:estacion);

SELECT sumar_piezas(:estacion);

SELECT sumar_piezas_alt(:estacion);

SELECT sumar_piezas_alt_trimestral(:estacion);

SELECT sumar_piezas_trimestral(:estacion);

SELECT sumar_presupuesto(:estacion);

SELECT sumar_presupuesto_trimestral(:estacion);

SELECT trigger_clas_tema();

SELECT trigger_cliente();

SELECT trigger_copia_adquisicion();

SELECT trigger_copia_analista_crudo();

SELECT trigger_copia_crudo();

SELECT trigger_copia_crudo_pieza();

SELECT trigger_copia_info_pieza();

SELECT trigger_copia_informante();

SELECT trigger_copiar_transaccion_pago();

SELECT trigger_empleado_jefe();

SELECT trigger_function_verif_jerarquia_lugar();

SELECT trigger_insert_update_crudo_pieza();

SELECT trigger_insert_update_informante();

SELECT trigger_oficina_principal();

SELECT trigger_personal_inteligencia();

SELECT trigger_registro_temas_cliente_adquisicion();

SELECT trigger_update_insert_crudo();

SELECT trigger_update_pieza();

CALL validar_acesso_dir_area_estacion(:id_empleado_acceso,:id_estacion);

CALL validar_acesso_dir_area_jefe_estacion(:id_empleado_acceso,:id_jefe_estacion);

CALL validar_acesso_empleado_estacion(:id_empleado_acceso,:id_estacion);

CALL validar_acesso_empleado_personal_inteligencia(:id_empleado_acceso,:id_personal_inteligencia);

CALL validar_arco_exclusivo();

SELECT validar_cant_analistas_verifican_crudo(:id_crudo);

CALL validar_exit_tema(:id_tema);

CALL validar_jerarquia_empleado_jefe(:id_empleado_sup,:tipo_va);

CALL validar_tipo_empleado_jefe(:id_empleado,:tipo_va);

CALL validar_tipo_lugar(:id_lugar,:tipo_va);

SELECT validar_venta_exclusiva(:id_pieza);

SELECT ver_cliente(:id_cliente);

SELECT ver_clientes();

SELECT ver_cuenta_estacion_dir_area(:id_empleado_acceso,:id_estacion);

SELECT ver_cuenta_estacion_jefe_estacion(:id_empleado_acceso,:id_estacion);

SELECT ver_datos_pieza(:id_pieza,:id_personal_inteligencia);

SELECT ver_director_area(:id_director_area);

SELECT ver_director_ejecutivo(:id_director_ejecutivo);

SELECT ver_directores_area();

SELECT ver_directores_ejecutivos();

SELECT ver_estacion(:id_empleado_acceso,:id_estacion);

SELECT ver_estaciones(:id_empleado_acceso);

SELECT ver_historico_cargo_personal_inteligencia(:id_empleado_acceso,:id_personal_inteligencia);

SELECT ver_jefe_e(:id_empleado_acceso,:id_jefe);

SELECT ver_jefes_e(:id_empleado_acceso);

SELECT ver_lista_informantes_empleado_confidente(:id_empleado_acceso);

SELECT ver_lista_informantes_personal_inteligencia_agente(:id_personal_inteligencia);

SELECT ver_lista_informantes_personal_inteligencia_confidente(:id_personal_inteligencia);

SELECT ver_lugar(:id_lugar);

SELECT ver_lugares();

SELECT ver_oficina(:id_oficina);

SELECT ver_oficinas();

SELECT ver_personal_inteligencia_con_cargo(:id_empleado_acceso,:id_personal_inteligencia);

SELECT ver_personal_inteligencia_sin_cargo(:id_personal_inteligencia);

SELECT ver_presupuesto_estacion(:id_empleado_acceso,:id_estacion);

SELECT ver_todos_personal_inteligencia_con_cargo(:id_empleado_acceso);

SELECT ver_todos_personal_inteligencia_sin_cargo();

CALL verificar_crudo(:id_analista,:id_crudo,:nivel_confiabilidad_va);

