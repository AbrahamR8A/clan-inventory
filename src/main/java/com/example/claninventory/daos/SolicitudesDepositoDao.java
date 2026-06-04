package com.example.claninventory.daos;

import com.example.claninventory.beans.KpiDeposito;
import com.example.claninventory.beans.Solicitudes;
import com.example.claninventory.beans.Usuarios;
import com.example.claninventory.beans.Detalles;
import com.example.claninventory.beans.Productos;

import java.sql.*;
import java.util.ArrayList;

public class SolicitudesDepositoDao extends BaseDao {

    // ───  Listar Solicitudes por estado (aprobada o entregada) ─────────────────
    public ArrayList<Solicitudes> listarSolicitudesPorEstado(String estado, String solicitanteId, String fecha) {
        ArrayList<Solicitudes> lista = new ArrayList<>();
        
        String sql = "SELECT s.id_solicitudes, s.proposito, s.estado, s.fecha_solicitud, s.fecha_entrega, " +
                "u.id_usuarios, u.nombres, u.apellido_paterno, u.apellido_materno, " +
                "c.nombres AS coord_nombres " +
                "FROM solicitudes s " +
                "JOIN usuarios u ON s.id_solicitante = u.id_usuarios " +
                "LEFT JOIN usuarios c ON s.id_coordinador = c.id_usuarios " +
                "WHERE s.estado = ? " +
                "AND (? IS NULL OR u.id_usuarios = ?) " +
                "AND (? IS NULL OR DATE(s.fecha_solicitud) = ?) " +
                "ORDER BY s.id_solicitudes DESC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, estado);
            
            // Filtro por Solicitante
            pstmt.setString(2, (solicitanteId == null || solicitanteId.isEmpty()) ? null : solicitanteId);
            pstmt.setString(3, (solicitanteId == null || solicitanteId.isEmpty()) ? null : solicitanteId);
            
            // Filtro por Fecha
            pstmt.setString(4, (fecha == null || fecha.isEmpty()) ? null : fecha);
            pstmt.setString(5, (fecha == null || fecha.isEmpty()) ? null : fecha);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Solicitudes s = new Solicitudes();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setProposito(rs.getString("proposito"));
                    s.setEstado(rs.getString("estado"));
                    s.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));
                    s.setFechaEntrega(rs.getTimestamp("fecha_entrega"));

                    Usuarios solicitante = new Usuarios();
                    solicitante.setIdUsuarios(rs.getInt("id_usuarios"));
                    solicitante.setNombres(rs.getString("nombres"));
                    solicitante.setApellidoPaterno(rs.getString("apellido_paterno"));
                    solicitante.setApellidoMaterno(rs.getString("apellido_materno"));
                    s.setSolicitante(solicitante);
                    
                    Usuarios coordinador = new Usuarios();
                    coordinador.setNombres(rs.getString("coord_nombres"));
                    s.setCoordinador(coordinador);

                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ───  Obtener KPIs del Depósito ──────────────────────────────────────────
    public KpiDeposito obtenerKpisDeposito() {
        KpiDeposito kpis = new KpiDeposito();

        String sqlEntregadas = "SELECT COUNT(*) FROM solicitudes WHERE estado = 'entregada'";
        String sqlPorEntregar = "SELECT COUNT(*) FROM solicitudes WHERE estado = 'aprobada'";
        // Atrasadas: aprobadas hace más de 3 días (usando fecha_revision)
        String sqlAtrasadas = "SELECT COUNT(*) FROM solicitudes WHERE estado = 'aprobada' AND DATEDIFF(CURRENT_TIMESTAMP, fecha_revision) > 3";

        try (Connection conn = this.getConnection()) {
            // Entregadas
            try (PreparedStatement pstmt = conn.prepareStatement(sqlEntregadas);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) kpis.setEntregadas(rs.getInt(1));
            }
            // Por Entregar
            try (PreparedStatement pstmt = conn.prepareStatement(sqlPorEntregar);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) kpis.setPorEntregar(rs.getInt(1));
            }
            // Atrasadas
            try (PreparedStatement pstmt = conn.prepareStatement(sqlAtrasadas);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) kpis.setAtrasadas(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return kpis;
    }

    // ───  Marcar como Entregada ──────────────────────────────────────────────
    public boolean marcarComoEntregada(int idSolicitud, int idEncargado) {
        Connection conn = null;

        try {
            conn = this.getConnection();
            conn.setAutoCommit(false); // Transacción para asegurar consistencia

            // 1. Cambiar estado a entregada y registrar id_deposito
            String sqlUpdateSolicitud = "UPDATE solicitudes SET estado = 'entregada', fecha_entrega = CURRENT_TIMESTAMP(), id_deposito = ? WHERE id_solicitudes = ?";
            try (PreparedStatement pstmt1 = conn.prepareStatement(sqlUpdateSolicitud)) {
                pstmt1.setInt(1, idEncargado);
                pstmt1.setInt(2, idSolicitud);
                pstmt1.executeUpdate();
            }

            // 2. Obtener los productos y cantidades de la solicitud
            String sqlSelectDetalles = "SELECT id_productos, cantidad FROM detalles WHERE id_solicitudes = ?";
            ArrayList<Detalles> detallesEntrega = new ArrayList<>();

            try (PreparedStatement pstmt2 = conn.prepareStatement(sqlSelectDetalles)) {
                pstmt2.setInt(1, idSolicitud);
                try (ResultSet rs = pstmt2.executeQuery()) {
                    while (rs.next()) {
                        Detalles d = new Detalles();
                        d.setCantidad(rs.getInt("cantidad"));
                        Productos p = new Productos();
                        p.setIdProductos(rs.getInt("id_productos"));
                        d.setProducto(p);
                        detallesEntrega.add(d);
                    }
                }
            }

            // 3. Registrar el movimiento de 'salida' para cada producto
            String sqlInsertMovimiento = "INSERT INTO movimientos (tipo, cantidad, id_productos, id_responsable, id_solicitudes) VALUES ('salida', ?, ?, ?, ?)";
            try (PreparedStatement pstmt3 = conn.prepareStatement(sqlInsertMovimiento)) {
                for (Detalles d : detallesEntrega) {
                    pstmt3.setInt(1, d.getCantidad());
                    pstmt3.setInt(2, d.getProducto().getIdProductos());
                    pstmt3.setInt(3, idEncargado);
                    pstmt3.setInt(4, idSolicitud);
                    pstmt3.executeUpdate();
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
