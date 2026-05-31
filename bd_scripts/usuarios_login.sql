-- =====================================================================
--  Usuarios de login (4 cuentas, una por rol).
--  Ejecutar en MySQL Workbench sobre la base de datos clan_db.
-- =====================================================================
USE clan_db;

INSERT INTO clan_db.usuarios
    (nombres, apellido_paterno, apellido_materno, rol, correo, contrasenia, activo, id_creador)
VALUES
    ('Nathan',  'Castillo',   '',     'administrador',       'NathanCastillo@gmail.com',    '20216583', 1, NULL),
    ('Luis',    'Quillas',    'León', 'solicitante',         'LuisQuillas@gmail.com',       '20216150', 1, NULL),
    ('Abraham', 'Ramirez',    '',     'coordinador',         'AbrahamRamirez@gmail.com',    '20206364', 1, NULL),
    ('Camila',  'Altamirano', '',     'encargado_deposito',  'CamilaAltamirano@gmail.com',  '20220964', 1, NULL);

SELECT id_usuarios, nombres, apellido_paterno, rol, correo FROM clan_db.usuarios ORDER BY id_usuarios;
