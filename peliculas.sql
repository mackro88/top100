-- Crear base de datos llamada películas
CREATE DATABASE peliculas;
\c peliculas;
-- Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes, determinando la relación entre ambas tablas.
CREATE TABLE peliculas (
    id INT NOT NULL UNIQUE,
    titulo VARCHAR(150) NOT NULL,
    anio_estreno INT,
    director VARCHAR(50),
    PRIMARY KEY (id)
);
CREATE TABLE reparto (
    id_peliculas INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    FOREIGN KEY (id_peliculas) REFERENCES peliculas(id)
);
-- Cargar ambos archivos a su tabla correspondiente
\copy peliculas FROM 'csv/peliculas.csv' csv header;
\copy reparto FROM 'csv/reparto.csv' csv header;
