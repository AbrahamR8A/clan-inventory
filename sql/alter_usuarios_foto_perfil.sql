-- ============================================================
-- Script: Agregar columna foto_perfil (LONGBLOB) a tabla usuarios
-- Base de datos: clan_db
-- Ejecutar una sola vez para actualizar la estructura de la tabla
-- ============================================================

USE clan_db;

-- Agrega la columna foto_perfil como LONGBLOB (para almacenar imágenes de hasta ~4GB)
-- NULL permite que usuarios existentes no tengan foto asignada
ALTER TABLE usuarios
    ADD COLUMN foto_perfil LONGBLOB NULL COMMENT 'Foto de perfil del usuario almacenada en binario';
