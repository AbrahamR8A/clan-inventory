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
-- Populamos tabla de usuarios (Actualizado para Apellido Paterno y Apellido Materno)
-- -----------------------------------------------------
INSERT INTO `clan_db`.`usuarios` 
(`nombres`, `apellido_paterno`, `apellido_materno`, `rol`, `correo`, `contrasenia`, `foto_perfil`, `activo`, `id_creador`) 
VALUES 
('Super', 'Admin', '', 'superadmin', 'superadmin@clan.com', 'c797bd812e10e4ba5c25c916946a7a6a36306cf1831c20ccaf082b1de2912ddd', NULL, 1, NULL),
('Nathan', 'Castillo', '', 'administrador', 'NathanCastillo@gmail.com', '52e302428e6db29686bc5f69df2e28bf6f283f2ef3f75d563e99dd5e1b225469', NULL, 1, 1),
('Camila', 'Altamirano', '', 'encargado_deposito', 'CamilaAltamirano@gmail.com', 'd1e24bcd98e0db74448a1341c7147029bff49c0345448f7bc9e3b7eeda861b92', NULL, 1, 2),
('Abraham', 'Ramirez', '', 'coordinador', 'AbrahamRamirez@gmail.com', 'abbe9820f1f072a706f38e3054f0f2ce0f67ffbcd217b1cf9d45fad57ccd4964', NULL, 1, 2),
('Luis', 'Quillas', 'León', 'solicitante', 'LuisQuillas@gmail.com', '491f1416064741057c7763d4a4bc3ccfa1edb9efa2778d90d2567cd3b4178dda', NULL, 1, 2);

SELECT * FROM usuarios;

-- -----------------------------------------------------
-- Populamos tabla de productos
-- -----------------------------------------------------

INSERT INTO `clan_db`.`productos` 
(`codigo`, `nombre`, `stock_actual`, `stock_bajo`,`stock_critico`, `imagen`, `activo`, `id_usuarios`, `id_categorias`) 
VALUES 
('0100', 'Monopolio', 500, 15, 5, NULL, 1, 2, 3),        	-- SKU: L-0100 (Estado: Verde)
('0101', 'Jenga', 400, 10, 5, NULL, 1, 2, 3),             	-- SKU: L-0101 (Estado: Verde)
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

('Primer taller infantil de dibujo', 'pendiente', '2026-07-03 17:15:30', NULL, 5, NULL, NULL, NULL, NULL),
('Dinámica de integración', 'aprobada', CURRENT_TIMESTAMP, NULL, 5, 4, NULL, NULL, '2026-06-04 14:15:30'),
('Gorras para el evento del sábado', 'entregada', CURRENT_TIMESTAMP, NULL, 5, 4, 3, '2026-06-03 10:30:00', '2026-06-01 16:45:00'),
('Taller de cuentacuentos externo', 'aprobada', CURRENT_TIMESTAMP, NULL, 5, 4, NULL, NULL, '2026-06-05 09:00:00'),
('Capacitación de seguridad trimestral', 'aprobada', CURRENT_TIMESTAMP, NULL, 5, 4, NULL, NULL, '2026-06-05 10:30:00'),
('Material para dinámica de bienvenida', 'aprobada', CURRENT_TIMESTAMP, NULL, 5, 4, NULL, NULL, '2026-06-05 11:45:00'),
('Taller de caligrafía', 'pendiente', '2026-05-03 12:15:30', NULL, 5, NULL, NULL, NULL, NULL),
('Segundo taller infantil de dibujo', 'pendiente', '2026-05-03 10:15:30', NULL, 5, NULL, NULL, NULL, NULL),
('Actividad de integración', 'pendiente', CURRENT_TIMESTAMP, NULL, 5, NULL, NULL, NULL, NULL);

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
(6, 2, 3),  -- 3 Jengas

-- Detalles para Solicitud 7
(7, 3, 30), -- 15 Papelotes 
(7, 4, 30), -- 10 Marcadores gruesos 

-- Detalles para Solicitud 8
(8, 3, 30), -- 15 Papelotes 
(8, 4, 30), -- 10 Marcadores gruesos 

-- Detalles para Solicitud 9
(9, 3, 30), -- 15 Papelotes 
(9, 4, 30), -- 10 Marcadores gruesos 
(9, 1, 1),  -- 1 Monopolio 
(9, 2, 3);  -- 3 Jengas

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

-- -----------------------------------------------------
-- Tabla de notificaciones (Datos para el Administrador)
-- -----------------------------------------------------

INSERT INTO `clan_db`.`notificaciones` 
(`mensaje`, `tipo`, `fecha_creacion`, `id_usuarios`) 
VALUES 
('El producto "Jenga" ha llegado a un nivel crítico de stock (4 unidades).', 'danger', CURRENT_TIMESTAMP, 2),
('Se ha registrado un nuevo usuario en el sistema: Roberto Díaz.', 'info', CURRENT_TIMESTAMP, 2),
('Ingreso exitoso: 100 unidades de Papelotes registradas en almacén.', 'success', CURRENT_TIMESTAMP, 2),
('Alerta de sistema: Hay solicitudes pendientes de revisión acumuladas en la bandeja.', 'warning', CURRENT_TIMESTAMP, 2);

SELECT * FROM notificaciones;


