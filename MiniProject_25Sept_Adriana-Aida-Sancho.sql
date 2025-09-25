-- Crear base de datos
DROP DATABASE IF EXISTS streaming_musical;
CREATE DATABASE streaming_musical;
USE streaming_musical;

-- Tabla usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    pais VARCHAR(50),
    fecha_registro DATE NOT NULL
);

-- Tabla planes
CREATE TABLE planes (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(6,2) NOT NULL,
    descripcion VARCHAR(200)
);

-- Tabla suscripciones
CREATE TABLE suscripciones (
    id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_plan INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_plan) REFERENCES planes(id_plan)
);

-- Tabla artistas
CREATE TABLE artistas (
    id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    genero_principal VARCHAR(50)
);

-- Tabla albumes
CREATE TABLE albumes (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    id_artista INT,
    titulo VARCHAR(100) NOT NULL,
    fecha_lanzamiento DATE,
    genero VARCHAR(50),
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista)
);

-- Tabla canciones
CREATE TABLE canciones (
    id_cancion INT AUTO_INCREMENT PRIMARY KEY,
    id_album INT,
    titulo VARCHAR(100) NOT NULL,
    duracion TIME NOT NULL,
    reproducciones INT DEFAULT 0,
    FOREIGN KEY (id_album) REFERENCES albumes(id_album)
);

-- Tabla playlists
CREATE TABLE playlists (
    id_playlist INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    nombre VARCHAR(100) NOT NULL,
    fecha_creacion DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla intermedia playlist_canciones (relación N:M)
CREATE TABLE playlist_canciones (
    id_playlist INT,
    id_cancion INT,
    PRIMARY KEY (id_playlist, id_cancion),
    FOREIGN KEY (id_playlist) REFERENCES playlists(id_playlist),
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion)
);

-- Tabla historial de reproducción
CREATE TABLE historial (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_cancion INT,
    fecha_reproduccion DATETIME NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion)
);

-- Tabla likes
CREATE TABLE likes (
    id_like INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_cancion INT,
    fecha_like DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES canciones(id_cancion)
);

-- ========================
-- USUARIOS (20 registros)
-- ========================
INSERT INTO usuarios (nombre, email, pais, fecha_registro) VALUES
('Ana Torres','ana.torres@gmail.com','México','2023-01-15'),
('Luis Fernández','luis.fernandez@hotmail.com','España','2023-02-10'),
('Carla Méndez','carla.mendez@yahoo.com','Argentina','2023-03-22'),
('Pedro Ruiz','pedro.ruiz@gmail.com','Chile','2023-01-28'),
('Laura Gómez','laura.gomez@hotmail.com','Colombia','2023-04-05'),
('David Silva','david.silva@gmail.com','Perú','2023-01-20'),
('María López','maria.lopez@yahoo.com','México','2023-05-11'),
('Andrés Pérez','andres.perez@gmail.com','España','2023-02-19'),
('Sofía Ramos','sofia.ramos@hotmail.com','Chile','2023-03-10'),
('Diego Castro','diego.castro@gmail.com','Argentina','2023-06-15'),
('Paula Jiménez','paula.jimenez@gmail.com','México','2023-07-03'),
('Jorge Díaz','jorge.diaz@yahoo.com','Colombia','2023-02-14'),
('Camila Herrera','camila.herrera@hotmail.com','Chile','2023-05-21'),
('Rodrigo Sánchez','rodrigo.sanchez@gmail.com','España','2023-04-30'),
('Valentina Ortiz','valentina.ortiz@yahoo.com','Perú','2023-03-17'),
('Hugo Martínez','hugo.martinez@gmail.com','México','2023-06-01'),
('Elena Vázquez','elena.vazquez@hotmail.com','Argentina','2023-05-12'),
('Sebastián Romero','sebastian.romero@gmail.com','Chile','2023-04-09'),
('Martina Cabrera','martina.cabrera@yahoo.com','Colombia','2023-03-30'),
('Fernando Reyes','fernando.reyes@gmail.com','España','2023-07-20');

-- ========================
-- PLANES (20 registros)
-- ========================
INSERT INTO planes (nombre, precio, descripcion) VALUES
('Gratis', 0.00, 'Acceso con anuncios'),
('Individual', 9.99, 'Acceso premium para 1 persona'),
('Duo', 12.99, 'Acceso premium para 2 personas'),
('Familiar', 14.99, 'Acceso premium hasta 6 personas'),
('Estudiantes', 4.99, 'Acceso premium con descuento'),
('Anual', 99.99, 'Plan anual individual'),
('Premium Plus', 19.99, 'Alta calidad de audio'),
('Trial 1 mes', 0.00, 'Prueba gratuita 30 días'),
('Empresa', 49.99, 'Licencia para negocios'),
('VIP', 29.99, 'Acceso anticipado a lanzamientos'),
('DJ Pack', 24.99, 'Herramientas para DJs'),
('Clásico', 5.99, 'Acceso básico sin anuncios'),
('Kids', 3.99, 'Contenido apto para niños'),
('Gold', 15.99, 'Premium + beneficios exclusivos'),
('Lite', 1.99, 'Uso limitado sin anuncios'),
('Silver', 7.99, 'Plan básico con streaming HD'),
('Bronze', 3.49, 'Plan económico limitado'),
('Corporate', 79.99, 'Cuenta para empresas medianas'),
('Family Plus', 17.99, 'Familiar extendido'),
('Black', 34.99, 'Experiencia completa sin límites');

-- ========================
-- ARTISTAS (20 registros)
-- ========================
INSERT INTO artistas (nombre, pais, genero_principal) VALUES
('Bad Bunny','Puerto Rico','Reguetón'),
('Shakira','Colombia','Pop'),
('Rosalía','España','Flamenco Urbano'),
('Maluma','Colombia','Reguetón'),
('Dua Lipa','Reino Unido','Pop'),
('Coldplay','Reino Unido','Rock'),
('Karol G','Colombia','Reguetón'),
('J Balvin','Colombia','Reguetón'),
('Adele','Reino Unido','Soul'),
('Taylor Swift','EE.UU.','Pop'),
('Ed Sheeran','Reino Unido','Pop'),
('Ozuna','Puerto Rico','Reguetón'),
('Drake','Canadá','Hip-Hop'),
('The Weeknd','Canadá','R&B'),
('Daddy Yankee','Puerto Rico','Reguetón'),
('Beyoncé','EE.UU.','Pop'),
('Imagine Dragons','EE.UU.','Rock'),
('Camila Cabello','Cuba','Pop'),
('Sebastián Yatra','Colombia','Pop'),
('Maná','México','Rock Latino');

-- ========================
-- ALBUMES (20 registros)
-- ========================
INSERT INTO albumes (id_artista, titulo, fecha_lanzamiento, genero) VALUES
(1,'Un Verano Sin Ti','2022-05-06','Reguetón'),
(2,'El Dorado','2017-05-26','Pop'),
(3,'Motomami','2022-03-18','Flamenco Urbano'),
(4,'Papi Juancho','2020-08-21','Reguetón'),
(5,'Future Nostalgia','2020-03-27','Pop'),
(6,'Music of the Spheres','2021-10-15','Rock'),
(7,'KG0516','2021-03-25','Reguetón'),
(8,'Colores','2020-03-19','Reguetón'),
(9,'25','2015-11-20','Soul'),
(10,'Midnights','2022-10-21','Pop'),
(11,'Divide','2017-03-03','Pop'),
(12,'Nibiru','2019-11-29','Reguetón'),
(13,'Scorpion','2018-06-29','Hip-Hop'),
(14,'After Hours','2020-03-20','R&B'),
(15,'Barrio Fino','2004-07-13','Reguetón'),
(16,'Renaissance','2022-07-29','Pop'),
(17,'Evolve','2017-06-23','Rock'),
(18,'Camila','2018-01-12','Pop'),
(19,'Fantasía','2019-04-12','Pop'),
(20,'Sueños Líquidos','1997-09-22','Rock Latino');


-- ========================
-- CANCIONES (40 registros, 2 por álbum)
-- ========================
INSERT INTO canciones (id_album, titulo, duracion, reproducciones) VALUES
(1,'Moscow Mule','00:03:34',1200),
(1,'Tití Me Preguntó','00:04:03',2500),
(2,'Chantaje','00:03:15',2100),
(2,'Me Enamoré','00:03:50',1300),
(3,'Saoko','00:02:17',1600),
(3,'Bizcochito','00:02:35',1400),
(4,'Hawái','00:03:19',3200),
(4,'Parce','00:04:12',1000),
(5,'Levitating','00:03:23',5000),
(5,'Don’t Start Now','00:03:03',4300),
(6,'Higher Power','00:03:26',1800),
(6,'My Universe','00:03:46',2700),
(7,'Bichota','00:03:12',4100),
(7,'Location','00:03:25',2000),
(8,'Rojo','00:03:25',2400),
(8,'Amarillo','00:03:07',1700),
(9,'Hello','00:04:55',6100),
(9,'Send My Love','00:03:43',1900),
(10,'Anti-Hero','00:03:21',7200),
(10,'Lavender Haze','00:03:22',3300),
(11,'Shape of You','00:03:53',10000),
(11,'Perfect','00:04:23',8500),
(12,'Caramelo','00:03:35',2600),
(12,'Se Preparó','00:03:34',2200),
(13,'God’s Plan','00:03:19',9200),
(13,'Nice For What','00:03:31',5100),
(14,'Blinding Lights','00:03:20',15000),
(14,'Save Your Tears','00:03:35',8700),
(15,'Gasolina','00:03:12',9500),
(15,'Lo Que Pasó, Pasó','00:03:32',7400),
(16,'Break My Soul','00:04:38',4600),
(16,'Cuff It','00:03:45',2800),
(17,'Believer','00:03:24',12000),
(17,'Thunder','00:03:07',8900),
(18,'Havana','00:03:37',8000),
(18,'Never Be the Same','00:03:47',3400),
(19,'Un Año','00:03:11',5300),
(19,'Cristina','00:03:26',4000),
(20,'Clavado en un Bar','00:04:32',6100),
(20,'En el Muelle de San Blas','00:05:24',7200);

-- ========================
-- PLAYLISTS (20 registros)
-- ========================
INSERT INTO playlists (id_usuario, nombre, fecha_creacion) VALUES
(1,'Favoritas de Ana','2023-06-01'),
(2,'Hits Españoles','2023-06-03'),
(3,'Pop Argentino','2023-06-05'),
(4,'Reguetón Top','2023-06-07'),
(5,'Lo Mejor de Colombia','2023-06-09'),
(6,'Clásicos del Rock','2023-06-11'),
(7,'Relax México','2023-06-13'),
(8,'Workout España','2023-06-15'),
(9,'Chill Chile','2023-06-17'),
(10,'Argentina Hits','2023-06-19'),
(11,'Mix Pop','2023-06-21'),
(12,'Salsa y más','2023-06-23'),
(13,'Trap Urbano','2023-06-25'),
(14,'Indie Español','2023-06-27'),
(15,'Baladas','2023-06-29'),
(16,'Kids Party','2023-07-01'),
(17,'Viaje Lento','2023-07-03'),
(18,'Electro Pop','2023-07-05'),
(19,'Favoritos de Sebas','2023-07-07'),
(20,'Clásicos Latinos','2023-07-09');

-- ========================
-- PLAYLIST_CANCIONES (40 registros, 2 canciones por playlist)
-- ========================
INSERT INTO playlist_canciones (id_playlist, id_cancion) VALUES
(1,11),(1,12),
(2,25),(2,26),
(3,19),(3,20),
(4,7),(4,8),
(5,3),(5,4),
(6,35),(6,36),
(7,39),(7,40),
(8,21),(8,22),
(9,15),(9,16),
(10,17),(10,18),
(11,5),(11,6),
(12,31),(12,32),
(13,1),(13,2),
(14,9),(14,10),
(15,27),(15,28),
(16,33),(16,34),
(17,23),(17,24),
(18,29),(18,30),
(19,13),(19,14),
(20,37),(20,38);

-- ========================
-- HISTORIAL DE REPRODUCCIÓN (20 registros)
-- ========================
INSERT INTO historial (id_usuario, id_cancion, fecha_reproduccion) VALUES
(1,11,'2023-06-01 10:30:00'),
(2,25,'2023-06-01 11:00:00'),
(3,19,'2023-06-02 09:15:00'),
(4,7,'2023-06-02 14:20:00'),
(5,3,'2023-06-03 16:45:00'),
(6,35,'2023-06-04 20:10:00'),
(7,39,'2023-06-04 22:30:00'),
(8,21,'2023-06-05 18:40:00'),
(9,15,'2023-06-06 07:55:00'),
(10,17,'2023-06-06 12:00:00'),
(11,5,'2023-06-07 13:25:00'),
(12,31,'2023-06-08 21:05:00'),
(13,1,'2023-06-09 23:30:00'),
(14,9,'2023-06-10 08:45:00'),
(15,27,'2023-06-11 19:20:00'),
(16,33,'2023-06-12 20:55:00'),
(17,23,'2023-06-13 17:30:00'),
(18,29,'2023-06-14 15:15:00'),
(19,13,'2023-06-15 11:40:00'),
(20,37,'2023-06-16 14:10:00');

-- ========================
-- LIKES (20 registros)
-- ========================
INSERT INTO likes (id_usuario, id_cancion, fecha_like) VALUES
(1,11,'2023-06-01'),
(2,25,'2023-06-02'),
(3,19,'2023-06-02'),
(4,7,'2023-06-03'),
(5,3,'2023-06-04'),
(6,35,'2023-06-04'),
(7,39,'2023-06-05'),
(8,21,'2023-06-05'),
(9,15,'2023-06-06'),
(10,17,'2023-06-06'),
(11,5,'2023-06-07'),
(12,31,'2023-06-07'),
(13,1,'2023-06-08'),
(14,9,'2023-06-09'),
(15,27,'2023-06-09'),
(16,33,'2023-06-10'),
(17,23,'2023-06-11'),
(18,29,'2023-06-11'),
(19,13,'2023-06-12'),
(20,37,'2023-06-13');

-- 20 suscripciones de prueba (ajusta según necesites)
INSERT INTO suscripciones (id_usuario, id_plan, fecha_inicio, fecha_fin, estado) VALUES
(1, 2, '2023-01-15', '2024-01-15', 'Activo'),
(2, 3, '2023-02-10', '2024-02-10', 'Activo'),
(3, 1, '2023-03-22', NULL, 'Activo'),
(4, 4, '2023-04-01', '2024-04-01', 'Activo'),
(5, 5, '2023-05-11', '2023-11-11', 'Vencido'),
(6, 2, '2023-06-05', '2024-06-05', 'Activo'),
(7, 6, '2023-07-07', '2024-07-07', 'Activo'),
(8, 8, '2023-08-20', '2023-09-20', 'Vencido'),
(9, 9, '2023-09-01', '2024-09-01', 'Activo'),
(10, 10, '2023-10-12', '2024-10-12', 'Activo'),
(11, 2, '2023-11-15', '2024-11-15', 'Activo'),
(12, 3, '2023-12-01', '2024-12-01', 'Activo'),
(13, 4, '2023-12-20', '2024-12-20', 'Activo'),
(14, 5, '2023-07-01', '2023-12-31', 'Vencido'),
(15, 6, '2023-08-01', '2024-08-01', 'Activo'),
(16, 7, '2023-09-01', '2024-09-01', 'Activo'),
(17, 8, '2023-10-01', '2023-11-01', 'Vencido'),
(18, 9, '2023-11-01', '2024-11-01', 'Activo'),
(19, 10, '2023-12-01', '2024-12-01', 'Activo'),
(20, 11, '2023-12-15', '2024-12-15', 'Activo');


