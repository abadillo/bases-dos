--ALTER TABLE INFORMANTE DISABLE TRIGGER ALL;

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


TRUNCATE TABLE INFORMANTE_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE TRANSACCION_PAGO_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE CRUDO_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE ANALISTA_CRUDO_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE PIEZA_INTELIGENCIA_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE CRUDO_PIEZA_ALT RESTART IDENTITY CASCADE;
TRUNCATE TABLE ADQUISICION_ALT RESTART IDENTITY CASCADE;

      

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
('Est. Sisimiut', 3, 19, 18),
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



----CLIENTE
INSERT INTO cliente (nombre_empresa, pagina_web, exclusivo, telefonos, contactos, fk_lugar_pais) VALUES
('mexicaso', 'mexicaso.org.ve' ,true, ARRAY[CAST((58,4126909353) as telefono_ty), CAST((58,4165420879)as telefono_ty)],  ARRAY[ ROW('Eloisa', 'Petronila', 'Nolasco', 'White', '91 Sage Ave. Colorado Springs, CO 80911',  ROW(58,4121705701)), ROW('Nicolas', 'Abelardo', 'Tafoya', 'Peralta', '8370 Euclid Lane Harrisburg, PA 17109', ROW(58,4127728311))]::contacto_ty[], 4),
('exibera', 'exibera.com' ,true, ARRAY[CAST((58,4141416359) as telefono_ty), CAST((58,4124647938)as telefono_ty)],  ARRAY[ ROW('Cayetano', 'Paulo', 'Guillen', 'Miramontes', '260 Griffin Ave. Saint Joseph, MI 49085',  ROW(58,4147468253)), ROW('Aidana', 'Consuelo', 'Hidalgo', 'Rodrigues', '421A El Dorado St. Pittsburgh, PA 15206', ROW(58,4145897204))]::contacto_ty[], 1),
('ecuario', 'ecuario.org.ve' ,false, ARRAY[CAST((58,4249630352) as telefono_ty), CAST((58,4125063079)as telefono_ty)],  ARRAY[ ROW('Constantino', 'Adolfo', 'Bustos', 'Lima', '7630 Race Drive Chippewa Falls, WI 54729',  ROW(58,4148881705)), ROW('Juan', 'Gregorio', 'Madrid', 'Larios', '9248 S. Myers Dr. Barrington, IL 60010', ROW(58,4125199193))]::contacto_ty[], 2),
('wavian', 'wavian.com' ,false, ARRAY[CAST((58,4246170813) as telefono_ty), CAST((58,4243008369)as telefono_ty)],  ARRAY[ ROW('Antonio', 'Tulio', 'Pinto', 'Cordero', '67 Purple Finch St. Battle Ground, WA 98604',  ROW(58,4124534802)), ROW('Ivan', 'Vivaldo', 'Monge', 'Orozco', '8 Wood St. Lawndale, CA 90260', ROW(58,4147759286))]::contacto_ty[], 3),
('zuerteto', 'zuerteto.org.ve' ,true, ARRAY[CAST((58,4167058294) as telefono_ty), CAST((58,4164227118)as telefono_ty)],  ARRAY[ ROW('Dulcinea', 'Consuelo', 'Pizarro', 'Santiago', '2 Arnold Rd. Clementon, NJ 08021',  ROW(58,4149820142)), ROW('Andres', 'Caligula', 'Salguero', 'Cantu', '387 Corona Ave. Council Bluffs, IA 51501', ROW(58,4127896106))]::contacto_ty[], 5),
('namelix', 'namelix.com' ,true, ARRAY[CAST((58,4124224557) as telefono_ty), CAST((58,4149275489)as telefono_ty)],  ARRAY[ ROW('Marsello', 'Alan', 'Carpio', 'Thomas', '5 Summerhouse Dr. Winston Salem, NC 27103',  ROW(58,4167928205)), ROW('Mia', 'Caridad', 'Avalos', 'Castaneda', '7014 Beacon Road Stratford, CT 06614', ROW(58,416559594))]::contacto_ty[], 6),
('maxure', 'maxure.org.ve' ,false, ARRAY[CAST((58,4249270841) as telefono_ty), CAST((58,4161697839)as telefono_ty)],  ARRAY[ ROW('Antonio', 'Diego', 'Recinos', 'Santacruz', '14 Pulaski Street Dalton, GA 30721',  ROW(58,4125874357)), ROW('Camilo', 'Breno', 'Larios', 'Irizarry', '250 East Brewery Ave. Hattiesburg, MS 39401', ROW(58,4167713892))]::contacto_ty[], 7),
('critine', 'critine.com' ,false, ARRAY[CAST((58,4121948734) as telefono_ty), CAST((58,4142669811)as telefono_ty)],  ARRAY[ ROW('Greta', 'Rosaura', 'Valdivia', 'Cruz', '7044C Bellevue Avenue Sylvania, OH 43560',  ROW(58,4128117935)), ROW('Foster', 'Hercules', 'Palma', 'Palomino', '405 Division St. Long Beach, NY 11561', ROW(58,4142206919))]::contacto_ty[], 8),
('strise', 'strise.org.ve' ,true, ARRAY[CAST((58,4128375628) as telefono_ty), CAST((58,4129566333)as telefono_ty)],  ARRAY[ ROW('Marcela', 'Amelia', 'Galdamez', 'Rogers', '8561 Woodsman St. Soddy Daisy, TN 37379',  ROW(58,4125871125)), ROW('Ophelia', 'Genesis', 'Roman', 'Reza', '8680 Vermont Avenue Fayetteville, NC 28303', ROW(58,4129331604))]::contacto_ty[], 9),
('finess', 'finess.com' ,true, ARRAY[CAST((58,4145172324) as telefono_ty), CAST((58,4148423998)as telefono_ty)],  ARRAY[ ROW('Pamela', 'Veronica', 'Torres', 'Diaz', '7003 North Pin Oak Drive Southfield, MI 48076',  ROW(58,4167261669)), ROW('Gladys', 'Guadalupe', 'Nelson', 'Collazo', '6 Nichols St. Sidney, OH 45365', ROW(58,412210943))]::contacto_ty[], 1),
('spirate', 'spirate.org.ve' ,false, ARRAY[CAST((58,4143941547) as telefono_ty), CAST((58,4148656594)as telefono_ty)],  ARRAY[ ROW('Cayetano', 'Fulgencio', 'Marquez', 'Infante', '8864 West Grant Ave. Gastonia, NC 28052',  ROW(58,4123559954)), ROW('Dulce', 'Aleyda', 'Jacobo', 'Farias', '9630 Sage Avenue Virginia Beach, VA 23451', ROW(58,4142338258))]::contacto_ty[], 2),
('tratone', 'tratone.com' ,false, ARRAY[CAST((58,4127166191) as telefono_ty), CAST((58,4167339412)as telefono_ty)],  ARRAY[ ROW('Jhoan', 'Dante', 'Lucero', 'Orona', '1 Tunnel Dr. Havertown, PA 19083',  ROW(58,4124168039)), ROW('Ramon', 'Cesar', 'Soliz', 'Alvarenga', '9700 Fremont Street Oak Lawn, IL 60453', ROW(58,4166551066))]::contacto_ty[], 3),
('restra', 'restra.org.ve' ,true, ARRAY[CAST((58,4128656384) as telefono_ty), CAST((58,4141393239)as telefono_ty)],  ARRAY[ ROW('Elidio', 'Jonathan', 'Puentes', 'Ozuna', '87 Aspen Street Seattle, WA 98144',  ROW(58,4167372066)), ROW('Margarito', 'Leopoldo', 'Araujo', 'Villarreal', '722 Young Ave. Green Bay, WI 54302', ROW(58,4247562597))]::contacto_ty[], 4),
('stedwork', 'stedwork.com' ,true, ARRAY[CAST((58,4144533212) as telefono_ty), CAST((58,4167169159)as telefono_ty)],  ARRAY[ ROW('Gloria', 'Eneida', 'Duque', 'Uribe', '77 East Saxton Circle Royal Oak, MI 48067',  ROW(58,4166612681)), ROW('Vitalicio', 'Calixtrato', 'Medina', 'Sanabria', '226 Dogwood Ave. Loxahatchee, FL 33470', ROW(58,4241393767))]::contacto_ty[], 5),
('rampact', 'rampact.org.ve' ,false, ARRAY[CAST((58,4162219883) as telefono_ty), CAST((58,4149417666)as telefono_ty)],  ARRAY[ ROW('Jennifer', 'Valentina', 'Vigil', 'Aviles', '947 Harvey Rd. Erlanger, KY 41018',  ROW(58,4248900652)), ROW('Elba', 'Amparo', 'Bejarano', 'Barboza', '37 Foster Avenue Powhatan, VA 23139', ROW(58,4129348253))]::contacto_ty[], 6),
('disconse', 'disconse.com' ,false, ARRAY[CAST((58,4141415929) as telefono_ty), CAST((58,4122793317)as telefono_ty)],  ARRAY[ ROW('Claudio', 'Lincoln', 'Sullivan', 'Tafoya', '936 Amerige Ave. Manchester, NH 03102',  ROW(58,4148438619)), ROW('Damaris', 'Corania', 'Benavides', 'Cook', '339 Devon Dr. Old Bridge, NJ 08857', ROW(58,4242480061))]::contacto_ty[], 7),
('restricp', 'restricp.org.ve' ,true, ARRAY[CAST((58,4242584943) as telefono_ty), CAST((58,4244832665)as telefono_ty)],  ARRAY[ ROW('Fabian', 'Melchor', 'Deltoro', 'Lucero', '8963 Buckingham Street Roslindale, MA 02131',  ROW(58,4243181758)), ROW('Victor', 'Leon', 'Sorto', 'Velasquez', '67 Inverness Ave. East Stroudsburg, PA 18301', ROW(58,4167211111))]::contacto_ty[], 8),
('devflair', 'devflair.com' ,true, ARRAY[CAST((58,4167026825) as telefono_ty), CAST((58,4166388369)as telefono_ty)],  ARRAY[ ROW('Daniela', 'Aidana', 'Avelar', 'Recinos', '23 Monroe St. Maryville, TN 37803',  ROW(58,4167709376)), ROW('Silvio', 'Maximiliano', 'Granados', 'Cordova', '9 South Hilltop Road Bethel Park, PA 15102', ROW(58,4166783921))]::contacto_ty[], 9),
('inconce', 'inconce.org.ve' ,false, ARRAY[CAST((58,4247453786) as telefono_ty), CAST((58,4143307715)as telefono_ty)],  ARRAY[ ROW('Pilar', 'Inocencia', 'Antonio', 'Cepeda', '9241 Blackburn St. Oak Creek, WI 53154',  ROW(58,4243443197)), ROW('Ayala', 'Adria', 'Arriaga', 'Cota', '114 Lookout Court Egg Harbor Township, NJ 08234', ROW(58,4144959888))]::contacto_ty[], 4),
('sloquest', 'sloquest.com' ,false, ARRAY[CAST((58,4162833863) as telefono_ty), CAST((58,4144556851)as telefono_ty)],  ARRAY[ ROW('Flor', 'Esperanza', 'Peterson', 'Sarmiento', '49 W. Lees Creek Ave. Pickerington, OH 43147',  ROW(58,4165511783)), ROW('Perla', 'Gloria', 'Lima', 'Valentin', '78 Clay St. Uniondale, NY 11553', ROW(58,4124743278))]::contacto_ty[], 6);






-- personal_inteligencia
INSERT INTO personal_inteligencia (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, altura_cm, peso_kg, color_ojos, vision, class_seguridad, fotografia, huella_retina, huella_digital, telefono, licencia_manejo, idiomas, familiares, identificaciones, nivel_educativo, aliases, fk_lugar_ciudad) VALUES
('Florentina','Mariluz','Landa','Heredia','1993-03-05',189,66,'verde claro','20/25','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4145866510) ,ROW('75518194','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Araceli',null,'Alcantara','Candelaria','1960-06-01','tío',ROW(58,4145335249) ), ROW('Calixtrato','Vicente','Quintanilla','Estrada','1960-06-01','hermano',ROW(58,4142583859) )]::familiar_ty[], ARRAY[ ROW('31656053','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Economía','Máster','Finanzas')]::nivel_educativo_ty[],null,'10'),
('Constancia',null,'Oviedo','Aguilera','2000-10-30',181,79,'marrón oscuro','20/63','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2129022789) ,ROW('97109426','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cecilio',null,'Maravilla','Soria','1950-05-20','hermano',ROW(58,2345984196) ), ROW('Ramon','Cesar','Soliz','Alvarenga','1950-05-20','madre',ROW(58,2341591625) )]::familiar_ty[], ARRAY[ ROW('73480307','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Enfermería','null','null') ]::nivel_educativo_ty[],null,'10'),
('Libertad','Virginia','Casas','Cornejo','1998-11-21',160,79,'verde oscuro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4143613707) ,ROW('96567423','Irlanda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Jesus','Juliano','Gallegos','Curiel','1949-10-23','padre',ROW(58,2129442380) ), ROW('Fabian','Benjamin','Jara','Arguello','1949-10-23','hermano',ROW(58,2127035299) )]::familiar_ty[], ARRAY[ ROW('89872007','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'10'),
('Teodora','Abigail','Nolasco','Armendariz','1997-12-15',159,81,'azul claro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2819188487) ,ROW('34181131','Uganda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Fermin',null,'Figueroa','Cordova','1973-11-14','madre',ROW(58,2817690358) ), ROW('Hugo',null,'Serrato','Barrios','1973-11-14','abuelo',ROW(58,2811839796) )]::familiar_ty[], ARRAY[ ROW('34656827','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'10'),
('Valentin','Kevin','Machuca','Tello','1993-08-25',152,70,'verde oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4121120302) ,ROW('83939097','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Bibiana',null,'Monge','Ruano','1962-10-16','padre',ROW(58,4121292914) ), ROW('Brandon','Constantino','Razo','Casillas','1962-10-16','abuelo',ROW(58,4126797513) )]::familiar_ty[], ARRAY[ ROW('85007606','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','Máster','Ingeniería de Datos Masivos')]::nivel_educativo_ty[],null,'11'),
('Cesarino',null,'Zuniga','Anderson','1983-09-15',153,87,'verde claro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4246887111) ,ROW('92394600','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('William',null,'Tellez','Cedillo','1953-04-17','abuelo',ROW(58,2618046167) ), ROW('Margarito','Leopoldo','Araujo','Villarreal','1953-04-17','hermano',ROW(58,2618879740) )]::familiar_ty[], ARRAY[ ROW('10298770','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Ciencias Sociales ','null','null') ]::nivel_educativo_ty[],null,'11'),
('Bruno','Magnus','Quiroga','Ornelas','1998-12-03',172,94,'azul oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4128853127) ,ROW('92063010','Irlanda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cecilio','Owen','Alexander','Adams','1950-10-03','madre',ROW(58,4126782925) ), ROW('Juan','Felix','Najera','Echevarria','1950-10-03','abuelo',ROW(58,4128488674) )]::familiar_ty[], ARRAY[ ROW('73772983','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'11'),
('Jane','Amanda','Tenorio','Roberts','1999-09-14',180,69,'azul claro','20/20','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2348900127) ,ROW('17637177','Uganda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Felicio',null,'Meneses','Ward','1975-10-18','hermano',ROW(58,2345115466) ), ROW('Luis',null,'Oliva','Arias','1975-10-18','primo',ROW(58,2345387649) )]::familiar_ty[], ARRAY[ ROW('90044381','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null')]::nivel_educativo_ty[],null,'11'),
('Bienvenido','Vivaldo','Martines','Luis','1994-05-26',184,79,'azul oscuro','20/20','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2127226245) ,ROW('23562931','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Gracia',null,'Sanchez','Simon','1963-06-08','madre',ROW(58,2125614539) ), ROW('Anthony','Amilcar','Tafoya','Buenrostro','1963-06-08','primo',ROW(58,2129456655) )]::familiar_ty[], ARRAY[ ROW('82240519','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Comunicación','Máster','Comunicación Corporativa')]::nivel_educativo_ty[],null,'12'),
('Valerio','Adan','Bahena','Deltoro','1984-05-22',175,68,'verde oscuro','20/40','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2876127251) ,ROW('14201050','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Luisa',null,'Menjivar','Velasquez','1955-08-29','primo',ROW(58,2444138606) ), ROW('Vitalicio','Calixtrato','Medina','Sanabria','1955-08-29','hermano',ROW(58,2443544775) )]::familiar_ty[], ARRAY[ ROW('34067073','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Economía','null','null') ]::nivel_educativo_ty[],null,'12'),
('Margarito','Juvenal','Nevarez','Galarza','2000-03-09',172,74,'azul claro','20/16','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2122399063) ,ROW('90384414','Irlanda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Consolacion','Maximina','Maciel','Robledo','1953-11-30','hermano',ROW(58,2121432805) ), ROW('Tito','Julian','Vallejo','Pinon','1953-11-30','primo',ROW(58,2123516189) )]::familiar_ty[], ARRAY[ ROW('66986530','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Enfermería','null','null') ]::nivel_educativo_ty[],null,'12'),
('Feliciano','Cristian','Guzman','Roman','1999-09-20',151,81,'marrón claro','20/16','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2615875263) ,ROW('82241949','Uganda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Irma',null,'Barahona','Maldonado','1976-03-18','hermano',ROW(58,2616835607) ), ROW('Klement',null,'Montiel','Salguero','1976-03-18','hermano',ROW(58,2616167116) )]::familiar_ty[], ARRAY[ ROW('53953897','Irlanda')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'12'),
('Santiago','Andres','Izaguirre','Giron','1992-05-02',168,76,'verde oscuro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4123525045) ,ROW('45386610','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Pablo','Emiliano','Santana','Almeida','1956-04-21','hermano',ROW(58,4121690963) ), ROW('Greta',null,'Valdivia','Cruz','1956-04-21','hermano',ROW(58,4124128200) )]::familiar_ty[], ARRAY[ ROW('21689880','Holanda'),row('44522900','Zimbabue') ]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Ingeniería Industrial','Máster','Dirección de Empresas') ]::nivel_educativo_ty[],null,'13'),
('Elidio','Pablo','Carreno','Villarreal','1996-11-17',167,80,'verde oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4243130690) ,ROW('20350915','Groenlandia'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Jorge','Silvester','Rodrigues','Baez','1959-10-09','primo',ROW(58,2817063392) ), ROW('Lincoln',null,'Alvarenga','Elizondo','1959-10-09','hermano',ROW(58,2819767615) )]::familiar_ty[], ARRAY[ ROW('72450226','Holanda')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null')]::nivel_educativo_ty[],null,'13'),
('Regulo','Pastor','Coria','Valverde','1996-11-15',166,76,'verde claro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4248476748) ,ROW('61525397','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Marco',null,'Armijo','Jimenez','1970-12-22','primo',ROW(58,4246536171) ), ROW('Emperatriz',null,'Angulo','Valdivia','1970-12-22','hermano',ROW(58,4246894005) )]::familiar_ty[], ARRAY[ ROW('79323151','Holanda')]::identificacion_ty[], ARRAY[ ROW('Psicología','Máster','Inteligencia Emocional')]::nivel_educativo_ty[],null,'13'),
('Atenea','Mariana','Escalante','Garay','1998-11-20',168,83,'marrón claro','20/160','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2345434526) ,ROW('54275139','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Camilo','Margarito','Aguayo','Giraldo','1976-03-16','abuelo',ROW(58,2435397521) ), ROW('Fabian','Melchor','Deltoro','Lucero','1976-03-16','primo',ROW(58,2439905049) )]::familiar_ty[], ARRAY[ ROW('63868170','Holanda'),row('99264338','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Comunicación','Máster','Comunicación Corporativa') ]::nivel_educativo_ty[],null,'13'),
('Silvio','Fidel','Avelar','Mojica','1992-05-29',157,94,'azul oscuro','20/16','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2125394572) ,ROW('97347032','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Julian','Cornelio','Ceja','Castro','1957-07-10','abuelo',ROW(58,2123045079) ), ROW('Marcela',null,'Galdamez','Rogers','1957-07-10','abuelo',ROW(58,2123074046) )]::familiar_ty[], ARRAY[ ROW('68391991','Holanda'),row('20282221','Zimbabue') ]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Derecho','Máster','Abogacía') ]::nivel_educativo_ty[],null,'14'),
('Cristian','Feliciano','Montero','Arango','1999-09-22',154,89,'azul oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2874198040) ,ROW('68367092','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Constantino','Ciceron','Perez','Manriquez','1960-08-31','tío',ROW(58,2341751544) ), ROW('Alba',null,'Arriola','Duenas','1960-08-31','hermano',ROW(58,2342392342) )]::familiar_ty[], ARRAY[ ROW('70300861','Holanda')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null')]::nivel_educativo_ty[],null,'14'),
('Ives','Victor','Valerio','Alejo','1997-08-10',163,71,'verde oscuro','20/40','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2872490402) ,ROW('53615903','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cesarino',null,'Delrio','Caldera','1971-06-23','tío',ROW(58,2877296617) ), ROW('Vilma',null,'Monreal','Toscano','1971-06-23','hermano',ROW(58,2877719078) )]::familiar_ty[], ARRAY[ ROW('47860793','Holanda')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null')]::nivel_educativo_ty[],null,'14'),
('Poncio',null,'Parker','Palafox','1998-12-02',180,72,'marrón claro','20/200','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4125384784) ,ROW('75223071','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Peregrino','William','Reyes','Ruiz','1977-04-02','primo',ROW(58,2812734537) ), ROW('Daniela','Aidana','Avelar','Recinos','1977-04-02','hermano',ROW(58,2813105315) )]::familiar_ty[], ARRAY[ ROW('46357458','Holanda'),row('44481119','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Ciencias Sociales ','Máster','Acción Internacional Humanitaria') ]::nivel_educativo_ty[],null,'14'),
('Breno','Marcial','Acuna','Lewis','1993-05-13',166,79,'azul claro','20/160','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4249642333) ,ROW('91677759','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Sabina','Perla','Guevara','Morris','1959-09-04','abuelo',ROW(58,4248429139) ), ROW('Pamela','Veronica','Torres','Diaz','1959-09-04','abuelo',ROW(58,4247610538) )]::familiar_ty[], ARRAY[ ROW('51910927','Holanda'),row('47471546','Australia') ]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Ingeniería Informática','Máster','Ciberseguridad') ]::nivel_educativo_ty[],null,'15'),
('Eneida','Matilde','Velasco','Estevez','2000-04-20',181,82,'azul claro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2433043182) ,ROW('18249635','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Miranda','Maximina','Alonso','Zamora','1961-03-27','padre',ROW(58,2614456079) ), ROW('Pilar',null,'Alvarado','Contreras','1961-03-27','abuelo',ROW(58,2611171690) )]::familiar_ty[], ARRAY[ ROW('68101834','Holanda')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null')]::nivel_educativo_ty[],null,'15'),
('Jayden','Emilio','Amezcua','Maya','1997-10-10',184,78,'azul oscuro','20/32','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2438683153) ,ROW('27461011','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Luciana',null,'Garibay','Contreras','1973-05-18','padre',ROW(58,2436662586) ), ROW('Luna',null,'Castrejon','Narvaez','1973-05-18','abuelo',ROW(58,2438871140) )]::familiar_ty[], ARRAY[ ROW('22626609','Holanda')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'15'),
('Alba',null,'Cortez','Alegria','2000-03-08',151,76,'marrón oscuro','20/160','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2123276384) ,ROW('56132642','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Georgina','Julia','Lazaro','Perales','1979-02-20','primo',ROW(58,2341639383) ), ROW('Pilar','Inocencia','Antonio','Cepeda','1979-02-20','hermano',ROW(58,2345663933) )]::familiar_ty[], ARRAY[ ROW('59542288','Holanda')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Derecho','Máster','Asesoría Fiscal') ]::nivel_educativo_ty[],null,'15'),
('Kevin','Matias','Edwards','Peterson','1984-12-23',180,69,'azul oscuro','20/32','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2438709942) ,ROW('46605807','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Bertrudis','Lorena','Valerio','Serna','1960-06-20','primo',ROW(58,4144917521) ), ROW('Elba','Amparo','Bejarano','Barboza','1960-06-20','abuelo',ROW(58,4141031653) )]::familiar_ty[], ARRAY[ ROW('16796400','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Economía','null','null') ]::nivel_educativo_ty[],null,'16'),
('Alana','Erika','Nevarez','Deanda','1988-02-06',186,73,'verde claro','20/100','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2875377144) ,ROW('42190247','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Ignacio','Ulises','Cartagena','Roman','1944-01-18','madre',ROW(58,2877271523) ), ROW('Vivaldo','Tarsicio','Rosas','Jackson','1944-01-18','abuelo',ROW(58,2871548914) )]::familiar_ty[], ARRAY[ ROW('93148961','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Derecho','Máster','Abogacía')]::nivel_educativo_ty[],null,'16'),
('Eladio','Silvestre','Arteaga','Camarena','1998-03-19',171,76,'verde oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2872836156) ,ROW('71948361','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Anastasia','Melina','Pelayo','Veliz','1967-09-23','madre',ROW(58,2122945886) ), ROW('Gloria','Eneida','Duque','Uribe','1967-09-23','hermano',ROW(58,2129372640) )]::familiar_ty[], ARRAY[ ROW('10774911','Groenlandia'),row('64999971','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Economía','Máster','Auditoria Financiera y Riegos') ]::nivel_educativo_ty[],null,'16'),
('Sabina','Ada','Johnson','Caballero','1992-05-03',185,66,'marrón oscuro','20/12.5','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4129451264) ,ROW('79967621','Uganda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Patricia','Victoria','Munguia','Garcia','1978-09-06','tío',ROW(58,2816108763) ), ROW('Pablo','Orosio','Avendano','Marroquin','1978-09-06','hermano',ROW(58,2814749236) )]::familiar_ty[], ARRAY[ ROW('85559692','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Ingeniería Industrial','null','null') ]::nivel_educativo_ty[],null,'16'),
('Soledad','Esmeralda','Moreno','Sullivan','1986-05-03',163,83,'azul claro','20/25','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2811159875) ,ROW('34000680','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Eliana','Dulcinea','Ocampo','Mitchell','1961-09-09','tío',ROW(58,4125762280) ), ROW('Damaris','Corania','Benavides','Cook','1961-09-09','abuelo',ROW(58,4121731002) )]::familiar_ty[], ARRAY[ ROW('56081849','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'17'),
('Judas','Faustiniano','Cerda','Villa','1988-05-07',168,70,'verde oscuro','20/80','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2433381870) ,ROW('17005825','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Orosio','Javier','Delao','Delao','1945-05-04','hermano',ROW(58,2437162307) ), ROW('Gracia','Berenice','Bocanegra','Rizo','1945-05-04','primo',ROW(58,2436035571) )]::familiar_ty[], ARRAY[ ROW('15538458','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','Máster','Ciberseguridad')]::nivel_educativo_ty[],null,'17'),
('Mariam','Mireya','Orellana','Manzano','1998-04-22',151,66,'azul oscuro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2435220229) ,ROW('44028931','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Marisol','Trinidad','Escobedo','Pinon','1970-08-26','hermano',ROW(58,4241178425) ), ROW('Jennifer','Valentina','Vigil','Aviles','1970-08-26','abuelo',ROW(58,4247437539) )]::familiar_ty[], ARRAY[ ROW('16874541','Groenlandia'),row('67012147','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Economía','Máster','Finanzas') ]::nivel_educativo_ty[],null,'17'),
('Jorge','Rafael','Ocampo','Landeros','1992-05-30',153,83,'verde claro','20/10','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2121559430) ,ROW('23277313','Uganda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Pilar','Nathaly','Olmos','Melo','1979-12-29','padre',ROW(58,2346982594) ), ROW('Andres','Orosio','Pichardo','Castanon','1979-12-29','hermano',ROW(58,2346895289) )]::familiar_ty[], ARRAY[ ROW('56423791','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Ciencias Sociales ','null','null') ]::nivel_educativo_ty[],null,'17'),
('Fiona','Adriana','Soriano','Pedraza','1988-12-02',179,91,'marrón claro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2342055319) ,ROW('70044430','Argentina'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Pedro','Dante','Paez','Ramos','1963-10-06','padre',ROW(58,2123596460) ), ROW('Victor','Leon','Sorto','Velasquez','1963-10-06','primo',ROW(58,2125812506) )]::familiar_ty[], ARRAY[ ROW('15808057','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'18'),
('Inocencia','Adria','Maldonado','Mojica','1988-06-13',150,87,'azul oscuro','20/63','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2819888112) ,ROW('32723958','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Emily','Mireya','Tellez','Cabrera','1945-06-24','hermano',ROW(58,2812159587) ), ROW('Esperanza','Ana','Corona','Granados','1945-06-24','tío',ROW(58,2817969996) )]::familiar_ty[], ARRAY[ ROW('77420775','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Comunicación','Máster','Lexicografía')]::nivel_educativo_ty[],null,'18'),
('Thais','Cloe','Kelly','Santacruz','1998-06-26',154,82,'azul claro','20/40','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2816967861) ,ROW('17999862','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Mario','David','Barrientos','Montesdeoca','1975-06-22','hermano',ROW(58,2873876073) ), ROW('Claudio','Lincoln','Sullivan','Tafoya','1975-06-22','abuelo',ROW(58,2873839920) )]::familiar_ty[], ARRAY[ ROW('92497828','Groenlandia'),row('97310413','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ingeniería Informática','Máster','Ingeniería de Datos Masivos') ]::nivel_educativo_ty[],null,'18'),
('William','Lorenzo','Miranda','Rueda','1993-05-14',157,82,'verde oscuro','20/125','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4246304410) ,ROW('34655510','Uganda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Maria','Belinda','Angeles','Paniagua','1980-08-09','madre',ROW(58,2614175980) ), ROW('Leonardo','Klement','Bedolla','Bocanegra','1980-08-09','abuelo',ROW(58,2612580133) )]::familiar_ty[], ARRAY[ ROW('29689116','Groenlandia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'18'),
('Bernarda','Anunciacion','Preciado','Botello','2000-05-20',188,70,'marrón claro','20/40','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2817721032) ,ROW('49074622','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Romeo','Adrian','Damian','Vallejo','1962-06-17','madre',ROW(58,2447307869) ), ROW('Marina',null,'Elizondo','Nunez','1962-06-17','abuelo',ROW(58,2446714836) )]::familiar_ty[], ARRAY[ ROW('97452380','Argentina')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null')]::nivel_educativo_ty[],null,'19'),
('Bertrudis','Damaris','Mandujano','Sosa','1989-01-03',151,93,'azul oscuro','20/80','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2431175947) ,ROW('76461038','Holanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Alma','Moira','Moreno','Batista','1944-06-08','primo',ROW(58,2435756755) ), ROW('Cayetano',null,'Guillen','Miramontes','1944-06-08','abuelo',ROW(58,2434965894) )]::familiar_ty[], ARRAY[ ROW('95091182','Argentina'),row('16926723','Groenlandia') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null')]::nivel_educativo_ty[],null,'19'),
('Melina','Bonita','Cardenas','Hill','1990-08-29',164,71,'azul oscuro','20/25','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4121570489) ,ROW('84072515','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Jessica','Brenda','Garcia','Anguiano','1970-11-02','abuelo',ROW(58,4249360234) ), ROW('Ayala','Haydee','Sauceda','Mares','1970-11-02','abuelo',ROW(58,4244759443) )]::familiar_ty[], ARRAY[ ROW('22294936','Argentina')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Psicología','null','null') ]::nivel_educativo_ty[],null,'19'),
('Tito',null,'Serna','Suarez','1989-12-18',173,71,'verde claro','20/40','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2618135658) ,ROW('88656236','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Carla',null,'Larios','Mazariegos','1980-12-04','hermano',ROW(58,2434584531) ), ROW('Natividad','Fabiola','Samaniego','Castellanos','1980-12-04','hermano',ROW(58,2433593713) )]::familiar_ty[], ARRAY[ ROW('91620847','Argentina')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null')]::nivel_educativo_ty[],null,'19'),
('Emperatriz',null,'Farias','Rincon','2000-08-11',174,75,'marrón claro','20/160','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2343226301) ,ROW('30050667','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Amanda','Viviana','Delrio','Solorzano','1963-02-19','hermano',ROW(58,4144552274) ), ROW('Justiniano','Foster','Olivares','Ellis','1963-02-19','primo',ROW(58,4143866668) )]::familiar_ty[], ARRAY[ ROW('62925370','Argentina')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null')]::nivel_educativo_ty[],null,'20'),
('Faustino','Margarito','Quinones','Mena','1989-12-16',161,87,'azul claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2818687845) ,ROW('86083433','Holanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Emiliana','Constanza','Renteria','Almaguer','1944-12-12','primo',ROW(58,2813553082) ), ROW('Constantino',null,'Bustos','Lima','1944-12-12','primo',ROW(58,2819638370) )]::familiar_ty[], ARRAY[ ROW('31880045','Argentina'),row('97834556','Groenlandia') ]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null')]::nivel_educativo_ty[],null,'20'),
('Facunda','Alvara','Prado','Sarmiento','1991-01-29',153,72,'azul claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2128815730) ,ROW('56155975','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Constantino','Leon','Marte','Recinos','1973-02-13','abuelo',ROW(58,2871278225) ), ROW('Salvador','Eleazar','Madrid','Moore','1973-02-13','abuelo',ROW(58,2873542917) )]::familiar_ty[], ARRAY[ ROW('58856164','Argentina')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Psicología','null','null') ]::nivel_educativo_ty[],null,'20'),
('Dulcinea',null,'Angeles','Ordonez','1990-02-07',178,90,'verde oscuro','20/32','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2444461580) ,ROW('76990356','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Camila',null,'Garibay','Valle','1936-09-25','hermano',ROW(58,2818191517) ), ROW('Rosa','Mariana','Quiroz','Escobedo','1936-09-25','abuelo',ROW(58,2813112354) )]::familiar_ty[], ARRAY[ ROW('21082874','Argentina')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null')]::nivel_educativo_ty[],null,'20'),
('Michael',null,'Moreno','Acuna','2000-10-19',177,74,'marrón oscuro','20/200','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4129161124) ,ROW('10985338','Argentina'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Maximiliano','Pastor','Candelaria','Oropeza','1966-10-10','hermano',ROW(58,4122331801) ), ROW('Alba','Celia','Salcedo','Machado','1966-10-10','madre',ROW(58,4128452043) )]::familiar_ty[], ARRAY[ ROW('78826748','Argentina')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null')]::nivel_educativo_ty[],null,'21'),
('Marcos','Alfredo','Solorio','Roldan','1990-02-05',168,86,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2346723703) ,ROW('61606618','Holanda'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Fernanda','Amelia','Ruano','Quintanilla','1946-12-07','tío',ROW(58,2346783122) ), ROW('Antonio',null,'Pinto','Cordero','1946-12-07','tío',ROW(58,2342921290) )]::familiar_ty[], ARRAY[ ROW('39940174','Argentina'),row('93675431','Groenlandia') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null')]::nivel_educativo_ty[],null,'21'),
('Matias','Orosio','Segura','Alvarenga','1991-05-26',171,69,'marrón claro','20/16','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4248510703) ,ROW('59370849','Malasia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Valentin','Fermin','Burgos','Caraballo','1976-01-07','primo',ROW(58,2437433265) ), ROW('Lucrecia','Margarita','Alonzo','Saenz','1976-01-07','primo',ROW(58,2431228910) )]::familiar_ty[], ARRAY[ ROW('86486594','Argentina')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'21'),
('Amara',null,'Saldana','Delao','1990-08-30',159,75,'azul oscuro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4145733047) ,ROW('59643306','Uganda'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Jorge',null,'James','Lopez','1937-04-10','abuelo',ROW(58,2349484976) ), ROW('Myriam','Zoe','Serrano','Ochoa','1937-04-10','abuelo',ROW(58,2347321093) )]::familiar_ty[], ARRAY[ ROW('93951813','Argentina')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null')]::nivel_educativo_ty[],null,'21'),
('Nikita','Victoria','Sanabria','Monreal','2000-10-29',181,86,'azul oscuro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2123944612) ,ROW('17901622','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Poncio',null,'Alcala','Falcon','1981-02-02','tío',ROW(58,2126204462) ), ROW('Silvester',null,'Morris','Serrato','1981-02-02','primo',ROW(58,2124364221) )]::familiar_ty[], ARRAY[ ROW('62132851','Taiwán'),row('64962613','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'22'),
('Benigno',null,'Lozano','Garay','2000-04-30',159,79,'azul claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2122163297) ,ROW('45787069','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Julian',null,'Quezada','Badillo','1948-11-18','padre',ROW(58,2874376083) ), ROW('Ophelia','Genesis','Roman','Reza','1948-11-18','primo',ROW(58,2878862181) )]::familiar_ty[], ARRAY[ ROW('75801459','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'22'),
('Jonathan',null,'Caballero','Hidalgo','1986-05-04',166,68,'azul claro','20/80','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2439974589) ,ROW('43586737','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Vicente','Juliano','Bello','Osuna','1978-12-06','tío',ROW(58,2128406187) ), ROW('Ophelia','Isabella','Pabon','Zambrano','1978-12-06','abuelo',ROW(58,2125727947) )]::familiar_ty[], ARRAY[ ROW('15103034','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null')]::nivel_educativo_ty[],null,'22'),
('Jiovani','Julian','Villeda','Barahona','2000-04-29',188,75,'marrón oscuro','20/12.5','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2444886584) ,ROW('33371745','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Amada',null,'Rendon','Ochoa','1976-07-16','abuelo',ROW(58,2447538370) ), ROW('Rosalia',null,'Valles','Montes','1976-07-16','hermano',ROW(58,2447297009) )]::familiar_ty[], ARRAY[ ROW('12556461','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'22'),
('Yves','Cornelio','Avina','Camarena','1983-09-14',162,83,'azul claro','20/16','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4247327815) ,ROW('43798096','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Sebastian',null,'Cabral','Cedillo','1936-02-14','padre',ROW(58,4242563853) ), ROW('Magali',null,'Salmeron','Izquierdo','1936-02-14','tío',ROW(58,4244391590) )]::familiar_ty[], ARRAY[ ROW('57015909','Taiwán'),row('33501965','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null')]::nivel_educativo_ty[],null,'23'),
('Isabel',null,'Rueda','Carmona','2000-05-30',156,92,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4249862179) ,ROW('65512579','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cornelio',null,'Ceja','Jaimes','1949-10-09','madre',ROW(58,2438644298) ), ROW('Gladys','Guadalupe','Nelson','Collazo','1949-10-09','tío',ROW(58,2438176910) )]::familiar_ty[], ARRAY[ ROW('19988380','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'23'),
('Adria',null,'Hermosillo','Barboza','1988-12-03',184,72,'marrón claro','20/63','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2814972399) ,ROW('65842138','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Marco','Maximiliano','Valadez','Thompson','1979-04-04','padre',ROW(58,4241620132) ), ROW('Paciano','Jose','Lima','Beltran','1979-04-04','primo',ROW(58,4242674984) )]::familiar_ty[], ARRAY[ ROW('61913792','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null')]::nivel_educativo_ty[],null,'23'),
('Brenda','Fabia','Baltazar','Antonio','2000-05-31',161,73,'verde claro','20/32','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4141015396) ,ROW('76028943','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Naomi',null,'Powell','Butler','1979-05-22','abuelo',ROW(58,4143703820) ), ROW('Griselda',null,'Pedraza','Lozano','1979-05-22','abuelo',ROW(58,4144178311) )]::familiar_ty[], ARRAY[ ROW('66992678','Taiwán'),row('10755026','Australia') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null')]::nivel_educativo_ty[],null,'23'),
('Adria','Cloe','Armijo','Hall','1984-05-21',177,71,'marrón claro','20/12.5','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4126259620) ,ROW('40577438','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Marlene',null,'Maravilla','Merino','1938-07-26','madre',ROW(58,4125113606) ), ROW('Emiliana',null,'Mariscal','Lora','1938-07-26','padre',ROW(58,4123090152) )]::familiar_ty[], ARRAY[ ROW('86577438','Taiwán'),row('82197561','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null')]::nivel_educativo_ty[],null,'24'),
('Sharon',null,'Beltran','Gallardo','2000-08-10',189,72,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4125991055) ,ROW('54872264','Holanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Liliana',null,'Cavazos','Coronado','1949-10-16','hermano',ROW(58,2818930522) ), ROW('Dulce','Aleyda','Jacobo','Farias','1949-10-16','padre',ROW(58,2817769439) )]::familiar_ty[], ARRAY[ ROW('57448642','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'24'),
('Alfredo',null,'Flores','Velazquez','1989-01-05',164,80,'marrón oscuro','20/50','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2344141623) ,ROW('19430278','Malasia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Ana','Carola','Olivares','Rubio','1979-08-01','madre',ROW(58,2873401454) ), ROW('Marcelo','Vicente','Montez','Walker','1979-08-01','hermano',ROW(58,2875455927) )]::familiar_ty[], ARRAY[ ROW('68036828','Taiwán')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null')]::nivel_educativo_ty[],null,'24'),
('Emperatriz','Georgia','Castanon','Castillo','2000-08-09',157,80,'verde oscuro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4129293691) ,ROW('42069213','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Adrian',null,'Price','Becerra','1981-01-22','primo',ROW(58,4129613046) ), ROW('Daniel',null,'Price','Gallardo','1981-01-22','abuelo',ROW(58,4122221410) )]::familiar_ty[], ARRAY[ ROW('81705889','Taiwán'),row('69507128','Australia') ]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null')]::nivel_educativo_ty[],null,'24'),
('Sylvia',null,'Caraballo','Velarde','1996-11-16',187,95,'azul claro','20/63','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2812842710) ,ROW('65439784','Australia'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Anunciacion',null,'Osuna','Barcenas','1938-06-18','hermano',ROW(58,4122962348) ), ROW('Juan','Gregorio','Madrid','Larios','1938-06-18','tío',ROW(58,4123557490) )]::familiar_ty[], ARRAY[ ROW('93470901','Malasia')]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'25'),
('Clarence','Marsello','Angel','Campos','2000-07-23',168,89,'marrón claro','20/160','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4246960293) ,ROW('78503990','Holanda'),ARRAY['español','inglés','hindi','francés']::varchar(50)[], ARRAY[ ROW('Liliana','Luisa','Carrillo','Cartagena','1956-12-09','hermano',ROW(58,4248965154) ), ROW('Ava','Guadalupe','Suarez','Caballero','1956-12-09','tío',ROW(58,4241522009) )]::familiar_ty[], ARRAY[ ROW('87787395','Malasia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ciencias Sociales ','null','null') ]::nivel_educativo_ty[],null,'25'),
('Donatila','Melania','Michel','Zambrano','1994-06-22',166,82,'azul claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4249842977) ,ROW('95842887','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Santiago',null,'Lozada','Ledesma','1964-03-10','hermano',ROW(58,4241054465) ), ROW('Libertad','Eliana','Garces','Casanova','1964-03-10','tío',ROW(58,4248765720) )]::familiar_ty[], ARRAY[ ROW('32471655','Malasia')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','Máster','Acción Internacional Humanitaria')]::nivel_educativo_ty[],null,'25'),
('Erika',null,'Ordaz','Tolentino','2000-07-22',152,92,'verde claro','20/125','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4242140682) ,ROW('90860097','Zimbabue'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Emma','Audrey','Verduzco','Gallegos','1980-07-05','tío',ROW(58,2611410976) ), ROW('Flor','Esperanza','Peterson','Sarmiento','1980-07-05','abuelo',ROW(58,2613152019) )]::familiar_ty[], ARRAY[ ROW('87756498','Malasia')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Criminología','Máster','Química Orgánica') ]::nivel_educativo_ty[],null,'25'),
('Maximo',null,'Moncada','Resendez','1997-08-11',158,81,'marrón claro','20/50','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2341321695) ,ROW('70030398','Australia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Hilda',null,'Landa','Trejo','1942-09-24','hermano',ROW(58,2125700117) ), ROW('Ivan','Vivaldo','Monge','Orozco','1942-09-24','padre',ROW(58,2125735772) )]::familiar_ty[], ARRAY[ ROW('36844069','Malasia')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','null','null'), ROW('Criminología','null','null') ]::nivel_educativo_ty[],null,'26'),
('Juliana','Heidi','Archuleta','Sanchez','2000-08-28',189,83,'marrón oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4128726022) ,ROW('93543002','Holanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Nadia','Monica','Flores','Correa','1958-01-04','abuelo',ROW(58,2877798988) ), ROW('Victoria','Donatila','Vidal','Gastelum','1958-01-04','padre',ROW(58,2877186836) )]::familiar_ty[], ARRAY[ ROW('72295363','Malasia')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Economía','null','null') ]::nivel_educativo_ty[],null,'26'),
('Haydee','Gladys','Caldera','Fabian','1995-07-22',188,81,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4125951582) ,ROW('66629517','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Haydee',null,'Solis','Villeda','1965-12-24','hermano',ROW(58,4127342159) ), ROW('Ignacio','Chistopher','Concepcion','Teran','1965-12-24','padre',ROW(58,4129268326) )]::familiar_ty[], ARRAY[ ROW('88810717','Malasia')]::identificacion_ty[], ARRAY[ ROW('Derecho','Máster','Asesoría Fiscal')]::nivel_educativo_ty[],null,'26'),
('Carla',null,'Mojica','Campbell','2000-08-27',182,86,'verde oscuro','20/100','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2872437442) ,ROW('38383416','Zimbabue'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Ives','Jorge','Narvaez','Tolentino','1980-09-16','padre',ROW(58,2444071786) ), ROW('Nicolas','Abelardo','Tafoya','Peralta','1980-09-16','abuelo',ROW(58,2445818807) )]::familiar_ty[], ARRAY[ ROW('73155349','Malasia')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Psicología','Máster','Inteligencia Emocional') ]::nivel_educativo_ty[],null,'26'),
('Adolfo',null,'Quinonez','Garces','1997-10-11',151,70,'marrón oscuro','20/40','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2612924198) ,ROW('72294857','Australia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Atenea',null,'Amaya','Patino','1943-03-10','abuelo',ROW(58,4245126805) ), ROW('Andres','Caligula','Salguero','Cantu','1943-03-10','madre',ROW(58,4243490244) )]::familiar_ty[], ARRAY[ ROW('79684586','Malasia')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null'), ROW('Psicología','null','null') ]::nivel_educativo_ty[],null,'27'),
('Ramona','Amelia','Viramontes','Ascencio','1996-09-22',173,76,'verde claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2129011871) ,ROW('82429267','Holanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Marcos','Venancio','Caldera','Alcantara','1959-04-26','abuelo',ROW(58,2433119934) ), ROW('Michael',null,'Montero','Mora','1959-04-26','madre',ROW(58,2437139396) )]::familiar_ty[], ARRAY[ ROW('46543023','Malasia')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null')]::nivel_educativo_ty[],null,'27'),
('Elizabeth','Eduviges','Henriquez','Hinojosa','1996-09-20',180,82,'marrón oscuro','20/63','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2127152706) ,ROW('67345679','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Caligula',null,'Estevez','Cifuentes','1970-06-29','abuelo',ROW(58,2125663308) ), ROW('Fidel','Juan','Regalado','Machuca','1970-06-29','madre',ROW(58,2126723842) )]::familiar_ty[], ARRAY[ ROW('31627114','Malasia')]::identificacion_ty[], ARRAY[ ROW('Criminología','Máster','Química Orgánica')]::nivel_educativo_ty[],null,'27'),
('Carmona',null,'Martinez','Olivarez','1996-09-21',156,73,'azul oscuro','20/80','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2439707517) ,ROW('80718477','Zimbabue'),ARRAY['español','inglés','hindi','ruso','mandarín','bengalí']::varchar(50)[], ARRAY[ ROW('Arturo',null,'Lovato','Hernandes','1938-03-06','madre',ROW(58,4144592848) ), ROW('Aidana','Consuelo','Hidalgo','Rodrigues','1938-03-06','primo',ROW(58,4146396575) )]::familiar_ty[], ARRAY[ ROW('24825622','Malasia')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'27'),
('Klement','Julian','Alonzo','Michel','1998-03-20',175,87,'marrón claro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2345973358) ,ROW('45514606','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Eleazar','Cesarino','Pina','Watson','1946-02-25','primo',ROW(58,2127920227) ), ROW('Gloria','Lorena','Valdez','Orozco','1946-02-25','padre',ROW(58,2128577731) )]::familiar_ty[], ARRAY[ ROW('97508067','Uganda')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'28'),
('Emilio','Jaime','Quiles','Amezcua','1983-03-26',179,73,'azul claro','20/200','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4124658197) ,ROW('15376359','Irlanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Irma','Nieves','Roque','Urias','1940-04-13','primo',ROW(58,4121393132) ), ROW('Celeste','Soledad','Chacon','Machado','1940-04-13','hermano',ROW(58,4123485281) )]::familiar_ty[], ARRAY[ ROW('44826830','Uganda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','Máster','Inteligencia Artificial')]::nivel_educativo_ty[],null,'28'),
('Rosaura','Sharon','Zelaya','Rico','1993-10-08',158,69,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4122105602) ,ROW('42964955','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Mario','Marcelo','Alexander','Roberts','1960-08-26','primo',ROW(58,4124457460) ), ROW('Cayetano','Fulgencio','Marquez','Infante','1960-08-26','primo',ROW(58,4128628948) )]::familiar_ty[], ARRAY[ ROW('57521570','Uganda'),row('88222732','Australia') ]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Comunicación','Máster','Lexicografía') ]::nivel_educativo_ty[],null,'28'),
('Luis','Marcus','Wilson','Tejeda','1993-10-09',177,68,'azul oscuro','20/100','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2874851540) ,ROW('70037582','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Italo','Florindo','Barragan','Salinas','1936-11-09','hermano',ROW(58,2442783407) ), ROW('Genesis','Ana','Davis','Vicente','1936-11-09','abuelo',ROW(58,2441541760) )]::familiar_ty[], ARRAY[ ROW('32853447','Uganda')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Criminología','null','null') ]::nivel_educativo_ty[],null,'28'),
('Ludmila','Facunda','Almonte','Frias','1998-04-23',169,89,'marrón oscuro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2612011700) ,ROW('25650571','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Felix','Petronilo','Abarca','Melo','1946-05-22','primo',ROW(58,4245545777) ), ROW('Inocencia','Carolina','Menendez','Saldana','1946-05-22','madre',ROW(58,4247120910) )]::familiar_ty[], ARRAY[ ROW('88242914','Uganda')]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null'), ROW('Ingeniería Industrial','null','null') ]::nivel_educativo_ty[],null,'29'),
('Delfina','Ligia','Carpio','Buenrostro','1984-01-23',173,91,'marrón claro','20/160','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2124075760) ,ROW('47676861','Irlanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Teodora','Libertad','Montero','Aparicio','1940-09-24','tío',ROW(58,2121211721) ), ROW('Marlene','Donatila','Rosa','Almazan','1940-09-24','hermano',ROW(58,2122363486) )]::familiar_ty[], ARRAY[ ROW('30946999','Uganda')]::identificacion_ty[], ARRAY[ ROW('Comunicación','Máster','Comunicación Intercultural')]::nivel_educativo_ty[],null,'29'),
('Eneida','America','Guerrero','Mireles','1995-01-08',168,66,'marrón oscuro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2121632100) ,ROW('15492537','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Javier','Breno','Benitez','Zayas','1963-01-23','tío',ROW(58,2129242169) ), ROW('Jhoan','Dante','Lucero','Orona','1963-01-23','madre',ROW(58,2128078170) )]::familiar_ty[], ARRAY[ ROW('57512360','Uganda'),row('59997320','Australia') ]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Enfermería','Máster','Investigación de Medicamentos') ]::nivel_educativo_ty[],null,'29'),
('Constancia','Alma','Payan','Moya','1995-01-09',172,80,'azul claro','20/80','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2439959656) ,ROW('77887372','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Maricruz','Viviana','Moore','Zamora','1936-12-24','hermano',ROW(58,4148258146) ), ROW('Ignacio','Maximo','Wright','Resendez','1936-12-24','primo',ROW(58,4148917731) )]::familiar_ty[], ARRAY[ ROW('48172871','Uganda')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Psicología','null','null') ]::nivel_educativo_ty[],null,'29'),
('Imelda','Genesis','Salmeron','Baca','1998-06-27',167,81,'verde claro','20/32','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2449530602) ,ROW('67338157','Australia'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Celina','Mafalda','Smith','Alcantar','1948-02-28','tío',ROW(58,4128913319) ), ROW('Hermione','Mariluz','Manzanares','Chavez','1948-02-28','hermano',ROW(58,4121129176) )]::familiar_ty[], ARRAY[ ROW('98933002','Uganda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Informática','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'30'),
('Felicia','Emiliana','Pacheco','Munoz','1986-03-28',175,70,'marrón oscuro','20/125','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4244117340) ,ROW('49703495','Irlanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Marcelo','Tulio','Paredes','Heredia','1943-12-14','padre',ROW(58,4248387995) ), ROW('Fabiano','Tarsicio','Santamaria','Jaquez','1943-12-14','abuelo',ROW(58,4249631241) )]::familiar_ty[], ARRAY[ ROW('52235413','Uganda')]::identificacion_ty[], ARRAY[ ROW('Ingeniería Industrial','Máster','Dirección de Empresas')]::nivel_educativo_ty[],null,'30'),
('Tarsicio','Carlos','Garza','Ochoa','1995-07-24',162,69,'verde claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4242640511) ,ROW('47591916','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Patricia','Maricruz','Miller','Amador','1965-03-19','padre',ROW(58,4126888534) ), ROW('Elidio','Jonathan','Puentes','Ozuna','1965-03-19','hermano',ROW(58,4123171192) )]::familiar_ty[], ARRAY[ ROW('40936348','Uganda'),row('40745243','Irlanda') ]::identificacion_ty[], ARRAY[ ROW('Comunicación','null','null'), ROW('Ciencias Sociales ','Máster','Relaciones Internacionales') ]::nivel_educativo_ty[],null,'30'),
('Jacobo','Elian','Person','Bianco','1995-07-25',181,86,'marrón claro','20/20','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2818200361) ,ROW('15230878','Zimbabue'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Cristiano','Fabiano','Toledo','Bustos','1941-01-27','abuelo',ROW(58,4125407316) ), ROW('Eduardo','Juan','Roybal','Escamilla','1941-01-27','tío',ROW(58,4126598183) )]::familiar_ty[], ARRAY[ ROW('22623786','Uganda')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'30'),
('Diego','Cesar','Bueno','Conde','1989-02-08',177,75,'azul claro','20/50','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2347045671) ,ROW('46003066','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Hilda','Bernarda','Tamez','Cuellar','1954-08-20','abuelo',ROW(58,2349506556) ), ROW('Mirella','Zamira','Machuca','Magallon','1954-08-20','padre',ROW(58,2348108392) )]::familiar_ty[], ARRAY[ ROW('75410645','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Enfermería','Máster','Investigación de Medicamentos')]::nivel_educativo_ty[],null,'31'),
('Eleazar','Silvio','Calderon','Maciel','1984-12-22',158,74,'marrón oscuro','20/10','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2123510656) ,ROW('37037351','Irlanda'),ARRAY['español','inglés','portugués','francés']::varchar(50)[], ARRAY[ ROW('Aleyda','Donatila','Nolasco','Salgado','1938-11-18','hermano',ROW(58,2121530571) ), ROW('Pamela',null,'Guevara','Zapata','1938-11-18','madre',ROW(58,2122904772) )]::familiar_ty[], ARRAY[ ROW('36639067','Zimbabue'),row('78017599','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null')]::nivel_educativo_ty[],null,'31'),
('Facundo','Cristian','Ventura','Valladares','1989-01-04',172,68,'marrón oscuro','20/16','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2616773916) ,ROW('81242984','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Agustin','Hugo','Maldonado','Estrella','1965-09-12','madre',ROW(58,4248540911) ), ROW('Silvio','Maximiliano','Granados','Cordova','1965-09-12','madre',ROW(58,4247069608) )]::familiar_ty[], ARRAY[ ROW('48286733','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Ciencias Sociales ','null','null') ]::nivel_educativo_ty[],null,'31'),
('Venancio','Justin','Miramontes','Verduzco','1989-04-24',189,88,'marrón claro','20/40','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2618231899) ,ROW('42006385','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Octavio',null,'Villanueva','Valles','1955-07-02','abuelo',ROW(58,2612763993) ), ROW('Vicente','Agustin','Rosas','Arguello','1955-07-02','madre',ROW(58,2619623603) )]::familiar_ty[], ARRAY[ ROW('92826593','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','Máster','Relaciones Internacionales')]::nivel_educativo_ty[],null,'32'),
('Eleazar','Francisco','Abreu','Alba','1986-05-02',174,91,'verde claro','20/125','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4243858397) ,ROW('47009264','Irlanda'),ARRAY['español','inglés','hindi','francés']::varchar(50)[], ARRAY[ ROW('Lionel','Vivaldo','Martinez','Elias','1940-07-21','hermano',ROW(58,4247638175) ), ROW('Feliciano',null,'Hurtado','Baca','1940-07-21','hermano',ROW(58,4241274002) )]::familiar_ty[], ARRAY[ ROW('16130752','Zimbabue'),row('15985105','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Economía','null','null')]::nivel_educativo_ty[],null,'32'),
('Vitalicio','Benjamin','Bennett','Rios','1989-12-17',165,84,'verde claro','20/12.5','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2445192944) ,ROW('72821520','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Yovanni','Ivan','Barbosa','Orosco','1965-11-26','hermano',ROW(58,4127971069) ), ROW('Ayala','Adria','Arriaga','Cota','1965-11-26','hermano',ROW(58,4126316402) )]::familiar_ty[], ARRAY[ ROW('19300027','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Ciencias Sociales ','null','null'), ROW('Derecho','null','null') ]::nivel_educativo_ty[],null,'32'),
('Camilo','Marcos','Melgoza','Roa','1990-09-14',186,67,'marrón oscuro','20/32','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2441475499) ,ROW('24683243','Groenlandia'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Julio',null,'Avelar','Conde','1955-12-31','primo',ROW(58,2443157513) ), ROW('Octavia','Eduviges','Mena','Alcantara','1955-12-31','hermano',ROW(58,2444809325) )]::familiar_ty[], ARRAY[ ROW('92757360','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Economía','Máster','Auditoria Financiera y Riegos')]::nivel_educativo_ty[],null,'33'),
('Ulises','Jhoan','Delgadillo','Vera','1988-12-01',169,89,'verde oscuro','20/100','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2879331316) ,ROW('86795048','Irlanda'),ARRAY['español','inglés','hindi','ruso']::varchar(50)[], ARRAY[ ROW('Valerio','Carmona','Solis','Sarabia','1942-07-22','abuelo',ROW(58,2875790429) ), ROW('Eloisa',null,'Nolasco','White','1942-07-22','hermano',ROW(58,2874376756) )]::familiar_ty[], ARRAY[ ROW('59587535','Zimbabue'),row('66240845','Holanda') ]::identificacion_ty[], ARRAY[ ROW('Filosofía','null','null')]::nivel_educativo_ty[],null,'33'),
('Paula','Laila','Serna','Mora','1990-02-06',166,66,'verde oscuro','20/32','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4143488598) ,ROW('87257042','Taiwán'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Celeste','Jessica','Maravilla','Quiroga','1969-05-14','hermano',ROW(58,2124055055) ), ROW('Perla','Gloria','Lima','Valentin','1969-05-14','hermano',ROW(58,2128248567) )]::familiar_ty[], ARRAY[ ROW('86266460','Zimbabue')]::identificacion_ty[], ARRAY[ ROW('Economía','null','null'), ROW('Criminología','null','null') ]::nivel_educativo_ty[],null,'33'),
('Constancia','Sheila','Olivo','Cifuentes','1990-08-28',185,69,'marrón claro','20/20','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2617701710) ,ROW('10951253','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Javier','Valentin','Aguirre','Covarrubias','1954-01-12','padre',ROW(58,2613766481) ), ROW('Dulcinea',null,'Pizarro','Santiago','1954-01-12','padre',ROW(58,2615339812) )]::familiar_ty[], ARRAY[ ROW('67705000','Australia'),row('89817176','Uganda') ]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null')]::nivel_educativo_ty[],null,'34'),
('Sebastian',null,'Mitchell','Hill','1997-12-16',151,75,'verde claro','20/32','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2445752091) ,ROW('90175740','Irlanda'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Arturo',null,'Villa','Tejeda','1945-07-24','abuelo',ROW(58,4125122784) ), ROW('Mia','Caridad','Avalos','Castaneda','1945-07-24','hermano',ROW(58,4125195244) )]::familiar_ty[], ARRAY[ ROW('76417890','Australia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ingeniería Informática','null','null') ]::nivel_educativo_ty[],null,'34'),
('Gabriela',null,'Vallejo','Holguin','1983-09-16',164,71,'verde claro','20/160','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2124182379) ,ROW('48148974','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Gabriel','Caligula','Batista','Moreno','1967-09-29','abuelo',ROW(58,2128902943) ), ROW('Benicio','Victor','Morris','Gray','1967-09-29','hermano',ROW(58,2127197016) )]::familiar_ty[], ARRAY[ ROW('66763426','Australia')]::identificacion_ty[], ARRAY[ ROW('Derecho','null','null')]::nivel_educativo_ty[],null,'34'),
('Ema','Chantal','Ramirez','Mendez','1991-01-31',186,86,'marrón oscuro','20/32','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2443451374) ,ROW('97392406','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Amelia','Veronica','Huerta','Quesada','1955-01-04','madre',ROW(58,2446002152) ), ROW('Marsello',null,'Carpio','Thomas','1955-01-04','madre',ROW(58,2441977699) )]::familiar_ty[], ARRAY[ ROW('98507303','Australia'),row('21946037','Uganda') ]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null'), ROW('Ingeniería Informática','Máster','Inteligencia Artificial') ]::nivel_educativo_ty[],null,'35'),
('Heidi',null,'Luciano','Aguayo','1999-09-15',174,71,'verde oscuro','20/25','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4146509559) ,ROW('74832616','Irlanda'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Johanna',null,'Ayala','Bocanegra','1946-05-25','primo',ROW(58,2123844815) ), ROW('Camilo','Breno','Larios','Irizarry','1946-05-25','hermano',ROW(58,2125246310) )]::familiar_ty[], ARRAY[ ROW('46107042','Australia')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Comunicación','null','null') ]::nivel_educativo_ty[],null,'35'),
('Benedicto',null,'Melgar','Arevalo','1984-05-23',175,70,'verde oscuro','20/125','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4241790394) ,ROW('50378948','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Ciceron','Regulo','Luevano','Samaniego','1967-10-01','primo',ROW(58,4248213116) ), ROW('Santiago','Angel','Magallanes','Catalan','1967-10-01','hermano',ROW(58,4249074168) )]::familiar_ty[], ARRAY[ ROW('66952979','Australia')]::identificacion_ty[], ARRAY[ ROW('Criminología','null','null')]::nivel_educativo_ty[],null,'35'),
('Waldetrudis','Lucila','Angulo','Barajas','1991-05-25',185,79,'verde claro','20/25','confidencial',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4141686021) ,ROW('88039234','Groenlandia'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Rafael','Amador','Solis','Garcia','1955-09-08','hermano',ROW(58,4148275755) ), ROW('Antonio',null,'Recinos','Santacruz','1955-09-08','hermano',ROW(58,4141386237) )]::familiar_ty[], ARRAY[ ROW('96945124','Australia'),row('40968680','Zimbabue') ]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null'), ROW('Comunicación','Máster','Comunicación Intercultural') ]::nivel_educativo_ty[],null,'36'),
('Faustino',null,'Camarillo','Carreno','1999-09-21',163,79,'azul oscuro','20/20','top_secret',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,4128188205) ,ROW('37643473','Irlanda'),ARRAY['inglés','árabe','portugués','francés']::varchar(50)[], ARRAY[ ROW('Ignacio',null,'Gallardo','Corrales','1947-09-12','tío',ROW(58,4242643231) ), ROW('Foster','Hercules','Palma','Palomino','1947-09-12','abuelo',ROW(58,4244868574) )]::familiar_ty[], ARRAY[ ROW('57976029','Australia')]::identificacion_ty[], ARRAY[ ROW('Enfermería','null','null'), ROW('Ingeniería Industrial','null','null') ]::nivel_educativo_ty[],null,'36'),
('Marcelo',null,'Parada','Alcantar','1984-12-24',179,77,'azul oscuro','20/100','no_clasificado',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_digital.png'),FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/huella_retina.png'),ROW(58,2872981731) ,ROW('38336640','Taiwán'),ARRAY['español','inglés','hindi','ruso','mandarín']::varchar(50)[], ARRAY[ ROW('Irma','Natividad','Cordova','Torrez','1971-01-05','primo',ROW(58,4121629139) ), ROW('Samuel','Tulio','Rolon','Henderson','1971-01-05','abuelo',ROW(58,4128149218) )]::familiar_ty[], ARRAY[ ROW('33377073','Australia')]::identificacion_ty[], ARRAY[ ROW('Psicología','null','null')]::nivel_educativo_ty[],null,'36');


--select ((familiares))::varchar[] from personal_inteligencia ;

--select * from personal_inteligencia ;

-- PERSONAL_INTELIGENCIA.aliases[]
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bertrudis','Viviana','Sanchez','Serna',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1993-09-21','Argentina',39794059,'marrón oscuro','Tucson, AZ 85718','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 2;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bienvenido','Vivaldo','Salmeron','Sarmiento',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2002-05-06','Taiwán',40559018,'azul oscuro','Kennesaw, GA 30144','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 4;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adrian','Vitalicio','Ward','Zambrano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1982-05-28','Argentina',72828593,'azul oscuro','93 Sunbeam Drive ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 6;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anastasia','Victor','Toro','Valentin',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2000-09-18','Malasia',76942186,'verde oscuro','Nashville, TN 37205','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 8;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Brandon','Vicente','Salguero','Santiago',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2007-01-29','Malasia',73098156,'marrón claro','Germantown, MD 20874','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 10;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adolfo','Vicente','Zaragoza','Zaragoza',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1973-02-07','Holanda',23155030,'azul claro','586 Bear Hill Court ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 12;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alba','Veronica','Vidal','Villa',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2006-08-18','Zimbabue',94219591,'verde claro','Stroudsburg, PA 18360','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 14;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alma','Vanesa','Valles','Velazquez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-07-14','Holanda',93788472,'verde oscuro','West Bloomfield, MI 48322','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 16;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Valentina','Serrano','Stewart',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1965-06-03','Uganda',94840883,'azul claro','Madison Heights, MI 48071','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 18;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aidana','Tulio','Villareal','Villatoro',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1995-05-19','Malasia',64619158,'verde oscuro','Richardson, TX 75080','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 20;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Andres','Tulio','Terrazas','Valdivia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2004-03-15','Uganda',99567426,'azul claro','West Haven, CT 06516','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 22;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Abelardo','Trinidad','Zuniga','Zuniga',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1964-12-31','Irlanda',18003181,'marrón oscuro','9161 Court Street ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 24;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bella','Tarsicio','Serrato','Sullivan',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-02-15','Uganda',97325556,'verde oscuro','Bedford, OH 44146','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 26;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Atenea','Tarsicio','Stevens','Teran',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1985-08-22','Groenlandia',55392472,'marrón oscuro','Elkridge, MD 21075','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 28;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Berta','Soledad','Sandoval','Serrato',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1990-12-04','Groenlandia',39013095,'azul claro','Longview, TX 75604','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 30;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alana','Santiago','Vidal','Villalobos',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2000-06-05','Uganda',65981559,'marrón oscuro','Milledgeville, GA 31061','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 32;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aurelio','Saida','Soliz','Tejeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1996-08-09','Taiwán',88309073,'azul oscuro','Casselberry, FL 32707','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 34;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Berenice','Rosaura','Santiago','Sifuentes',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1982-09-23','Holanda',97186591,'marrón oscuro','Thibodaux, LA 70301','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 36;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alan','Renato','Villa','Villarreal',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1999-03-19','Uganda',57484344,'azul claro','Maplewood, NJ 07040','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 38;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Ramona','Segura','Solorzano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1971-12-24','Australia',29831792,'verde claro','Tupelo, MS 38801','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 40;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Breno','Pilar','Saldana','Santiago',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-09-15','Malasia',79845444,'marrón oscuro','Glen Allen, VA 23059','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 42;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anastasia','Petronila','Torrez','Valerio',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1999-02-16','Malasia',39725738,'marrón oscuro','Meadville, PA 16335','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 44;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alejandro','Paulo','Verdugo','Vicente',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-08-18','Australia',45560993,'azul oscuro','Round Lake, IL 60073','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 46;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alfredo','Orosio','Vargas','Vera',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1973-12-12','Irlanda',20218427,'marrón oscuro','Shakopee, MN 55379','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 48;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Angel','Orosio','Tello','Valadez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2005-05-04','Zimbabue',48566663,'marrón oscuro','East Brunswick, NJ 08816','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 50;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ayala','Ophelia','Solis','Tamez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2007-03-05','Malasia',90611411,'marrón oscuro','Miami Gardens, FL 33056','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 52;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Antonio','Nathaly','Tavarez','Urena',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1968-01-12','Australia',88091838,'azul oscuro','Orchard Park, NY 14127','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 54;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Arturo','Myriam','Sullivan','Tolentino',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-07-31','Holanda',53170592,'verde oscuro','Lorton, VA 22079','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 56;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ana','Michael','Ulloa','Valle',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1996-09-25','Taiwán',62612183,'marrón claro','Woodbridge, VA 22191','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 58;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bibiana','Melina','Samaniego','Scott',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1996-01-26','Argentina',36247798,'verde claro','Lake Mary, FL 32746','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 60;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Caligula','Melchor','Saavedra','Santacruz',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1969-09-17','Uganda',46978646,'verde oscuro','Arlington, MA 02474','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 62;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Abigail','Maximo','Zelaya','Zayas',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1970-03-20','Irlanda',60979224,'verde oscuro','7399 Brickyard St. ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 64;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bernarda','Maximo','Santana','Sierra',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1986-10-17','Holanda',72588079,'verde oscuro','Mason, OH 45040','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 66;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amelia','Maximo','Valdivia','Valverde',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1990-05-03','Argentina',91050198,'verde claro','Venice, FL 34293','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 68;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aleyda','Maximiliano','Velasco','Verdugo',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1967-02-15','Australia',99242558,'marrón claro','West Springfield, MA 01089','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 70;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amanda','Mariluz','Valerio','Velarde',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1983-06-07','Groenlandia',73523260,'marrón oscuro','Zionsville, IN 46077','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 72;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Agnes','Mariana','Villeda','Walker',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1989-03-16','Taiwán',29778317,'marrón oscuro','Chillicothe, OH 45601','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 74;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benigno','Mariam','Sauceda','Simon',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-06-12','Australia',22868275,'azul oscuro','Palm Harbor, FL 34683','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 76;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Antonio','Margarita','Tamez','Trejo',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1971-06-15','Irlanda',57996320,'marrón claro','Cheshire, CT 06410','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 78;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Araceli','Marcial','Tafoya','Torrez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1972-08-11','Irlanda',47494018,'marrón oscuro','Georgetown, SC 29440','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 80;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benjamin','Marcela','Santillan','Silva',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1979-03-29','Irlanda',96303281,'marrón claro','Maumee, OH 43537','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 82;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adolfo','Mabel','Yepez','Zapata',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1974-12-30','Groenlandia',62878182,'marrón oscuro','29 Golf St. ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 84;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Lucrecia','Serna','Soria',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1968-08-05','Zimbabue',72372788,'marrón oscuro','Winston Salem, NC 27103','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 86;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aurelio','Lorena','Soriano','Tejeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1994-08-02','Argentina',51949025,'verde claro','New York, NY 10002','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 88;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adriana','Lincoln','Viramontes','Watson',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1987-06-01','Taiwán',52531353,'marrón claro','8417 South Brandywine Rd. ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 90;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amparo','Liliana','Valadez','Vallejo',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1994-03-07','Argentina',66552946,'azul oscuro','Nottingham, MD 21236','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 92;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ashley','Leopoldo','Suarez','Thompson',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1980-06-12','Groenlandia',22457934,'azul claro','Lake Villa, IL 60046','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 94;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adria','Leopoldo','Wilson','Zamora',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1980-03-31','Groenlandia',70689277,'verde claro','9638 Greenrose Road ','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 96;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ava','Leonardo','Solis','Tavarez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2004-05-20','Taiwán',43195703,'marrón claro','Lawrenceville, GA 30043','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 98;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amada','Leon','Vallejo','Velasquez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-12-30','Holanda',23444439,'azul claro','Adrian, MI 49221','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 100;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anthony','Klement','Tellez','Uribe',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1966-06-15','Zimbabue',44190141,'verde claro','New Berlin, WI 53151','2035-04-09 07:00:00' )::alias_ty)	 WHERE id = 102;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Arturo','Guadalupe','Sullivan','Tobar',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1980-04-16','Holanda',50444013,'azul oscuro','1 Baker Court ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 2;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Betsabe','Liliana','Sanabria','Segovia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1995-05-17','Argentina',90303068,'marrón oscuro','1 Shirley Drive ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 4;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alan','Adan','Vigil','Villalpando',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2000-01-03','Uganda',40757806,'marrón claro','121 Lincoln Lane ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 6;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Antonella','Consuelo','Tejeda','Urias',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1966-08-26','Australia',79031778,'verde oscuro','14 N. Southampton Dr. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 8;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ayala','Gloria','Solis','Tapia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2005-10-25','Malasia',25323734,'marrón oscuro','15 SW. Gates Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 10;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bibiana','Celia','Salmeron','Sarmiento',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1999-12-14','Taiwán',80919225,'verde oscuro','235 Orchard Dr. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 12;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ayala','Eleazar','Smith','Tafoya',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-01-03','Malasia',71818044,'verde claro','3 Cedarwood Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 14;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Antonio','Vivaldo','Tamez','Umana',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1970-09-16','Australia',34265217,'azul claro','34 Cross St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 16;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ava','Maximiliano','Soliz','Taveras',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2003-08-08','Taiwán',29286791,'azul claro','367 West Cedarwood Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 18;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Caligula','Mariana','Saavedra','Santacruz',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1970-10-02','Uganda',78102467,'azul oscuro','4 Division Circle ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 20;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anastasia','Dante','Trejo','Valladares',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1998-02-18','Taiwán',44890413,'marrón oscuro','417 North Cedar St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 22;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Angela','Esperanza','Tellez','Uribe',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1965-05-26','Zimbabue',44795450,'marrón oscuro','474 Primrose Rd. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 24;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Andres','Aidana','Tenorio','Valdes',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2004-07-13','Uganda',78933613,'marrón claro','567 Brickyard St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 26;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benita','Mariluz','Santoyo','Silva',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1977-02-23','Irlanda',87519420,'azul claro','60 Leatherwood Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 28;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bruno','Vicente','Salcedo','Santamaria',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1968-01-03','Uganda',20273309,'verde claro','637 Elizabeth Dr. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 30;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alan','Nathaly','Villanueva','Villarreal',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1995-07-06','Malasia',89479928,'azul oscuro','65 Johnson Drive ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 32;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alba','Klement','Vidal','Villa',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2002-04-12','Zimbabue',27684565,'marrón oscuro','666 Princeton Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 34;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Brandon','Angel','Salinas','Sarabia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2005-04-04','Taiwán',92579393,'azul claro','67 Vermont Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 36;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aleyda','Gracia','Velasco','Vera',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1967-11-20','Irlanda',40678396,'marrón oscuro','7049 Bradford Court ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 38;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benicio','Lorena','Sauceda','Solorio',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1974-08-30','Australia',67276837,'verde oscuro','7497 Pheasant Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 40;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anunciacion','Caridad','Tafoya','Toscano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1972-06-09','Irlanda',85046113,'marrón oscuro','7810 Marshall Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 42;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aleyda','Vitalicio','Ventura','Verduzco',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1965-04-16','Australia',49398743,'azul claro','7965 Academy Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 44;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Agustin','Juan','Villeda','Villeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1993-04-14','Malasia',13945007,'verde claro','8011 Kirkland Road ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 46;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bernarda','Guadalupe','Santana','Sifuentes',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1983-04-26','Holanda',65569169,'verde claro','8201 Old Arrowhead Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 48;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Maximo','Segura','Solorzano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1969-07-22','Zimbabue',45992348,'marrón oscuro','8351 E. Young St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 50;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Arturo','Hercules','Tafoya','Tolentino',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-01-17','Holanda',25512067,'verde claro','8466 Lakeview Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 52;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Brenda','Isabella','Salgado','Santiago',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2010-09-23','Malasia',16821110,'marrón oscuro','8487 W. Foxrun Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 54;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aurelia','Calixtrato','Sorto','Tello',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1985-11-11','Argentina',65407611,'marrón oscuro','858 Franklin Drive ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 56;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Anastasia','Eneida','Torres','Valerio',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2000-04-03','Malasia',50134371,'verde claro','8794 Old Cobblestone Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 58;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Aurelio','Corania','Solorio','Tejeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1996-01-05','Argentina',46450821,'verde oscuro','884 Glenridge Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 60;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'America','Rosaura','Valdez','Valles',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1990-07-24','Argentina',86622561,'verde oscuro','893 South Stonybrook Dr. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 62;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Ana','Veronica','Umana','Vallejo',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1994-09-06','Taiwán',18467817,'azul claro','8966 High Drive ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 64;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amanda','Tulio','Vallejo','Velasquez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1982-03-05','Groenlandia',79164693,'marrón claro','9036 Harvey Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 66;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bernarda','Michael','Santamaria','Servin',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1990-01-26','Groenlandia',83415767,'azul oscuro','917 Ketch Harbour St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 68;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bertrudis','Saida','Sandoval','Serrato',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1991-08-22','Groenlandia',53815695,'marrón claro','9205 Carson Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 70;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benedicto','Klement','Serna','Sosa',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1965-09-20','Zimbabue',74305778,'marrón claro','922 North Brown Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 72;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alicia','Jaime','Valverde','Veliz',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-06-03','Irlanda',26775064,'verde claro','9414 Fawn St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 74;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Altagracia','Paulo','Valles','Velazquez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1975-10-27','Holanda',39666670,'azul oscuro','944 Shadow Brook Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 76;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Benjamin','Felix','Santillan','Sifuentes',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1981-11-20','Irlanda',47803369,'marrón oscuro','954 Lyme Road ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 78;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Andres','Lincoln','Toledo','Valdivia',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2002-05-07','Uganda',93493532,'azul oscuro','9552 Beach Ave. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 80;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Alba','Mabel','Verduzco','Viera',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2010-11-25','Zimbabue',32861153,'verde oscuro','9619 Jennings Rd. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 82;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Amara','Alan','Valerio','Velarde',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1989-03-23','Groenlandia',35495666,'marrón oscuro','962 St Paul St. ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 84;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Bella','Orosio','Serrano','Suarez',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'2011-05-23','Uganda',78836787,'azul oscuro','9822 High Noon Street ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 86;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Atenea','Cesar','Suarez','Thomas',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1984-04-26','Groenlandia',38144260,'marrón claro','9951 Lyme Road ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 88;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adria','Zamira','Wright','Zamora',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1977-10-31','Groenlandia',98124904,'marrón oscuro','Atlantic City, NJ 08401','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 90;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adan','Tarsicio','Zavala','Zarate',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1971-04-19','Holanda',35618221,'azul oscuro','Chattanooga, TN 37421','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 92;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Abigail','Soledad','Zepeda','Zepeda',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1966-05-13','Irlanda',90693292,'verde claro','Leland, NC 28451','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 94;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adria','Eduviges','Ward','Zambrano',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1980-05-19','Argentina',23482544,'verde oscuro','Mc Lean, VA 22101','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 96;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adrian','Constantino','Walker','White',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1982-10-08','Argentina',77240684,'azul claro','Patchogue, NY 11772','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 98;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adolfo','Berenice','Zacarias','Zaragoza',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1974-10-04','Holanda',54104127,'marrón claro','Peachtree City, GA 30269','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 100;
UPDATE personal_inteligencia SET aliases = array_append(aliases,  ROW( 'Adriana','Eliana','Villeda','Ward',FORMATO_ARCHIVO_A_BYTEA('personal_inteligencia_data/foto.png'),'1987-10-13','Taiwán',77246173,'marrón oscuro','Unit 7 ','2035-05-09 07:00:00' )::alias_ty)	 WHERE id = 102;

----AREA INTERES
INSERT INTO area_interes (fk_clas_tema, fk_cliente) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(1, 10),
(2, 11),
(3, 12),
(4, 13),
(5, 14),
(6, 15),
(7, 16),
(8, 17),
(9, 18),
(4, 19),
(5, 20);


-- HIST_CARGO

INSERT INTO HIST_CARGO (fecha_inicio, fecha_fin, cargo,  fk_personal_inteligencia, fk_estacion, fk_oficina_principal) VALUES 
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',1,1,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',2,1,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',3,1,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',4,1,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',5,2,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',6,2,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',7,2,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',8,2,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',9,3,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',10,3,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',11,3,1),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',12,3,1),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',13,4,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',14,4,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',15,4,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',16,4,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',17,5,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',18,5,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',19,5,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',20,5,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',21,6,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',22,6,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',23,6,2),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',24,6,2),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',25,7,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',26,7,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',27,7,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',28,7,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',29,8,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',30,8,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',31,8,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',32,8,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',33,9,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',34,9,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',35,9,3),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',36,9,3),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',37,10,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',38,10,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',39,10,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',40,10,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',41,11,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',42,11,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',43,11,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',44,11,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',45,12,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',46,12,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',47,12,4),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',48,12,4),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',49,13,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',50,13,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',51,13,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',52,13,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',53,14,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',54,14,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',55,14,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',56,14,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',57,15,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',58,15,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',59,15,5),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',60,15,5),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',61,16,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',62,16,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',63,16,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',64,16,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',65,17,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',66,17,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',67,17,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',68,17,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',69,18,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',70,18,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',71,18,6),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',72,18,6),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',73,19,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',74,19,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',75,19,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',76,19,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',77,20,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',78,20,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',79,20,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',80,20,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',81,21,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',82,21,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',83,21,7),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',84,21,7),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',85,22,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',86,22,8),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',87,22,8),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',88,23,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',89,23,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',90,23,8),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',91,24,8),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',92,24,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',93,24,8),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',94,25,9),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',95,25,9),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',96,25,9),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',97,26,9),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',98,26,9),
('2034-01-06 01:00:00','2035-03-12 07:00:00','agente',99,26,9),
('2034-01-06 01:00:00','2035-03-12 07:00:00','analista',100,27,9),
('2034-01-05 01:00:00','2035-03-09 07:00:00','agente',101,27,9),
('2034-01-05 01:00:00','2035-03-09 07:00:00','analista',102,27,9),
('2035-03-09 07:00:00',null,'analista',1,1,1),
('2035-03-09 07:00:00',null,'agente',2,1,1),
('2035-03-12 07:00:00',null,'analista',3,1,1),
('2035-03-12 07:00:00',null,'agente',4,1,1),
('2035-03-09 07:00:00',null,'analista',5,2,1),
('2035-03-09 07:00:00',null,'agente',6,2,1),
('2035-03-12 07:00:00',null,'analista',7,2,1),
('2035-03-12 07:00:00',null,'agente',8,2,1),
('2035-03-09 07:00:00',null,'analista',9,3,1),
('2035-03-09 07:00:00',null,'agente',10,3,1),
('2035-03-12 07:00:00',null,'analista',11,3,1),
('2035-03-12 07:00:00',null,'agente',12,3,1),
('2035-03-09 07:00:00',null,'analista',13,4,2),
('2035-03-09 07:00:00',null,'agente',14,4,2),
('2035-03-12 07:00:00',null,'analista',15,4,2),
('2035-03-12 07:00:00',null,'agente',16,4,2),
('2035-03-09 07:00:00',null,'analista',17,5,2),
('2035-03-09 07:00:00',null,'agente',18,5,2),
('2035-03-12 07:00:00',null,'analista',19,5,2),
('2035-03-12 07:00:00',null,'agente',20,5,2),
('2035-03-09 07:00:00',null,'analista',21,6,2),
('2035-03-09 07:00:00',null,'agente',22,6,2),
('2035-03-12 07:00:00',null,'analista',23,6,2),
('2035-03-12 07:00:00',null,'agente',24,6,2),
('2035-03-09 07:00:00',null,'analista',25,7,3),
('2035-03-09 07:00:00',null,'agente',26,7,3),
('2035-03-12 07:00:00',null,'analista',27,7,3),
('2035-03-12 07:00:00',null,'agente',28,7,3),
('2035-03-09 07:00:00',null,'analista',29,8,3),
('2035-03-09 07:00:00',null,'agente',30,8,3),
('2035-03-12 07:00:00',null,'analista',31,8,3),
('2035-03-12 07:00:00',null,'agente',32,8,3),
('2035-03-09 07:00:00',null,'analista',33,9,3),
('2035-03-09 07:00:00',null,'agente',34,9,3),
('2035-03-12 07:00:00',null,'analista',35,9,3),
('2035-03-12 07:00:00',null,'agente',36,9,3),
('2035-03-09 07:00:00',null,'analista',37,10,4),
('2035-03-09 07:00:00',null,'agente',38,10,4),
('2035-03-12 07:00:00',null,'analista',39,10,4),
('2035-03-12 07:00:00',null,'agente',40,10,4),
('2035-03-09 07:00:00',null,'analista',41,11,4),
('2035-03-09 07:00:00',null,'agente',42,11,4),
('2035-03-12 07:00:00',null,'analista',43,11,4),
('2035-03-12 07:00:00',null,'agente',44,11,4),
('2035-03-09 07:00:00',null,'analista',45,12,4),
('2035-03-09 07:00:00',null,'agente',46,12,4),
('2035-03-12 07:00:00',null,'analista',47,12,4),
('2035-03-12 07:00:00',null,'agente',48,12,4),
('2035-03-09 07:00:00',null,'analista',49,13,5),
('2035-03-09 07:00:00',null,'agente',50,13,5),
('2035-03-12 07:00:00',null,'analista',51,13,5),
('2035-03-12 07:00:00',null,'agente',52,13,5),
('2035-03-09 07:00:00',null,'analista',53,14,5),
('2035-03-09 07:00:00',null,'agente',54,14,5),
('2035-03-12 07:00:00',null,'analista',55,14,5),
('2035-03-12 07:00:00',null,'agente',56,14,5),
('2035-03-09 07:00:00',null,'analista',57,15,5),
('2035-03-09 07:00:00',null,'agente',58,15,5),
('2035-03-12 07:00:00',null,'analista',59,15,5),
('2035-03-12 07:00:00',null,'agente',60,15,5),
('2035-03-09 07:00:00',null,'analista',61,16,6),
('2035-03-09 07:00:00',null,'agente',62,16,6),
('2035-03-12 07:00:00',null,'analista',63,16,6),
('2035-03-12 07:00:00',null,'agente',64,16,6),
('2035-03-09 07:00:00',null,'analista',65,17,6),
('2035-03-09 07:00:00',null,'agente',66,17,6),
('2035-03-12 07:00:00',null,'analista',67,17,6),
('2035-03-12 07:00:00',null,'agente',68,17,6),
('2035-03-09 07:00:00',null,'analista',69,18,6),
('2035-03-09 07:00:00',null,'agente',70,18,6),
('2035-03-12 07:00:00',null,'analista',71,18,6),
('2035-03-12 07:00:00',null,'agente',72,18,6),
('2035-03-09 07:00:00',null,'analista',73,19,7),
('2035-03-09 07:00:00',null,'agente',74,19,7),
('2035-03-12 07:00:00',null,'analista',75,19,7),
('2035-03-12 07:00:00',null,'agente',76,19,7),
('2035-03-09 07:00:00',null,'analista',77,20,7),
('2035-03-09 07:00:00',null,'agente',78,20,7),
('2035-03-12 07:00:00',null,'analista',79,20,7),
('2035-03-12 07:00:00',null,'agente',80,20,7),
('2035-03-09 07:00:00',null,'analista',81,21,7),
('2035-03-09 07:00:00',null,'agente',82,21,7),
('2035-03-12 07:00:00',null,'analista',83,21,7),
('2035-03-12 07:00:00',null,'agente',84,21,7),
('2035-03-09 07:00:00',null,'analista',85,22,8),
('2035-03-09 07:00:00',null,'agente',86,22,8),
('2035-03-12 07:00:00',null,'analista',87,22,8),
('2035-03-12 07:00:00',null,'agente',88,23,8),
('2035-03-09 07:00:00',null,'analista',89,23,8),
('2035-03-09 07:00:00',null,'agente',90,23,8),
('2035-03-12 07:00:00',null,'analista',91,24,8),
('2035-03-12 07:00:00',null,'agente',92,24,8),
('2035-03-09 07:00:00',null,'analista',93,24,8),
('2035-03-09 07:00:00',null,'agente',94,25,9),
('2035-03-12 07:00:00',null,'analista',95,25,9),
('2035-03-12 07:00:00',null,'agente',96,25,9),
('2035-03-09 07:00:00',null,'analista',97,26,9),
('2035-03-09 07:00:00',null,'agente',98,26,9),
('2035-03-12 07:00:00',null,'analista',99,26,9),
('2035-03-12 07:00:00',null,'agente',100,27,9),
('2035-03-09 07:00:00',null,'analista',101,27,9),
('2035-03-09 07:00:00',null,'agente',102,27,9);



--select aliases from personal_inteligencia pi2 where id = 1;

---INFORMANTES

INSERT INTO informante (nombre_clave, fk_personal_inteligencia_encargado, fk_fecha_inicio_encargado, fk_estacion_encargado, fk_oficina_principal_encargado, fk_empleado_jefe_confidente, fk_personal_inteligencia_confidente, fk_fecha_inicio_confidente, fk_estacion_confidente, fk_oficina_principal_confidente) VALUES
('Ameamezersali', 1, '2034-01-05 01:00:00', 1, 1, 11, null, null, null, null),
('Cuente', 3, '2034-01-06 01:00:00', 1, 1, 11, null, null, null, null),
('Tipini', 5, '2034-01-05 01:00:00', 2, 1, 12, null, null, null, null),
('Matella', 7, '2034-01-06 01:00:00', 2, 1, 12, null, null, null, null),
('Criola', 9, '2034-01-05 01:00:00', 3, 1, 13, null, null, null, null),
('Mentino', 11, '2034-01-06 01:00:00', 3, 1, 13, null, null, null, null),
('Traccion', 13, '2034-01-05 01:00:00', 4, 2, 14, null, null, null, null),
('Oversta', 15, '2034-01-06 01:00:00', 4, 2, 14, null, null, null, null),
('Inforaza', 17, '2034-01-05 01:00:00', 5, 2, null, 15, '2034-01-06 01:00:00', 4, 2),
('Endora', 19, '2034-01-06 01:00:00', 5, 2, null, 17, '2034-01-05 01:00:00', 5, 2),
('Chalida', 21, '2034-01-05 01:00:00', 6, 2, null, 19, '2034-01-06 01:00:00', 5, 2),
('Trustora', 101, '2034-01-05 01:00:00', 27, 9, null, 99, '2034-01-06 01:00:00', 26, 9),
('Impaza', 1, '2034-01-05 01:00:00', 1, 1, null, 17, '2034-01-05 01:00:00', 5, 2),
('Clari', 3, '2034-01-06 01:00:00', 1, 1, null, 15, '2034-01-06 01:00:00', 4, 2),
('Monerte', 5, '2034-01-05 01:00:00', 2, 1, null, 13, '2034-01-05 01:00:00', 4, 2),
('Accuenti', 7, '2034-01-06 01:00:00', 2, 1, null, 11, '2034-01-06 01:00:00', 3, 1),
('Advazon', 9, '2034-01-05 01:00:00', 3, 1, null, 9, '2034-01-05 01:00:00', 3, 1),
('Promante', 11, '2034-01-06 01:00:00', 3, 1, null, 7, '2034-01-06 01:00:00', 2, 1),
('Evantino', 13, '2034-01-05 01:00:00', 4, 2, null, 5, '2034-01-05 01:00:00', 2, 1),
('Advinco', 15, '2034-01-06 01:00:00', 4, 2, null, 3, '2034-01-06 01:00:00', 1, 1),
('Inforwer', 17, '2034-01-05 01:00:00', 5, 2, null, 1, '2034-01-05 01:00:00', 1, 1);


--CRUDOS

INSERT INTO crudo (contenido, tipo_contenido, resumen, fuente, valor_apreciacion, nivel_confiabilidad_inicial, nivel_confiabilidad_final, fecha_obtencion, fecha_verificacion_final, cant_analistas_verifican, fk_clas_tema, fk_informante, fk_estacion_pertenece, fk_oficina_principal_pertenece, fk_estacion_agente, fk_oficina_principal_agente, fk_fecha_inicio_agente, fk_personal_inteligencia_agente) VALUES
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen.jpg'), 'imagen', 'Problemas politicos en Vitnam I', 'secreta', 500, 85, 85 , '2034-01-05 01:00:00', '2034-12-02 17:00:00', 2, 1, 1, 1, 1, 1, 1, '2034-01-05 01:00:00', 1),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen.jpg'), 'imagen', 'Problemas politicos en Vitnam II', 'secreta', 550, 87, 10 , '2034-01-05 01:00:00', '2034-11-03 07:00:00', 2, 7, 2, 1, 1, 1, 1, '2034-01-06 01:00:00', 3),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen.jpg'), 'imagen', 'Consecuencias de problemas politicos por territorio', 'secreta', 560, 88, 90 , '2034-01-06 01:00:00', '2034-10-04 02:00:00', 2, 8, 3, 2, 1, 2, 1, '2034-01-05 01:00:00', 5),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen4.jpg'), 'imagen', 'Manifestaciones por cambio de leyes', 'secreta', 570, 85, 85 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 9, 4, 2, 1, 2, 1, '2034-01-06 01:00:00', 7),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen2.jpg'), 'imagen', 'Consecuencias de problemas politicos por petroleo en otros territorios', 'secreta', 580, 93, 90 , '2034-01-05 01:00:00', '2035-01-05 01:00:00', 2, 9, 5, 3, 1, 3, 1, '2034-01-05 01:00:00', 9),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen2.jpg'), 'imagen', 'Resultado de guerras entre paises ', 'secreta', 590, 85, 60 , '2034-01-06 01:00:00', '2034-07-07 05:00:00', 2, 8, 6, 3, 1, 3, 1, '2034-01-06 01:00:00', 11),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen2.jpg'), 'imagen', 'Consecuencias de problemas politicos ', 'secreta', 600, 90, 90 , '2034-01-06 01:00:00', '2034-11-03 07:00:00', 3, 9, 7, 4, 2, 4, 2, '2034-01-05 01:00:00', 13),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen4.jpg'), 'imagen', 'Manifestaciones por digustos de una población por el abuso de poder', 'secreta', 610, 85, 70 , '2034-01-05 01:00:00', '2034-10-04 02:00:00', 3, 9, 8, 4, 2, 4, 2, '2034-01-06 01:00:00', 15),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto2.txt'), 'texto', 'Conflictos entre paises por poder II', 'abierta', 620, 93, 90 , '2034-01-05 01:00:00', '2035-01-05 01:00:00', 2, 1, null, 5, 2, 5, 2, '2034-01-05 01:00:00', 17),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto2.txt'), 'texto', 'Conflictos entre paises por poder II', 'tecnica', 630, 88, 80 , '2034-01-06 01:00:00', '2035-01-05 01:00:00', 2, 1, null, 5, 2, 5, 2, '2034-01-06 01:00:00', 19),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto2.txt'), 'texto', 'Tension entre paises y sus consecuencias', 'secreta', 640, 90, 80 , '2034-01-05 01:00:00', '2034-02-28 07:00:00', 2, 1, 9, 6, 2, 6, 2, '2034-01-05 01:00:00', 21),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto2.txt'), 'texto', 'Resultados de los conflictos I', 'abierta', 650, 85, 85 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 8, null, 27, 9, 27, 9, '2034-01-05 01:00:00', 101),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'Resultados de los conflictos II', 'tecnica', 660, 88, 95 , '2034-01-06 01:00:00', '2035-01-05 01:00:00', 2, 8, null, 1, 1, 1, 1, '2034-01-05 01:00:00', 1),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'Resultados de conflictos entre grupo de personas', 'secreta', 670, 94, 60 , '2034-01-06 01:00:00', '2035-01-05 01:00:00', 2, 1, 10, 1, 1, 1, 1, '2034-01-06 01:00:00', 3),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/texto.txt'), 'texto', 'Resultados de conflictos entre grupo de personas II', 'abierta', 680, 88, 60 , '2034-01-06 01:00:00', '2034-02-28 07:00:00', 3, 8, null, 2, 1, 2, 1, '2034-01-05 01:00:00', 5),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/audio.mp3'), 'sonido', 'Agresion de grupo de personas en la via publica', 'tecnica', 690, 90, 90 , '2034-01-05 01:00:00', '2035-03-10 06:00:00', 3, 2, null, 2, 1, 2, 1, '2034-01-06 01:00:00', 7),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/audio.mp3'), 'sonido', 'Agresion de grupo de personas en la via publica', 'secreta', 700, 87, 85 , '2034-01-06 01:00:00', '2035-01-06 01:00:00', 2, 2, 11, 3, 1, 3, 1, '2034-01-05 01:00:00', 9),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/audio.mp3'), 'sonido', 'Conflictos en calle con individuos', 'abierta', 710, 95, 30 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 2, null, 3, 1, 3, 1, '2034-01-06 01:00:00', 11),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/formulas.mp4'), 'video', 'Formulas para las empresas', 'tecnica', 720, 87, 35 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 4, null, 4, 2, 4, 2, '2034-01-05 01:00:00', 13),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen3.png'), 'imagen', 'Planificacin de marketing', 'secreta', 730, 93, 66 , '2034-01-05 01:00:00', '2035-01-06 01:00:00', 2, 3, 12, 4, 2, 4, 2, '2034-01-06 01:00:00', 15),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/planos.png'), 'imagen', 'Investigacion de planos para construcción', 'abierta', 740, 94, 45 , '2034-01-05 01:00:00', '2034-07-07 05:00:00', 2, 8, null, 5, 2, 5, 2, '2034-01-05 01:00:00', 17),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/planos.png'), 'imagen', 'Planificacion de marketing', 'tecnica', 750, 96, 90 , '2034-01-06 01:00:00', '2035-01-06 01:00:00', 2, 3, null, 5, 2, 5, 2, '2034-01-06 01:00:00', 19),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/imagen3.png'), 'imagen', 'Organizacion de marketing', 'abierta', 760, 88, 89 , '2034-01-05 01:00:00', '2034-07-04 02:00:00', 3, 3, null, 6, 2, 6, 2, '2034-01-05 01:00:00', 21),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/planos.png'), 'imagen', 'Investigacion de planos para construcción', 'abierta', 770, 88, 88 , '2034-01-05 01:00:00', '2034-05-19 07:00:00', 3, 8, null, 1, 1, 1, 1, '2034-01-05 01:00:00', 1),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por problemas economicos', 'tecnica', 780, 90, 85 , '2034-01-05 01:00:00', '2036-01-06 01:00:00', 2, 8, null, 3, 1, 3, 1, '2034-01-06 01:00:00', 11),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por malas decisiones del directivo part I', 'secreta', 790, 98, 10 , '2034-01-05 01:00:00', '2036-01-06 01:00:00', 2, 6, 1, 4, 2, 4, 2, '2034-01-05 01:00:00', 13),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por malas decisiones del directivo part II', 'secreta', 800, 88, 90 , '2034-01-06 01:00:00', '2036-01-05 01:00:00', 2, 3, 3, 4, 2, 4, 2, '2034-01-06 01:00:00', 15),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por malas decisiones del directivo part I', 'secreta', 810, 98, 85 , '2034-01-05 01:00:00', '2036-01-06 01:00:00', 2, 8, 5, 5, 2, 5, 2, '2034-01-05 01:00:00', 17),
(FORMATO_ARCHIVO_A_BYTEA('crudo_contenido/images.jpg'), 'imagen', 'Empresa en quiebra por malas decisiones del directivo part I', 'secreta', 820, 88, 90 , '2034-01-05 01:00:00', '2036-01-05 01:00:00', 2, 6, 7, 1, 1, 1, 1, '2034-01-05 01:00:00', 1);


-- ANALISTA_CRUDO

INSERT INTO analista_crudo (fecha_hora, nivel_confiabilidad, fk_crudo, fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista, fk_oficina_principal_analista) VALUES
('2034-01-05 01:00:00', 85, 1, '2034-01-05 01:00:00',10,3,1),
('2034-12-02 17:00:00', 85, 1, '2034-01-05 01:00:00',6,2,1),
('2034-01-05 01:00:00', 90, 2, '2034-01-06 01:00:00',12,3,1),
('2034-11-03 07:00:00', 85, 2, '2034-01-05 01:00:00',6,2,1),
('2034-01-06 01:00:00', 85, 3, '2034-01-05 01:00:00',10,3,1),
('2034-10-04 02:00:00', 90, 3, '2034-01-05 01:00:00',18,5,2),
('2034-01-05 01:00:00', 90, 4, '2034-01-05 01:00:00',10,3,1),
('2035-01-06 01:00:00', 80, 4, '2034-01-05 01:00:00',14,4,2),
('2034-01-05 01:00:00', 90, 5, '2034-01-05 01:00:00',14,4,2),
('2035-01-05 01:00:00', 95, 5, '2034-01-05 01:00:00',2,1,1),
('2034-01-06 01:00:00', 85, 6, '2034-01-06 01:00:00',16,4,2),
('2034-07-07 05:00:00', 85, 6, '2034-01-05 01:00:00',18,5,2),
('2034-01-06 01:00:00', 90, 7, '2034-01-06 01:00:00',20,5,2),
('2034-01-06 01:00:00', 90, 7, '2034-01-06 01:00:00',12,3,1),
('2034-11-03 07:00:00', 90, 7, '2034-01-05 01:00:00',26,7,3),
('2034-01-05 01:00:00', 85, 8, '2034-01-05 01:00:00',102,27,9),
('2034-01-05 01:00:00', 85, 8, '2034-01-05 01:00:00',10,3,1),
('2034-10-04 02:00:00', 85, 8, '2034-01-05 01:00:00',6,2,1),
('2034-01-05 01:00:00', 90, 9, '2034-01-05 01:00:00',2,1,1),
('2035-01-05 01:00:00', 95, 9, '2034-01-05 01:00:00',6,2,1),
('2034-01-06 01:00:00', 95, 10, '2034-01-06 01:00:00',16,4,2),
('2035-01-05 01:00:00', 80, 10, '2034-01-05 01:00:00',2,1,1),
('2034-01-05 01:00:00', 90, 11, '2034-01-05 01:00:00',26,7,3),
('2034-02-28 07:00:00', 90, 11, '2034-01-05 01:00:00',30,8,3),
('2034-01-05 01:00:00', 85, 12, '2034-01-05 01:00:00',30,8,3),
('2035-01-06 01:00:00', 85, 12, '2034-01-05 01:00:00',34,9,3),
('2034-01-06 01:00:00', 90, 13, '2034-01-06 01:00:00',40,10,4),
('2035-01-05 01:00:00', 85, 13, '2034-01-05 01:00:00',42,11,4),
('2034-01-06 01:00:00', 90, 14, '2034-01-06 01:00:00',44,11,4),
('2035-01-05 01:00:00', 97, 14, '2034-01-05 01:00:00',46,12,4),
('2034-01-06 01:00:00', 90, 15, '2034-01-06 01:00:00',48,12,4),
('2034-01-05 01:00:00', 90, 15, '2034-01-05 01:00:00',50,13,5),
('2034-02-28 07:00:00', 85, 15, '2034-01-05 01:00:00',54,14,5),
('2034-01-05 01:00:00', 90, 16, '2034-01-05 01:00:00',14,4,2),
('2035-01-05 01:00:00', 90, 16, '2034-01-06 01:00:00',28,7,3),
('2035-03-10 06:00:00', 90, 16, '2034-01-05 01:00:00',42,11,4),
('2034-01-06 01:00:00', 85, 17, '2034-01-06 01:00:00',40,10,4),
('2035-01-06 01:00:00', 88, 17, '2034-01-06 01:00:00',20,5,2),
('2034-01-05 01:00:00', 90, 18, '2034-01-05 01:00:00',2,1,1),
('2035-01-06 01:00:00', 100, 18, '2034-01-06 01:00:00',8,2,1),
('2034-01-05 01:00:00', 80, 19, '2034-01-05 01:00:00',22,6,2),
('2035-01-06 01:00:00', 94, 19, '2034-01-06 01:00:00',20,5,2),
('2034-01-05 01:00:00', 90, 20, '2034-01-05 01:00:00',6,2,1),
('2035-01-06 01:00:00', 96, 20, '2034-01-05 01:00:00',2,1,1),
('2034-01-05 01:00:00', 90, 21, '2034-01-06 01:00:00',16,4,2),
('2034-07-07 05:00:00', 98, 21, '2034-01-06 01:00:00',12,3,1),
('2034-01-06 01:00:00', 95, 22, '2034-01-06 01:00:00',24,6,2),
('2035-01-06 01:00:00', 96, 22, '2034-01-06 01:00:00',40,10,4),
('2034-01-05 01:00:00', 80, 23, '2034-01-05 01:00:00',2,1,1),
('2034-01-06 01:00:00', 95, 23, '2034-01-06 01:00:00',20,5,2),
('2034-07-04 02:00:00', 90, 23, '2034-01-05 01:00:00',6,2,1),
('2034-01-05 01:00:00', 80, 24, '2034-01-05 01:00:00',30,8,3),
('2034-03-05 01:00:00', 90, 24, '2034-01-06 01:00:00',12,3,1),
('2034-05-19 07:00:00', 95, 24, '2034-01-05 01:00:00',66,17,6),
('2034-01-05 01:00:00', 95, 25, '2034-01-05 01:00:00',2,1,1),
('2036-01-06 01:00:00', 85, 25, '2034-01-05 01:00:00',14,4,2),
('2034-01-05 01:00:00', 97, 26, '2034-01-05 01:00:00',2,1,1),
('2036-01-06 01:00:00', 98, 26, '2034-01-05 01:00:00',6,2,1),
('2034-01-06 01:00:00', 85, 27, '2034-01-06 01:00:00',8,2,1),
('2036-01-05 01:00:00', 90, 27, '2034-01-05 01:00:00',18,5,2),
('2034-01-05 01:00:00', 97, 28, '2034-01-05 01:00:00',10,3,1),
('2036-01-06 01:00:00', 98, 28, '2034-01-05 01:00:00',14,4,2),
('2034-01-05 01:00:00', 89, 29, '2034-01-05 01:00:00',14,4,2),
('2036-01-05 01:00:00', 87, 29, '2034-01-05 01:00:00',10,3,1);





--TRANSACCION_PAGO

INSERT INTO TRANSACCION_PAGO (fecha_hora, monto_pago, fk_crudo, fk_informante) VALUES
(' 2034-01-08 01:00:00',250,1,1),
(' 2034-01-09 01:00:00',260,2,2),
(' 2035-01-08 01:00:00',270,3,3),
(' 2035-01-09 01:00:00',280,4,4),
(' 2035-01-10 01:00:00',290,5,5),
(' 2035-01-09 01:00:00',300,6,6),
(' 2035-01-11 01:00:00',310,7,7),
(' 2035-02-10 01:00:00',320,8,8),
(' 2035-06-05 01:00:00',320,11,9),
(' 2036-01-20 01:00:00',335,14,10),
(' 2036-03-12 01:00:00',350,17,11),
(' 2036-03-05 01:00:00',365,20,12);



-- PIEZA

INSERT INTO PIEZA_INTELIGENCIA (fecha_creacion, nivel_confiabilidad,  precio_base, class_seguridad,
                                fk_fecha_inicio_analista, fk_personal_inteligencia_analista, fk_estacion_analista,
                                fk_oficina_principal_analista, fk_clas_tema)
                                VALUES
    ('2034-12-02 17:00:00', 90, 1000, 'no_clasificado', '2034-01-05 01:00:00', 2,1,1,1), --CHECK 1
    ('2034-11-03 07:00:00', 88, 1222, 'confidencial', '2034-01-06 01:00:00', 4,1,1,2), --CHECK 2
    ('2034-10-04 02:00:00', 78, 1234, 'no_clasificado', '2034-01-05 01:00:00', 2,1,1,3), --CHECK 3
    ('2035-02-05 03:00:00', 77, 1111, 'no_clasificado', '2034-01-06 01:00:00', 4,1,1,4), --CHECK 4
    ('2035-08-06 04:00:00', 67, 1245, 'top_secret', '2035-03-09 07:00:00', 1,1,1,5), --CHECK 5
    ('2034-07-07 05:00:00', 56, 1234, 'no_clasificado', '2034-01-05 01:00:00', 2,1,1,5), --CHECK 6
    ('2035-06-08 06:00:00', 10, 1249, 'confidencial', '2035-03-12 07:00:00', 3,1,1,6), --CHECK 7
    ('2036-05-09 07:00:00', 99, 1234, 'no_clasificado', '2035-03-09 07:00:00', 5,2,1,7), --CHECK 8
    ('2035-01-09 08:00:00', 100, 999, 'no_clasificado', '2034-01-05 01:00:00', 2,1,1,6), --CHECK 9
    ('2036-01-29 17:00:00', 90, 1000, 'no_clasificado', '2035-03-12 07:00:00', 7,2,1,1), --CHECK 10
    ('2034-02-28 07:00:00', 88, 1222, 'confidencial', '2034-01-06 01:00:00', 4,1,1,7), --CHECK 11
    ('2035-03-27 02:00:00', 78, 1234, 'confidencial', '2035-03-09 07:00:00', 9,3,1,2), --CHECK 12
    ('2035-04-26 03:00:00', 77, 1111, 'top_secret', '2035-03-09 07:00:00', 101,27,9,3), --CHECK 13
    ('2035-05-25 04:00:00', 67, 1245, 'no_clasificado', '2035-03-12 07:00:00', 99,26,9,4), --CHECK 14
    ('2035-06-24 05:00:00', 56, 1234, 'confidencial', '2035-03-09 07:00:00', 97,26,9,6), --CHECK 15
    ('2035-03-10 06:00:00', 10, 1249, 'no_clasificado', '2034-01-06 01:00:00', 4,1,1,1), --CHECK 16
    ('2036-08-22 07:00:00', 99, 1234, 'no_clasificado', '2035-03-12 07:00:00', 95,25,9,4), --CHECK 17
    ('2035-01-21 08:00:00', 100, 999, 'no_clasificado', '2034-01-06 01:00:00', 4,1,1,2), --CHECK 18
    ('2034-03-20 17:00:00', 90, 1000, 'no_clasificado', '2034-01-05 01:00:00', 102,27,9,1), --CHECK 19 
    ('2034-05-19 07:00:00', 88, 1222, 'confidencial', '2034-01-06 01:00:00', 100,27,9,2), --CHECK 20
    ('2034-07-18 02:00:00', 78, 1234, 'no_clasificado', '2034-01-05 01:00:00', 98,26,9,3), --CHECK 21
    ('2035-01-17 03:00:00', 77, 1111, 'confidencial', '2034-01-06 01:00:00', 96,25,9,4), --CHECK 22
    ('2035-03-01 04:00:00', 67, 1245, 'no_clasificado', '2034-01-05 01:00:00', 94,25,9,5), --CHECK 23
    ('2035-01-15 05:00:00', 56, 1234, 'confidencial', '2034-01-06 01:00:00', 92,24,8,6), --CHECK 24
    ('2035-02-14 06:00:00', 10, 1249, 'no_clasificado', '2034-01-05 01:00:00', 90,23,8,7), --CHECK 25
    ('2034-03-13 07:00:00', 99, 1234, 'no_clasificado', '2034-01-05 01:00:00', 86,22,8,1), --CHECK 26
    ('2035-02-18 08:00:00', 100, 999, 'no_clasificado', '2034-01-05 01:00:00', 34,9,3,2) --CHECK 27
;




-- ADQUISICION

INSERT INTO ADQUISICION (fecha_hora_venta, precio_vendido, fk_cliente, fk_pieza_inteligencia) VALUES

-- clientes exclusivos: 1, 2, 5, 6, 9, 10, 13, 14, 17, 18
-- Una pieza de inteligencia de venta exclusiva tiene al menos el 45% de recargo de su precio base.

    ('2035-12-02 17:00:00', 1544, 1, 1),
    ('2034-12-04 07:00:00', 1870, 1, 2),
    ('2034-12-05 02:00:00', 1820, 1, 3),
    ('2036-09-06 03:00:00', 1700, 2, 4),
    ('2035-08-16 04:00:00', 1850, 2, 5),
    ('2036-02-12 17:00:00', 1500, 5, 10),
    ('2034-03-28 07:00:00', 1880, 6, 11),
    ('2035-09-02 04:00:00', 1966, 10, 14),
    ('2035-12-22 17:00:00', 2030, 9, 16),
    ('2034-12-05 02:00:00', 1987, 10, 12), 

-- no exclusivos:

    ('2035-11-07 05:00:00', 2000, 3, 6),
    ('2035-07-08 06:00:00', 1400, 3, 7),
    ('2036-05-19 07:00:00', 1280, 3, 8),
    ('2036-06-09 08:00:00', 1001, 4, 9),
    ('2035-04-27 02:00:00', 1303, 7, 17),
    ('2035-07-26 03:00:00', 1122, 8, 13),
    ('2036-02-24 05:00:00', 1456, 12, 15),
    ('2034-12-04 07:00:00', 1666, 11, 6), 
    ('2036-09-06 03:00:00', 1440, 20, 15),
    ('2035-08-16 04:00:00', 1333, 4, 7), 
    ('2035-11-07 05:00:00', 2000, 7, 8),
    ('2035-07-08 06:00:00', 1111, 8, 18),
    ('2036-05-19 07:00:00', 1281, 11, 8),
    ('2036-06-09 08:00:00', 1233, 12, 19),
    ('2036-02-12 17:00:00', 1200, 15, 19),
    ('2034-03-28 07:00:00', 1770, 16, 20),
    ('2035-04-27 02:00:00', 1322, 16, 21),
    ('2035-07-26 03:00:00', 2222, 16, 13),
    ('2035-09-02 04:00:00', 1800, 19, 25),
    ('2036-02-24 05:00:00', 1777, 20, 26)
    ;




-- CRUDO-PIEZA

INSERT INTO CRUDO_PIEZA ( fk_pieza_inteligencia, fk_crudo) VALUES
    
    -- Exclusivos:
    (1, 1), 
    (1, 6),  
    (1, 20), 
    (2, 2),  
    (2, 7),  
    (2, 21), 
    (3, 3),  
    (3, 8), 
    (3, 23),  
    (4, 4),  
    (4, 9),  
    (5, 5),  
    (5, 12),  
    (10, 10),  
    (10, 13), 
    (11, 11), 
    (11, 15),  
    (12, 22), 
    (12, 19), 
    (14, 14), 
    (14, 17), 
    (16, 16), 
    (16, 18), 


    (6,24),
    (6,25),
    (6,26),
    (7,25),
    (7,27),
    (7,29),
    (8,24),
    (8,26),
    (9,29),
    (9,25),
    (9,27),
    (9,24),
    (13,24),
    (13,26),
    (13,29),
    (15,25),
    (15,26),
    (17,24),
    (17,28),
    (17,29),
    (18,26),
    (18,25),
    (19,25),
    (19,27),
    (19,28),
    (20,24),
    (20,29),
    (21,25),
    (21,28),
    (21,26),
    (21,27),
    (21,29),
    (22,26),
    (22,25),
    (22,28),
    (23,26),
    (23,29),
    (24,24),
    (24,28),
    (25,26),
    (25,25),
    (25,28),
    (26,26),
    (26,28),
    (27,25),
    (27,27),
    (27,29),
    (27,24)
    ;



-- INTENTO NO AUTORIZADO

INSERT INTO INTENTO_NO_AUTORIZADO (fecha_hora, id_pieza,  id_empleado, fk_personal_inteligencia) VALUES

    ('2034-01-01 01:00:00', 2, 11, 2),   -- Est. Dublin. Fk lugar: 10. C
    ('2034-02-07 01:00:00', 5, 12, 5),   -- Est. Cork. 11. T
    ('2034-02-02 01:00:00', 7, 13, 10),  -- Est. Galway. 12. C
    ('2034-03-01 01:00:00', 11, 14, 14), -- Est. Amsterdam 13. C
    ('2035-06-22 01:00:00', 12, 15, 18), -- Est. Roterdam 14. C
    ('2035-09-11 01:00:00', 13, 16, 24), -- Est. Haarlam 15. T
    ('2035-10-21 01:00:00', 15, 17, 26), -- Est. Nuuk 16. C
    ('2035-11-30 01:00:00', 20, 18, 30), -- Est. Qaqortoq 17. C
    ('2035-12-06 01:00:00', 22, 19, 34), -- Est. Sisimiut 18. C
    ('2036-01-13 01:00:00', 24, 20, 39)  -- Est. Buenos Aires 19. C 
;
   
   
   


-------------------------------------- BLOQUE PARA RESTAR 14 AÑOS A TODAS LAS FECHAS ---------------------------------------------




WITH 
	a AS (
   		UPDATE HIST_CARGO SET fecha_inicio = RESTA_14_FECHA_HORA(fecha_inicio), fecha_fin = RESTA_14_FECHA_HORA(fecha_fin)
    ), b as (
   		UPDATE CRUDO SET fecha_obtencion = RESTA_14_FECHA_HORA(fecha_obtencion), fecha_verificacion_final = RESTA_14_FECHA_HORA(fecha_verificacion_final), fk_fecha_inicio_agente = RESTA_14_FECHA_HORA(fk_fecha_inicio_agente) 
	), c as (
		UPDATE TRANSACCION_PAGO SET fecha_hora = RESTA_14_FECHA_HORA(fecha_hora) 
	), d as (
		UPDATE ANALISTA_CRUDO SET fecha_hora = RESTA_14_FECHA_HORA(fecha_hora) , fk_fecha_inicio_analista = RESTA_14_FECHA_HORA(fk_fecha_inicio_analista)
	), e as (
		UPDATE PIEZA_INTELIGENCIA SET fecha_creacion = RESTA_14_FECHA_HORA(fecha_creacion) , fk_fecha_inicio_analista = RESTA_14_FECHA_HORA(fk_fecha_inicio_analista)
	), f as (
		UPDATE ADQUISICION SET fecha_hora_venta = RESTA_14_FECHA_HORA(fecha_hora_venta)
	), g as (
		UPDATE PERSONAL_INTELIGENCIA SET fecha_nacimiento = RESTA_14_FECHA(fecha_nacimiento)
	), i as (
		UPDATE INFORMANTE SET fk_fecha_inicio_encargado = RESTA_14_FECHA_HORA(fk_fecha_inicio_encargado), fk_fecha_inicio_confidente = RESTA_14_FECHA_HORA(fk_fecha_inicio_confidente)
	), j AS (
   		UPDATE HIST_CARGO_ALT SET fecha_inicio = RESTA_14_FECHA_HORA(fecha_inicio), fecha_fin = RESTA_14_FECHA_HORA(fecha_fin)
    ), k as (
   		UPDATE CRUDO_ALT SET fecha_obtencion = RESTA_14_FECHA_HORA(fecha_obtencion), fk_fecha_inicio_agente = RESTA_14_FECHA_HORA(fk_fecha_inicio_agente) 
	), l as (
		UPDATE TRANSACCION_PAGO_ALT SET fecha_hora = RESTA_14_FECHA_HORA(fecha_hora) 
	), m as (
		UPDATE PIEZA_INTELIGENCIA_ALT SET fecha_creacion = RESTA_14_FECHA_HORA(fecha_creacion) , fk_fecha_inicio_analista = RESTA_14_FECHA_HORA(fk_fecha_inicio_analista)
	), n as (
		UPDATE ADQUISICION_ALT SET fecha_hora_venta = RESTA_14_FECHA_HORA(fecha_hora_venta)
	), o as (
		UPDATE CUENTA SET año = RESTA_14_FECHA(año)
	), p as (
		UPDATE INFORMANTE_ALT SET fk_fecha_inicio_encargado = RESTA_14_FECHA_HORA(fk_fecha_inicio_encargado)
	)
UPDATE INTENTO_NO_AUTORIZADO SET fecha_hora = RESTA_14_FECHA_HORA(fecha_hora);	





------------------------------------- BLOQUE PARA COPIAR VENTAS EXCLUSIVAS -----------------------------



CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (11);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (2);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (3);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (12);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (5);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (14);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (1);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (16);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (10);
CALL ELIMINACION_REGISTROS_VENTA_EXCLUSIVA (4);



