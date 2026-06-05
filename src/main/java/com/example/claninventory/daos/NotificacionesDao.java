package com.example.claninventory.daos;

import com.example.claninventory.beans.Notificaciones;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NotificacionesDao extends BaseDao {

    public int obtenerCantidadNoLeidas(int idUsuario) {
        int count = 0;
        String sql = "SELECT COUNT(id_notificaciones) FROM clan_db.notificaciones WHERE id_usuarios = ? AND leido = 0;";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Notificaciones> obtenerUltimasNotificaciones(int idUsuario) {
        List<Notificaciones> lista = new ArrayList<>();
        String sql = "SELECT * FROM clan_db.notificaciones WHERE id_usuarios = ? ORDER BY fecha_creacion DESC LIMIT 5;";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Notificaciones notif = new Notificaciones();
                    notif.setIdNotificacion(rs.getInt("id_notificaciones"));
                    notif.setMensaje(rs.getString("mensaje"));
                    notif.setLeido(rs.getBoolean("leido"));
                    notif.setTipo("primary"); // Default tipo as it's not in DB
                    notif.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                    notif.setIdUsuario(rs.getInt("id_usuarios"));
                    lista.add(notif);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
