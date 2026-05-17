-- ====================================================================
-- QUERIES EXCLUSIVOS PARA EL ROL: ENCARGADO DE DEPÓSITO
-- Base de datos: clan_db
-- ====================================================================

USE clan_db;

-- 1. MÉTRICAS SUPERIORES (DASHBOARD)
-- Solicitudes entregadas
SELECT COUNT(id_solicitudes) AS solicitudes_entregadas
FROM clan_db.solicitudes 
WHERE estado = 'entregada';

-- Solicitudes por entregar (aprobadas por el coordinador)
SELECT COUNT(id_solicitudes) AS solicitudes_por_entregar
FROM clan_db.solicitudes 
WHERE estado = 'aprobada';

-- Total de operaciones de entrada
SELECT COUNT(id_movimientos) AS entradas_totales
FROM clan_db.movimientos 
WHERE tipo = 'entrada';


-- 2. BANDEJA DE SOLICITUDES (Pendientes de despacho)
-- Vista general básica
SELECT 
    CONCAT('#', s.id_solicitudes) AS id_solicitud,
    CONCAT(sol.nombres, ' ', sol.apellido_paterno, ' ', sol.apellido_materno) AS solicitante,
    CONCAT(coord.nombres, ' ', coord.apellido_paterno, ' ', coord.apellido_materno) AS aprobador,
    DATE_FORMAT(s.fecha_revision, '%d/%m/%Y') AS fecha
FROM clan_db.solicitudes s
JOIN clan_db.usuarios sol ON s.id_solicitante = sol.id_usuarios
JOIN clan_db.usuarios coord ON s.id_coordinador = coord.id_usuarios
WHERE s.estado = 'aprobada';

-- Bandeja con filtros aplicados desde el backend (Frontend envía valores a los SET)
SET @filtro_solicitante = NULL;   -- Ejemplo: 4
SET @filtro_coordinador = NULL;   -- Ejemplo: 6
SET @filtro_fecha = NULL;         -- Ejemplo: '2026-06-05'
SET @buscar = NULL;               

SELECT 
    s.id_solicitudes AS id_solicitud,
    CONCAT(u_sol.nombres, ' ', u_sol.apellido_paterno, ' ', u_sol.apellido_materno) AS nombre_solicitante,
    CONCAT(u_coord.nombres, ' ', u_coord.apellido_paterno, ' ', u_coord.apellido_materno) AS aprobador,
    DATE_FORMAT(s.fecha_revision, '%d/%m/%Y') AS fecha
FROM clan_db.solicitudes s
JOIN clan_db.usuarios u_sol ON s.id_solicitante = u_sol.id_usuarios
JOIN clan_db.usuarios u_coord ON s.id_coordinador = u_coord.id_usuarios
WHERE s.estado = 'aprobada' 
  AND (@filtro_solicitante IS NULL OR s.id_solicitante = @filtro_solicitante)
  AND (@filtro_coordinador IS NULL OR s.id_coordinador = @filtro_coordinador)
  AND (@filtro_fecha IS NULL OR DATE(s.fecha_revision) = @filtro_fecha)
  AND (@buscar IS NULL
        OR s.id_solicitudes LIKE CONCAT('%', @buscar, '%')
        OR CONCAT(u_sol.nombres, ' ', u_sol.apellido_paterno, ' ', u_sol.apellido_materno) LIKE CONCAT('%', @buscar, '%')
        OR CONCAT(u_coord.nombres, ' ', u_coord.apellido_paterno, ' ', u_coord.apellido_materno) LIKE CONCAT('%', @buscar, '%')
      )
ORDER BY s.fecha_solicitud DESC;


-- 3. VER DETALLE DE UNA SOLICITUD APROBADA (Ejemplo con ID 2)
SELECT 
    DATE_FORMAT(s.fecha_revision, '%d/%m/%Y') AS fecha_aprobacion,
    CONCAT(sol.nombres, ' ', sol.apellido_paterno, ' ', sol.apellido_materno) AS solicitado_por,
    CONCAT(coord.nombres, ' ', coord.apellido_paterno, ' ', coord.apellido_materno) AS aprobado_por,
    d.cantidad AS cantidad,
    p.nombre AS material,
    CONCAT(c.sigla, '-', p.codigo) AS sku,
    s.proposito AS proposito
FROM clan_db.solicitudes s
JOIN clan_db.usuarios sol ON s.id_solicitante = sol.id_usuarios
JOIN clan_db.usuarios coord ON s.id_coordinador = coord.id_usuarios
JOIN clan_db.detalles d ON s.id_solicitudes = d.id_solicitudes
JOIN clan_db.productos p ON d.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE s.id_solicitudes = 2;


-- 4. REGISTROS HISTÓRICOS DE INVENTARIO
-- Registro general de existencias y semáforo
SELECT 
    p.nombre AS producto,
    CONCAT('SKU: ', c.sigla, '-', p.codigo) AS codigo,
    p.stock_actual AS stock_actual,
    CASE 
        WHEN p.stock_actual <= p.stock_critico THEN 'Rojo'      
        WHEN p.stock_actual <= p.stock_bajo THEN 'Amarillo'     
        ELSE 'Verde'                                            
    END AS estado_color
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE p.activo = 1;

-- Registro histórico de salidas (Solicitudes ya entregadas)
SELECT 
    CONCAT('#', s.id_solicitudes) AS id_solicitud,
    CONCAT(u.nombres, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS solicitante,
    DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y') AS fecha_pedido,
    DATE_FORMAT(s.fecha_entrega, '%d/%m/%Y') AS fecha_entrega
FROM clan_db.solicitudes s
JOIN clan_db.usuarios u ON s.id_solicitante = u.id_usuarios
WHERE s.estado = 'entregada';


-- 5. SISTEMA DE NOTIFICACIONES (Campana superior para el usuario ID 3)
-- Previsualización en la campana (No leídas)
SELECT 
    mensaje AS notificacion,
    DATE_FORMAT(fecha_creacion, '%d/%m/%Y %H:%i') AS fecha_hora
FROM clan_db.notificaciones
WHERE id_usuarios = 3 AND leido = 0
ORDER BY fecha_creacion DESC
LIMIT 5;

-- Contador de notificaciones en la campana
SELECT COUNT(id_notificaciones) AS total_no_leidas
FROM clan_db.notificaciones
WHERE id_usuarios = 3 AND leido = 0;

-- Página de historial completo de notificaciones
SELECT 
    mensaje AS notificacion, 
    CASE WHEN leido = 0 THEN 'No Leído' ELSE 'Leído' END AS estado,
    DATE_FORMAT(fecha_creacion, '%d/%m/%Y') AS fecha
FROM clan_db.notificaciones
WHERE id_usuarios = 3
ORDER BY fecha_creacion DESC;


-- 6. ACCIONES TRANSACCIONALES (Despachar pedido)
-- Ejemplo despachando la Solicitud #2 por el Encargado ID 3
START TRANSACTION;

-- Paso A: Cambiar estado a entregada
UPDATE clan_db.solicitudes 
SET estado = 'entregada', 
    id_deposito = 3, 
    fecha_entrega = CURRENT_TIMESTAMP 
WHERE id_solicitudes = 2;

-- Paso B: Registrar en el Kardex/Movimientos la salida de los productos de esa solicitud
INSERT INTO clan_db.movimientos 
(tipo, cantidad, id_productos, id_responsable, id_solicitudes) 
VALUES 
('salida', 2, 1, 3, 2),  -- Despacha 2 unidades del producto ID 1
('salida', 2, 2, 3, 2);  -- Despacha 2 unidades del producto ID 2

-- Paso C: Restar el stock en la tabla productos
UPDATE clan_db.productos SET stock_actual = stock_actual - 2 WHERE id_productos = 1;
UPDATE clan_db.productos SET stock_actual = stock_actual - 2 WHERE id_productos = 2;

COMMIT;