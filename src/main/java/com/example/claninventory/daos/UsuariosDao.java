package com.example.claninventory.daos;

import com.example.claninventory.beans.Usuarios;
import java.sql.*;
import java.util.ArrayList;

public class UsuariosDao extends BaseDao{

    // 1. CREATE: Registrar Nuevo Usuario
    public boolean registrarUsuario(Usuarios usuario) {
        String sql = "INSERT INTO usuarios (nombres, apellido_paterno, apellido_materno, rol, correo, contrasenia, activo, id_creador) " +
                "VALUES (?, ?, ?, ?, ?, ?, 1, ?)";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usuario.getNombres());
            pstmt.setString(2, usuario.getApellidoPaterno());
            pstmt.setString(3, usuario.getApellidoMaterno());
            pstmt.setString(4, usuario.getRol());
            pstmt.setString(5, usuario.getCorreo());
            pstmt.setString(6, usuario.getContrasenia()); // debe venir hasheado desde el Servlet
            // Manejamos idCreador como Integer para permitir NULL
            if (usuario.getIdCreador() != null) {
                pstmt.setInt(7, usuario.getIdCreador());
            } else {
                pstmt.setNull(7, Types.INTEGER);
            }

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. READ: Listar todos los usuarios para la tabla administrativa
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

    // 3. UPDATE: Editar datos de un usuario
    public boolean actualizarUsuario(Usuarios usuario) {
        String sql = "UPDATE usuarios SET nombres = ?, apellido_paterno = ?, apellido_materno = ?, rol = ?, correo = ? " +
                "WHERE id_usuarios = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usuario.getNombres());
            pstmt.setString(2, usuario.getApellidoPaterno());
            pstmt.setString(3, usuario.getApellidoMaterno());
            pstmt.setString(4, usuario.getRol());
            pstmt.setString(5, usuario.getCorreo());
            pstmt.setInt(6, usuario.getIdUsuarios());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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
}
