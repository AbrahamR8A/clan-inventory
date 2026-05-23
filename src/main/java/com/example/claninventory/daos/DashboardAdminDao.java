package com.example.claninventory.daos;

import com.example.claninventory.beans.ActividadSistemaDTO;
import com.example.claninventory.beans.AlertaStockDTO;
import com.example.claninventory.beans.DashboardAdminDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DashboardAdminDao extends BaseDao {

    public DashboardAdminDTO obtenerKPIs() {
        DashboardAdminDTO dto = new DashboardAdminDTO();
        String sqlUsuarios = "SELECT COUNT(id_usuarios) FROM clan_db.usuarios WHERE activo = 1;";
        String sqlAprobadas = "SELECT COUNT(id_solicitudes) FROM clan_db.solicitudes WHERE estado = 'aprobada' AND fecha_revision IS NOT NULL AND YEAR(fecha_revision) = YEAR(CURDATE()) AND MONTH(fecha_revision) = MONTH(CURDATE());";
        String sqlPendientes = "SELECT COUNT(id_solicitudes) FROM clan_db.solicitudes WHERE estado = 'pendiente' AND YEAR(fecha_solicitud) = YEAR(CURDATE()) AND MONTH(fecha_solicitud) = MONTH(CURDATE());";
        String sqlRechazadas = "SELECT COUNT(id_solicitudes) FROM clan_db.solicitudes WHERE estado = 'rechazada' AND fecha_revision IS NOT NULL AND YEAR(fecha_revision) = YEAR(CURDATE()) AND MONTH(fecha_revision) = MONTH(CURDATE());";

        try (Connection conn = getConnection()) {
            try (PreparedStatement stmt = conn.prepareStatement(sqlUsuarios); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) dto.setUsuariosRegistrados(rs.getInt(1));
            }
            try (PreparedStatement stmt = conn.prepareStatement(sqlAprobadas); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) dto.setSolicitudesAprobadas(rs.getInt(1));
            }
            try (PreparedStatement stmt = conn.prepareStatement(sqlPendientes); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) dto.setSolicitudesPendientes(rs.getInt(1));
            }
            try (PreparedStatement stmt = conn.prepareStatement(sqlRechazadas); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) dto.setSolicitudesRechazadas(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dto;
    }

    public List<ActividadSistemaDTO> obtenerActividadReciente() {
        List<ActividadSistemaDTO> lista = new ArrayList<>();
        String sql = "SELECT * FROM (" +
                "    SELECT CONCAT(u.nombres, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS Usuario, u.rol AS Rol, " +
                "    CASE WHEN m.tipo = 'entrada' THEN 'Stock Añadido' WHEN m.tipo = 'salida' THEN 'Stock Retirado' END AS Accion, " +
                "    CASE WHEN m.tipo = 'entrada' THEN CONCAT('Agregó ', m.cantidad, ' unidades de \"', p.nombre, '\"') " +
                "         WHEN m.tipo = 'salida' THEN CONCAT('Retiró ', m.cantidad, ' unidades de \"', p.nombre, '\"') END AS Detalle, " +
                "    DATE_FORMAT(m.fecha_movimiento, '%d/%m/%Y - %h:%i %p') AS Fecha_y_Hora, m.fecha_movimiento AS fecha_orden " +
                "    FROM clan_db.movimientos m JOIN clan_db.usuarios u ON m.id_responsable = u.id_usuarios " +
                "    JOIN clan_db.productos p ON m.id_productos = p.id_productos " +
                "    UNION ALL " +
                "    SELECT CONCAT(u.nombres, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS Usuario, u.rol AS Rol, " +
                "    'Registro de solicitud' AS Accion, CONCAT('Registró una nueva solicitud #', s.id_solicitudes) AS Detalle, " +
                "    DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y - %h:%i %p') AS Fecha_y_Hora, s.fecha_solicitud AS fecha_orden " +
                "    FROM clan_db.solicitudes s JOIN clan_db.usuarios u ON s.id_solicitante = u.id_usuarios " +
                "    UNION ALL " +
                "    SELECT CONCAT(u.nombres, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS Usuario, u.rol AS Rol, " +
                "    CASE WHEN s.estado = 'aprobada' THEN 'Solicitud Aprobada' WHEN s.estado = 'rechazada' THEN 'Solicitud Rechazada' END AS Accion, " +
                "    CASE WHEN s.estado = 'aprobada' THEN CONCAT('Aprobó solicitud #', s.id_solicitudes) WHEN s.estado = 'rechazada' THEN CONCAT('Rechazó solicitud #', s.id_solicitudes) END AS Detalle, " +
                "    DATE_FORMAT(s.fecha_revision, '%d/%m/%Y - %h:%i %p') AS Fecha_y_Hora, s.fecha_revision AS fecha_orden " +
                "    FROM clan_db.solicitudes s JOIN clan_db.usuarios u ON s.id_coordinador = u.id_usuarios " +
                "    WHERE s.estado IN ('aprobada', 'rechazada') AND s.fecha_revision IS NOT NULL " +
                "    UNION ALL " +
                "    SELECT CONCAT(c.nombres, ' ', c.apellido_paterno, ' ', c.apellido_materno) AS Usuario, c.rol AS Rol, " +
                "    'Usuario Creado' AS Accion, CONCAT('Registró a nuevo usuario: ', u.nombres, ' ', u.apellido_paterno) AS Detalle, " +
                "    DATE_FORMAT(u.fecha_creacion, '%d/%m/%Y - %h:%i %p') AS Fecha_y_Hora, u.fecha_creacion AS fecha_orden " +
                "    FROM clan_db.usuarios u JOIN clan_db.usuarios c ON u.id_creador = c.id_usuarios " +
                ") AS actividad ORDER BY fecha_orden DESC LIMIT 6;";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ActividadSistemaDTO dto = new ActividadSistemaDTO();
                dto.setUsuario(rs.getString("Usuario"));
                dto.setRol(rs.getString("Rol"));
                dto.setAccion(rs.getString("Accion"));
                dto.setDetalle(rs.getString("Detalle"));
                dto.setFechaHora(rs.getString("Fecha_y_Hora"));
                lista.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<AlertaStockDTO> obtenerAlertasStock() {
        List<AlertaStockDTO> lista = new ArrayList<>();
        String sql = "SELECT p.nombre AS Material, p.stock_actual AS Cantidad, " +
                "CASE WHEN p.stock_actual <= p.stock_critico THEN 'Crítico' WHEN p.stock_actual <= p.stock_bajo THEN 'Bajo' ELSE 'Óptimo' END AS Estado, " +
                "CASE WHEN p.stock_actual <= p.stock_critico THEN 'Rojo' WHEN p.stock_actual <= p.stock_bajo THEN 'Amarillo' ELSE 'Verde' END AS EstadoColor " +
                "FROM clan_db.productos p WHERE p.activo = 1 " +
                "ORDER BY CASE WHEN p.stock_actual <= p.stock_critico THEN 1 WHEN p.stock_actual <= p.stock_bajo THEN 2 ELSE 3 END, p.stock_actual ASC, p.nombre ASC LIMIT 10;";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                AlertaStockDTO dto = new AlertaStockDTO();
                dto.setProducto(rs.getString("Material"));
                dto.setCantidad(rs.getInt("Cantidad"));
                dto.setEstado(rs.getString("Estado"));
                dto.setEstadoColor(rs.getString("EstadoColor"));
                lista.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
