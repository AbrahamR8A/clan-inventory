-- ============================================================
-- ALTER: Actualizaciones a la tabla productos
-- Ejecutar este script SOLO si ya tienes la BD creada.
-- Si vas a ejecutar 1_esquema.sql desde cero, NO necesitas este script.
-- ============================================================

USE `clan_db`;

-- 1. Ampliar el campo codigo de CHAR(4) a VARCHAR(20)
ALTER TABLE `clan_db`.`productos`
    MODIFY COLUMN `codigo` VARCHAR(20) NOT NULL COMMENT 'Código o referencia del producto.';

-- 2. Cambiar imagen de VARCHAR a LONGBLOB (almacenamiento binario directo)
--    IMPORTANTE: Este paso borra el valor actual de imagen en todos los registros.
--    Si ya tienes rutas de imagen guardadas como texto, haz un respaldo antes.
ALTER TABLE `clan_db`.`productos`
    MODIFY COLUMN `imagen` LONGBLOB NULL COMMENT 'Imagen del producto almacenada como binario en la BD.';

-- 3. Agregar campo descripcion
ALTER TABLE `clan_db`.`productos`
    ADD COLUMN `descripcion` VARCHAR(255) NULL COMMENT 'Descripción, marca, color u otras especificaciones.'
    AFTER `imagen`;
