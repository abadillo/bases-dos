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

INSERT INTO empleado_jefe (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, tipo, fk_empleado_jefe) VALUES 
('Brandon', 'Constantino', 'Razo', 'Casillas', ROW(412,2390021), 'director_ejecutivo', null),
('Elian', 'Maximo', 'Carter', 'Silva', ROW(412,6699623), 'director_area', 1),
('Fabiano', 'Tarsicio', 'Santamaria', 'Jaquez', ROW(412,3948307), 'director_area', 1),
('Esperanza', 'Ana', 'Corona', 'Granados', ROW(412,1189159), 'director_area', 1),
('Octavia', 'Eduviges', 'Mena', 'Alcantara', ROW(412,3974651), 'director_area', 1),
('Anthony', 'Amilcar', 'Tafoya', 'Buenrostro', ROW(414,1319978), 'director_area', 1),
('Fidel', 'Juan', 'Regalado', 'Machuca', ROW(416,7319514), 'director_area', 1),
('Luna', null, 'Castrejon', 'Narvaez', ROW(412,6345573), 'director_area', 1),
('Klement', null, 'Montiel', 'Salguero', ROW(414,3977631), 'director_area', 1),
('Daniel', null, 'Price', 'Gallardo', ROW(414,3609837), 'director_area', 1),
('Silvester', null, 'Morris', 'Serrato', ROW(412,5343364), 'jefe', 2),
('Pamela', 'Irma', 'Guevara', 'Zapata', ROW(424,2908908), 'jefe', 2),
('Feliciano', 'Jaime', 'Hurtado', 'Baca', ROW(424,2109538), 'jefe', 2),
('Eloisa', 'Petronila', 'Nolasco', 'White', ROW(414,6830298), 'jefe', 3),
('Cayetano', 'Paulo', 'Guillen', 'Miramontes', ROW(412,4866865), 'jefe', 3),
('Constantino', 'Adolfo', 'Bustos', 'Lima', ROW(412,2392031), 'jefe', 3),
('Antonio', 'Tulio', 'Pinto', 'Cordero', ROW(416,3952857), 'jefe', 4),
('Dulcinea', 'Consuelo', 'Pizarro', 'Santiago', ROW(416,7676921), 'jefe', 4),
('Marsello', 'Alan', 'Carpio', 'Thomas', ROW(414,7291221), 'jefe', 4),
('Antonio', 'Diego', 'Recinos', 'Santacruz', ROW(414,4392478), 'jefe', 5),
('Greta', 'Rosaura', 'Valdivia', 'Cruz', ROW(416,1080469), 'jefe', 5),
('Marcela', 'Amelia', 'Galdamez', 'Rogers', ROW(412,6909353), 'jefe', 5),
('Pamela', 'Veronica', 'Torres', 'Diaz', ROW(414,1416359), 'jefe', 6),
('Cayetano', 'Fulgencio', 'Marquez', 'Infante', ROW(424,9630352), 'jefe', 6),
('Jhoan', 'Dante', 'Lucero', 'Orona', ROW(424,6170815), 'jefe', 6),
('Elidio', 'Jonathan', 'Puentes', 'Ozuna', ROW(416,7058298), 'jefe', 7),
('Gloria', null, 'Duque', 'Uribe', ROW(412,4224557), 'jefe', 7),
('Jennifer', null, 'Vigil', 'Aviles', ROW(424,9270841), 'jefe', 7),
('Celeste', 'Soledad', 'Chacon', 'Machado', ROW(412,1229016), 'jefe', 8),
('Vivaldo', 'Tarsicio', 'Rosas', 'Jackson', ROW(412,5018092), 'jefe', 8),
('Mirella', 'Zamira', 'Machuca', 'Magallon', ROW(416,3371835), 'jefe', 8),
('Calixtrato', null, 'Quintanilla', 'Estrada', ROW(414,3049959), 'jefe', 9),
('Libertad', null, 'Garces', 'Casanova', ROW(414,8123924), 'jefe', 9),
('Emperatriz', 'Myriam', 'Angulo', 'Valdivia', ROW(4148,999846), 'jefe', 9),
('Hugo', 'Adan', 'Serrato', 'Barrios', ROW(416,1450123), 'jefe', 10),
('Rosalia', 'Pilar', 'Valles', 'Montes', ROW(414,1292334), 'jefe', 10),
('Claudio', 'Lincoln', 'Sullivan', 'Tafoya', ROW(412,1948734), 'jefe', 10);


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
('Ofi. Ginebra', true, null, 1, 38);


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
('2034-31-12',  10000, 1, 1),
('2035-31-12',  10500, 1, 1),
('2036-31-12',  11000, 1, 1),
('2034-31-12',  12000, 2, 1),
('2035-31-12',  13000, 2, 1),
('2036-31-12',  10000, 2, 1),
('2034-31-12',  10500, 3, 1),
('2035-31-12',  11000, 3, 1),
('2036-31-12',  11500, 3, 1),
('2034-31-12',  10000, 4, 2),
('2035-31-12',  10500, 4, 2),
('2036-31-12',  11000, 4, 2),
('2034-31-12',  10000, 5, 2),
('2035-31-12',  10500, 5, 2),
('2036-31-12',  11000, 5, 2),
('2034-31-12',  12000, 6, 2),
('2035-31-12',  13000, 6, 2),
('2036-31-12',  10000, 6, 2),
('2034-31-12',  10500, 7, 3),
('2035-31-12',  11000, 7, 3),
('2036-31-12',  11500, 7, 3),
('2034-31-12',  10000, 8, 3),
('2035-31-12',  10500, 8, 3),
('2036-31-12',  11000, 8, 3),
('2034-31-12',  10000, 9, 3),
('2035-31-12',  10500, 9, 3),
('2036-31-12',  11000, 9, 3),
('2034-31-12',  12000, 10, 4),
('2035-31-12',  13000, 10, 4),
('2036-31-12',  10000, 10, 4),
('2034-31-12',  10500, 11, 4),
('2035-31-12',  11000, 11, 4),
('2036-31-12',  11500, 11, 4),
('2034-31-12',  10000, 12, 4),
('2035-31-12',  10500, 12, 4),
('2036-31-12',  11000, 12, 4),
('2034-31-12',  10000, 13, 5),
('2035-31-12',  10500, 13, 5),
('2036-31-12',  11000, 13, 5),
('2034-31-12',  12000, 14, 5),
('2035-31-12',  13000, 14, 5),
('2036-31-12',  10000, 14, 5),
('2034-31-12',  10500, 15, 5),
('2035-31-12',  11000, 15, 5),
('2036-31-12',  11500, 15, 5),
('2034-31-12',  10000, 16, 6),
('2035-31-12',  10500, 16, 6),
('2036-31-12',  11000, 16, 6),
('2034-31-12',  10000, 17, 6),
('2035-31-12',  10500, 17, 6),
('2036-31-12',  11000, 17, 6),
('2034-31-12',  12000, 18, 6),
('2035-31-12',  13000, 18, 6),
('2036-31-12',  10000, 18, 6),
('2034-31-12',  10500, 19, 7),
('2035-31-12',  11000, 19, 7),
('2036-31-12',  11500, 19, 7),
('2034-31-12',  10000, 20, 7),
('2035-31-12',  10500, 20, 7),
('2036-31-12',  11000, 20, 7),
('2034-31-12',  10000, 21, 7),
('2035-31-12',  10500, 21, 7),
('2036-31-12',  11000, 21, 7),
('2034-31-12',  12000, 22, 8),
('2035-31-12',  13000, 22, 8),
('2036-31-12',  10000, 22, 8),
('2034-31-12',  10500, 23, 8),
('2035-31-12',  11000, 23, 8),
('2036-31-12',  11500, 23, 8),
('2034-31-12',  10000, 24, 8),
('2035-31-12',  10500, 24, 8),
('2036-31-12',  11000, 24, 8),
('2034-31-12',  10000, 25, 9),
('2035-31-12',  10500, 25, 9),
('2036-31-12',  11000, 25, 9),
('2034-31-12',  12000, 26, 9),
('2035-31-12',  13000, 26, 9),
('2036-31-12',  10000, 26, 9),
('2034-31-12',  10500, 27, 9),
('2035-31-12',  11000, 27, 9),
('2036-31-12',  11500, 27, 9),




