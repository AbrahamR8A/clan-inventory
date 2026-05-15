-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clan_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `clan_db` ;

-- -----------------------------------------------------
-- Schema clan_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clan_db` DEFAULT CHARACTER SET utf8 ;
USE `clan_db` ;

-- -----------------------------------------------------
-- Table `clan_db`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clan_db`.`usuarios` (
  `id_usuarios` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(25) NOT NULL,
  `apellidos` VARCHAR(25) NOT NULL,
  `rol` ENUM('administrador', 'coordinador', 'encargado_deposito', 'solicitante', 'superadmin') NOT NULL COMMENT 'Roles definidos.',
  `correo` VARCHAR(45) NOT NULL COMMENT 'Correo del usuario.\nTiene marcado UQ (unique index) para que no existan dos cuentas con el mismo correo.',
  `contrasenia` VARCHAR(255) NOT NULL,
  `foto_perfil` VARCHAR(255) NULL,
  `activo` TINYINT NOT NULL DEFAULT 1 COMMENT '1 para activo, 0 para retirado.',
  `id_creador` INT UNSIGNED NULL COMMENT 'ID del usuario (admin) que creó esta cuenta. Relación 1:N recursiva.',
  PRIMARY KEY (`id_usuarios`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE,
  INDEX `fk_usuarios_creador_idx` (`id_creador` ASC) VISIBLE,
CONSTRAINT `fk_usuarios_creador`
    FOREIGN KEY (`id_creador`)
    REFERENCES `clan_db`.`usuarios` (`id_usuarios`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clan_db`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clan_db`.`categorias` (
  `id_categorias` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL COMMENT 'Nombre de la categoría',
  `sigla` CHAR(1) NOT NULL COMMENT 'Sigla de la categoría. Por ejemplo, "M" para Merchandising institucional.',
  
  PRIMARY KEY (`id_categorias`),
   UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clan_db`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clan_db`.`productos` (
  `id_productos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` CHAR(4) NOT NULL COMMENT 'Código del producto de la forma "0123".',
  `nombre` VARCHAR(45) NOT NULL COMMENT 'Nombre descriptivo del producto.',
  `stock_actual` INT UNSIGNED NOT NULL COMMENT 'Cantidad disponible en tiempo real en el depósito.',
  `stock_bajo` INT UNSIGNED NOT NULL COMMENT 'Cantidad de stock para determinar estado bajo (amarillo).',
  `stock_critico` INT UNSIGNED NOT NULL COMMENT 'Cantidad de stock para determinar estado crítico (rojo).',
  `imagen` VARCHAR(256) NULL COMMENT 'Enlace al servicio cloud de almacenamiento de archivos.',
  `activo` TINYINT NOT NULL DEFAULT 1 COMMENT '1 para activo, 0 para retirado.',
  `id_usuarios` INT UNSIGNED NOT NULL,
  `id_categorias` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_productos`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `sku_UNIQUE` (`codigo` ASC, `id_categorias` ASC) VISIBLE,
  INDEX `fk_productos_usuarios1_idx` (`id_usuarios` ASC) VISIBLE,
  INDEX `fk_productos_categorias_idx` (`id_categorias` ASC) VISIBLE,
  CONSTRAINT `fk_productos_usuarios1`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `clan_db`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_categorias`
    FOREIGN KEY (`id_categorias`)
    REFERENCES `clan_db`.`categorias` (`id_categorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clan_db`.`solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clan_db`.`solicitudes` (
  `id_solicitudes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `proposito` TEXT NOT NULL COMMENT 'Justifiación de parte del solicitante',
  `estado` ENUM('pendiente', 'aprobada', 'rechazada', 'entregada') NOT NULL DEFAULT 'pendiente' COMMENT 'Se definen 4 estados para una solicitud: \'pendiente\' (por defecto), \'aprobada\', \'rechazada\' y \'entregada\'.',
  `fecha_solicitud` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comentario_rechazo` TEXT NULL,
  `id_solicitante` INT UNSIGNED NOT NULL,
  `id_coordinador` INT UNSIGNED NULL,
  `id_deposito` INT UNSIGNED NULL,
  `fecha_entrega` DATETIME NULL COMMENT 'Se llena únicamente cuando el estado de la solicitud cambia a \'entregada\'.',
  `fecha_revision` DATETIME NULL COMMENT 'Cuando el coordinador cambia el estado de la solicitud a \'aprobada\' o \'rechazada\', se guarda la hora y fecha de esa revisión.',
  PRIMARY KEY (`id_solicitudes`),
  INDEX `fk_solicitudes_usuarios1_idx` (`id_solicitante` ASC) VISIBLE,
  INDEX `fk_solicitudes_usuarios1_idx1` (`id_coordinador` ASC) VISIBLE,
  INDEX `fk_solicitudes_usuarios2_idx` (`id_deposito` ASC) VISIBLE,
  CONSTRAINT `fk_solicitudes_solicitante`
    FOREIGN KEY (`id_solicitante`)
    REFERENCES `clan_db`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_coordinador`
    FOREIGN KEY (`id_coordinador`)
    REFERENCES `clan_db`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_deposito`
    FOREIGN KEY (`id_deposito`)
    REFERENCES `clan_db`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clan_db`.`movimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clan_db`.`movimientos` (
  `id_movimientos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('entrada', 'salida') NOT NULL,
  `fecha_movimiento` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad` INT UNSIGNED NOT NULL COMMENT 'Cantidad entrante o saliente de un producto.',
  `id_productos` INT UNSIGNED NOT NULL COMMENT 'Indica qué producto se movió.',
  `id_responsable` INT UNSIGNED NOT NULL COMMENT 'Salida: Encargado de Depósito (verifica que el material salga físicamente). Ingreso: Admin (recibe la mercadería nueva y la registran para aumentar el stock).',
  `id_solicitudes` INT UNSIGNED NULL COMMENT 'Indica por qué se movió el producto. Definimos como NULL para que los ingresos de stock (sin solicitud) no fallen.',
  PRIMARY KEY (`id_movimientos`),
  INDEX `fk_movimientos_productos1_idx` (`id_productos` ASC) VISIBLE,
  INDEX `fk_movimientos_responsable1_idx` (`id_responsable` ASC) VISIBLE,
  INDEX `fk_movimientos_solicitudes1_idx` (`id_solicitudes` ASC) VISIBLE,
  CONSTRAINT `fk_movimientos_productos1`
    FOREIGN KEY (`id_productos`)
    REFERENCES `clan_db`.`productos` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimientos_responsable1`
    FOREIGN KEY (`id_responsable`)
    REFERENCES `clan_db`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimientos_solicitudes1`
    FOREIGN KEY (`id_solicitudes`)
    REFERENCES `clan_db`.`solicitudes` (`id_solicitudes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clan_db`.`detalles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clan_db`.`detalles` (
  `id_solicitudes` INT UNSIGNED NOT NULL,
  `id_productos` INT UNSIGNED NOT NULL,
  `id_detalles` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cantidad` INT UNSIGNED NOT NULL COMMENT 'Cantidad del producto solicitada.\nTiene el atributo UN (unsigned) para que no se almacenen número negativos.\nINT (Signed): De -2,147,483,648 a 2,147,483,647\nINT (Unsigned): De 0 a 4,294,967,295',
  INDEX `fk_solicitudes_has_productos_productos1_idx` (`id_productos` ASC) VISIBLE,
  INDEX `fk_solicitudes_has_productos_solicitudes_idx` (`id_solicitudes` ASC) VISIBLE,
  PRIMARY KEY (`id_detalles`),
  CONSTRAINT `fk_solicitudes_has_productos_solicitudes`
    FOREIGN KEY (`id_solicitudes`)
    REFERENCES `clan_db`.`solicitudes` (`id_solicitudes`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_has_productos_productos1`
    FOREIGN KEY (`id_productos`)
    REFERENCES `clan_db`.`productos` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clan_db`.`notificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clan_db`.`notificaciones` (
  `id_notificaciones` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `mensaje` VARCHAR(255) NOT NULL COMMENT 'El texto de la notificación.',
  `leido` TINYINT NOT NULL DEFAULT 0 COMMENT '0 para no leída, 1 para leída.',
  `fecha_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_usuarios` INT UNSIGNED NOT NULL COMMENT 'El usuario que recibe la notificación.',
  PRIMARY KEY (`id_notificaciones`),
  INDEX `fk_notificaciones_usuarios_idx` (`id_usuarios` ASC) VISIBLE,
  CONSTRAINT `fk_notificaciones_usuarios`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `clan_db`.`usuarios` (`id_usuarios`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
