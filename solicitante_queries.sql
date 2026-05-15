 USE clan_db;

-- 1. ¿Cuáles son los 4 tipos de productos (Categorías)?
SELECT id_categorias, nombre AS tipo_producto, sigla 
FROM clan_db.categorias;

-- 2. ¿Qué productos tiene la Categoría Merchandising?
SELECT p.nombre AS producto, CONCAT(c.sigla, '-', p.codigo) AS sku, p.stock_actual 
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE c.nombre = 'Merchandising' AND p.activo = 1;

-- 3. ¿Qué productos tiene la Categoría Kits?
SELECT p.nombre AS producto, CONCAT(c.sigla, '-', p.codigo) AS sku, p.stock_actual 
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE c.nombre = 'Kits' AND p.activo = 1;

-- 4. ¿Qué productos tiene la Categoría Ludicos?
SELECT p.nombre AS producto, CONCAT(c.sigla, '-', p.codigo) AS sku, p.stock_actual 
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE c.nombre = 'Ludicos' AND p.activo = 1;

-- 5. ¿Qué productos tiene la Categoría Utileria?
SELECT p.nombre AS producto, CONCAT(c.sigla, '-', p.codigo) AS sku, p.stock_actual 
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE c.nombre = 'Utileria' AND p.activo = 1;

-- 6. ¿Qué cantidad de solicitudes tiene aprobadas el solicitante (ID 4 - Roberto José)?
SELECT COUNT(id_solicitudes) AS total_aprobadas
FROM clan_db.solicitudes
WHERE id_solicitante = 4 AND estado = 'aprobada';

-- 7. ¿Qué cantidad de solicitudes tiene rechazadas el solicitante (ID 4)?
SELECT COUNT(id_solicitudes) AS total_rechazadas
FROM clan_db.solicitudes
WHERE id_solicitante = 4 AND estado = 'rechazada';

-- 8. Detalles de una solicitud específica hecha por el solicitante (Solicitud #4 del original)
SELECT d.id_solicitudes, p.nombre AS producto, CONCAT(c.sigla, '-', p.codigo) AS sku, d.cantidad
FROM clan_db.detalles d
JOIN clan_db.productos p ON d.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE d.id_solicitudes = 4;

-- 9. ¿Cuántas solicitudes tiene Roberto José por cada estado?
SELECT 
    estado,
    COUNT(id_solicitudes) AS total_solicitudes
FROM clan_db.solicitudes
WHERE id_solicitante = 4
GROUP BY estado;


-- 10. ¿Qué productos están en stock bajo o crítico?
SELECT 
    p.nombre AS producto,
    CONCAT(c.sigla, '-', p.codigo) AS sku,
    p.stock_actual,
    p.stock_bajo,
    p.stock_critico,
    CASE 
        WHEN p.stock_actual <= p.stock_critico THEN 'Crítico'
        WHEN p.stock_actual <= p.stock_bajo THEN 'Bajo'
        ELSE 'Normal'
    END AS estado_stock
FROM clan_db.productos p
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
WHERE p.activo = 1
  AND p.stock_actual <= p.stock_bajo;


-- 11. ¿Cuál es el historial de movimientos de productos?
SELECT 
    m.id_movimientos,
    m.tipo,
    p.nombre AS producto,
    CONCAT(c.sigla, '-', p.codigo) AS sku,
    m.cantidad,
    CONCAT(u.nombres, ' ', u.apellidos) AS responsable,
    m.id_solicitudes,
    DATE_FORMAT(m.fecha_movimiento, '%d/%m/%Y %H:%i') AS fecha_movimiento
FROM clan_db.movimientos m
JOIN clan_db.productos p ON m.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
JOIN clan_db.usuarios u ON m.id_responsable = u.id_usuarios
ORDER BY m.fecha_movimiento DESC;


-- 12. ¿Cuáles son los productos más solicitados?
SELECT 
    p.nombre AS producto,
    CONCAT(c.sigla, '-', p.codigo) AS sku,
    SUM(d.cantidad) AS total_solicitado
FROM clan_db.detalles d
JOIN clan_db.productos p ON d.id_productos = p.id_productos
JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias
GROUP BY p.id_productos, p.nombre, c.sigla, p.codigo
ORDER BY total_solicitado DESC;