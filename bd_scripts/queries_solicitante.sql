-- ====================================================================
-- QUERIES EXCLUSIVOS PARA EL ROL: SOLICITANTE
-- Base de datos: clan_db
-- ====================================================================

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
-- OJO: Este te va a salir vacío (0 rows) porque en tu script original 
-- no insertaste ningún producto que pertenezca a la categoría 2 (Kits). ¡Es normal!
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