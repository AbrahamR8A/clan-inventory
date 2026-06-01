package com.example.claninventory.daos;

import com.example.claninventory.beans.Solicitudes;
import com.example.claninventory.beans.Usuarios;
import com.example.claninventory.beans.Detalles;
import com.example.claninventory.beans.Productos;

import java.sql.*;
import java.util.ArrayList;

public class SolicitudesCoordinadorDao extends BaseDao {

    public ArrayList<Solicitudes> listarSolicitudesPendientes(String buscar, String fecha) {
        ArrayList<Solicitudes> lista = new ArrayList<>();

        // SQL actualizado con filtros condicionales idénticos a los del historial
        String sql = "SELECT s.id_solicitudes, s.proposito, s.fecha_solicitud, s.estado, " +
                "u.id_usuarios, u.nombres, u.apellido_paterno, u.apellido_materno " +
                "FROM solicitudes s " +
                "JOIN usuarios u ON s.id_solicitante = u.id_usuarios " +
                "WHERE s.estado = 'pendiente' " +
                "AND (? IS NULL OR DATE(s.fecha_solicitud) = ?) " +
                "AND (? IS NULL OR s.id_solicitudes LIKE ? OR u.nombres LIKE ? OR u.apellido_paterno LIKE ? OR u.apellido_materno LIKE ?) " +
                "ORDER BY s.fecha_solicitud ASC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Seteamos los parámetros de la fecha (Signos 1 y 2)
            pstmt.setString(1, (fecha == null || fecha.isEmpty()) ? null : fecha);
            pstmt.setString(2, (fecha == null || fecha.isEmpty()) ? null : fecha);

            // Armamos el patrón para el LIKE con comodines %
            String pattern = (buscar != null && !buscar.isEmpty()) ? "%" + buscar + "%" : null;

            // Seteamos los parámetros del buscador (Signos 3, 4, 5 y 6)
            pstmt.setString(3, (buscar == null || buscar.isEmpty()) ? null : buscar);
            pstmt.setString(4, pattern);
            pstmt.setString(5, pattern);
            pstmt.setString(6, pattern);
            pstmt.setString(7, pattern);

            // Ahora que los parámetros están listos, ejecutamos la consulta
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Solicitudes s = new Solicitudes();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setProposito(rs.getString("proposito"));
                    s.setEstado(rs.getString("estado"));
                    s.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));

                    Usuarios solicitante = new Usuarios();
                    solicitante.setIdUsuarios(rs.getInt("id_usuarios"));
                    solicitante.setNombres(rs.getString("nombres"));
                    solicitante.setApellidoPaterno(rs.getString("apellido_paterno"));
                    solicitante.setApellidoMaterno(rs.getString("apellido_materno"));
                    s.setSolicitante(solicitante);

                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public ArrayList<Detalles> obtenerDetallesPorSolicitud(int idSolicitud) {
        ArrayList<Detalles> listaDetalles = new ArrayList<>();
        String sql = "SELECT d.id_detalles, d.cantidad, p.id_productos, p.codigo, p.nombre, " +
                "p.stock_actual, p.stock_bajo, p.stock_critico, " +
                "c.nombre AS nombre_categoria, c.sigla AS sigla_categoria " +
                "FROM detalles d " +
                "JOIN productos p ON d.id_productos = p.id_productos " +
                "JOIN categorias c ON p.id_categorias = c.id_categorias " +
                "WHERE d.id_solicitudes = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idSolicitud);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Detalles det = new Detalles();
                    det.setIdDetalles(rs.getInt("id_detalles"));
                    det.setCantidad(rs.getInt("cantidad"));

                    Productos prod = new Productos();
                    prod.setIdProductos(rs.getInt("id_productos"));
                    prod.setCodigo(rs.getString("codigo"));
                    prod.setNombre(rs.getString("nombre"));
                    prod.setStockActual(rs.getInt("stock_actual"));
                    prod.setStockBajo(rs.getInt("stock_bajo"));
                    prod.setStockCritico(rs.getInt("stock_critico"));
                    prod.setNombreCategoria(rs.getString("nombre_categoria"));
                    prod.setSiglaCategoria(rs.getString("sigla_categoria"));

                    det.setProducto(prod);
                    listaDetalles.add(det);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaDetalles;
    }

    // ───  Aprobar solicitudes y reservar stock  ─────────────────────────────────────────
    public boolean aprobarSolicitud(int idSolicitud, int idCoordinador) {
        Connection conn = null;

        try {
            conn = this.getConnection();
            // Apagamos el autocommit para asegurar que ambos pasos se cumplan juntos
            conn.setAutoCommit(false);

            // Actualizamos el estado de la solicitud a 'aprobada'
            String sqlUpdateSolicitud = "UPDATE solicitudes SET estado = 'aprobada', fecha_revision = CURRENT_TIMESTAMP(), id_coordinador = ? WHERE id_solicitudes = ?";
            try (PreparedStatement pstmt1 = conn.prepareStatement(sqlUpdateSolicitud)) {
                pstmt1.setInt(1, idCoordinador);
                pstmt1.setInt(2, idSolicitud);
                pstmt1.executeUpdate();
            }

            // Obtenemos qué productos y cantidades se pidieron
            String sqlSelectDetalles = "SELECT id_productos, cantidad FROM detalles WHERE id_solicitudes = ?";
            ArrayList<Detalles> detallesReserva = new ArrayList<>();

            try (PreparedStatement pstmt2 = conn.prepareStatement(sqlSelectDetalles)) {
                pstmt2.setInt(1, idSolicitud);
                try (ResultSet rs = pstmt2.executeQuery()) {
                    while (rs.next()) {
                        Detalles d = new Detalles();
                        d.setCantidad(rs.getInt("cantidad"));

                        Productos p = new Productos();
                        p.setIdProductos(rs.getInt("id_productos"));
                        d.setProducto(p);

                        detallesReserva.add(d);
                    }
                }
            }

            // Descontamos el stock para asegurar la reserva
            String sqlUpdateStock = "UPDATE productos SET stock_actual = stock_actual - ? WHERE id_productos = ?";

            try (PreparedStatement pstmt3 = conn.prepareStatement(sqlUpdateStock)) {
                for (Detalles d : detallesReserva) {
                    pstmt3.setInt(1, d.getCantidad());
                    pstmt3.setInt(2, d.getProducto().getIdProductos());
                    pstmt3.executeUpdate();
                }
            }

            // Si no hubo errores, confirmamos todo el bloque (Aprobación + Reserva)
            conn.commit();
            return true;

        } catch (SQLException e) {
            // Si algo falla, revertimos para que no se descuente stock por error
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

    // ───  Rechazar solicitudes  ─────────────────────────────────────────
    public boolean rechazarSolicitud(int idSolicitud, int idCoordinador, String motivoRechazo) {
        String sql = "UPDATE solicitudes " +
                "SET estado = 'rechazada', fecha_revision = NOW(), id_coordinador = ?, comentario_rechazo = ? " +
                "WHERE id_solicitudes = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idCoordinador);
            pstmt.setString(2, motivoRechazo);
            pstmt.setInt(3, idSolicitud);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ───  Obtener Solicitud por ID  ─────────────────────────────────────────
    public Solicitudes obtenerSolicitudPorId(int idSolicitud) {
        Solicitudes s = null;
        String sql = "SELECT s.id_solicitudes, s.proposito, s.estado, s.fecha_solicitud, s.comentario_rechazo, s.fecha_revision, s.fecha_entrega, " +
                "u.id_usuarios, u.nombres, u.apellido_paterno, u.apellido_materno, u.correo " +
                "FROM solicitudes s " +
                "JOIN usuarios u ON s.id_solicitante = u.id_usuarios " +
                "WHERE s.id_solicitudes = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idSolicitud);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    s = new Solicitudes();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setProposito(rs.getString("proposito"));
                    s.setEstado(rs.getString("estado"));
                    s.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));
                    s.setComentarioRechazo(rs.getString("comentario_rechazo"));
                    s.setFechaRevision(rs.getTimestamp("fecha_revision"));
                    s.setFechaEntrega(rs.getTimestamp("fecha_entrega"));

                    // Mapeamos al solicitante
                    Usuarios solicitante = new Usuarios();
                    solicitante.setIdUsuarios(rs.getInt("id_usuarios"));
                    solicitante.setNombres(rs.getString("nombres"));
                    solicitante.setApellidoPaterno(rs.getString("apellido_paterno"));
                    solicitante.setApellidoMaterno(rs.getString("apellido_materno"));
                    solicitante.setCorreo(rs.getString("correo"));
                    s.setSolicitante(solicitante);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return s;
    }

    // ───  Listar historial de solicitudes procesadas por Coordinador ─────────────────────────────────────────
    public ArrayList<Solicitudes> listarSolicitudesProcesadas(String buscar, String fecha, String estado) {
        ArrayList<Solicitudes> lista = new ArrayList<>();

        String sql = "SELECT s.id_solicitudes, s.proposito, s.estado, s.fecha_solicitud, s.fecha_revision, " +
                "u.nombres, u.apellido_paterno, u.apellido_materno " +
                "FROM solicitudes s " +
                "JOIN usuarios u ON s.id_solicitante = u.id_usuarios " +
                "WHERE s.estado IN ('aprobada', 'rechazada') " +
                "AND (? IS NULL OR s.estado = ?) " +
                "AND (? IS NULL OR DATE(s.fecha_solicitud) = ?) " +
                "AND (? IS NULL OR CAST(s.id_solicitudes AS CHAR) LIKE ? OR u.nombres LIKE ? OR u.apellido_paterno LIKE ? OR u.apellido_materno LIKE ?) " +
                "ORDER BY s.fecha_revision DESC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 1 y 2: Filtro de Estado
            pstmt.setString(1, (estado == null || estado.isEmpty()) ? null : estado);
            pstmt.setString(2, (estado == null || estado.isEmpty()) ? null : estado);

            // 3 y 4: Filtro de Fecha
            pstmt.setString(3, (fecha == null || fecha.isEmpty()) ? null : fecha);
            pstmt.setString(4, (fecha == null || fecha.isEmpty()) ? null : fecha);

            // Armamos el patrón LIKE
            String pattern = (buscar != null && !buscar.isEmpty()) ? "%" + buscar + "%" : null;

            // 5 al 9: Filtros del buscador de texto e ID
            pstmt.setString(5, (buscar == null || buscar.isEmpty()) ? null : buscar);
            pstmt.setString(6, pattern);
            pstmt.setString(7, pattern);
            pstmt.setString(8, pattern);
            pstmt.setString(9, pattern);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Solicitudes s = new Solicitudes();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setProposito(rs.getString("proposito"));
                    s.setEstado(rs.getString("estado"));
                    s.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));
                    s.setFechaRevision(rs.getTimestamp("fecha_revision"));

                    Usuarios solicitante = new Usuarios();
                    solicitante.setNombres(rs.getString("nombres"));
                    solicitante.setApellidoPaterno(rs.getString("apellido_paterno"));
                    solicitante.setApellidoMaterno(rs.getString("apellido_materno"));
                    s.setSolicitante(solicitante);

                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ───  Contar solicitudes por estado (para tarjetas) ─────────────────────────────────────────
    public int contarSolicitudesPorEstado(String estado) {
        int contador = 0;
        String sql = "SELECT COUNT(*) FROM solicitudes WHERE estado = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, estado);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    contador = rs.getInt(1); // Obtiene el resultado del COUNT
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contador;
    }

}

