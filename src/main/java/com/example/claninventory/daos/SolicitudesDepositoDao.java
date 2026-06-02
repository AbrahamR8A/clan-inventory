package com.example.claninventory.daos;

import com.example.claninventory.beans.Solicitudes;
import com.example.claninventory.beans.Usuarios;
import com.example.claninventory.beans.Detalles;
import com.example.claninventory.beans.Productos;

import java.sql.*;
import java.util.ArrayList;

public class SolicitudesDepositoDao extends BaseDao {

    // ─── 1. KPIs (Tarjetas Superiores) ─────────────────────────────────────────

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


    // ─── 2. Filtros ─────────────────────────────────────────

    public ArrayList<Usuarios> listarSolicitudesAprobadas() {
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

    // ─── 3. Bandeja de Solicitudes Aprobadas (por entregar) ─────────

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

    // ─── 4. Detalles de la solicitud para la vista del encargado ────────────────

    public ArrayList<Detalles> obtenerDetallesPorSolicitud(int idSolicitud) {
        ArrayList<Detalles> listaDetalles = new ArrayList<>();

        String sql = "SELECT d.cantidad, p.codigo, p.nombre, " +
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
}