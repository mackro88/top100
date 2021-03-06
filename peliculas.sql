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
-- Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto.
SELECT nombre, titulo, anio_estreno, director FROM reparto INNER JOIN peliculas ON reparto.id_peliculas = peliculas.id WHERE id_peliculas = (SELECT id FROM peliculas WHERE titulo = 'Titanic');
-- Listar los titulos de las películas donde actúe Harrison Ford
SELECT titulo AS Películas_Harrison_Ford FROM peliculas INNER JOIN reparto ON peliculas.id = reparto.id_peliculas WHERE nombre = 'Harrison Ford';
-- Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT director, count(director) AS peliculas FROM peliculas GROUP BY director ORDER BY count(director) DESC LIMIT 10; 
-- Indicar cuantos actores distintos hay
SELECT count(distinct nombre) AS distintos FROM reparto; 
-- Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.
SELECT titulo, anio_estreno FROM peliculas WHERE anio_estreno BETWEEN 1989 AND 2000 ORDER BY titulo ASC; 
-- Listar el reparto de las películas lanzadas el año 2001
SELECT nombre FROM reparto INNER JOIN peliculas ON reparto.id_peliculas = peliculas.id WHERE anio_estreno = 2001 ORDER BY nombre ASC; 
-- Listar los actores de la película más nueva (son 3 las películas del último año)
SELECT nombre, titulo FROM reparto INNER JOIN peliculas ON reparto.id_peliculas = peliculas.id WHERE anio_estreno = (SELECT max(anio_estreno) FROM peliculas);