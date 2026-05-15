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
('Fernando Enrique', 'Fernández Del Río', 'coordinador', 'fernando.fernandezdelrio@quintaola.com', 'hash456', NULL, 1, 2);

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
('Dinámica de integración', 'aprobada', CURRENT_TIMESTAMP, NULL, 4, 5, NULL, NULL, '2026-06-04 14:15:30'),
('Gorras para el evento del sábado', 'entregada', CURRENT_TIMESTAMP, NULL, 4, 5, 3, '2026-06-03 10:30:00', '2026-06-01 16:45:00');

SELECT * FROM solicitudes;

-- -----------------------------------------------------
-- Tabla de detalles
-- -----------------------------------------------------

INSERT INTO `clan_db`.`detalles` 
(`id_solicitudes`, `id_productos`, `cantidad`) 
VALUES 
-- Detalles para Solicitud 1: Taller de dibujo
(1, 3, 10), -- 10 Papelotes
(1, 4, 5),  -- 5 Marcadores gruesos

-- Detalles para Solicitud 2: Dinámica de integración
(2, 1, 2),  -- 2 Monopolios
(2, 2, 2),  -- 2 Jengas

-- Detalles para Solicitud 3: Gorras para el evento
(3, 5, 30); -- 30 Gorras

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


-- -----------------------------------------------------------------------
-- Populamos tabla de notificaciones (pruebas para encargado de Depósito)
-- -----------------------------------------------------------------------

INSERT INTO `clan_db`.`notificaciones` 
(`mensaje`, `leido`, `fecha_creacion`, `id_usuarios`) 
VALUES 
-- Notificación de solicitud aprobada
('El coordinador Fernando Enrique aprobó la solicitud #2. Lista para preparación.', 0, '2026-06-04 14:16:00', 3),

-- Confirmación de entrega
('Realizaste la entrega de la solicitud #3 exitosamente.', 0, '2026-06-03 10:30:05', 3);

-- La lógica para concatenar el id de la solicitud con el mensaje se hará a nivel de código en el backend.
SELECT * FROM notificaciones;


-- -----------------------------------------------------
-- Tablas para el rol de Encargado de Depósito
-- -----------------------------------------------------

SELECT COUNT(id_solicitudes) AS total_entregadas 
FROM clan_db.solicitudes 
WHERE estado = 'entregada';

SELECT COUNT(id_solicitudes) AS total_por_entregar 
FROM clan_db.solicitudes 
WHERE estado = 'aprobada';

SELECT COUNT(id_movimientos) AS total_operaciones_entrada 
FROM clan_db.movimientos 
WHERE tipo = 'entrada';


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


SELECT 

DATE_FORMAT(s.fecha_revision, '%d/%m/%Y') AS 'Fecha de aprobacion',
CONCAT(sol.nombres, ' ', sol.apellidos) AS 'Solicitado por',
CONCAT(coord.nombres, ' ', coord.apellidos) AS 'Aprobado por',
d.cantidad AS 'Cantidad',
p.nombre AS 'Material',
s.proposito AS 'Proposito',
CONCAT(c.sigla, '-', p.codigo) AS 'SKU'
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

-- ====================================================================
-- Encargado de Depósito registra entrada de nuevo stock
-- ====================================================================

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

