DROP DATABASE IF EXISTS SENA;
CREATE DATABASE SENA;
USE SENA;
SHOW TABLES;
DROP TABLE IF EXISTS Carrera;
CREATE TABLE Carrera (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(32) NOT NULL,
    PRIMARY KEY (`id`)
    );
INSERT INTO Carrera 
VALUES (1,'Desarrollo de Software'), (2,'Electrónica'), (3,'Mecánica Automotriz'), (4,'Seguridad y Salud Ocupacional'), (5,'Soldadura');

DROP TABLE IF EXISTS Cursos;
CREATE TABLE Cursos (
    `id_curso` int NOT NULL AUTO_INCREMENT,
    `curso` varchar(32) NOT NULL,
    PRIMARY KEY (`id_curso`)
    );
INSERT INTO Cursos VALUES (1,'Matemáticas Básicas'),(2,'Álgebra Computacional'),(3,'Programación Básica'),(4,'Inglés'),(5,'Electrónica Básica'),(6,'Motor de Cuatro Tiempos'),(7,'Enfermedades Laborales'),(8,'Higiene Postural en el Trabajo'),(9,'Ergonomía'),(10,'Legislación Laboral en Colombia'),(11,'Materiales de Soldadura'),(12,'Métodos de Soldadura'),(13,'Fusión de Metales'),(14,'Buceo 1'),(15,'Buceo 2'),(16,'Riesgo Eléctrico'),(17,'Bases de Datos Relacionales'),(18,'Bases de Datos NO Relacionales'),(19,'Electrónica Digital'),(20,'Microprocesadores');

DROP TABLE IF EXISTS Aprendices;
CREATE TABLE Aprendices (
     `id_aprendiz` int NOT NULL AUTO_INCREMENT,
     `nombre` varchar(32) NOT NULL,
     `apellido` varchar(32) NOT NULL,
     `edad` int NOT NULL,
     PRIMARY KEY (`id_aprendiz`)
     );
INSERT INTO Aprendices VALUES (1, 'Carlos Saúl', 'Gómez', 17), (2, 'Leyla María', 'Delgado Vargas', 18), (3, 'Juan José', 'Martinez', 19), (4, 'Sergio Augusto' , 'Contreras Navas', 20), (5, 'Ana María', 'Velasquez Parra', 17), (6, 'Gustavo', 'Noriega Alzate', 18), (7, 'Pedro Nell', 'Gómez Díaz', 19), (8, 'Jairo Augusto', 'Castro Camargo', 20), (9, 'Henry', 'Soler Vega', 17), (10, 'Antonio', 'Cañate Cortés', 18), (11, 'Daniel', 'Simancas Junior', 19);

DROP TABLE IF EXISTS Rutas;
CREATE TABLE Rutas (
     `id_ruta` int NOT NULL AUTO_INCREMENT,
     `ruta` varchar(50) DEFAULT NULL,
     `id_carrera` int NOT NULL,
     PRIMARY KEY (`id_ruta`),
     CONSTRAINT `ruta_carrera` FOREIGN KEY (`id_carrera`) REFERENCES `Carrera` (`id`)
    );
INSERT INTO Rutas VALUES (1,'Sistemas de Información Empresariales',1),(2,'Videojuegos',1),(3,'Machine Learning',1),(4,'Microcontroladores',2),(5,'Robótica',2),(6,'Dispositivos Bio-médicos',2),(7,'Motores Híbridos',3),(8,'Vehículos de Uso Agrícola',3),(9,'Sistemas de Gestión en Seguridad Ocupacional',4),(10,'Soldadura Autógena Industrial',5),(11,'Soldadura Eléctrica Industrial',5),(12,'Soldadura Submarina',5);

DROP TABLE IF EXISTS Matricula;
CREATE TABLE Matricula (
    `id_aprendiz` int NOT NULL,
    `id_ruta` int NOT NULL,
    `estado` ENUM('En Ejecución', 'Terminado', 'Cancelado'),
    FOREIGN KEY (id_aprendiz) REFERENCES Aprendices (id_aprendiz),
    FOREIGN KEY (id_ruta) REFERENCES Rutas (id_ruta),
    CONSTRAINT MatriculaxAprendiz UNIQUE (id_aprendiz, id_ruta, estado)
);
INSERT INTO Matricula VALUES (1,1,1),(2,1,1),(3,2,3),(4,2,1),(5,3,1),(6,4,2),(7,4,2),(8,5,2),(9,5,3),(10,11,2),(11,10,2);

DROP TABLE IF EXISTS Instructores;
CREATE TABLE Instructores (
     `id_instructor` int NOT NULL AUTO_INCREMENT,
     `instructor` varchar(32) NOT NULL,
     `especialidad` varchar(32) NOT NULL,
     PRIMARY KEY (`id_instructor`)
     );
INSERT INTO Instructores VALUES (1, 'Ricardo Vicente Jaimes', 'Sistemas'), (2, 'Marinela Narvaez', 'Salud Ocupacional'), (3, 'Agustín Parra Granados', 'Soldadura'), (4, 'Nelson Raúl Buitrago', 'Mecánica'), (5, 'Roy Hernando Llamas', 'Inglés'), (6, 'Maria Jimena Monsalve', 'Electrónica'), (7, 'Juan Carlos Cobos', 'Electrónica'), (8, 'Pedro Nell Santoamaría', 'Sistemas'), (9, 'Andrea González', 'Sistemas'), (10, 'Marisela Sevilla', 'Salud Ocupacional');

DROP TABLE IF EXISTS Cursos_Ruta;
CREATE TABLE Cursos_Ruta (
    `id_clase` int NOT NULL AUTO_INCREMENT,
    `id_ruta` int NOT NULL,
    `id_curso` int NOT NULL,
    `id_instructor` int NULL,
    CONSTRAINT CursoxRuta UNIQUE (id_ruta, id_curso, id_instructor),
    PRIMARY KEY (id_clase)
);
INSERT INTO Cursos_Ruta(id_ruta, id_curso, id_instructor) VALUES (1,17,2), (1,2,1), (1,18,2), (1,1,4), (1,3,3), (1,4,5), (2,1,4), (2,2,1), (2,3,3), (2,4,5), (3,3,3), (3,4,5), (3,17,2), (4,5,7), (4,19,6), (4,20,7), (5,5,7), (5,19,6), (5,20,7), (11,11,3), (11,13,3), (10,12,3), (10,14,NULL);

DROP TABLE IF EXISTS Clase_Aprendiz;
CREATE TABLE Clase_Aprendiz (
    `id_aprendiz` int NOT NULL,
    `id_clase` int NOT NULL,
    FOREIGN KEY (id_aprendiz) REFERENCES Aprendices (id_aprendiz),
    FOREIGN KEY (id_clase) REFERENCES Cursos_Ruta (id_clase),
    PRIMARY KEY (id_aprendiz, id_clase)
);
INSERT INTO Clase_Aprendiz VALUES (1,1), (1,2), (1,5), (1,3), (2,4), (2,2), (2,5), (2,6), (3,7), (3,8), (3,9), (4,10), (4,7), (4,8), (5,11), (5,12), (5,13), (6,14), (6,15), (6,16), (7,14), (7,15), (7,16), (8,17), (8,18), (9,17), (9,18), (9,19), (10,20), (10,21), (11,22), (11,23);

--CONSULTAS EN LA BASE DE DATOS--
--Punto 4
SELECT A.nombre, A.apellido, A.edad  FROM Aprendices A INNER JOIN Matricula M ON A.id_aprendiz=M.id_aprendiz WHERE M.id_ruta IN (SELECT id_ruta FROM Rutas WHERE id_carrera=2);

--Punto 5
SELECT A.nombre, A.apellido, A.edad, R.ruta FROM Aprendices A JOIN Matricula M ON M.id_aprendiz=A.id_aprendiz JOIN Rutas R ON M.id_ruta=R.id_ruta WHERE M.estado='Cancelado';

--Punto 6
SELECT R.ruta,C.curso FROM Cursos C INNER JOIN Cursos_Ruta CR ON C.id_curso=CR.id_curso INNER JOIN Rutas R on R.id_ruta=CR.id_ruta WHERE CR.id_instructor IS NULL;

--Punto 7
SELECT DISTINCT I.instructor AS Instructor_Sistemas_de_Información_Empresariales FROM Instructores I INNER JOIN Cursos_Ruta CR ON I.id_instructor=CR.id_instructor INNER JOIN Rutas R ON R.id_ruta=CR.id_ruta WHERE R.ruta='Sistemas de Información Empresariales';

--Punto 8
SELECT CONCAT(A.nombre, ' ', A.apellido) AS Profesional, Ca.name AS Carrera, R.ruta AS Énfasis FROM Aprendices A INNER JOIN Matricula M ON A.id_aprendiz=M.id_aprendiz INNER JOIN Rutas R ON R.id_ruta=M.id_ruta INNER JOIN Carrera Ca ON R.id_carrera=Ca.id WHERE M.estado='Terminado';

--Punto 9
SELECT CONCAT(A.nombre, ' ', A.apellido) AS Aprendiz FROM Aprendices A INNER JOIN Clase_Aprendiz CA ON A.id_aprendiz=CA.id_aprendiz INNER JOIN Cursos_Ruta CR ON CA.id_clase=CR.id_clase INNER JOIN Cursos C ON CR.id_curso=C.id_curso WHERE C.curso='Bases de Datos Relacionales';

--Punto 10
SELECT I.instructor AS Instructores_sin_Cursos FROM Instructores I LEFT JOIN Cursos_Ruta CR ON I.id_instructor=CR.id_instructor WHERE CR.id_instructor IS NULL;