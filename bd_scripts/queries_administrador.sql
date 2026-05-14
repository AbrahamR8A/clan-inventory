-- ====================================================================
-- QUERIES EXCLUSIVOS PARA EL ROL: ADMINISTRADOR
-- Base de datos: clan_db
-- ====================================================================

USE clan_db;

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
-- Reemplazar @id_admin por el id del usuario administrador en sesión.
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
-- Cambiar los SET según los filtros del frontend.
-- Si un filtro no se usa, dejarlo en NULL.
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




-- 3. REGISTRAR NUEVO INTEGRANTE

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
-- Si no se usa un filtro, dejarlo en NULL.
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
