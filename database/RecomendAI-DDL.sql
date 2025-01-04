CREATE SCHEMA RecomendAI;

USE RecomendAI;

CREATE TABLE Rol (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);

CREATE TABLE Participe (
id INT PRIMARY KEY,
NOMBRE VARCHAR (50)
);

CREATE TABLE Tipo (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);

CREATE TABLE Pais (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);

CREATE TABLE Contenido (
id INT PRIMARY KEY,
duracion INT,
año DATE,
titulo VARCHAR (50),
idPais INT,
idTipo INT,
CONSTRAINT Contenido_Pais_FK FOREIGN KEY (idPais) REFERENCES Pais (id)
);

CREATE TABLE RolParticipeContenido (
idRol INT,
idParticipe INT,
idContenido INT,
CONSTRAINT RolParticipeContenido_PK PRIMARY KEY (idRol, idParticipe, idContenido),
CONSTRAINT RolParticipeContenido_Rol_FK FOREIGN KEY (idRol) REFERENCES Rol (id),
CONSTRAINT RolParticipeContenido_Participe_FK FOREIGN KEY (idParticipe) REFERENCES Participe (id),
CONSTRAINT RolParticipeContenido_Contenido_FK FOREIGN KEY (idContenido) REFERENCES Contenido (id)
);

CREATE TABLE ContenidoContenido (
idContenidoPadre INT,
idContenidoHijo INT,
CONSTRAINT ContenidoContenido_PK PRIMARY KEY (idContenidoPadre, idContenidoHijo),
CONSTRAINT ContenidoContenido_Padre_FK FOREIGN KEY (idContenidoPadre) REFERENCES Contenido (id),
CONSTRAINT ContenidoContenido_Hijo_FK FOREIGN KEY (idContenidoHijo) REFERENCES Contenido (id)
);

CREATE TABLE Conversacion (
id INT PRIMARY KEY
);

CREATE TABLE Chat(
idConversacion INT,
chat VARCHAR(255),
CONSTRAINT Chat_PK PRIMARY KEY (idConversacion, Chat),
CONSTRAINT Chat_Conversacion_FK FOREIGN KEY (idConversacion) REFERENCES Conversacion (id)
);



CREATE TABLE ContenidoConversacion (
idContenido INT,
idConversacion INT,
acertado BOOLEAN,
puntuacion INT,
consumio BOOLEAN,
opinion TEXT,
CONSTRAINT ContenidoConversacion_PK PRIMARY KEY (idContenido, idConversacion),
CONSTRAINT ContenidoConversacion_Contenido_FK FOREIGN KEY (idContenido) REFERENCES Contenido (id),
CONSTRAINT ContenidoConversacion_Conversacion_FK FOREIGN KEY (idConversacion) REFERENCES Conversacion (id)
);

CREATE TABLE Genero (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);

CREATE TABLE Tematica (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);

CREATE TABLE ContenidoGenero (
idContenido INT, 
idGenero INT,
CONSTRAINT ContenidoGenero_PK PRIMARY KEY (idContenido, idGenero),
CONSTRAINT ContenidoGenero_Contenido_FK FOREIGN KEY (idContenido) REFERENCES Contenido (id),
CONSTRAINT ContenidoGenero_Genero_FK FOREIGN KEY (idGenero) REFERENCES Genero (id)
);

CREATE TABLE ContenidoTematica (
idContenido INT, 
idTematica INT,
CONSTRAINT ContenidoTematica PRIMARY KEY (idContenido, idTematica),
CONSTRAINT ContenidoTematica_Contenido_FK FOREIGN KEY (idContenido) REFERENCES  Contenido (id),
CONSTRAINT ContenidoTematica_Tematica_FK FOREIGN KEY (idTematica) REFERENCES Tematica (id)
);

CREATE TABLE Caracteristica (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);

CREATE TABLE Emocion (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);

CREATE TABLE ContenidoCaracteristicaEmocion (
idContenido INT,
idCaracteristica INT,
idEmocion INT,
id INT,
peso_global INT,
CONSTRAINT ContenidoCaracteristicaEmocion_PK PRIMARY KEY (idContenido, idCaracteristica, idEmocion, id),
CONSTRAINT ContenidoCaracteristicaEmocion_Contenido_FK FOREIGN KEY (idContenido) REFERENCES Contenido (id),
CONSTRAINT ContenidoCaracteristicaEmocion_Caracteristica_FK FOREIGN KEY (idCaracteristica) REFERENCES Caracteristica (id),
CONSTRAINT ContenidoCaracteristicaEmocion_Emocion_FK FOREIGN KEY (idEmocion) REFERENCES Emocion (id)
);

CREATE TABLE CaracteristicaEmocion (
idCaracteristica INT,
idEmocion INT,
CONSTRAINT CaracteristicaEmocion_PK PRIMARY KEY  (idCaracteristica, idEmocion),
CONSTRAINT CaracteristicaEmocion_Caracteristica_FK FOREIGN KEY (idCaracteristica) REFERENCES Caracteristica (id),
CONSTRAINT CaracteristicaEmocion_Emocion_FK FOREIGN KEY (idEmocion) REFERENCES Emocion (id)
);

CREATE TABLE ContenidoCaracteristica (
idContenido INT,
idCaracteristica INT,
CONSTRAINT ContenidoCaracteristica_PK PRIMARY KEY (idContenido, idCaracteristica),
CONSTRAINT ContenidoCaracteristica_Contenido_FK FOREIGN KEY (idContenido) REFERENCES Contenido (id),
CONSTRAINT ContenidoCaracteristica_Caracteristica_FK FOREIGN KEY (idCaracteristica) REFERENCES Caracteristica (id)
);

CREATE TABLE Idioma (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);


CREATE TABLE GeneroUsuario (
id INT PRIMARY KEY,
nombre VARCHAR (50)
);


CREATE TABLE Usuario (
id INT PRIMARY KEY,
email VARCHAR (50),
contraseña VARCHAR (50),
f_nac DATE,
idGeneroUsuario INT,
idResidencia INT,
idOrigen INT,
CONSTRAINT Usuario_idGeneroUsuario_FK FOREIGN KEY (idGeneroUsuario) REFERENCES GeneroUsuario (id),
CONSTRAINT Usuario_idResidencia_FK FOREIGN KEY (idResidencia) REFERENCES Pais (id),
CONSTRAINT Usuario_Origen_FK FOREIGN KEY (idOrigen) REFERENCES Pais (id)
);

CREATE TABLE CaracteristicaUsuario (
idCaracteristica INT,
idUsuario INT,
puntuacion INT,
CONSTRAINT CaracteristicaUsuario_PK PRIMARY KEY (idCaracteristica, idUsuario),
CONSTRAINT CaracteristicaUsuario_Caracteristica_FK FOREIGN KEY (idCaracteristica) REFERENCES Caracteristica (id),
CONSTRAINT CaracteristicaUsuario_Usuario_FK FOREIGN KEY (idUsuario) REFERENCES Usuario (id)
);

CREATE TABLE UsuarioIdioma (
idUsuario INT,
idIdioma INT,
CONSTRAINT UsuarioIdioma_PK PRIMARY KEY(idUsuario, idIdioma),
CONSTRAINT UsuarioIdioma_Usuario_FK FOREIGN KEY (idUsuario) REFERENCES Usuario (id),
CONSTRAINT Usuarioidioma_Idioma_FK FOREIGN KEY (idIdioma) REFERENCES Idioma (id)
);

CREATE TABLE ConversacionEmocionUsuario (
idConversacion INT, 
idEmocion INT,
idUsuario INT,
CONSTRAINT ConversacionEmocionUsuario_PK PRIMARY KEY (idConversacion, idUsuario),
CONSTRAINT ConversacionEmocionUsuario_Conversacion_FK FOREIGN KEY (idConversacion) REFERENCES Conversacion (id), 
CONSTRAINT ConversacionEmocionUsuario_Emocion_FK FOREIGN KEY (idEmocion) REFERENCES Emocion (id),
CONSTRAINT ConversacionEmocionUsuario_Usuario_FK FOREIGN KEY (idUsuario) REFERENCES Usuario (id)
);

CREATE TABLE CaracteristicaConversacion (
idCaracteristica INT,
idConversacion INT,
CONSTRAINT CaracteristicaConversacion_PK PRIMARY KEY (idCaracteristica, idConversacion),
CONSTRAINT CaracteristicaConversacion_Caracteristica_FK FOREIGN KEY (idCaracteristica) REFERENCES Caracteristica (id),
CONSTRAINT CaracteristicaConversacion_Conversacion_FK FOREIGN KEY (idConversacion) REFERENCES Conversacion (id)
);

CREATE TABLE TematicaConversacion (
idTematica INT,
idConversacion INT,
CONSTRAINT TematicaConversacion_PK PRIMARY KEY (idTematica, idConversacion),
CONSTRAINT TematicaConversacion_Tematica_FK FOREIGN KEY (idTematica)  REFERENCES Tematica (id),
CONSTRAINT TematicaConversacion_Conversacion_FK FOREIGN KEY (idConversacion) REFERENCES Conversacion (id)
);

CREATE TABLE GeneroConversacion (
idGenero INT,
idConversacion INT,
CONSTRAINT GeneroConversacion_PK PRIMARY KEY (idGenero, idConversacion),
CONSTRAINT GeneroConversacion_Genero_FK FOREIGN KEY (idGenero) REFERENCES Genero (id),
CONSTRAINT GeneroConversacion_Conversacion_FK FOREIGN KEY (idConversacion) REFERENCES Conversacion (id)
);

INSERT INTO Rol (id, nombre) VALUES
  (1, 'Autor'),
  (2, 'Coautor'),
  (3, 'Director'),
  (4, 'Guionista'),
  (5, 'Productor'),
  (6, 'Actor'),
  (7, 'Actriz'),
  (8, 'Cantante'),
  (9, 'Compositor'),
  (10, 'Músico'),
  (11, 'Diseñador de juegos'),
  (12, 'Desarrollador de juegos'),
  (13, 'Narrador'),
  (14, 'Editor'),
  (15, 'Presentador'),
  (16, 'Comodin');

INSERT INTO Participe (id, nombre) VALUES
  (1, 'Daniel Radcliffe'),
  (2, 'Rupert Grint'),
  (3, 'Emma Watson'),
  (4, 'Jennifer Lawrence'),
  (5, 'Josh Hutcherson'),
  (6, 'Liam Hemsworth'),
  (7, 'Shailene Woodley'),
  (8, 'Theo James'),
  (9, 'Kate Winslet'),
  (10, 'Leonardo DiCaprio'),
  (11, 'Daniel Craig'),
  (12, 'Mads Mikkelsen'),
  (13, 'Tom Hardy'),
  (14, 'Zendaya'),
  (15, 'Timothée Chalamet'),
  (16, 'Donald Glover'),
  (17, 'Beyoncé'),
  (18, 'Jay-Z'),
  (19, 'Ed Sheeran'),
  (20, 'Justin Bieber'),
  (21, 'Comodin');

INSERT INTO Tipo (id, nombre) VALUES
  (1, 'Película'),
  (2, 'Serie de televisión'),
  (3, 'Cortometraje'),
  (4, 'Documental'),
  (5, 'Canción'),
  (6, 'Álbum'),
  (7, 'Podcast'),
  (8, 'Audiolibro'),
  (9, 'Libro'),
  (10, 'Novela gráfica'),
  (11, 'Videojuego'),
  (12, 'Obra de teatro'),
  (13, 'Espectáculo de danza'),
  (14, 'Concierto'),
  (15, 'Evento deportivo');

INSERT INTO Pais (id, nombre) VALUES
(1, 'Estados Unidos'),
(2, 'Reino Unido'),
(3, 'Francia'),
(4, 'Alemania'),
(5, 'España'),
(6, 'Italia'),
(7, 'Japón'),
(8, 'Corea del Sur'),
(9, 'China'),
(10, 'India'),
(11, 'Brasil'),
(12, 'Argentina'),
(13, 'México'),
(14, 'Canadá'),
(15, 'Australia'),
(16, 'Rusia'),
(17, 'Suecia'),
(18, 'Noruega'),
(19, 'Dinamarca'),
(20, 'Finlandia'),
(21, 'Países Bajos'),
(22, 'Bélgica'),
(23, 'Suiza'),
(24, 'Portugal'),
(25, 'Grecia'),
(26, 'Turquía'),
(27, 'Egipto'),
(28, 'Sudáfrica'),
(29, 'Nigeria'),
(30, 'Kenia'),
(31, 'Chile'),
(32, 'Perú'),
(33, 'Colombia'),
(34, 'Venezuela'),
(35, 'Ecuador'),
(36, 'Costa Rica'),
(37, 'Panamá'),
(38, 'Cuba'),
(39, 'Jamaica'),
(40, 'Puerto Rico'),
(41, 'República Dominicana'),
(42, 'Honduras'),
(43, 'Guatemala'),
(44, 'El Salvador'),
(45, 'Nicaragua'),
(46, 'Haití'),
(47, 'Bahamas'),
(48, 'Trinidad y Tobago'),
(49, 'Barbados'),
(50, 'Granada');

INSERT INTO Contenido (id, duracion, año, titulo, idPais, idTipo) VALUES
  (1, 152, '1997-06-26', 'Harry Potter y la piedra filosofal', 2, 1),
  (2, 181, '2002-11-15', 'Harry Potter y la cámara secreta', 2, 1),
  (3, 142, '2004-06-04', 'Harry Potter y el prisionero de Azkaban', 2, 1),
  (4, 157, '2005-11-18', 'Harry Potter y el cáliz de fuego', 2, 1),
  (5, 122, '2007-06-26', 'Harry Potter y la Orden del Fénix', 2, 1),
  (6, 158, '2009-07-15', 'Harry Potter y el misterio del príncipe', 2, 1),
  (7, 112, '2011-11-19', 'Harry Potter y las reliquias de la muerte: Parte 1', 2, 1),
  (8, 130, '2011-11-14', 'Harry Potter y las reliquias de la muerte: Parte 2', 2, 1),
  (9, 138, '2012-03-22', 'Los juegos del hambre', 1, 1),
  (10, 142, '2013-11-22', 'Los juegos del hambre: En llamas', 1, 1),
  (11, 137, '2014-11-21', 'Los juegos del hambre: Sinsajo - Parte 1', 1, 1),
  (12, 137, '2015-11-20', 'Los juegos del hambre: Sinsajo - Parte 2', 1, 1),
  (13, 123, '2016-03-18', 'Divergente', 1, 1),
  (14, 139, '2017-03-16', 'Insurgente', 1, 1),
  (15, 111, '2018-03-12', 'Leal', 1, 1),
  (16, 240, '1970-07-26', 'Bohemian Rhapsody', 2, 5),
  (17, 360, '1971-09-24', 'Imagine', 2, 5),
  (18, 277, '1991-01-01', 'Smells Like Teen Spirit', 1, 5),
  (19, 302, '2016-04-08', 'One Dance', 5, 5),
  (20, 246, '2019-06-21', 'Shape of You', 2, 5);

INSERT INTO RolParticipeContenido (idRol, idParticipe, idContenido) VALUES
	-- Harry Potter y la piedra filosofal (Contenido ID: 1)
	(6, 1, 1), -- Actor: Daniel Radcliffe
	(6, 2, 1), -- Actor: Rupert Grint
	(7, 3, 1), -- Actriz: Emma Watson
	-- Harry Potter y la cámara secreta (Contenido ID: 2)
	(6, 1, 2), -- Actor: Daniel Radcliffe
	(6, 2, 2), -- Actor: Rupert Grint
	(7, 3, 2), -- Actriz: Emma Watson
	-- Harry Potter y el prisionero de Azkaban (Contenido ID: 3)
	(6, 1, 3), -- Actor: Daniel Radcliffe
	(6, 2, 3), -- Actor: Rupert Grint
	(7, 3, 3), -- Actriz: Emma Watson
	-- Harry Potter y el cáliz de fuego (Contenido ID: 4)
	(6, 1, 4), -- Actor: Daniel Radcliffe
	(6, 2, 4), -- Actor: Rupert Grint
	(7, 3, 4), -- Actriz: Emma Watson
	-- Harry Potter y la Orden del Fénix (Contenido ID: 5)
	(6, 1, 5), -- Actor: Daniel Radcliffe
	(6, 2, 5), -- Actor: Rupert Grint
	(7, 3, 5), -- Actriz: Emma Watson
	-- Harry Potter y el misterio del príncipe (Contenido ID: 6)
	(6, 1, 6), -- Actor: Daniel Radcliffe
	(6, 2, 6), -- Actor: Rupert Grint
	(7, 3, 6), -- Actriz: Emma Watson
	-- Harry Potter y las reliquias de la muerte: Parte 1 (Contenido ID: 7)
	(6, 1, 7), -- Actor: Daniel Radcliffe
	(6, 2, 7), -- Actor: Rupert Grint
	(7, 3, 7), -- Actriz: Emma Watson
	-- Harry Potter y las reliquias de la muerte: Parte 2 (Contenido ID: 8)
	(6, 1, 8), -- Actor: Daniel Radcliffe
	(6, 2, 8), -- Actor: Rupert Grint
	(7, 3, 8), -- Actriz: Emma Watson
	-- Los juegos del hambre (Contenido ID: 9)
	(6, 4, 9), -- Actriz: Jennifer Lawrence
	(6, 5, 9), -- Actor: Josh Hutcherson
	(6, 6, 9), -- Actor: Liam Hemsworth
	-- Los juegos del hambre: En llamas (Contenido ID: 10)
	(6, 4, 10), -- Actriz: Jennifer Lawrence
	(6, 5, 10), -- Actor: Josh Hutcherson
	(6, 8, 10), -- Actor: Theo James
	-- Los juegos del hambre: Sinsajo - Parte 1 (Contenido ID: 11)
	(7, 4, 11), -- Actriz: Jennifer Lawrence
	(6, 5, 11), -- Actor: Josh Hutcherson
	(6, 8, 11), -- Actor: Theo James
	-- Los juegos del hambre: Sinsajo - Parte 2 (Contenido ID: 12)
	(7, 4, 12), -- Actriz: Jennifer Lawrence
	(6, 5, 12), -- Actor: Josh Hutcherson
	(6, 8, 12), -- Actor: Theo James
	-- Divergente (Contenido ID: 13)
	(7, 7, 13), -- Actriz: Shailene Woodley
	(6, 8, 13), -- Actor: Theo James 
	-- Insurgente (Contenido ID: 14)
	(7, 7, 14), -- Actriz: Shailene Woodley
	(6, 8, 14), -- Actor: Theo James
	-- Leal (Contenido ID: 15)
	(7, 7, 15), -- Actriz: Shailene Woodley
	(6, 8, 15), -- Actor: Theo James
	-- Shape of You (Contenido ID: 20)
	(8, 19, 20), -- Cantante: Ed Sheeran
	(9, 19, 20); -- Compositor: Ed Sheeran

INSERT INTO ContenidoContenido (idContenidoPadre, idContenidoHijo) VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(9, 10),
(9, 11),
(9, 12),
(13, 14),
(13, 15);

INSERT INTO Conversacion (id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13);

INSERT INTO Chat (idConversacion, chat) VALUES
  (1, 'IA: Hola, ¿cómo estás hoy?'),
  (1, 'Usuario: Hola, estoy bien'),
  (2, 'IA: Hola, ¿cómo estás hoy?'),
  (2, 'Usuario: Me siento un poco triste hoy.'),
  (2, 'IA: Lamento escuchar eso. ¿Qué te hace sentir triste?'),
  (2, 'Usuario: No estoy seguro, simplemente me siento deprimido.'),
  (3, 'IA: Hola, ¿cómo estás hoy?'),
  (3, 'Usuario: Me siento muy feliz hoy.'),
  (3, 'IA: ¡Me alegra escuchar eso! ¿Qué te hace sentir feliz?'),
  (3, 'Usuario: Acabo de recibir buenas noticias en el trabajo.'),
  (4, 'IA: Hola, ¿cómo estás hoy?'),
  (4, 'Usuario: Me siento un poco ansioso hoy.'),
  (4, 'IA: Entiendo. ¿Qué te hace sentir ansioso?'),
  (4, 'Usuario: Tengo una presentación importante mañana.'),
  (5, 'IA: Hola, ¿cómo estás hoy?'),
  (5, 'Usuario: Me siento muy cansado hoy.'),
  (5, 'IA: Lo siento, ¿dormiste bien anoche?'),
  (5, 'Usuario: No, no pude dormir bien.'),
  (6, 'IA: Hola, ¿cómo estás hoy?'),
  (6, 'Usuario: Me siento muy motivado hoy.'),
  (6, 'IA: ¡Qué bueno! ¿Qué te motiva?'),
  (6, 'Usuario: Acabo de empezar un nuevo proyecto que me apasiona.'),
  (7, 'IA: Hola, ¿cómo estás hoy?'),
  (7, 'Usuario: Me siento un poco abrumado hoy.'),
  (7, 'IA: Entiendo. ¿Qué te abruma?'),
  (7, 'Tengo muchas tareas que cumplir y no sé por dónde empezar.'),
  (8, 'IA: Hola, ¿cómo estás hoy?'),
  (8, 'Usuario: Me siento muy creativo hoy.'),
  (8, 'IA: ¡Qué bueno! ¿Qué te inspira?'),
  (8, 'Estoy leyendo un libro que me está llenando de ideas.'),
  (9, 'IA: Hola, ¿cómo estás hoy?'),
  (9, 'Usuario: Me siento muy agradecido hoy.'),
  (9, 'IA: ¿Por qué te sientes agradecido?'),
  (9, 'Por todas las cosas buenas que tengo en mi vida.');

INSERT INTO Genero (id, nombre) VALUES
  (1, 'Acción'),
  (2, 'Aventura'),
  (3, 'Comedia'),
  (4, 'Drama'),
  (5, 'Fantasía'),
  (6, 'Ciencia ficción'),
  (7, 'Terror'),
  (8, 'Romance'),
  (9, 'Suspenso'),
  (10, 'Documental'),
  (11, 'Musical'),
  (12, 'Familiar'),
  (13, 'Infantil'),
  (14, 'Animación'),
  (15, 'Deportes'),
  (16, 'POP');

INSERT INTO Tematica (id, nombre) VALUES
  (1, 'Zombies'),
  (2, 'Paranormal'),
  (3, 'Espionaje'),
  (4, 'Crimen'),
  (5, 'Apocalipsis'),
  (6, 'Viajes en el tiempo'),
  (7, 'Superhéroes'),
  (8, 'Distopía'),
  (9, 'Utopía'),
  (10, 'Fantasía oscura'),
  (11, 'Misterio sobrenatural'),
  (12, 'Magia'),
  (13, 'Histórico bélico'),
  (14, 'Espacial');

INSERT INTO ContenidoGenero (idContenido, idGenero) VALUES
  (1, 4),  -- Harry Potter y la piedra filosofal: Drama
  (1, 5),  -- Harry Potter y la piedra filosofal: Fantasía
  (2, 4),  -- Harry Potter y la cámara secreta: Drama
  (2, 5),  -- Harry Potter y la cámara secreta: Fantasía
  (3, 4),  -- Harry Potter y el prisionero de Azkaban: Drama
  (3, 5),  -- Harry Potter y el prisionero de Azkaban: Fantasía
  (4, 4),  -- Harry Potter y el cáliz de fuego: Drama
  (4, 5),  -- Harry Potter y el cáliz de fuego: Fantasía
  (5, 4),  -- Harry Potter y la Orden del Fénix: Drama
  (5, 5),  -- Harry Potter y la Orden del Fénix: Fantasía
  (6, 4),  -- Harry Potter y el misterio del príncipe: Drama
  (6, 5),  -- Harry Potter y el misterio del príncipe: Fantasía
  (7, 4),  -- Harry Potter y las reliquias de la muerte: Parte 1: Drama
  (7, 5),  -- Harry Potter y las reliquias de la muerte: Parte 1: Fantasía
  (8, 4),  -- Harry Potter y las reliquias de la muerte: Parte 2: Drama
  (8, 5),  -- Harry Potter y las reliquias de la muerte: Parte 2: Fantasía
  (9, 1),  -- Los juegos del hambre: Acción
  (9, 5),  -- Los juegos del hambre: Fantasía
  (10, 1),  -- Los juegos del hambre: En llamas: Acción
  (10, 5),  -- Los juegos del hambre: En llamas: Fantasía
  (11, 1),  -- Los juegos del hambre: Sinsajo - Parte 1: Acción
  (11, 5),  -- Los juegos del hambre: Sinsajo - Parte 1: Fantasía
  (12, 1),  -- Los juegos del hambre: Sinsajo - Parte 2: Acción
  (12, 5),  -- Los juegos del hambre: Sinsajo - Parte 2: Fantasía
  (13, 1),  -- Divergente: Acción
  (13, 6),  -- Divergente: Ciencia ficción
  (14, 1),  -- Insurgente: Acción
  (14, 6),  -- Insurgente: Ciencia ficción
  (15, 1),  -- Leal: Acción
  (15, 6),  -- Leal: Ciencia ficción
  (20, 16); -- Shape of You: POP

INSERT INTO ContenidoTematica (idContenido, idTematica) VALUES
  (1, 10),  -- Harry Potter y la piedra filosofal: Fantasía oscura
  (1, 12), -- Harry Potter y la piedra filosofal: Magia
  (2, 10),  -- Harry Potter y la cámara secreta: Fantasía oscura
  (2, 12), -- Harry Potter y la cámara secreta: Magia
  (3, 10),  -- Harry Potter y el prisionero de Azkaban: Fantasía oscura
  (3, 12), -- Harry Potter y el prisionero de Azkaban: Magia
  (4, 10),  -- Harry Potter y el cáliz de fuego: Fantasía oscura
  (4, 12), -- Harry Potter y el cáliz de fuego: Magia
  (5, 10),  -- Harry Potter y la Orden del Fénix: Fantasía oscura
  (5, 12), -- Harry Potter y la Orden del Fénix: Magia
  (6, 10),  -- Harry Potter y el misterio del príncipe: Fantasía oscura
  (6, 12), -- Harry Potter y el misterio del príncipe: Magia
  (7, 10),  -- Harry Potter y las reliquias de la muerte: Parte 1: Fantasía oscura
  (7, 12), -- Harry Potter y las reliquias de la muerte: Parte 1: Magia
  (8, 10),  -- Harry Potter y las reliquias de la muerte: Parte 2: Fantasía oscura
  (8, 12), -- Harry Potter y las reliquias de la muerte: Parte 2: Magia
  (9, 10),  -- Los juegos del hambre: Fantasía oscura
  (10, 10), -- Los juegos del hambre: En llamas: Fantasía oscura
  (11, 10), -- Los juegos del hambre: Sinsajo - Parte 1: Fantasía oscura
  (12, 10), -- Los juegos del hambre: Sinsajo - Parte 2: Fantasía oscura
  (13, 8),  -- Divergente: Distopía
  (13, 14), -- Divergente: Espacial
  (14, 8),  -- Insurgente: Distopía
  (14, 14), -- Insurgente: Espacial
  (15, 8),  -- Leal: Distopía
  (15, 14); -- Leal: Espacial

INSERT INTO Caracteristica (id, nombre) VALUES
  (1, 'Divertido'),
  (2, 'Emocionante'),
  (3, 'Conmovedor'),
  (4, 'Reflexivo'),
  (5, 'Lleno de acción'),
  (6, 'De suspenso'),
  (7, 'Inspirador'),
  (8, 'Romántico'),
  (9, 'De terror'),
  (10, 'Familiar'),
  (11, 'Apasionante'),
  (12, 'Basado en hechos reales'),
  (13, 'Visualmente impactante'),
  (14, 'Original'),
  (15, 'Clásico'),
  (16, 'Atrapante');


INSERT INTO Emocion (id, nombre) VALUES
(1, 'Alegría'),
(2, 'Tristeza'),
(3, 'Miedo'),
(4, 'Enojo'),
(5, 'Sorpresa'),
(6, 'Amor'),
(7, 'Esperanza'),
(8, 'Desagrado'),
(9, 'Culpa'),
(10, 'Emoción'),
(11, 'Empatía'),
(12, 'Entusiasmo'),
(13, 'Confianza'),
(14, 'Frustración'),
(15, 'Admiración'),
(16, 'Nostalgia'),
(17, 'Preocupación'),
(18, 'Gratitud'),
(19, 'Orgullo'),
(20, 'Vergüenza'),
(21, 'Aburrido');

INSERT INTO ContenidoCaracteristicaEmocion (idContenido, idCaracteristica, idEmocion, id, peso_global)
VALUES
  -- Harry Potter y la piedra filosofal
  (1, 1, 1, 1, 0.8),  --  Divertido, Alegría
  (1, 16, 1, 14, 0.8), -- Atrapante, Alegría
  -- Harry Potter y la cámara secreta 
  (2, 1, 1, 2, 0.8),  --  Divertido, Alegría
  (2, 16, 1, 15, 0.8), -- Atrapante, Alegría
  -- Harry Potter y el prisionero de Azkaban
  (3, 1, 1, 3, 0.8),  --  Divertido, Alegría
  (3, 16, 1, 16, 0.8), -- Atrapante, Alegría
  -- Harry Potter y el cáliz de fuego
  (4, 1, 1, 4, 0.8),  --  Divertido, Alegría
  (4, 16, 1, 17, 0.8), -- Atrapante, Alegría
  -- Harry Potter y la Orden del Fénix
  (5, 1, 1, 5, 0.8),  --  Divertido, Alegría
  (5, 16, 1, 18, 0.8), -- Atrapante, Alegría
  -- Harry Potter y el misterio del príncipe
  (6, 1, 1, 6, 0.8),  --  Divertido, Alegría
  (6, 16, 1, 19, 0.8), -- Atrapante, Alegría
  -- Harry Potter y las reliquias de la muerte: Parte 1 
  (7, 1, 1, 7, 0.8),  --  Divertido, Alegría
  (7, 16, 1, 20, 0.8), -- Atrapante, Alegría
  -- Harry Potter y las reliquias de la muerte: Parte 2 
  (8, 1, 1, 8, 0.8),  --  Divertido, Alegría
  (8, 16, 1, 21, 0.8), -- Atrapante, Alegría
  -- Los juegos del hambre 
  (9, 5, 11, 9, 0.8),  -- Lleno de acción, Empatía
  (9, 16, 11, 22, 0.4), -- Atrapante, Empatía
  -- Los juegos del hambre: En llamas
  (10, 5, 11, 10, 0.8),  -- Lleno de acción, Empatía
  (10, 16, 11, 23, 0.4), -- Atrapante, Empatía
  -- Los juegos del hambre: Sinsajo - Parte 1 
  (11, 5, 11, 11, 0.8),  -- Lleno de acción, Empatía
  (11, 16, 11, 24, 0.4), -- Atrapante, Empatía
  -- Los juegos del hambre: Sinsajo - Parte 2
  (12, 5, 11, 12, 0.8),  -- Lleno de acción, Empatía
  (12, 16, 11, 25, 0.8), -- Atrapante, Empatía
  -- Shape of You (Pop)
  (20, 2, 6, 13, 0.9);  -- Emocionante, Amor
  
  --------------------------------------------------------------------------------

INSERT INTO CaracteristicaEmocion (idCaracteristica, idEmocion) VALUES
(1, 1),
(1, 10),
(2, 10),
(2, 5),
(3, 11),
(3, 15),
(4, 4),
(4, 9),
(5, 12),
(11, 6),
(12, 11),
(13, 5),
(14, 10),
(12, 15),
(16, 21),
(7, 17),
(10, 18),
(1, 19);



INSERT INTO ContenidoCaracteristica (idContenido, idCaracteristica) VALUES
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 16),
(10, 16),
(11, 16),
(12, 16),
(13, 14),
(14, 14),
(15, 14),
(16, 12),
(17, 3),
(18, 2),
(19, 1),
(20, 8);

INSERT INTO Idioma (id, nombre) VALUES
(1, 'Inglés'),
(2, 'Español'),
(3, 'Francés'),
(4, 'Alemán'),
(5, 'Italiano'),
(6, 'Portugués'),
(7, 'Chino'),
(8, 'Japonés'),
(9, 'Coreano'),
(10, 'Árabe');

INSERT INTO GeneroUsuario (id, nombre) VALUES
(1, 'Masculino'),
(2, 'Femenino'),
(3, 'No binario'),
(4, 'Género fluido'),
(5, 'Otro');

INSERT INTO Usuario (id, email, contraseña, f_nac, idGeneroUsuario, idResidencia, idOrigen) VALUES
(1, 'Francoz@gmail.com', 'boca1234', '1990-01-15', 1, 1, 12),
(2, 'Gabi.l@hotmail.com', 'unlamFacu', '1985-02-20', 2, 3, 3),
(3, 'NicolasEzequiel@gmail.com', 'argentinaCampeon2022', '1995-03-10', 1, 12, 1),
(4, 'NicoleN@gmail.com', 'BuenosAires2000', '1988-04-25', 2, 1, 4),
(5, 'Caro1993@hotmail.com', 'TeAmo2000', '1993-05-17', 2, 3, 5),
(6, 'EditQuiroga@gmail.com', 'LimaLimon', '1992-06-11', 2, 2, 2),
(7, 'JoseRodriguez@hotmail.com', 'abc123', '1987-07-01', 3, 1, 3),
(8, 'PamelaL@gmail.com', 'agosto1994', '1994-08-29', 5, 3, 1),
(9, 'MirkoM@hotmail.com', 'Marley', '2015-09-14', 2, 2, 4),
(10, 'LiliPeretti@hotmail.com', 'amoAmiFamilia', '1963-10-22', 3, 1, 15),
(11, 'MartaLopez@gmail.com', 'martaSoyYo', '1991-11-03', 1, 3, 2),
(12, 'GustiJavier@gmail.com', 'copito123', '1962-12-18', 2, 2, 3),
(13, 'ZoeAmeliaP@hotmail.com', 'Canela1234!', '1997-01-05', 1, 12, 1),
(14, 'PazFlorenciaRodriguez@gmail.com', 'Oliver2007', '1990-02-08', 2, 12, 12),
(15, 'Ursula55@hotmail.com', 'AronYLuli', '1985-03-21', 3, 12, 12);


INSERT INTO CaracteristicaUsuario (idCaracteristica, idUsuario, puntuacion) VALUES
(1, 1, 8),
(2, 2, 7),
(3, 3, 9),
(4, 4, 6),
(5, 5, 4),
(1, 6, 7),
(2, 7, 9),
(3, 8, 6),
(4, 9, 8),
(5, 10, 3),
(1, 11, 8),
(2, 12, 7),
(3, 13, 9),
(4, 14, 6),
(5, 15, 8);


INSERT INTO UsuarioIdioma (idUsuario, idIdioma) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 1),
(6, 4),
(7, 1),
(8, 2),
(9, 2),
(10, 4),
(11, 1),
(12, 2),
(13, 5),
(14, 4),
(15, 1);


INSERT INTO ConversacionEmocionUsuario (idConversacion, idEmocion, idUsuario) VALUES
(1, 1, 1),
(1, 2, 2),
(5, 3, 3),
(3, 4, 4),
(2, 1, 5),
(9, 2, 6),
(2, 3, 7),
(8, 4, 8);


INSERT INTO CaracteristicaConversacion (idCaracteristica, idConversacion) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(1, 3),
(2, 3),
(3, 4),
(4, 4),
(16, 5),
(1, 5),
(2, 6),
(3, 6),
(4, 13),
(5, 7),
(1, 8),
(2, 8),
(3, 9),
(4, 9),
(5, 10);


INSERT INTO GeneroConversacion (idGenero, idConversacion) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(1, 3),
(2, 3),
(3, 4),
(4, 4),
(5, 5),
(1, 5),
(2, 6),
(3, 6),
(4, 7),
(5, 7),
(1, 8),
(2, 8),
(3, 9),
(4, 9),
(5, 10),
(1, 10);

INSERT INTO ContenidoConversacion (idContenido, idConversacion, acertado, puntuacion, consumio, opinion) VALUES
(1, 1, true, 8, true, 'Excelente pelicula, me encanto el contexto.'),
(2, 1, false, 5, true, 'Interesante pero pudo ser más clara la trama.'),
(3, 2, true, 9, true, 'Muy informativo, deja enseñanzas valiosas.'),
(4, 2, true, 10, true, 'Me encantó este contenido, muy relevante.'),
(5, 3, false, 3, false, 'No me parecio un contenido acertado.'),
(1, 3, true, 7, true, 'Buen aporte a la conversación.'),
(2, 4, false, 4, true, 'No me aporto ninguna emoción.'),
(3, 4, true, 8, true, 'Esplendido, me encanto este contenido.'),
(4, 5, true, 9, true, 'Visualmente impresionante, no te lo podes perder.'),
(5, 5, true, 10, true, 'Increible, muy bien ejecutada.'),
(1, 6, true, 8, true, 'Bien argumentado y emocionante.'),
(2, 6, false, 5, true, 'Fue confuso, no me gusto el final.'),
(3, 7, true, 9, true, 'Excelente selección para el tema.'),
(4, 7, true, 10, true, 'Cumplió mis expectativas.'),
(5, 8, false, 3, false, 'No me atrajo, podría ser más interesante.'),
(1, 8, true, 7, true, 'Aportó mucho a mi estado de animo.'),
(2, 9, false, 4, true, 'No fue relevante para lo que buscaba.'),
(3, 9, true, 8, true, 'Muy buena, mejoraría el final.'),
(1, 5, true, 10, true, 'Todos deberian consumir este contenido, 10 puntos.'),
(1, 7, true, 10, true, 'Fantastico, la recomiendo totalmente.');
