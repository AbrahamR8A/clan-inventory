-- ====================================================================
-- QUERIES EXCLUSIVOS PARA EL ROL: COORDINADOR
-- Base de datos: clan_db
-- ====================================================================

USE clan_db;

-- Definimos el ID del coordinador que ha iniciado sesión (Ejemplo: 6 - Fernando Enrique)
SET @id_coordinador_sesion = 6;

-- ====================================================================
-- PANTALLA 1: INICIO (DASHBOARD)
-- ====================================================================

-- 1.1 Tarjetas Superiores (Métricas)
-- Solicitudes Aprobadas (por este coordinador)
SELECT COUNT(id_solicitudes) AS solicitudes_aprobadas
FROM clan_db.solicitudes
WHERE estado = 'aprobada' AND id_coordinador = @id_coordinador_sesion;

-- Solicitudes Pendientes (Globales, esperando revisión de cualquier coordinador)
SELECT COUNT(id_solicitudes) AS solicitudes_pendientes
FROM clan_db.solicitudes
WHERE estado = 'pendiente';

-- Solicitudes Rechazadas (por este coordinador)
SELECT COUNT(id_solicitudes) AS solicitudes_rechazadas
FROM clan_db.solicitudes
WHERE estado = 'rechazada' AND id_coordinador = @id_coordinador_sesion;

-- 1.2 Tabla: Bandeja de solicitudes pendientes (Con filtros)
SET @filtro_solicitante_pend = NULL; -- Ejemplo: 4
SET @filtro_fecha_pend = NULL;       -- Ejemplo: '2026-04-10'
SET @buscar_pend = NULL;             -- Ejemplo: 'Nathan'

SELECT 
    CONCAT('#', s.id_solicitudes) AS id_solicitud,
    CONCAT(u.nombres, ' ', u.apellidos) AS solicitante,
    DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y') AS fecha,
    'Pendiente' AS estado
FROM clan_db.solicitudes s
JOIN clan_db.usuarios u ON s.id_solicitante = u.id_usuarios
WHERE s.estado = 'pendiente'
  AND (@filtro_solicitante_pend IS NULL OR s.id_solicitante = @filtro_solicitante_pend)
  AND (@filtro_fecha_pend IS NULL OR DATE(s.fecha_solicitud) = @filtro_fecha_pend)
  AND (@buscar_pend IS NULL
        OR s.id_solicitudes LIKE CONCAT('%', @buscar_pend, '%')
        OR CONCAT(u.nombres, ' ', u.apellidos) LIKE CONCAT('%', @buscar_pend, '%')
      )
ORDER BY s.fecha_solicitud ASC; -- Las más antiguas primero

-- 1.3 Alertas de Stock (Panel lateral derecho)
SELECT 
    p.nombre AS Material,
    p.stock_actual AS Cantidad,
    CASE 
        WHEN p.stock_actual <= p.stock_critico THEN 'Crítico'
        WHEN p.stock_actual <= p.stock_bajo THEN 'Bajo'
        ELSE 'Óptimo'
    END AS EstadoColor -- El front usará esto para pintar el círculo rojo/amarillo/verde
FROM clan_db.productos p
WHERE p.activo = 1
ORDER BY p.stock_actual ASC
LIMIT 10;


-- ====================================================================
-- PANTALLA 2: HISTORIAL DE SOLICITUDES (Procesadas)
-- ====================================================================

-- 2.1 Tabla de historial con GROUP_CONCAT para mostrar varios materiales en una fila
SET @filtro_categoria_hist = NULL;   -- Ejemplo: 3
SET @filtro_solicitante_hist = NULL; -- Ejemplo: 4
SET @filtro_fecha_hist = NULL;       -- Ejemplo: '2026-04-03'
SET @filtro_estado_hist = NULL;      -- Ejemplo: 'aprobada' o 'rechazada'
SET @buscar_hist = NULL;             

SELECT 
    CONCAT('#', s.id_solicitudes) AS id_solicitud,
    CONCAT(u.nombres, ' ', u.apellidos) AS solicitante,
    -- Agrupamos todos los materiales de esa solicitud en un solo texto separado por saltos de línea (\n)
    GROUP_CONCAT(CONCAT(d.cantidad, ' ', p.nombre) SEPARATOR '\n') AS materiales,
    GROUP_CONCAT(CONCAT('SKU: ', c.sigla, '-', p.codigo) SEPARATOR '\n') AS codigos,
    DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y') AS fecha_solicitud,
    s.estado
FROM clan_db.solicitudes s
JOIN clan_db.usuarios u ON s.id_solicitante = u.id_usuarios
JOIN clan_db.detalles d ON s.id_solicitudes = d.id_solicitudes
JOIN clan_db.productos p ON d.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE s.id_coordinador = @id_coordinador_sesion -- Solo ve las que él mismo procesó
  AND s.estado IN ('aprobada', 'rechazada', 'entregada')
  AND (@filtro_estado_hist IS NULL OR s.estado = @filtro_estado_hist)
  AND (@filtro_solicitante_hist IS NULL OR s.id_solicitante = @filtro_solicitante_hist)
  AND (@filtro_fecha_hist IS NULL OR DATE(s.fecha_solicitud) = @filtro_fecha_hist)
  -- Lógica para filtrar por categoría: Revisa si la solicitud tiene al menos un producto de esa categoría
  AND (@filtro_categoria_hist IS NULL OR EXISTS (
        SELECT 1 FROM clan_db.detalles d2 
        JOIN clan_db.productos p2 ON d2.id_productos = p2.id_productos
        WHERE d2.id_solicitudes = s.id_solicitudes AND p2.id_categorias = @filtro_categoria_hist
      ))
  AND (@buscar_hist IS NULL
        OR s.id_solicitudes LIKE CONCAT('%', @buscar_hist, '%')
        OR CONCAT(u.nombres, ' ', u.apellidos) LIKE CONCAT('%', @buscar_hist, '%')
      )
GROUP BY s.id_solicitudes
ORDER BY s.fecha_revision DESC;


-- ====================================================================
-- PANTALLA 3: DETALLES DE SOLICITUD PENDIENTE
-- ====================================================================
SET @id_solicitud_detalle = 1; -- El ID de la solicitud a revisar

-- 3.1 Cabecera de la solicitud
SELECT 
    CONCAT('#', s.id_solicitudes) AS id_solicitud,
    CONCAT(u.nombres, ' ', u.apellidos) AS datos_solicitante,
    DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y %H:%i') AS fecha_hora_solicitud,
    s.estado,
    s.proposito
FROM clan_db.solicitudes s
JOIN clan_db.usuarios u ON s.id_solicitante = u.id_usuarios
WHERE s.id_solicitudes = @id_solicitud_detalle;

-- 3.2 Tabla: Materiales Solicitados y Proyección de Impacto
-- Aquí unificamos ambas tablas del diseño frontal en un solo Query para mayor eficiencia
SELECT 
    CONCAT('SKU: ', c.sigla, '-', p.codigo) AS codigo,
    p.nombre AS producto,
    c.nombre AS categoria,
    d.cantidad AS cantidad_solicitada,
    p.stock_actual AS stock_actual,
    (p.stock_actual - d.cantidad) AS nuevo_stock_proyectado -- Resta matemática para la tabla lateral
FROM clan_db.detalles d
JOIN clan_db.productos p ON d.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE d.id_solicitudes = @id_solicitud_detalle;


-- ====================================================================
-- ACCIONES: APROBAR O RECHAZAR SOLICITUD
-- ====================================================================

-- ACCIÓN A: Si presiona el botón "Aprobar"
UPDATE clan_db.solicitudes
SET estado = 'aprobada',
    id_coordinador = @id_coordinador_sesion,
    fecha_revision = CURRENT_TIMESTAMP
WHERE id_solicitudes = @id_solicitud_detalle;

-- Opcional: Generar notificación para el Encargado de Depósito (ID 3) avisando que hay trabajo
INSERT INTO clan_db.notificaciones (mensaje, id_usuarios) 
VALUES (CONCAT('El coordinador aprobó la solicitud #', @id_solicitud_detalle, '. Lista para preparación.'), 3);


-- ACCIÓN B: Si presiona el botón "Rechazar" y llena el motivo
SET @motivo_rechazo = 'Lamentablemente, el stock está reservado para un evento...';

UPDATE clan_db.solicitudes
SET estado = 'rechazada',
    id_coordinador = @id_coordinador_sesion,
    fecha_revision = CURRENT_TIMESTAMP,
    comentario_rechazo = @motivo_rechazo
WHERE id_solicitudes = @id_solicitud_detalle;


-- ====================================================================
-- PANTALLA 4: DETALLES DE SOLICITUD PROCESADA (Histórico Solo Lectura)
-- ====================================================================
SET @id_solicitud_procesada = 5;

-- Cabecera y Motivo de rechazo (si lo hubo)
SELECT 
    CONCAT('#', s.id_solicitudes) AS id_solicitud,
    CONCAT(u.nombres, ' ', u.apellidos) AS datos_solicitante,
    DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y %H:%i') AS fecha_hora_solicitud,
    DATE_FORMAT(s.fecha_revision, '%d/%m/%Y %H:%i') AS fecha_hora_respuesta,
    s.estado,
    s.proposito,
    s.comentario_rechazo
FROM clan_db.solicitudes s
JOIN clan_db.usuarios u ON s.id_solicitante = u.id_usuarios
WHERE s.id_solicitudes = @id_solicitud_procesada;

-- Tabla de materiales pedidos (Igual que la 3.2 pero sin la proyección de stock)
SELECT 
    CONCAT('SKU: ', c.sigla, '-', p.codigo) AS codigo,
    p.nombre AS producto,
    d.cantidad,
    p.stock_actual
FROM clan_db.detalles d
JOIN clan_db.productos p ON d.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE d.id_solicitudes = @id_solicitud_procesada;