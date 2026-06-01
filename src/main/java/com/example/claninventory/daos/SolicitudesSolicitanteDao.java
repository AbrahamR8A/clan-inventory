package com.example.claninventory.daos;

import com.example.claninventory.beans.DetalleSolicitante;
import com.example.claninventory.beans.KpiSolicitante;
import com.example.claninventory.beans.SolicitudSolicitante;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO de solicitudes para el rol Solicitante.
 *
 * Permite:
 *   - Obtener los KPIs del solicitante (tarjetas del Inicio).
 *   - Listar las solicitudes del solicitante (Tabla de Actividad Reciente).
 *   - Crear una nueva solicitud junto con sus detalles (cajita -> base de datos).
 *   - Obtener una solicitud y sus materiales (vista Detalle de Solicitud).
 */
public class SolicitudesSolicitanteDao extends BaseDao {

    // ─── 1. KPIs del solicitante (tarjetas del Inicio) ───────────────────────

    public KpiSolicitante obtenerKpis(int idSolicitante) {
        KpiSolicitante kpi = new KpiSolicitante();
        String sql =
            "SELECT " +
            "  SUM(estado = 'pendiente') AS pendientes, " +
            "  SUM(estado = 'aprobada')  AS aprobadas, " +
            "  SUM(estado = 'entregada') AS entregadas, " +
            "  SUM(estado = 'rechazada') AS rechazadas " +
            "FROM clan_db.solicitudes " +
            "WHERE id_solicitante = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idSolicitante);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    kpi.setPendientes(rs.getInt("pendientes"));
                    kpi.setAprobadas(rs.getInt("aprobadas"));
                    kpi.setEntregadas(rs.getInt("entregadas"));
                    kpi.setRechazadas(rs.getInt("rechazadas"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return kpi;
    }

    // ─── 2. Listar las solicitudes del solicitante (Actividad Reciente) ──────

    public ArrayList<SolicitudSolicitante> listarPorSolicitante(int idSolicitante) {
        ArrayList<SolicitudSolicitante> lista = new ArrayList<>();
        String sql =
            "SELECT s.id_solicitudes, s.proposito, s.estado, " +
            "       DATE_FORMAT(s.fecha_solicitud, '%d/%m/%Y') AS fecha, " +
            "       s.comentario_rechazo, " +
            "       GROUP_CONCAT(DISTINCT c.nombre ORDER BY c.nombre SEPARATOR '||') AS categorias " +
            "FROM clan_db.solicitudes s " +
            "LEFT JOIN clan_db.detalles d   ON d.id_solicitudes = s.id_solicitudes " +
            "LEFT JOIN clan_db.productos p  ON d.id_productos   = p.id_productos " +
            "LEFT JOIN clan_db.categorias c ON p.id_categorias  = c.id_categorias " +
            "WHERE s.id_solicitante = ? " +
            "GROUP BY s.id_solicitudes " +
            "ORDER BY s.fecha_solicitud DESC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idSolicitante);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    SolicitudSolicitante s = new SolicitudSolicitante();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setProposito(rs.getString("proposito"));
                    s.setEstado(rs.getString("estado"));
                    s.setFechaSolicitud(rs.getString("fecha"));
                    s.setComentarioRechazo(rs.getString("comentario_rechazo"));
                    s.setCategorias(rs.getString("categorias"));
                    s.setIdSolicitante(idSolicitante);
                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ─── 3. Crear una nueva solicitud con sus detalles (cajita) ──────────────

    /**
     * Inserta una solicitud (estado 'pendiente' por defecto) y todas sus
     * líneas de detalle dentro de una misma transacción.
     *
     * @return el id de la solicitud creada, o -1 si ocurrió un error.
     */
    public int crearSolicitud(String proposito, int idSolicitante,
                              List<DetalleSolicitante> items) {

        String sqlSolicitud = "INSERT INTO clan_db.solicitudes (proposito, id_solicitante) VALUES (?, ?)";
        String sqlDetalle   = "INSERT INTO clan_db.detalles (id_solicitudes, id_productos, cantidad) VALUES (?, ?, ?)";

        Connection conn = null;
        try {
            conn = this.getConnection();
            conn.setAutoCommit(false);   // inicia la transacción

            int idSolicitud;

            // 3.1 Insertar la cabecera de la solicitud
            try (PreparedStatement ps = conn.prepareStatement(
                    sqlSolicitud, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, proposito);
                ps.setInt(2, idSolicitante);
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        idSolicitud = rs.getInt(1);
                    } else {
                        conn.rollback();
                        return -1;
                    }
                }
            }

            // 3.2 Insertar cada línea de detalle
            try (PreparedStatement ps = conn.prepareStatement(sqlDetalle)) {
                for (DetalleSolicitante item : items) {
                    ps.setInt(1, idSolicitud);
                    ps.setInt(2, item.getIdProductos());
                    ps.setInt(3, item.getCantidad());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            conn.commit();               // confirma la transacción
            return idSolicitud;

        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return -1;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); }
                catch (SQLException ex) { ex.printStackTrace(); }
            }
        }
    }

    // ─── 4. Obtener una solicitud por su id (vista Detalle) ──────────────────

    public SolicitudSolicitante obtenerPorId(int idSolicitud) {
        String sql =
            "SELECT id_solicitudes, proposito, estado, " +
            "       DATE_FORMAT(fecha_solicitud, '%d/%m/%Y %H:%i') AS fecha, " +
            "       comentario_rechazo, id_solicitante " +
            "FROM clan_db.solicitudes " +
            "WHERE id_solicitudes = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idSolicitud);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    SolicitudSolicitante s = new SolicitudSolicitante();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setProposito(rs.getString("proposito"));
                    s.setEstado(rs.getString("estado"));
                    s.setFechaSolicitud(rs.getString("fecha"));
                    s.setComentarioRechazo(rs.getString("comentario_rechazo"));
                    s.setIdSolicitante(rs.getInt("id_solicitante"));
                    return s;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ─── 5. Listar los materiales (detalles) de una solicitud ────────────────

    public ArrayList<DetalleSolicitante> listarDetalles(int idSolicitud) {
        ArrayList<DetalleSolicitante> lista = new ArrayList<>();
        String sql =
            "SELECT d.id_detalles, d.id_solicitudes, d.id_productos, d.cantidad, " +
            "       p.codigo, p.nombre, p.stock_actual, " +
            "       c.nombre AS categoria, c.sigla AS sigla " +
            "FROM clan_db.detalles d " +
            "JOIN clan_db.productos p  ON d.id_productos  = p.id_productos " +
            "JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias " +
            "WHERE d.id_solicitudes = ? " +
            "ORDER BY d.id_detalles ASC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idSolicitud);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    DetalleSolicitante d = new DetalleSolicitante();
                    d.setIdDetalles(rs.getInt("id_detalles"));
                    d.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    d.setIdProductos(rs.getInt("id_productos"));
                    d.setCantidad(rs.getInt("cantidad"));
                    d.setCodigo(rs.getString("codigo"));
                    d.setNombre(rs.getString("nombre"));
                    d.setStockActual(rs.getInt("stock_actual"));
                    d.setCategoria(rs.getString("categoria"));
                    d.setSiglaCategoria(rs.getString("sigla"));
                    lista.add(d);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
