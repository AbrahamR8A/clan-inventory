package com.example.claninventory.daos;

import com.example.claninventory.beans.Usuarios;
import java.sql.*;
import java.util.ArrayList;

public class UsuariosDao extends BaseDao{

    // 1. CREATE: Registrar Nuevo Usuario
    public boolean registrarUsuario(Usuarios usuario) {
        String sql = "INSERT INTO usuarios (nombres, apellido_paterno, apellido_materno, rol, correo, contrasenia, activo, id_creador, foto_perfil) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usuario.getNombres());
            pstmt.setString(2, usuario.getApellidoPaterno());
            pstmt.setString(3, usuario.getApellidoMaterno());
            pstmt.setString(4, usuario.getRol());
            pstmt.setString(5, usuario.getCorreo());
            pstmt.setString(6, usuario.getContrasenia()); // debe venir hasheado desde el Servlet
            pstmt.setInt(7, usuario.getActivo());
            
            // Manejamos idCreador como Integer para permitir NULL
            if (usuario.getIdCreador() != null) {
                pstmt.setInt(8, usuario.getIdCreador());
            } else {
                pstmt.setNull(8, Types.INTEGER);
            }

            // Guardamos la foto como BLOB; si no viene foto, guardamos NULL
            if (usuario.getFotoPerfil() != null && usuario.getFotoPerfil().length > 0) {
                pstmt.setBytes(9, usuario.getFotoPerfil());
            } else {
                pstmt.setNull(9, Types.BLOB);
            }

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. READ: Listar todos los usuarios
    public ArrayList<Usuarios> listarUsuarios() {
        ArrayList<Usuarios> lista = new ArrayList<>();
        String sql = "SELECT id_usuarios, nombres, apellido_paterno, apellido_materno, correo, rol, activo " +
                "FROM usuarios ORDER BY id_usuarios DESC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Usuarios u = new Usuarios();
                u.setIdUsuarios(rs.getInt("id_usuarios"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidoPaterno(rs.getString("apellido_paterno"));
                u.setApellidoMaterno(rs.getString("apellido_materno"));
                u.setCorreo(rs.getString("correo"));
                u.setRol(rs.getString("rol"));
                u.setActivo(rs.getInt("activo"));
                lista.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // 2.1 Listar usuarios con filtros dinámicos para la tabla administrativa
    public ArrayList<Usuarios> listarUsuariosFiltrados(String idUsuario, String buscar, String rol, String estado) {
        ArrayList<Usuarios> lista = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT id_usuarios, nombres, apellido_paterno, apellido_materno, correo, rol, activo " +
                        "FROM usuarios WHERE 1=1 "
        );

        // Construcción de la consulta
        if (idUsuario != null && !idUsuario.trim().isEmpty()) {
            sql.append(" AND id_usuarios = ? ");
        }
        if (rol != null && !rol.trim().isEmpty()) {
            sql.append(" AND rol = ? ");
        }
        if (estado != null && !estado.trim().isEmpty()) {
            sql.append(" AND activo = ? ");
        }
        if (buscar != null && !buscar.trim().isEmpty()) {
            sql.append(" AND (nombres LIKE ? OR apellido_paterno LIKE ? OR correo LIKE ?) ");
        }

        sql.append(" ORDER BY id_usuarios DESC");

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            // Asignación de parámetros respetando el orden exacto de los IFs
            if (idUsuario != null && !idUsuario.trim().isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(idUsuario));
            }
            if (rol != null && !rol.trim().isEmpty()) {
                pstmt.setString(paramIndex++, rol);
            }
            if (estado != null && !estado.trim().isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(estado));
            }
            if (buscar != null && !buscar.trim().isEmpty()) {
                String searchPattern = "%" + buscar.trim() + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Usuarios u = new Usuarios();
                    u.setIdUsuarios(rs.getInt("id_usuarios"));
                    u.setNombres(rs.getString("nombres"));
                    u.setApellidoPaterno(rs.getString("apellido_paterno"));
                    u.setApellidoMaterno(rs.getString("apellido_materno"));
                    u.setCorreo(rs.getString("correo"));
                    u.setRol(rs.getString("rol"));
                    u.setActivo(rs.getInt("activo"));
                    lista.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    // 3. UPDATE: Editar datos de un usuario (con foto opcional)
    public boolean actualizarUsuario(Usuarios usuario) {
        // Si viene foto nueva la actualizamos; si no, solo actualizamos los campos de texto
        boolean tieneFoto = usuario.getFotoPerfil() != null && usuario.getFotoPerfil().length > 0;
        String sql = tieneFoto
                ? "UPDATE usuarios SET nombres = ?, apellido_paterno = ?, apellido_materno = ?, rol = ?, correo = ?, foto_perfil = ? WHERE id_usuarios = ?"
                : "UPDATE usuarios SET nombres = ?, apellido_paterno = ?, apellido_materno = ?, rol = ?, correo = ? WHERE id_usuarios = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usuario.getNombres());
            pstmt.setString(2, usuario.getApellidoPaterno());
            pstmt.setString(3, usuario.getApellidoMaterno());
            pstmt.setString(4, usuario.getRol());
            pstmt.setString(5, usuario.getCorreo());
            if (tieneFoto) {
                pstmt.setBytes(6, usuario.getFotoPerfil());
                pstmt.setInt(7, usuario.getIdUsuarios());
            } else {
                pstmt.setInt(6, usuario.getIdUsuarios());
            }

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3.1 Obtener foto de perfil de un usuario (para mostrarla en el modal de edición)
    public byte[] obtenerFotoPerfil(int idUsuario) {
        String sql = "SELECT foto_perfil FROM usuarios WHERE id_usuarios = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idUsuario);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getBytes("foto_perfil");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. DELETE (Lógico): Cambiar estado a inactivo
    public boolean desactivarUsuario(int idUsuario) {
        // En lugar de DELETE, cambiamos activo a 0
        String sql = "UPDATE usuarios SET activo = 0 WHERE id_usuarios = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idUsuario);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Reactivar un usuario previamente desactivado
    public boolean activarUsuario(int idUsuario) {
        String sql = "UPDATE usuarios SET activo = 1 WHERE id_usuarios = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idUsuario);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── 6. LOGIN: validar credenciales y devolver el usuario ───────────────
    /**
     * Valida el correo y la contraseña contra la tabla usuarios.
     * Solo acepta usuarios con activo = 1.
     *
     * @return el Usuarios correspondiente si las credenciales son correctas,
     *         o null si no coinciden o el usuario está inactivo.
     */
    public Usuarios validarLogin(String correo, String contrasenia) {
        String sql = "SELECT id_usuarios, nombres, apellido_paterno, apellido_materno, " +
                     "       rol, correo, activo " +
                     "FROM clan_db.usuarios " +
                     "WHERE correo = ? AND contrasenia = ? AND activo = 1 " +
                     "LIMIT 1";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, correo);
            pstmt.setString(2, contrasenia);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Usuarios u = new Usuarios();
                    u.setIdUsuarios(rs.getInt("id_usuarios"));
                    u.setNombres(rs.getString("nombres"));
                    u.setApellidoPaterno(rs.getString("apellido_paterno"));
                    u.setApellidoMaterno(rs.getString("apellido_materno"));
                    u.setRol(rs.getString("rol"));
                    u.setCorreo(rs.getString("correo"));
                    u.setActivo(rs.getInt("activo"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
