CREATE TABLE IF NOT EXISTS albergues (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    concello VARCHAR(100) NOT NULL,
    camino VARCHAR(100) NOT NULL,
    plazas INT NOT NULL,
    precio_noche NUMERIC(5, 2) NOT NULL
);