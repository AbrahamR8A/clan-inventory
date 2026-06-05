package com.example.claninventory.daos;

import com.example.claninventory.beans.KpiDeposito;
import com.example.claninventory.beans.Solicitudes;
import com.example.claninventory.beans.Usuarios;
import com.example.claninventory.beans.Detalles;
import com.example.claninventory.beans.Productos;

import java.sql.*;
import java.util.ArrayList;

public class SolicitudesDepositoDao extends BaseDao {

    // ───  Listar Solicitudes por estado  ─────────────────
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

    // ─── KPIs (Tarjetas Superiores) ─────────────────────────────────────────

    public int contarSolicitudesAprobadas() {
        int contador = 0;
        String sql = "SELECT COUNT(*) FROM solicitudes WHERE estado = 'aprobada'";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) contador = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return contador;
    }

    public int contarSolicitudesEntregadas() {
        int contador = 0;
        String sql = "SELECT COUNT(*) FROM solicitudes WHERE estado = 'entregada'";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) contador = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return contador;
    }

    public int contarSolicitudesAtrasadas() {
        int contador = 0;
        String sql = "SELECT COUNT(*) FROM solicitudes WHERE estado = 'aprobada' AND DATEDIFF(CURRENT_TIMESTAMP, fecha_revision) > 3";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) contador = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return contador;
    }


    // ─── Filtros ─────────────────────────────────────────

    // Para los pendientes (Solicitudes por Entregar)

    public ArrayList<Usuarios> listarSolicitantesAprobados() {
        ArrayList<Usuarios> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT u.id_usuarios, u.nombres, u.apellido_paterno, u.apellido_materno " +
                "FROM solicitudes s JOIN usuarios u ON s.id_solicitante = u.id_usuarios " +
                "WHERE s.estado = 'aprobada' ORDER BY u.nombres";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Usuarios u = new Usuarios();
                u.setIdUsuarios(rs.getInt("id_usuarios"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidoPaterno(rs.getString("apellido_paterno"));
                u.setApellidoMaterno(rs.getString("apellido_materno"));
                lista.add(u);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public ArrayList<Usuarios> listarCoordinadoresAprobadores() {
        ArrayList<Usuarios> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT u.id_usuarios, u.nombres, u.apellido_paterno, u.apellido_materno " +
                "FROM solicitudes s JOIN usuarios u ON s.id_coordinador = u.id_usuarios " +
                "WHERE s.estado = 'aprobada' ORDER BY u.nombres";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Usuarios u = new Usuarios();
                u.setIdUsuarios(rs.getInt("id_usuarios"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidoPaterno(rs.getString("apellido_paterno"));
                u.setApellidoMaterno(rs.getString("apellido_materno"));
                lista.add(u);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // Para el Historial (Solicitudes Entregadas)

    public ArrayList<Usuarios> listarSolicitantesEntregados() {
        ArrayList<Usuarios> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT u.id_usuarios, u.nombres, u.apellido_paterno, u.apellido_materno " +
                "FROM solicitudes s JOIN usuarios u ON s.id_solicitante = u.id_usuarios " +
                "WHERE s.estado = 'entregada' ORDER BY u.nombres";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Usuarios u = new Usuarios();
                u.setIdUsuarios(rs.getInt("id_usuarios"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidoPaterno(rs.getString("apellido_paterno"));
                u.setApellidoMaterno(rs.getString("apellido_materno"));
                lista.add(u);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public ArrayList<Usuarios> listarCoordinadoresEntregados() {
        ArrayList<Usuarios> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT u.id_usuarios, u.nombres, u.apellido_paterno, u.apellido_materno " +
                "FROM solicitudes s JOIN usuarios u ON s.id_coordinador = u.id_usuarios " +
                "WHERE s.estado = 'entregada' ORDER BY u.nombres";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Usuarios u = new Usuarios();
                u.setIdUsuarios(rs.getInt("id_usuarios"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidoPaterno(rs.getString("apellido_paterno"));
                u.setApellidoMaterno(rs.getString("apellido_materno"));
                lista.add(u);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }


    // ─── Bandeja de Solicitudes Aprobadas (por entregar) ─────────

    public ArrayList<Solicitudes> listarBandejaDeposito(String idSolicitante, String idCoordinador, String fecha) {
        ArrayList<Solicitudes> lista = new ArrayList<>();

        // Hacemos doble JOIN: uno para el solicitante y otro para el coordinador (aprobador).
        String sql = "SELECT s.id_solicitudes, s.fecha_revision, " +
                "sol.nombres AS sol_nombres, sol.apellido_paterno AS sol_paterno, sol.apellido_materno AS sol_materno, " +
                "coord.nombres AS coord_nombres, coord.apellido_paterno AS coord_paterno, coord.apellido_materno AS coord_materno " +
                "FROM solicitudes s " +
                "JOIN usuarios sol ON s.id_solicitante = sol.id_usuarios " +
                "JOIN usuarios coord ON s.id_coordinador = coord.id_usuarios " +
                "WHERE s.estado = 'aprobada' " +
                "AND (? IS NULL OR sol.id_usuarios = ?) " +
                "AND (? IS NULL OR coord.id_usuarios = ?) " +
                "AND (? IS NULL OR DATE(s.fecha_revision) = ?) " +
                "ORDER BY s.fecha_revision ASC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, (idSolicitante == null || idSolicitante.isEmpty()) ? null : idSolicitante);
            pstmt.setString(2, (idSolicitante == null || idSolicitante.isEmpty()) ? null : idSolicitante);

            pstmt.setString(3, (idCoordinador == null || idCoordinador.isEmpty()) ? null : idCoordinador);
            pstmt.setString(4, (idCoordinador == null || idCoordinador.isEmpty()) ? null : idCoordinador);

            pstmt.setString(5, (fecha == null || fecha.isEmpty()) ? null : fecha);
            pstmt.setString(6, (fecha == null || fecha.isEmpty()) ? null : fecha);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Solicitudes s = new Solicitudes();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setFechaRevision(rs.getTimestamp("fecha_revision"));

                    Usuarios solicitante = new Usuarios();
                    solicitante.setNombres(rs.getString("sol_nombres"));
                    solicitante.setApellidoPaterno(rs.getString("sol_paterno"));
                    solicitante.setApellidoMaterno(rs.getString("sol_materno"));
                    s.setSolicitante(solicitante);

                    Usuarios coordinador = new Usuarios();
                    coordinador.setNombres(rs.getString("coord_nombres"));
                    coordinador.setApellidoPaterno(rs.getString("coord_paterno"));
                    coordinador.setApellidoMaterno(rs.getString("coord_materno"));
                    s.setCoordinador(coordinador);

                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }


    // ─── Detalles de la solicitud para la vista del encargado ────────────────

    public ArrayList<Detalles> obtenerDetallesPorSolicitud(int idSolicitud) {
        ArrayList<Detalles> listaDetalles = new ArrayList<>();

        String sql = "SELECT d.cantidad, p.codigo, p.nombre, p.stock_actual, " +
                "c.nombre AS nombre_categoria, c.sigla AS sigla_categoria " +
                "FROM detalles d " +
                "JOIN productos p ON d.id_productos = p.id_productos " +
                "JOIN categorias c ON p.id_categorias = c.id_categorias " +
                "WHERE d.id_solicitudes = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Asignamos el parámetro como entero
            pstmt.setInt(1, idSolicitud);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Detalles det = new Detalles();
                    det.setCantidad(rs.getInt("cantidad"));

                    Productos prod = new Productos();
                    prod.setCodigo(rs.getString("codigo"));
                    prod.setNombre(rs.getString("nombre"));
                    prod.setStockActual(rs.getInt("stock_actual"));
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

    // ─── Obtener Cabecera de Solicitud por ID ──────────────────────────

    public Solicitudes obtenerSolicitudPorId(int idSolicitud) {
        Solicitudes s = null;
        // Agregamos s.estado y s.fecha_entrega a la consulta SQL
        String sql = "SELECT s.id_solicitudes, s.fecha_revision, s.proposito, s.estado, s.fecha_entrega, " +
                "sol.nombres AS sol_nombres, sol.apellido_paterno AS sol_paterno, sol.apellido_materno AS sol_materno, " +
                "coord.nombres AS coord_nombres, coord.apellido_paterno AS coord_paterno, coord.apellido_materno AS coord_materno, " +
                "dep.nombres AS dep_nombres, dep.apellido_paterno AS dep_paterno, dep.apellido_materno AS dep_materno " +
                "FROM solicitudes s " +
                "JOIN usuarios sol ON s.id_solicitante = sol.id_usuarios " +
                "JOIN usuarios coord ON s.id_coordinador = coord.id_usuarios " +
                "LEFT JOIN usuarios dep ON s.id_deposito = dep.id_usuarios " +
                "WHERE s.id_solicitudes = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idSolicitud);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    s = new Solicitudes();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setFechaRevision(rs.getTimestamp("fecha_revision"));
                    s.setProposito(rs.getString("proposito"));
                    s.setEstado(rs.getString("estado")); // Guardamos el estado
                    s.setFechaEntrega(rs.getTimestamp("fecha_entrega")); // Guardamos la fecha de entrega

                    Usuarios solicitante = new Usuarios();
                    solicitante.setNombres(rs.getString("sol_nombres"));
                    solicitante.setApellidoPaterno(rs.getString("sol_paterno"));
                    solicitante.setApellidoMaterno(rs.getString("sol_materno"));
                    s.setSolicitante(solicitante);

                    Usuarios coordinador = new Usuarios();
                    coordinador.setNombres(rs.getString("coord_nombres"));
                    coordinador.setApellidoPaterno(rs.getString("coord_paterno"));
                    coordinador.setApellidoMaterno(rs.getString("coord_materno"));
                    s.setCoordinador(coordinador);

                    // Evaluamos si ya hay un encargado asignado
                    Usuarios deposito = new Usuarios();
                    deposito.setNombres(rs.getString("dep_nombres"));                        deposito.setNombres(rs.getString("dep_nombres"));
                    deposito.setApellidoPaterno(rs.getString("dep_paterno"));
                    deposito.setApellidoMaterno(rs.getString("dep_materno"));
                    s.setDeposito(deposito);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return s;
    }

    // ───  Marcar como Entregada y Generar Movimiento ──────────────────────────────────────────────
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

            // Si no hubo errores en ninguno de los 3 pasos, guardamos los cambios
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


    // ─── Listar Historial de Entregas ─────────────────────────────────────────

    public ArrayList<Solicitudes> listarHistorialEntregadas(String idSolicitante, String idCoordinador, String fecha) {
        ArrayList<Solicitudes> lista = new ArrayList<>();

        // Traemos solo las que tienen estado 'entregada' y filtramos por fecha_entrega
        String sql = "SELECT s.id_solicitudes, s.fecha_entrega, " +
                "sol.nombres AS sol_nombres, sol.apellido_paterno AS sol_paterno, sol.apellido_materno AS sol_materno, " +
                "coord.nombres AS coord_nombres, coord.apellido_paterno AS coord_paterno, coord.apellido_materno AS coord_materno " +
                "FROM solicitudes s " +
                "JOIN usuarios sol ON s.id_solicitante = sol.id_usuarios " +
                "JOIN usuarios coord ON s.id_coordinador = coord.id_usuarios " +
                "WHERE s.estado = 'entregada' " +
                "AND (? IS NULL OR sol.id_usuarios = ?) " +
                "AND (? IS NULL OR coord.id_usuarios = ?) " +
                "AND (? IS NULL OR DATE(s.fecha_entrega) = ?) " +
                "ORDER BY s.fecha_entrega DESC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, (idSolicitante == null || idSolicitante.isEmpty()) ? null : idSolicitante);
            pstmt.setString(2, (idSolicitante == null || idSolicitante.isEmpty()) ? null : idSolicitante);
            pstmt.setString(3, (idCoordinador == null || idCoordinador.isEmpty()) ? null : idCoordinador);
            pstmt.setString(4, (idCoordinador == null || idCoordinador.isEmpty()) ? null : idCoordinador);
            pstmt.setString(5, (fecha == null || fecha.isEmpty()) ? null : fecha);
            pstmt.setString(6, (fecha == null || fecha.isEmpty()) ? null : fecha);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Solicitudes s = new Solicitudes();
                    s.setIdSolicitudes(rs.getInt("id_solicitudes"));
                    s.setFechaEntrega(rs.getTimestamp("fecha_entrega")); // Usamos la fecha de entrega

                    Usuarios solicitante = new Usuarios();
                    solicitante.setNombres(rs.getString("sol_nombres"));
                    solicitante.setApellidoPaterno(rs.getString("sol_paterno"));
                    solicitante.setApellidoMaterno(rs.getString("sol_materno"));
                    s.setSolicitante(solicitante);

                    Usuarios coordinador = new Usuarios();
                    coordinador.setNombres(rs.getString("coord_nombres"));
                    coordinador.setApellidoPaterno(rs.getString("coord_paterno"));
                    coordinador.setApellidoMaterno(rs.getString("coord_materno"));
                    s.setCoordinador(coordinador);

                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

}
