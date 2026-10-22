# Infraestructura Base de Datos - Red de Albergues del Camino de Santiago

Este proyecto despliega una base de datos PostgreSQL 17 y la herramienta de gestión web Adminer mediante Docker Compose.

## Requisitos previos

- Docker Daemon y Docker Compose instalados.

## Guía de arranque paso a paso

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/Javifdez17/e1-albergues.git
   cd e1-albergues
   ```

2. **Configurar el archivo de entorno:**
   Copia el archivo `.env.example` para crear el archivo `.env` con las credenciales locales:
   ```bash
   cp .env.example .env
   ```

3. **Iniciar el proyecto:**
   Ejecuta el siguiente comando para levantar la infraestructura en segundo plano:
   ```bash
   docker compose up -d
   ```

4. **Acceder a la aplicación:**
   Abre el navegador e ingresa a [http://localhost:8080](http://localhost:8080).
   - **Sistema de gestión de BD:** PostgreSQL
   - **Servidor:** `db`
   - **Usuario:** El definido en tu `.env` (`usuario`)
   - **Contraseña:** La definida en tu `.env` (`changeme`)
   - **Base de datos:** La definida en tu `.env` (`albergues_db`)

## Práctica de Persistencia

| Paso | Comando / Acción | Resultado obtenido |
| :---: | --- | --- |
| **1** | `docker compose up -d` | Los contenedores `db` y `adminer` se levantan correctamente. La base de datos se inicializa automáticamente con la tabla `albergues` y 8 registros. |
| **2** | Inserción desde Adminer | Se añade un nuevo registro manualmente ("Albergue de Ferrol"). La tabla pasa a tener 9 registros. |
| **3** | `docker compose down`<br>`docker compose up -d` | Los contenedores se destruyen y se vuelven a crear. Al acceder a Adminer, el 9º albergue insertado en el paso 2 sigue existiendo (9 registros en total). |
| **4** | `docker compose down -v`<br>`docker compose up -d` | Los contenedores y el volumen de datos se destruyen. Al levantar de nuevo el entorno, el 9º albergue se ha perdido y la base de datos vuelve a contener únicamente los 8 albergues iniciales de `02_datos.sql`. |

### Explicación técnica: ¿Por qué cambia el resultado en el Paso 4?

Al añadir la opción `-v` al comando `docker compose down -v`, Docker destruye explícitamente el volumen nombrado (`postgres_data`). Esto elimina de forma permanente las modificaciones realizadas en la base de datos. Al volver a levantar el entorno con `docker compose up -d`, PostgreSQL encuentra un volumen vacío y reejecuta los scripts de `initdb/`, restaurando los datos a su estado inicial.