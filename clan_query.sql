-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
-- Corran estos 3 pasos para resetear los datos de las tablas

USE clan_db;

-- 1. Desactivar temporalmente la revisión de llaves foráneas
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Vaciar todas las tablas del proyecto (reinicia los IDs a 1)
TRUNCATE TABLE detalles;
TRUNCATE TABLE movimientos;
TRUNCATE TABLE notificaciones;
TRUNCATE TABLE solicitudes;
TRUNCATE TABLE productos;
TRUNCATE TABLE usuarios;
TRUNCATE TABLE categorias;

-- 3. Reactivar la revisión de llaves foráneas
SET FOREIGN_KEY_CHECKS = 1;
-- ------------------------------------------------------------------
-- ------------------------------------------------------------------

-- -----------------------------------------------------
-- Populamos tabla de categorías
-- -----------------------------------------------------

INSERT INTO `clan_db`.`categorias` (nombre, sigla) VALUES 
('Merchandising', 'M'),
('Kits', 'K'),
('Ludicos', 'L'),
('Utileria', 'U');

SELECT * FROM categorias;

-- -----------------------------------------------------
-- Populamos tabla de usuarios
-- -----------------------------------------------------
INSERT INTO `clan_db`.`usuarios` (`nombres`, `apellidos`, `rol`, `correo`, `contrasenia`, `foto_perfil`, `activo`, `id_creador`) VALUES 
('Super', 'Admin', 'superadmin', 'superadmin@clan.com', 'hash_password_seguro', NULL, 1, NULL),
('Carlos André', 'Sánchez Silva', 'administrador', 'carlos.sanchezsilva@quintaola.com', 'hash456', NULL, 1, 1),
('Ana Lucía', 'Incio Bocchio', 'encargado_deposito', 'ana.inciobocchio@quintaola.com', 'hash789', NULL, 1, 2),
('Roberto José', 'Flores Ayala', 'solicitante', 'roberto.floresayala@quintaola.com', 'hash456', NULL, 1, 2),
('Giovanna Carla', 'Gauna Loayza', 'solicitante', 'giovanna.gaunaloayza@quintaola.com', 'hash422', NULL, 1, 2),
('Fernando Enrique', 'Fernández Del Río', 'coordinador', 'fernando.fernandezdelrio@quintaola.com', 'hash456', NULL, 1, 2),
('Jorge Santiago', 'Cárdenas Monte', 'coordinador', 'jorge.cardenasmonte@quintaola.com', 'hash156', NULL, 1, 2);

SELECT * FROM usuarios;

-- -----------------------------------------------------
-- Populamos tabla de productos
-- -----------------------------------------------------

INSERT INTO `clan_db`.`productos` 
(`codigo`, `nombre`, `stock_actual`, `stock_bajo`,`stock_critico`, `imagen`, `activo`, `id_usuarios`, `id_categorias`) 
VALUES 
('0100', 'Monopolio', 50, 15, 5, NULL, 1, 2, 3),        	-- SKU: L-0100 (Estado: Verde)
('0101', 'Jenga', 4, 10, 5, NULL, 1, 2, 3),             	-- SKU: L-0101 (Estado: Rojo)
('0100', 'Papelotes', 40, 50, 20, NULL, 1, 2, 4),       	-- SKU: U-0100 (Estado: Amarillo)
('0101', 'Marcadores gruesos', 50, 20, 5, NULL, 1, 2, 4), 	-- SKU: U-0101 (Estado: Verde)
('0100', 'Gorras', 60, 30, 10, NULL, 1, 2, 1);          	-- SKU: M-0100 (Estado: Verde)

SELECT * FROM productos;

-- -----------------------------------------------------
-- Tabla de solicitudes
-- -----------------------------------------------------

INSERT INTO `clan_db`.`solicitudes` 
(`proposito`, `estado`, `fecha_solicitud`, `comentario_rechazo`, `id_solicitante`, `id_coordinador`, `id_deposito`, `fecha_entrega`, `fecha_revision`) 
VALUES 
('Taller infantil de dibujo', 'pendiente', CURRENT_TIMESTAMP, NULL, 4, NULL, NULL, NULL, NULL),
('Dinámica de integración', 'aprobada', CURRENT_TIMESTAMP, NULL, 5, 6, NULL, NULL, '2026-06-04 14:15:30'),
('Gorras para el evento del sábado', 'entregada', CURRENT_TIMESTAMP, NULL, 5, 6, 3, '2026-06-03 10:30:00', '2026-06-01 16:45:00'),
('Taller de cuentacuentos externo', 'aprobada', CURRENT_TIMESTAMP, NULL, 4, 7, NULL, NULL, '2026-06-05 09:00:00'),
('Capacitación de seguridad trimestral', 'aprobada', CURRENT_TIMESTAMP, NULL, 4, 6, NULL, NULL, '2026-06-05 10:30:00'),
('Material para dinámica de bienvenida', 'aprobada', CURRENT_TIMESTAMP, NULL, 5, 7, NULL, NULL, '2026-06-05 11:45:00');

SELECT * FROM solicitudes;

-- -----------------------------------------------------
-- Tabla de detalles
-- -----------------------------------------------------

INSERT INTO `clan_db`.`detalles` 
(`id_solicitudes`, `id_productos`, `cantidad`) 
VALUES 
-- Detalles para Solicitud 1 (Taller de dibujo)
(1, 3, 10), -- 10 Papelotes
(1, 4, 5),  -- 5 Marcadores gruesos

-- Detalles para Solicitud 2 (Dinámica de integración)
(2, 1, 2),  -- 2 Monopolios
(2, 2, 2),  -- 2 Jengas

-- Detalles para Solicitud 3 (Gorras para el evento)
(3, 5, 30), -- 30 Gorras

-- Detalles para Solicitud 4 (Taller de cuentacuentos)
(4, 3, 15), -- 15 Papelotes 
(4, 4, 10), -- 10 Marcadores gruesos 

-- Detalles para Solicitud 5 (Capacitación de seguridad)
(5, 5, 20), -- 20 Gorras 
(5, 3, 5),  -- 5 Papelotes 

-- Detalles para Solicitud 6 (Dinámica de bienvenida)
(6, 1, 1),  -- 1 Monopolio 
(6, 2, 3);  -- 3 Jengas

SELECT * FROM detalles;

-- -----------------------------------------------------
-- Tabla de movimientos
-- -----------------------------------------------------

-- Primero ingresamos un stock inicial (compras generales) hecho por el Admin
INSERT INTO `clan_db`.`movimientos` 
(`tipo`, `fecha_movimiento`, `cantidad`, `id_productos`, `id_responsable`, `id_solicitudes`) 
VALUES 
('entrada', '2026-06-01 08:00:00', 100, 3, 2, NULL), -- Entran 100 Papelotes
('entrada', '2026-06-01 08:15:00', 90, 5, 2, NULL);  -- Entran 90 Gorras

-- Registramos la salida correspondiente a la Solicitud 3
INSERT INTO `clan_db`.`movimientos` 
(`tipo`, `fecha_movimiento`, `cantidad`, `id_productos`, `id_responsable`, `id_solicitudes`) 
VALUES 
('salida', '2026-06-03 10:30:00', 30, 5, 3, 3); -- Salen 30 Gorras por la solicitud 3

SELECT * FROM movimientos;

SELECT * FROM productos;


-- --------------------------------------------------------------------
-- Rol: Encargado de Depósito
-- --------------------------------------------------------------------
-- Populamos tabla de notificaciones

INSERT INTO `clan_db`.`notificaciones` 
(`mensaje`, `leido`, `fecha_creacion`, `id_usuarios`) 
VALUES 
-- Notificación de solicitud aprobada
('El coordinador Fernando Enrique aprobó la solicitud #2. Lista para preparación.', 0, '2026-06-05 14:16:00', 3),
('El coordinador Jorge Santiago aprobó la solicitud #3. Lista para preparación.', 1, '2026-06-04 14:16:00', 3),
('El coordinador Jorge Santiago aprobó la solicitud #4. Lista para preparación.', 1, '2026-06-04 14:16:00', 3),
('El coordinador Fernando Enrique aprobó la solicitud #1. Lista para preparación.', 0, '2026-06-05 14:16:00', 3),

-- Confirmación de entrega
('Realizaste la entrega de la solicitud #3 exitosamente.', 0, '2026-06-08 10:30:05', 3);

-- La lógica para concatenar el id de la solicitud con el mensaje se hará a nivel de código en el backend.
SELECT * FROM notificaciones;


SELECT * FROM solicitudes;

-- Solicitudes entregadas
SELECT COUNT(id_solicitudes) AS 'Solicitudes entregadas'
FROM clan_db.solicitudes 
WHERE estado = 'entregada';
-- Solicitudes por entregar
SELECT COUNT(id_solicitudes) AS 'Solicitudes por entregar'
FROM clan_db.solicitudes 
WHERE estado = 'aprobada';
-- Entradas
SELECT COUNT(id_movimientos) AS 'Entradas'
FROM clan_db.movimientos 
WHERE tipo = 'entrada';


-- -----------------------------------------------------
-- Tablas para el rol de Encargado de Depósito
-- -----------------------------------------------------

-- Bandeja de solicitudes

SELECT 
CONCAT('#', s.id_solicitudes) AS 'ID de Solicitud',
CONCAT(sol.nombres, ' ', sol.apellidos) AS 'Solicitante',
CONCAT(coord.nombres, ' ', coord.apellidos) AS 'Aprobador',
DATE_FORMAT(s.fecha_revision, '%d/%m/%Y') AS 'Fecha'
FROM clan_db.solicitudes s
JOIN clan_db.usuarios sol ON s.id_solicitante = sol.id_usuarios
JOIN clan_db.usuarios coord ON s.id_coordinador = coord.id_usuarios
WHERE s.estado = 'aprobada';


-- Filtros
-- Cambiamos los SET según los filtros que envíe el frontend.

SELECT * FROM usuarios;
SELECT * FROM solicitudes;
-- Estas variables simulan lo que el código Java enviará a MySQL.
SET @filtro_solicitante = 4;   -- Ejemplo: 4 o 5
SET @filtro_coordinador = NULL;   -- Ejemplo: 6 o 7
SET @filtro_fecha = NULL;         -- Ejemplo: '2026-06-05' o '2026-06-04'
SET @buscar = NULL;               

SELECT 
    s.id_solicitudes AS 'Id de solicitud',
    CONCAT(u_sol.nombres, ' ', u_sol.apellidos) AS 'Nombre del solicitante',
    CONCAT(u_coord.nombres, ' ', u_coord.apellidos) AS 'Aprobador',
    DATE_FORMAT(s.fecha_revision, '%d/%m/%Y') AS 'Fecha'
FROM clan_db.solicitudes s
-- Primer JOIN para traer los datos del usuario que solicita
JOIN clan_db.usuarios u_sol ON s.id_solicitante = u_sol.id_usuarios
-- Segundo JOIN para traer los datos del usuario que aprobó
JOIN clan_db.usuarios u_coord ON s.id_coordinador = u_coord.id_usuarios
-- Esta tabla solo muestra solicitudes ya aprobadas
WHERE s.estado = 'aprobada' 
  AND (@filtro_solicitante IS NULL OR s.id_solicitante = @filtro_solicitante)
  AND (@filtro_coordinador IS NULL OR s.id_coordinador = @filtro_coordinador)
  AND (@filtro_fecha IS NULL OR DATE(s.fecha_revision) = @filtro_fecha)
  AND (@buscar IS NULL
        OR s.id_solicitudes LIKE CONCAT('%', @buscar, '%')
        OR CONCAT(u_sol.nombres, ' ', u_sol.apellidos) LIKE CONCAT('%', @buscar, '%')
        OR CONCAT(u_coord.nombres, ' ', u_coord.apellidos) LIKE CONCAT('%', @buscar, '%')
      )
ORDER BY s.fecha_solicitud DESC;

-- Detalles de solicitud

SELECT 
DATE_FORMAT(s.fecha_revision, '%d/%m/%Y') AS 'Fecha de aprobación',
CONCAT(sol.nombres, ' ', sol.apellidos) AS 'Solicitado por',
CONCAT(coord.nombres, ' ', coord.apellidos) AS 'Aprobado por',
s.proposito AS 'Propósito'
FROM clan_db.solicitudes s
JOIN clan_db.usuarios sol ON s.id_solicitante = sol.id_usuarios
JOIN clan_db.usuarios coord ON s.id_coordinador = coord.id_usuarios
WHERE s.id_solicitudes = 2;

SELECT 
d.cantidad,
p.nombre,
CONCAT(c.sigla, '-', p.codigo) AS 'SKU'
FROM clan_db.detalles d
JOIN clan_db.productos p ON d.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE d.id_solicitudes = 2;

-- Forma alternativa

SELECT 
DATE_FORMAT(s.fecha_revision, '%d/%m/%Y') AS 'Fecha de aprobacion',
CONCAT(sol.nombres, ' ', sol.apellidos) AS 'Solicitado por',
CONCAT(coord.nombres, ' ', coord.apellidos) AS 'Aprobado por',
d.cantidad AS 'Cantidad',
p.nombre AS 'Material',
CONCAT(c.sigla, '-', p.codigo) AS 'SKU',
s.proposito AS 'Proposito'
FROM clan_db.solicitudes s
JOIN clan_db.usuarios sol ON s.id_solicitante = sol.id_usuarios
JOIN clan_db.usuarios coord ON s.id_coordinador = coord.id_usuarios
JOIN clan_db.detalles d ON s.id_solicitudes = d.id_solicitudes
JOIN clan_db.productos p ON d.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE s.id_solicitudes = 2;


-- Registro de entrada de productos

SELECT 
p.nombre AS 'Producto',
CONCAT('SKU: ', c.sigla, '-', p.codigo) AS 'Código',
p.stock_actual AS 'Stock Actual',
CASE 
	WHEN p.stock_actual <= p.stock_critico THEN 'Rojo'      -- ¿Está en estado crítico?
	WHEN p.stock_actual <= p.stock_bajo THEN 'Amarillo'     -- ¿Al menos está bajo?
	ELSE 'Verde'                                            -- Está en estado óptimo
END AS 'EstadoColor'
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE p.activo = 1;

-- Registro de salida de productos

SELECT 
CONCAT('#', s.id_solicitudes) AS 'ID de Solicitud',
CONCAT(u.nombres, ' ', u.apellidos) AS 'Solicitante',
DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y') AS 'Fecha de Pedido',
DATE_FORMAT(s.fecha_entrega, '%d/%m/%Y') AS 'Fecha de Entrega'
FROM clan_db.solicitudes s
JOIN clan_db.usuarios u ON s.id_solicitante = u.id_usuarios
WHERE s.estado = 'entregada';

-- Para el centro de notificaciones (campana)
SELECT 
mensaje AS 'Notificación',
DATE_FORMAT(fecha_creacion, '%d/%m/%Y %H:%i') AS 'Fecha y Hora'
FROM clan_db.notificaciones
WHERE id_usuarios = 3 AND leido = 0
ORDER BY fecha_creacion DESC
LIMIT 5;

-- Contar notificaciones no leídas (campana)
SELECT COUNT(id_notificaciones) AS total_no_leidas
FROM clan_db.notificaciones
WHERE id_usuarios = 3 AND leido = 0;

-- Historial completo de notificaciones
SELECT 
mensaje AS 'Notificación', 
CASE WHEN leido = 0 THEN 'No Leído' ELSE 'Leído' END AS 'Estado',
DATE_FORMAT(fecha_creacion, '%d/%m/%Y') AS 'Fecha'
FROM clan_db.notificaciones
WHERE id_usuarios = 3
ORDER BY fecha_creacion DESC;

-- --------------------------------------------------------------------
-- Encargado de Depósito entrega una solicitud (#2)
-- --------------------------------------------------------------------

-- Paso 1: Actualizar el estado de la solicitud y registrar quién la entregó
UPDATE clan_db.solicitudes 
SET estado = 'entregada', 
    id_deposito = 3, 
    fecha_entrega = CURRENT_TIMESTAMP 
WHERE id_solicitudes = 2;

SELECT * FROM solicitudes;

-- Paso 2: Registrar la salida física en la tabla movimientos para cada producto de esa solicitud
INSERT INTO clan_db.movimientos 
(`tipo`, `cantidad`, `id_productos`, `id_responsable`, `id_solicitudes`) 
VALUES 
('salida', 2, 1, 3, 2),  -- Salen 2 unidades del producto ID 1 (Monopolio)
('salida', 2, 2, 3, 2);  -- Salen 2 unidades del producto ID 2 (Jenga)

SELECT * FROM movimientos;
SELECT * FROM usuarios;
-- --------------------------------------------------------------------
-- Encargado de Depósito registra entrada de nuevo stock
-- --------------------------------------------------------------------

-- Paso 1: Sumar el stock en la tabla de productos (ejemplo: ingresan 10 Papelotes, ID 3)
UPDATE clan_db.productos 
SET stock_actual = stock_actual + 10 
WHERE id_productos = 3;

SELECT * FROM productos;

-- Paso 2: Registrar la entrada en la tabla movimientos, sin id_solicitudes
INSERT INTO clan_db.movimientos 
(`tipo`, `cantidad`, `id_productos`, `id_responsable`, `id_solicitudes`) 
VALUES 
('entrada', 10, 3, 3, NULL);

SELECT * FROM movimientos;


-- --------------------------------------------------------------------
-- Rol: Administrador
-- --------------------------------------------------------------------

-- 1. INICIO / DASHBOARD DEL ADMINISTRADOR

-- Usuarios registrados activos
SELECT COUNT(id_usuarios) AS usuarios_registrados
FROM clan_db.usuarios
WHERE activo = 1;

-- Solicitudes aprobadas del mes actual
SELECT COUNT(id_solicitudes) AS solicitudes_aprobadas
FROM clan_db.solicitudes
WHERE estado = 'aprobada'
  AND fecha_revision IS NOT NULL
  AND YEAR(fecha_revision) = YEAR(CURDATE())
  AND MONTH(fecha_revision) = MONTH(CURDATE());

-- Solicitudes pendientes del mes actual
SELECT COUNT(id_solicitudes) AS solicitudes_pendientes
FROM clan_db.solicitudes
WHERE estado = 'pendiente'
  AND YEAR(fecha_solicitud) = YEAR(CURDATE())
  AND MONTH(fecha_solicitud) = MONTH(CURDATE());

-- Solicitudes rechazadas del mes actual
SELECT COUNT(id_solicitudes) AS solicitudes_rechazadas
FROM clan_db.solicitudes
WHERE estado = 'rechazada'
  AND fecha_revision IS NOT NULL
  AND YEAR(fecha_revision) = YEAR(CURDATE())
  AND MONTH(fecha_revision) = MONTH(CURDATE());

-- Campana superior: cantidad de notificaciones no leídas del administrador logueado
SET @id_admin = 2;

SELECT COUNT(id_notificaciones) AS notificaciones_no_leidas
FROM clan_db.notificaciones
WHERE id_usuarios = @id_admin
  AND leido = 0;

-- Tabla: Actividad reciente del sistema
-- Muestra movimientos de inventario, registro de solicitudes y revisiones de solicitudes.
SELECT *
FROM (
    SELECT
        CONCAT(u.nombres, ' ', u.apellidos) AS Usuario,
        u.rol AS Rol,
        CASE
            WHEN m.tipo = 'entrada' THEN 'Stock Añadido'
            WHEN m.tipo = 'salida' THEN 'Stock Retirado'
        END AS Accion,
        CASE
            WHEN m.tipo = 'entrada' THEN CONCAT('Agregó ', m.cantidad, ' unidades de "', p.nombre, '"')
            WHEN m.tipo = 'salida' THEN CONCAT('Retiró ', m.cantidad, ' unidades de "', p.nombre, '"')
        END AS Detalle,
        DATE_FORMAT(m.fecha_movimiento, '%d/%m/%Y - %h:%i %p') AS Fecha_y_Hora,
        m.fecha_movimiento AS fecha_orden
    FROM clan_db.movimientos m
    JOIN clan_db.usuarios u ON m.id_responsable = u.id_usuarios
    JOIN clan_db.productos p ON m.id_productos = p.id_productos

    UNION ALL

    SELECT
        CONCAT(u.nombres, ' ', u.apellidos) AS Usuario,
        u.rol AS Rol,
        'Registro de solicitud' AS Accion,
        CONCAT('Registró una nueva solicitud #', s.id_solicitudes) AS Detalle,
        DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y - %h:%i %p') AS Fecha_y_Hora,
        s.fecha_solicitud AS fecha_orden
    FROM clan_db.solicitudes s
    JOIN clan_db.usuarios u ON s.id_solicitante = u.id_usuarios

    UNION ALL

    SELECT
        CONCAT(u.nombres, ' ', u.apellidos) AS Usuario,
        u.rol AS Rol,
        CASE
            WHEN s.estado = 'aprobada' THEN 'Solicitud Aprobada'
            WHEN s.estado = 'rechazada' THEN 'Solicitud Rechazada'
        END AS Accion,
        CASE
            WHEN s.estado = 'aprobada' THEN CONCAT('Aprobó solicitud #', s.id_solicitudes)
            WHEN s.estado = 'rechazada' THEN CONCAT('Rechazó solicitud #', s.id_solicitudes)
        END AS Detalle,
        DATE_FORMAT(s.fecha_revision, '%d/%m/%Y - %h:%i %p') AS Fecha_y_Hora,
        s.fecha_revision AS fecha_orden
    FROM clan_db.solicitudes s
    JOIN clan_db.usuarios u ON s.id_coordinador = u.id_usuarios
    WHERE s.estado IN ('aprobada', 'rechazada')
      AND s.fecha_revision IS NOT NULL
) AS actividad
ORDER BY fecha_orden DESC
LIMIT 6;

-- Panel lateral: Alertas de stock
SELECT
    p.nombre AS Material,
    p.stock_actual AS Cantidad,
    CASE
        WHEN p.stock_actual <= p.stock_critico THEN 'Crítico'
        WHEN p.stock_actual <= p.stock_bajo THEN 'Bajo'
        ELSE 'Óptimo'
    END AS Estado,
    CASE
        WHEN p.stock_actual <= p.stock_critico THEN 'Rojo'
        WHEN p.stock_actual <= p.stock_bajo THEN 'Amarillo'
        ELSE 'Verde'
    END AS EstadoColor
FROM clan_db.productos p
WHERE p.activo = 1
ORDER BY
    CASE
        WHEN p.stock_actual <= p.stock_critico THEN 1
        WHEN p.stock_actual <= p.stock_bajo THEN 2
        ELSE 3
    END,
    p.stock_actual ASC,
    p.nombre ASC
LIMIT 10;


-- 2. GESTIÓN DE USUARIOS / TABLA DE ADMINISTRACIÓN

-- Combo: filtrar por usuario
SELECT
    id_usuarios,
    CONCAT(nombres, ' ', apellidos) AS usuario
FROM clan_db.usuarios
WHERE activo = 1
ORDER BY nombres, apellidos;

-- Combo: filtrar por rol
SELECT DISTINCT rol
FROM clan_db.usuarios
ORDER BY rol;

-- Combo: filtrar por estado
SELECT 1 AS valor, 'Activo' AS estado
UNION ALL
SELECT 0 AS valor, 'Inactivo' AS estado;

-- Tabla de administración de personal
-- Se cambian los SET según los filtros del frontend.
-- Si un filtro no se usa, se deja en NULL.
SET @filtro_usuario = NULL;       -- Ejemplo: 3
SET @filtro_rol = NULL;           -- Ejemplo: 'solicitante'
SET @filtro_estado = NULL;        -- Ejemplo: 1 activo, 0 inactivo
SET @buscar = NULL;               -- Ejemplo: 'ana'

SELECT
    u.id_usuarios AS id,
    CONCAT(u.nombres, ' ', u.apellidos) AS Usuario,
    u.correo AS Correo,
    u.rol AS Roles,
    CASE
        WHEN u.activo = 1 THEN 'Activo'
        ELSE 'Inactivo'
    END AS Estado,
    u.foto_perfil AS Foto
FROM clan_db.usuarios u
WHERE (@filtro_usuario IS NULL OR u.id_usuarios = @filtro_usuario)
  AND (@filtro_rol IS NULL OR u.rol = @filtro_rol)
  AND (@filtro_estado IS NULL OR u.activo = @filtro_estado)
  AND (
        @buscar IS NULL
        OR CONCAT(u.nombres, ' ', u.apellidos) LIKE CONCAT('%', @buscar, '%')
        OR u.correo LIKE CONCAT('%', @buscar, '%')
        OR u.rol LIKE CONCAT('%', @buscar, '%')
      )
ORDER BY u.id_usuarios DESC
LIMIT 6 OFFSET 0;

-- Total de registros para la paginación de usuarios
SELECT COUNT(*) AS total_registros
FROM clan_db.usuarios u
WHERE (@filtro_usuario IS NULL OR u.id_usuarios = @filtro_usuario)
  AND (@filtro_rol IS NULL OR u.rol = @filtro_rol)
  AND (@filtro_estado IS NULL OR u.activo = @filtro_estado)
  AND (
        @buscar IS NULL
        OR CONCAT(u.nombres, ' ', u.apellidos) LIKE CONCAT('%', @buscar, '%')
        OR u.correo LIKE CONCAT('%', @buscar, '%')
        OR u.rol LIKE CONCAT('%', @buscar, '%')
      );

-- Botón ver detalle de usuario
SET @id_usuario = 2;

SELECT
    u.id_usuarios,
    u.nombres,
    u.apellidos,
    u.correo,
    u.rol,
    CASE
        WHEN u.activo = 1 THEN 'Activo'
        ELSE 'Inactivo'
    END AS estado,
    u.foto_perfil,
    CONCAT(creador.nombres, ' ', creador.apellidos) AS creado_por
FROM clan_db.usuarios u
LEFT JOIN clan_db.usuarios creador ON u.id_creador = creador.id_usuarios
WHERE u.id_usuarios = @id_usuario;


-- 3. REGISTRAR NUEVO USUARIO

-- Verificar si el correo ya existe antes de registrar
SET @correo_nuevo = 'nuevo.usuario@clan.com';

SELECT COUNT(*) AS correo_existe
FROM clan_db.usuarios
WHERE correo = @correo_nuevo;

-- Registrar nuevo integrante
-- La contraseña debe llegar hasheada desde el backend.
-- La pantalla separa apellido paterno y materno, pero la BD actual guarda un solo campo apellidos.
SET @id_admin_creador = 2;
SET @nombres = 'Nuevo';
SET @apellido_paterno = 'Usuario';
SET @apellido_materno = 'Prueba';
SET @rol = 'solicitante';
SET @correo = 'nuevo.usuario@clan.com';
SET @contrasenia_hash = 'hash_generado_en_backend';
SET @foto_perfil = NULL;

INSERT INTO clan_db.usuarios
(nombres, apellidos, rol, correo, contrasenia, foto_perfil, activo, id_creador)
VALUES
(
    @nombres,
    TRIM(CONCAT(@apellido_paterno, ' ', @apellido_materno)),
    @rol,
    @correo,
    @contrasenia_hash,
    @foto_perfil,
    1,
    @id_admin_creador
);

SELECT * FROM usuarios;

-- Editar usuario existente
SET @id_usuario_editar = 3;
SET @nombres_editar = 'Lucía';
SET @apellidos_editar = 'Bocchio';
SET @rol_editar = 'encargado_deposito';
SET @correo_editar = 'lucia.bocchio@clan.com';
SET @foto_editar = NULL;
SET @activo_editar = 1;

UPDATE clan_db.usuarios
SET nombres = @nombres_editar,
    apellidos = @apellidos_editar,
    rol = @rol_editar,
    correo = @correo_editar,
    foto_perfil = @foto_editar,
    activo = @activo_editar
WHERE id_usuarios = @id_usuario_editar;

SELECT * FROM usuarios;

-- Desactivar usuario sin eliminarlo físicamente
SET @id_usuario_desactivar = 4;

UPDATE clan_db.usuarios
SET activo = 0
WHERE id_usuarios = @id_usuario_desactivar;

-- Reactivar usuario
SET @id_usuario_reactivar = 4;

UPDATE clan_db.usuarios
SET activo = 1
WHERE id_usuarios = @id_usuario_reactivar;


-- 4. GESTIÓN DE INVENTARIO / TABLA DE INVENTARIO ACTUAL

-- Combo: categorías
SELECT
    id_categorias,
    nombre,
    sigla
FROM clan_db.categorias
ORDER BY nombre;

-- Combo: estados de stock
SELECT 'critico' AS valor, 'Crítico' AS estado
UNION ALL
SELECT 'bajo' AS valor, 'Bajo' AS estado
UNION ALL
SELECT 'optimo' AS valor, 'Óptimo' AS estado;

-- Tabla de inventario actual
-- Si no se usa un filtro, se deja en NULL.
SET @filtro_categoria = NULL;     -- Ejemplo: 3
SET @filtro_stock = NULL;         -- Ejemplo: 'critico', 'bajo', 'optimo'
SET @buscar_producto = NULL;      -- Ejemplo: 'polo'

SELECT
    p.id_productos AS id,
    CONCAT('SKU: ', c.sigla, '-', p.codigo) AS Codigo,
    p.nombre AS Producto,
    c.nombre AS Categoria,
    p.stock_actual AS Stock,
    CASE
        WHEN p.stock_actual <= p.stock_critico THEN 'Crítico'
        WHEN p.stock_actual <= p.stock_bajo THEN 'Bajo'
        ELSE 'Óptimo'
    END AS Estado,
    CASE
        WHEN p.stock_actual <= p.stock_critico THEN 'Rojo'
        WHEN p.stock_actual <= p.stock_bajo THEN 'Amarillo'
        ELSE 'Verde'
    END AS EstadoColor,
    p.imagen AS Imagen
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE p.activo = 1
  AND (@filtro_categoria IS NULL OR p.id_categorias = @filtro_categoria)
  AND (
        @filtro_stock IS NULL
        OR (@filtro_stock = 'critico' AND p.stock_actual <= p.stock_critico)
        OR (@filtro_stock = 'bajo' AND p.stock_actual > p.stock_critico AND p.stock_actual <= p.stock_bajo)
        OR (@filtro_stock = 'optimo' AND p.stock_actual > p.stock_bajo)
      )
  AND (
        @buscar_producto IS NULL
        OR p.nombre LIKE CONCAT('%', @buscar_producto, '%')
        OR c.nombre LIKE CONCAT('%', @buscar_producto, '%')
        OR CONCAT(c.sigla, '-', p.codigo) LIKE CONCAT('%', @buscar_producto, '%')
        OR CONCAT('SKU: ', c.sigla, '-', p.codigo) LIKE CONCAT('%', @buscar_producto, '%')
      )
ORDER BY p.id_productos DESC
LIMIT 6 OFFSET 0;

-- Total de registros para la paginación de inventario
SELECT COUNT(*) AS total_registros
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE p.activo = 1
  AND (@filtro_categoria IS NULL OR p.id_categorias = @filtro_categoria)
  AND (
        @filtro_stock IS NULL
        OR (@filtro_stock = 'critico' AND p.stock_actual <= p.stock_critico)
        OR (@filtro_stock = 'bajo' AND p.stock_actual > p.stock_critico AND p.stock_actual <= p.stock_bajo)
        OR (@filtro_stock = 'optimo' AND p.stock_actual > p.stock_bajo)
      )
  AND (
        @buscar_producto IS NULL
        OR p.nombre LIKE CONCAT('%', @buscar_producto, '%')
        OR c.nombre LIKE CONCAT('%', @buscar_producto, '%')
        OR CONCAT(c.sigla, '-', p.codigo) LIKE CONCAT('%', @buscar_producto, '%')
        OR CONCAT('SKU: ', c.sigla, '-', p.codigo) LIKE CONCAT('%', @buscar_producto, '%')
      );

-- Botón ver detalle de producto
SET @id_producto = 1;

SELECT
    p.id_productos,
    CONCAT(c.sigla, '-', p.codigo) AS sku,
    p.codigo,
    p.nombre AS producto,
    c.nombre AS categoria,
    p.stock_actual,
    p.stock_bajo,
    p.stock_critico,
    CASE
        WHEN p.stock_actual <= p.stock_critico THEN 'Crítico'
        WHEN p.stock_actual <= p.stock_bajo THEN 'Bajo'
        ELSE 'Óptimo'
    END AS estado,
    p.imagen,
    CONCAT(u.nombres, ' ', u.apellidos) AS registrado_por
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
JOIN clan_db.usuarios u ON p.id_usuarios = u.id_usuarios
WHERE p.id_productos = @id_producto;


-- 5. REGISTRAR NUEVO PRODUCTO

-- Verificar si ya existe el SKU antes de registrar
SET @codigo_producto = '0201';
SET @id_categoria_producto = 3;

SELECT COUNT(*) AS sku_existe
FROM clan_db.productos
WHERE codigo = @codigo_producto
  AND id_categorias = @id_categoria_producto;

-- Registrar producto nuevo y guardar movimiento inicial de entrada
-- La pantalla muestra estado con regla: crítico 0-5, bajo 6-10, óptimo 11 a más.
-- Por eso se usan stock_critico = 5 y stock_bajo = 10.
SET @id_admin_producto = 2;
SET @codigo = '0201';
SET @producto = 'Nuevo producto';
SET @stock_inicial = 12;
SET @id_categoria = 3;
SET @stock_critico = 5;
SET @stock_bajo = 10;
SET @imagen_producto = NULL;

START TRANSACTION;

INSERT INTO clan_db.productos
(codigo, nombre, stock_actual, stock_bajo, stock_critico, imagen, activo, id_usuarios, id_categorias)
VALUES
(@codigo, @producto, @stock_inicial, @stock_bajo, @stock_critico, @imagen_producto, 1, @id_admin_producto, @id_categoria);

SET @id_producto_nuevo = LAST_INSERT_ID();

INSERT INTO clan_db.movimientos
(tipo, fecha_movimiento, cantidad, id_productos, id_responsable, id_solicitudes)
SELECT 'entrada', NOW(), @stock_inicial, @id_producto_nuevo, @id_admin_producto, NULL
WHERE @stock_inicial > 0;

COMMIT;

-- Editar producto existente
SET @id_producto_editar = 1;
SET @codigo_editar = '0100';
SET @nombre_producto_editar = 'Monopolio';
SET @stock_bajo_editar = 10;
SET @stock_critico_editar = 5;
SET @imagen_editar = NULL;
SET @id_categoria_editar = 3;

UPDATE clan_db.productos
SET codigo = @codigo_editar,
    nombre = @nombre_producto_editar,
    stock_bajo = @stock_bajo_editar,
    stock_critico = @stock_critico_editar,
    imagen = @imagen_editar,
    id_categorias = @id_categoria_editar
WHERE id_productos = @id_producto_editar;

-- Ajustar stock por nueva entrada de materiales desde administrador
SET @id_producto_entrada = 1;
SET @cantidad_entrada = 20;
SET @id_admin_entrada = 2;

START TRANSACTION;

UPDATE clan_db.productos
SET stock_actual = stock_actual + @cantidad_entrada
WHERE id_productos = @id_producto_entrada;

INSERT INTO clan_db.movimientos
(tipo, fecha_movimiento, cantidad, id_productos, id_responsable, id_solicitudes)
VALUES
('entrada', NOW(), @cantidad_entrada, @id_producto_entrada, @id_admin_entrada, NULL);

COMMIT;

-- Desactivar producto sin eliminarlo físicamente
SET @id_producto_desactivar = 1;

UPDATE clan_db.productos
SET activo = 0
WHERE id_productos = @id_producto_desactivar;

-- Agregar un producto a la categoría 2 (Kits)
INSERT INTO `clan_db`.`productos` 
(`codigo`, `nombre`, `stock_actual`, `stock_bajo`,`stock_critico`, `imagen`, `activo`, `id_usuarios`, `id_categorias`) 
VALUES 
('0201', 'Kit escolar de emergencia', 15, 10, 5, NULL, 1, 2, 2);


-- Forzamos la creación de la Solicitud #4 (aprobada) y #5 (rechazada) para el usuario 4
INSERT INTO `clan_db`.`solicitudes` 
(`id_solicitudes`, `proposito`, `estado`, `fecha_solicitud`, `comentario_rechazo`, `id_solicitante`, `id_coordinador`, `id_deposito`, `fecha_entrega`, `fecha_revision`) 
VALUES 
(4, 'Material para el taller de integración', 'aprobada', CURRENT_TIMESTAMP, NULL, 4, 2, NULL, NULL, CURRENT_TIMESTAMP),
(5, 'Gorras extras para el evento', 'rechazada', CURRENT_TIMESTAMP, 'Se excedió el límite de presupuesto', 4, 2, NULL, NULL, CURRENT_TIMESTAMP);


-- Le agregamos productos (detalles) a la solicitud #4
INSERT INTO `clan_db`.`detalles` 
(`id_solicitudes`, `id_productos`, `cantidad`) 
VALUES 
(4, 3, 5),  -- 5 Papelotes (id_producto = 3)
(4, 4, 10); -- 10 Marcadores gruesos (id_producto = 4)