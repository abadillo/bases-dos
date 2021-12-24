TRUNCATE TABLE LUGAR RESTART IDENTITY CASCADE;
TRUNCATE TABLE CLIENTE RESTART IDENTITY CASCADE;
TRUNCATE TABLE EMPLEADO_JEFE RESTART IDENTITY CASCADE;
TRUNCATE TABLE OFICINA_PRINCIPAL RESTART IDENTITY CASCADE;
TRUNCATE TABLE ESTACION RESTART IDENTITY CASCADE;
TRUNCATE TABLE CUENTA RESTART IDENTITY CASCADE;
TRUNCATE TABLE PERSONAL_INTELIGENCIA RESTART IDENTITY CASCADE;
TRUNCATE TABLE INTENTO_NO_AUTORIZADO RESTART IDENTITY CASCADE;
TRUNCATE TABLE CLAS_TEMA RESTART IDENTITY CASCADE;
TRUNCATE TABLE AREA_INTERES RESTART IDENTITY CASCADE;
TRUNCATE TABLE TEMAS_ESP RESTART IDENTITY CASCADE;
TRUNCATE TABLE HIST_CARGO RESTART IDENTITY CASCADE;
TRUNCATE TABLE INFORMANTE RESTART IDENTITY CASCADE;
TRUNCATE TABLE TRANSACCION_PAGO RESTART IDENTITY CASCADE;
TRUNCATE TABLE CRUDO RESTART IDENTITY CASCADE;
TRUNCATE TABLE ANALISTA_CRUDO RESTART IDENTITY CASCADE;
TRUNCATE TABLE PIEZA_INTELIGENCIA RESTART IDENTITY CASCADE;
TRUNCATE TABLE CRUDO_PIEZA RESTART IDENTITY CASCADE;
TRUNCATE TABLE ADQUISICION RESTART IDENTITY CASCADE;

--SELECT nextval('lugar_id_seq');
--select * from lugar;
-- select pg_terminate_backend(pid) from pg_stat_activity where datname='PRUEBAS_GRUPO_9';

      

-------------------------------/////////////////////------------------------------

-- LUGAR

INSERT INTO lugar (nombre, tipo, region, fk_lugar) VALUES
('Irlanda', 'pais','europa', null),
('Holanda', 'pais','europa', null),
('Groenlandia', 'pais','america_norte', null),
('Argentina', 'pais','america_sur', null),
('Taiwán', 'pais','asia', null),
('Malasia', 'pais','asia', null),
('Uganda', 'pais','africa', null),
('Zimbabue', 'pais','africa', null),
('Australia', 'pais','oceania', null),
('Dublin', 'ciudad',null, 1),
('Cork', 'ciudad',null, 1),
('Galway', 'ciudad',null, 1),
('Amsterdam', 'ciudad',null, 2),
('Roterdam', 'ciudad',null, 2),
('Haarlam', 'ciudad',null, 2),
('Nuuk', 'ciudad',null, 3),
('Qaqortoq', 'ciudad',null, 3),
('Sisimiut ', 'ciudad',null, 3),
('Buenos Aires', 'ciudad',null, 4),
('Ciudad de Cordoba', 'ciudad',null, 4),
('Rosario', 'ciudad',null, 4),
('Taipei', 'ciudad',null, 5),
('Tainan', 'ciudad',null, 5),
('Kaohsiung', 'ciudad',null, 5),
('Kuala Lumpur', 'ciudad',null, 6),
('Malaca', 'ciudad',null, 6),
('Pulau Pinang', 'ciudad',null, 6),
('Kampala', 'ciudad',null, 7),
('Entebbe', 'ciudad',null, 7),
('Kasese', 'ciudad',null, 7),
('Harare', 'ciudad',null, 8),
('Bulawayo', 'ciudad',null, 8),
('Chitungwiza', 'ciudad',null, 8),
('Sidney', 'ciudad',null, 9),
('Perth', 'ciudad',null, 9),
('Gold Coast', 'ciudad',null, 9),
('Suiza', 'pais','europa', null),
('Ginebra', 'ciudad',null, 37);



-- EMPLEADO_JEFE

INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo,fk_empleado_jefe) VALUES 
('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_ejecutivo', null),
('Elian', 'Maximo', 'Carter', 'Silva', ROW(412,6699623), 'director_area', 1),
('Fabiano', 'Tarsicio', 'Santamaria', 'Jaquez', ROW(412,3948307), 'director_area', 1),
('Esperanza', 'Ana', 'Corona', 'Granados', ROW(412,1189159), 'director_area', 1),
('Octavia', 'Eduviges', 'Mena', 'Alcantara', ROW(412,3974651), 'director_area', 1),
('Anthony', 'Amilcar', 'Tafoya', 'Buenrostro', ROW(414,1319978), 'director_area', 1),
('Fidel', 'Juan', 'Regalado', 'Machuca', ROW(416,7319514), 'director_area', 1),
('Luna', 'Judith', 'Castrejon', 'Narvaez', ROW(412,6345573), 'director_area', 1),
('Klement', null, 'Montiel', 'Salguero', ROW(414,3977631), 'director_area', 1),
('Daniel', null, 'Price', 'Gallardo', ROW(414,3609837), 'director_area', 1),
('Silvester', null, 'Morris', 'Serrato', ROW(412,5343364), 'jefe', 2),
('Pamela', null, 'Guevara', 'Zapata', ROW(424,2908908), 'jefe', 2),
('Feliciano', 'Jaime', 'Hurtado', 'Baca', ROW(424,2109538), 'jefe', 2),
('Eloisa', 'Petronila', 'Nolasco', 'White', ROW(414,6830298), 'jefe', 3),
('Cayetano', 'Paulo', 'Guillen', 'Miramontes', ROW(412,4866865), 'jefe', 3),
('Constantino', 'Adolfo', 'Bustos', 'Lima', ROW(412,2392031), 'jefe', 3),
('Antonio', 'Tulio', 'Pinto', 'Cordero', ROW(416,3952857), 'jefe', 4),
('Dulcinea', 'Consuelo', 'Pizarro', 'Santiago', ROW(416,7676921), 'jefe', 4),
('Marsello', 'Alan', 'Carpio', 'Thomas', ROW(414,7291221), 'jefe', 4),
('Antonio', 'Diego', 'Recinos', 'Santacruz', ROW(414,4392478), 'jefe', 5),
('Greta', null, 'Valdivia', 'Cruz', ROW(416,1080469), 'jefe', 5),
('Marcela', null, 'Galdamez', 'Rogers', ROW(412,6909353), 'jefe', 5),
('Pamela', 'Veronica', 'Torres', 'Diaz', ROW(414,1416359), 'jefe', 6),
('Cayetano', 'Fulgencio', 'Marquez', 'Infante', ROW(424,9630352), 'jefe', 6),
('Jhoan', 'Dante', 'Lucero', 'Orona', ROW(424,6170815), 'jefe', 6),
('Elidio', 'Jonathan', 'Puentes', 'Ozuna', ROW(416,7058298), 'jefe', 7),
('Gloria', 'Eneida', 'Duque', 'Uribe', ROW(412,4224557), 'jefe', 7),
('Jennifer', 'Valentina', 'Vigil', 'Aviles', ROW(424,9270841), 'jefe', 7),
('Celeste', 'Soledad', 'Chacon', 'Machado', ROW(412,1229016), 'jefe', 8),
('Vivaldo', null, 'Rosas', 'Jackson', ROW(412,5018092), 'jefe', 8),
('Mirella', null, 'Machuca', 'Magallon', ROW(416,3371835), 'jefe', 8),
('Calixtrato', null, 'Quintanilla', 'Estrada', ROW(414,3049959), 'jefe', 9),
('Libertad', 'Eliana', 'Garces', 'Casanova', ROW(414,8123924), 'jefe', 9),
('Emperatriz', 'Myriam', 'Angulo', 'Valdivia', ROW(4148,999846), 'jefe', 9),
('Hugo', 'Adan', 'Serrato', 'Barrios', ROW(416,1450123), 'jefe', 10),
('Rosalia', 'Pilar', 'Valles', 'Montes', ROW(414,1292334), 'jefe', 10),
('Claudio', 'Lincoln', 'Sullivan', 'Tafoya', ROW(412,1948734), 'jefe', 10),
('Nicolas', 'Abelardo', 'Tafoya', 'Peralta', ROW(414,1277631), 'director_area', 1);



-- OFICINA_PRINCIPAL

INSERT INTO oficina_principal (nombre, sede, fk_director_area, fk_director_ejecutivo, fk_lugar_ciudad) VALUES

('Ofi. Dublin', false, 2, null, 10),
('Ofi. Amsterdam', false, 3, null, 13),
('Ofi. Nuuk', false, 4, null, 16),
('Ofi. Buenos Aires', false, 5, null, 19),
('Ofi. Taipei', false, 6, null, 22),
('Ofi. Kuala Lumpur', false, 7, null, 25),
('Ofi. Kampala', false, 8, null, 28),
('Ofi. Harare', false, 9, null, 31),
('Ofi. Sidney', false, 10, null, 34),
('Ofi. Ginebra', true, 38, 1, 38);



--ESTACION
INSERT INTO estacion (nombre, fk_oficina_principal, fk_empleado_jefe, fk_lugar_ciudad) VALUES
('Est. Dublin', 1, 11, 10),
('Est. Cork', 1, 12, 11),
('Est. Galway', 1, 13, 12),
('Est. Amsterdam', 2, 14, 13),
('Est. Roterdam', 2, 15, 14),
('Est. Haarlam', 2, 16, 15),
('Est. Nuuk', 3, 17, 16),
('Est. Qaqortoq', 3, 18, 17),
('Est. Sisimiut ', 3, 19, 18),
('Est. Buenos Aires', 4, 20, 19),
('Est. Ciudad de Cordoba', 4, 21, 20),
('Est. Rosario', 4, 22, 21),
('Est. Taipei', 5, 23, 22),
('Est. Tainan', 5, 24, 23),
('Est. Kaohsiung', 5, 25, 24),
('Est. Kuala Lumpur', 6, 26, 25),
('Est. Malaca', 6, 27, 26),
('Est. Pulau Pinang', 6, 28, 27),
('Est. Kampala', 7, 29, 28),
('Est. Entebbe', 7, 30, 29),
('Est. Kasese', 7, 31, 30),
('Est. Harare', 8, 32, 31),
('Est. Bulawayo', 8, 33, 32),
('Est. Chitungwiza', 8, 34, 33),
('Est. Sidney', 9, 35, 34),
('Est. Perth', 9, 36, 35),
('Est. Gold Coast', 9, 37, 36);


--CUENTA
INSERT INTO cuenta (año, presupuesto, fk_estacion, fk_oficina_principal) VALUES
('2034/01/01',  10000, 1, 1),
('2035/01/01',  10500, 1, 1),
('2036/01/01',  11000, 1, 1),
('2034/01/01',  12000, 2, 1),
('2035/01/01',  13000, 2, 1),
('2036/01/01',  10000, 2, 1),
('2034/01/01',  10500, 3, 1),
('2035/01/01',  11000, 3, 1),
('2036/01/01',  11500, 3, 1),
('2034/01/01',  10000, 4, 2),
('2035/01/01',  10500, 4, 2),
('2036/01/01',  11000, 4, 2),
('2034/01/01',  10000, 5, 2),
('2035/01/01',  10500, 5, 2),
('2036/01/01',  11000, 5, 2),
('2034/01/01',  12000, 6, 2),
('2035/01/01',  13000, 6, 2),
('2036/01/01',  10000, 6, 2),
('2034/01/01',  10500, 7, 3),
('2035/01/01',  11000, 7, 3),
('2036/01/01',  11500, 7, 3),
('2034/01/01',  10000, 8, 3),
('2035/01/01',  10500, 8, 3),
('2036/01/01',  11000, 8, 3),
('2034/01/01',  10000, 9, 3),
('2035/01/01',  10500, 9, 3),
('2036/01/01',  11000, 9, 3),
('2034/01/01',  12000, 10, 4),
('2035/01/01',  13000, 10, 4),
('2036/01/01',  10000, 10, 4),
('2034/01/01',  10500, 11, 4),
('2035/01/01',  11000, 11, 4),
('2036/01/01',  11500, 11, 4),
('2034/01/01',  10000, 12, 4),
('2035/01/01',  10500, 12, 4),
('2036/01/01',  11000, 12, 4),
('2034/01/01',  10000, 13, 5),
('2035/01/01',  10500, 13, 5),
('2036/01/01',  11000, 13, 5),
('2034/01/01',  12000, 14, 5),
('2035/01/01',  13000, 14, 5),
('2036/01/01',  10000, 14, 5),
('2034/01/01',  10500, 15, 5),
('2035/01/01',  11000, 15, 5),
('2036/01/01',  11500, 15, 5),
('2034/01/01',  10000, 16, 6),
('2035/01/01',  10500, 16, 6),
('2036/01/01',  11000, 16, 6),
('2034/01/01',  10000, 17, 6),
('2035/01/01',  10500, 17, 6),
('2036/01/01',  11000, 17, 6),
('2034/01/01',  12000, 18, 6),
('2035/01/01',  13000, 18, 6),
('2036/01/01',  10000, 18, 6),
('2034/01/01',  10500, 19, 7),
('2035/01/01',  11000, 19, 7),
('2036/01/01',  11500, 19, 7),
('2034/01/01',  10000, 20, 7),
('2035/01/01',  10500, 20, 7),
('2036/01/01',  11000, 20, 7),
('2034/01/01',  10000, 21, 7),
('2035/01/01',  10500, 21, 7),
('2036/01/01',  11000, 21, 7),
('2034/01/01',  12000, 22, 8),
('2035/01/01',  13000, 22, 8),
('2036/01/01',  10000, 22, 8),
('2034/01/01',  10500, 23, 8),
('2035/01/01',  11000, 23, 8),
('2036/01/01',  11500, 23, 8),
('2034/01/01',  10000, 24, 8),
('2035/01/01',  10500, 24, 8),
('2036/01/01',  11000, 24, 8),
('2034/01/01',  10000, 25, 9),
('2035/01/01',  10500, 25, 9),
('2036/01/01',  11000, 25, 9),
('2034/01/01',  12000, 26, 9),
('2035/01/01',  13000, 26, 9),
('2036/01/01',  10000, 26, 9),
('2034/01/01',  10500, 27, 9),
('2035/01/01',  11000, 27, 9),
('2036/01/01',  11500, 27, 9);

----CLASIFICACIÓN_TEMA

INSERT INTO clas_tema(nombre, descripcion, topico) VALUES
('Armamento', 'El conjunto de armas de cualquier tipo, que esta a disposicion de grupos militares', 'paises'),
('Antecedente Penal', 'El registro oficial de las sanciones impuestas a una persona en virtud de sentencia firme', 'individuos'),
('Estrategia de Marketing', 'Proceso que puede ayudar a utilizar todos los recursos disponibles para incrementar las ventas', 'eventos'),
('Formulas Quimicas', 'Estas son las formulas secretas para crear los productos y tener un punto clave en la empresa', 'empresas'),
('Software', 'Conjuntos de programas en pleno desarrollo para la mejora de la empresa ', 'empresas'),
('Estrategia de Ventas', 'Los planes que puede llevar a cabo una empresa para vender sus productos o servicios con la intención de obtener un beneficio', 'paises'),
('Estrategia Salud', 'Son actuaciones sobre problemas de salud que requieren un abordaje integral, que tenga en cuenta todos los aspectos relacionados con la asistencia sanitaria', 'paises'),
('Estrategia Económica', 'Estrategia para impulsar la economia prosperidad y el desempeño del pais.', 'paises'),
('Politica Exterior', 'El conjunto de decisiones, politicas y acciones que confomar un pais, para poder representar los intereses nacionales de este', 'paises');

----CLIENTES BIEN HECHOS
INSERT INTO cliente (nombre_empresa, pagina_web, exclusivo, telefonos, contactos, fk_lugar_pais) VALUES
(' mexicaso', 'mexicaso.org.ve' ,true, ARRAY[CAST((58,4126909353) as telefono_ty), CAST((58,4165420879)as telefono_ty)],  ARRAY[ ROW('Eloisa', 'Petronila', 'Nolasco', 'White', '91 Sage Ave. Colorado Springs, CO 80911',  ROW(58,4121705701)), ROW('Nicolas', 'Abelardo', 'Tafoya', 'Peralta', '8370 Euclid Lane Harrisburg, PA 17109', ROW(58,4127728311))]::contacto_ty[], 4),
(' exibera', 'exibera.com' ,true, ARRAY[CAST((58,4141416359) as telefono_ty), CAST((58,4124647938)as telefono_ty)],  ARRAY[ ROW('Cayetano', 'Paulo', 'Guillen', 'Miramontes', '260 Griffin Ave. Saint Joseph, MI 49085',  ROW(58,4147468253)), ROW('Aidana', 'Consuelo', 'Hidalgo', 'Rodrigues', '421A El Dorado St. Pittsburgh, PA 15206', ROW(58,4145897204))]::contacto_ty[], 1),
(' ecuario', 'ecuario.org.ve' ,false, ARRAY[CAST((58,4249630352) as telefono_ty), CAST((58,4125063079)as telefono_ty)],  ARRAY[ ROW('Constantino', 'Adolfo', 'Bustos', 'Lima', '7630 Race Drive Chippewa Falls, WI 54729',  ROW(58,4148881705)), ROW('Juan', 'Gregorio', 'Madrid', 'Larios', '9248 S. Myers Dr. Barrington, IL 60010', ROW(58,4125199193))]::contacto_ty[], 2),
(' wavian', 'wavian.com' ,false, ARRAY[CAST((58,4246170813) as telefono_ty), CAST((58,4243008369)as telefono_ty)],  ARRAY[ ROW('Antonio', 'Tulio', 'Pinto', 'Cordero', '67 Purple Finch St. Battle Ground, WA 98604',  ROW(58,4124534802)), ROW('Ivan', 'Vivaldo', 'Monge', 'Orozco', '8 Wood St. Lawndale, CA 90260', ROW(58,4147759286))]::contacto_ty[], 3),
(' zuerteto', 'zuerteto.org.ve' ,true, ARRAY[CAST((58,4167058294) as telefono_ty), CAST((58,4164227118)as telefono_ty)],  ARRAY[ ROW('Dulcinea', 'Consuelo', 'Pizarro', 'Santiago', '2 Arnold Rd. Clementon, NJ 08021',  ROW(58,4149820142)), ROW('Andres', 'Caligula', 'Salguero', 'Cantu', '387 Corona Ave. Council Bluffs, IA 51501', ROW(58,4127896106))]::contacto_ty[], 5),
(' namelix', 'namelix.com' ,true, ARRAY[CAST((58,4124224557) as telefono_ty), CAST((58,4149275489)as telefono_ty)],  ARRAY[ ROW('Marsello', 'Alan', 'Carpio', 'Thomas', '5 Summerhouse Dr. Winston Salem, NC 27103',  ROW(58,4167928205)), ROW('Mia', 'Caridad', 'Avalos', 'Castaneda', '7014 Beacon Road Stratford, CT 06614', ROW(58,416559594))]::contacto_ty[], 6),
(' maxure', 'maxure.org.ve' ,false, ARRAY[CAST((58,4249270841) as telefono_ty), CAST((58,4161697839)as telefono_ty)],  ARRAY[ ROW('Antonio', 'Diego', 'Recinos', 'Santacruz', '14 Pulaski Street Dalton, GA 30721',  ROW(58,4125874357)), ROW('Camilo', 'Breno', 'Larios', 'Irizarry', '250 East Brewery Ave. Hattiesburg, MS 39401', ROW(58,4167713892))]::contacto_ty[], 7),
(' critine', 'critine.com' ,false, ARRAY[CAST((58,4121948734) as telefono_ty), CAST((58,4142669811)as telefono_ty)],  ARRAY[ ROW('Greta', 'Rosaura', 'Valdivia', 'Cruz', '7044C Bellevue Avenue Sylvania, OH 43560',  ROW(58,4128117935)), ROW('Foster', 'Hercules', 'Palma', 'Palomino', '405 Division St. Long Beach, NY 11561', ROW(58,4142206919))]::contacto_ty[], 8),
(' strise', 'strise.org.ve' ,true, ARRAY[CAST((58,4128375628) as telefono_ty), CAST((58,4129566333)as telefono_ty)],  ARRAY[ ROW('Marcela', 'Amelia', 'Galdamez', 'Rogers', '8561 Woodsman St. Soddy Daisy, TN 37379',  ROW(58,4125871125)), ROW('Ophelia', 'Genesis', 'Roman', 'Reza', '8680 Vermont Avenue Fayetteville, NC 28303', ROW(58,4129331604))]::contacto_ty[], 9),
(' finess', 'finess.com' ,true, ARRAY[CAST((58,4145172324) as telefono_ty), CAST((58,4148423998)as telefono_ty)],  ARRAY[ ROW('Pamela', 'Veronica', 'Torres', 'Diaz', '7003 North Pin Oak Drive Southfield, MI 48076',  ROW(58,4167261669)), ROW('Gladys', 'Guadalupe', 'Nelson', 'Collazo', '6 Nichols St. Sidney, OH 45365', ROW(58,412210943))]::contacto_ty[], 1),
(' spirate', 'spirate.org.ve' ,false, ARRAY[CAST((58,4143941547) as telefono_ty), CAST((58,4148656594)as telefono_ty)],  ARRAY[ ROW('Cayetano', 'Fulgencio', 'Marquez', 'Infante', '8864 West Grant Ave. Gastonia, NC 28052',  ROW(58,4123559954)), ROW('Dulce', 'Aleyda', 'Jacobo', 'Farias', '9630 Sage Avenue Virginia Beach, VA 23451', ROW(58,4142338258))]::contacto_ty[], 2),
(' tratone', 'tratone.com' ,false, ARRAY[CAST((58,4127166191) as telefono_ty), CAST((58,4167339412)as telefono_ty)],  ARRAY[ ROW('Jhoan', 'Dante', 'Lucero', 'Orona', '1 Tunnel Dr. Havertown, PA 19083',  ROW(58,4124168039)), ROW('Ramon', 'Cesar', 'Soliz', 'Alvarenga', '9700 Fremont Street Oak Lawn, IL 60453', ROW(58,4166551066))]::contacto_ty[], 3),
(' restra', 'restra.org.ve' ,true, ARRAY[CAST((58,4128656384) as telefono_ty), CAST((58,4141393239)as telefono_ty)],  ARRAY[ ROW('Elidio', 'Jonathan', 'Puentes', 'Ozuna', '87 Aspen Street Seattle, WA 98144',  ROW(58,4167372066)), ROW('Margarito', 'Leopoldo', 'Araujo', 'Villarreal', '722 Young Ave. Green Bay, WI 54302', ROW(58,4247562597))]::contacto_ty[], 4),
(' stedwork', 'stedwork.com' ,true, ARRAY[CAST((58,4144533212) as telefono_ty), CAST((58,4167169159)as telefono_ty)],  ARRAY[ ROW('Gloria', 'Eneida', 'Duque', 'Uribe', '77 East Saxton Circle Royal Oak, MI 48067',  ROW(58,4166612681)), ROW('Vitalicio', 'Calixtrato', 'Medina', 'Sanabria', '226 Dogwood Ave. Loxahatchee, FL 33470', ROW(58,4241393767))]::contacto_ty[], 5),
(' rampact', 'rampact.org.ve' ,false, ARRAY[CAST((58,4162219883) as telefono_ty), CAST((58,4149417666)as telefono_ty)],  ARRAY[ ROW('Jennifer', 'Valentina', 'Vigil', 'Aviles', '947 Harvey Rd. Erlanger, KY 41018',  ROW(58,4248900652)), ROW('Elba', 'Amparo', 'Bejarano', 'Barboza', '37 Foster Avenue Powhatan, VA 23139', ROW(58,4129348253))]::contacto_ty[], 6),
(' disconse', 'disconse.com' ,false, ARRAY[CAST((58,4141415929) as telefono_ty), CAST((58,4122793317)as telefono_ty)],  ARRAY[ ROW('Claudio', 'Lincoln', 'Sullivan', 'Tafoya', '936 Amerige Ave. Manchester, NH 03102',  ROW(58,4148438619)), ROW('Damaris', 'Corania', 'Benavides', 'Cook', '339 Devon Dr. Old Bridge, NJ 08857', ROW(58,4242480061))]::contacto_ty[], 7),
(' restricp', 'restricp.org.ve' ,true, ARRAY[CAST((58,4242584943) as telefono_ty), CAST((58,4244832665)as telefono_ty)],  ARRAY[ ROW('Fabian', 'Melchor', 'Deltoro', 'Lucero', '8963 Buckingham Street Roslindale, MA 02131',  ROW(58,4243181758)), ROW('Victor', 'Leon', 'Sorto', 'Velasquez', '67 Inverness Ave. East Stroudsburg, PA 18301', ROW(58,4167211111))]::contacto_ty[], 8),
(' devflair', 'devflair.com' ,true, ARRAY[CAST((58,4167026825) as telefono_ty), CAST((58,4166388369)as telefono_ty)],  ARRAY[ ROW('Daniela', 'Aidana', 'Avelar', 'Recinos', '23 Monroe St. Maryville, TN 37803',  ROW(58,4167709376)), ROW('Silvio', 'Maximiliano', 'Granados', 'Cordova', '9 South Hilltop Road Bethel Park, PA 15102', ROW(58,4166783921))]::contacto_ty[], 9),
(' inconce', 'inconce.org.ve' ,false, ARRAY[CAST((58,4247453786) as telefono_ty), CAST((58,4143307715)as telefono_ty)],  ARRAY[ ROW('Pilar', 'Inocencia', 'Antonio', 'Cepeda', '9241 Blackburn St. Oak Creek, WI 53154',  ROW(58,4243443197)), ROW('Ayala', 'Adria', 'Arriaga', 'Cota', '114 Lookout Court Egg Harbor Township, NJ 08234', ROW(58,4144959888))]::contacto_ty[], 4),
(' sloquest', 'sloquest.com' ,false, ARRAY[CAST((58,4162833863) as telefono_ty), CAST((58,4144556851)as telefono_ty)],  ARRAY[ ROW('Flor', 'Esperanza', 'Peterson', 'Sarmiento', '49 W. Lees Creek Ave. Pickerington, OH 43147',  ROW(58,4165511783)), ROW('Perla', 'Gloria', 'Lima', 'Valentin', '78 Clay St. Uniondale, NY 11553', ROW(58,4124743278))]::contacto_ty[], 6),

