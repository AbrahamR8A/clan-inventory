package com.example.claninventory.daos;

import com.example.claninventory.beans.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdenIngresoDao extends BaseDao {

    public List<Productos> listarProductosActivos() {
        List<Productos> lista = new ArrayList<>();
        String sql = "SELECT id_productos, codigo, nombre, descripcion, stock_actual FROM productos WHERE activo = 1";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
             
            while (rs.next()) {
                Productos p = new Productos();
                p.setIdProductos(rs.getInt("id_productos"));
                p.setCodigo(rs.getString("codigo"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setStockActual(rs.getInt("stock_actual"));
                lista.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean registrarOrdenIngreso(OrdenIngreso orden, List<DetalleOrdenIngreso> detalles) {
        String sqlOrden = "INSERT INTO ordenes_ingreso (id_creador, estado, observaciones, fecha_esperada, proveedor) VALUES (?, 'Pendiente de Recepcion', ?, ?, ?)";
        String sqlDetalle = "INSERT INTO detalles_orden_ingreso (id_ordenes_ingreso, id_productos, cantidad_esperada) VALUES (?, ?, ?)";
        String sqlNotif = "INSERT INTO notificaciones (mensaje, id_usuarios) SELECT ?, id_usuarios FROM usuarios WHERE rol = 'encargado_deposito' AND activo = 1";
        
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false); // Iniciar transaccion

            int idOrdenGenerado = 0;
            try (PreparedStatement stmtOrden = conn.prepareStatement(sqlOrden, Statement.RETURN_GENERATED_KEYS)) {
                stmtOrden.setInt(1, orden.getCreador().getIdUsuarios());
                stmtOrden.setString(2, orden.getObservaciones());
                stmtOrden.setDate(3, orden.getFechaEsperada());
                stmtOrden.setString(4, orden.getProveedor());
                stmtOrden.executeUpdate();
                try (ResultSet rsKeys = stmtOrden.getGeneratedKeys()) {
                    if (rsKeys.next()) {
                        idOrdenGenerado = rsKeys.getInt(1);
                    }
                }
            }

            try (PreparedStatement stmtDetalle = conn.prepareStatement(sqlDetalle)) {
                for (DetalleOrdenIngreso det : detalles) {
                    stmtDetalle.setInt(1, idOrdenGenerado);
                    stmtDetalle.setInt(2, det.getProducto().getIdProductos());
                    stmtDetalle.setInt(3, det.getCantidadEsperada());
                    stmtDetalle.addBatch();
                }
                stmtDetalle.executeBatch();
            }

            try (PreparedStatement stmtNotif = conn.prepareStatement(sqlNotif)) {
                stmtNotif.setString(1, "Nueva orden de ingreso planificada (#" + idOrdenGenerado + "). Pendiente de recepción física.");
                stmtNotif.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
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

    public List<OrdenIngreso> listarOrdenesPendientes() {
        List<OrdenIngreso> lista = new ArrayList<>();
        String sql = "SELECT o.id_ordenes_ingreso, o.fecha_registro, o.fecha_esperada, o.proveedor, o.estado, u.nombres, u.apellido_paterno " +
                     "FROM ordenes_ingreso o " +
                     "JOIN usuarios u ON o.id_creador = u.id_usuarios " +
                     "WHERE o.estado = 'Pendiente de Recepcion' " +
                     "ORDER BY o.fecha_registro DESC";
                     
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
             
            while (rs.next()) {
                OrdenIngreso o = new OrdenIngreso();
                o.setIdOrdenesIngreso(rs.getInt("id_ordenes_ingreso"));
                o.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                o.setFechaEsperada(rs.getDate("fecha_esperada"));
                o.setProveedor(rs.getString("proveedor"));
                o.setEstado(rs.getString("estado"));
                
                Usuarios creador = new Usuarios();
                creador.setNombres(rs.getString("nombres"));
                creador.setApellidoPaterno(rs.getString("apellido_paterno"));
                o.setCreador(creador);
                
                lista.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public OrdenIngreso obtenerOrdenIngreso(int idOrden) {
        OrdenIngreso o = null;
        String sql = "SELECT o.*, u.nombres, u.apellido_paterno FROM ordenes_ingreso o " +
                     "JOIN usuarios u ON o.id_creador = u.id_usuarios WHERE o.id_ordenes_ingreso = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idOrden);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    o = new OrdenIngreso();
                    o.setIdOrdenesIngreso(rs.getInt("id_ordenes_ingreso"));
                    o.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                    o.setFechaEsperada(rs.getDate("fecha_esperada"));
                    o.setProveedor(rs.getString("proveedor"));
                    o.setEstado(rs.getString("estado"));
                    o.setObservaciones(rs.getString("observaciones"));
                    
                    Usuarios creador = new Usuarios();
                    creador.setIdUsuarios(rs.getInt("id_creador"));
                    creador.setNombres(rs.getString("nombres"));
                    creador.setApellidoPaterno(rs.getString("apellido_paterno"));
                    o.setCreador(creador);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return o;
    }

    public List<DetalleOrdenIngreso> obtenerDetallesPorOrden(int idOrden) {
        List<DetalleOrdenIngreso> lista = new ArrayList<>();
        String sql = "SELECT d.*, p.codigo, p.nombre FROM detalles_orden_ingreso d " +
                     "JOIN productos p ON d.id_productos = p.id_productos " +
                     "WHERE d.id_ordenes_ingreso = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idOrden);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DetalleOrdenIngreso d = new DetalleOrdenIngreso();
                    d.setIdDetallesOrden(rs.getInt("id_detalles_orden"));
                    d.setCantidadEsperada(rs.getInt("cantidad_esperada"));
                    
                    int recibida = rs.getInt("cantidad_recibida");
                    if (!rs.wasNull()) {
                        d.setCantidadRecibida(recibida);
                    }
                    
                    Productos p = new Productos();
                    p.setIdProductos(rs.getInt("id_productos"));
                    p.setCodigo(rs.getString("codigo"));
                    p.setNombre(rs.getString("nombre"));
                    d.setProducto(p);
                    
                    lista.add(d);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean procesarVerificacion(OrdenIngreso orden, List<DetalleOrdenIngreso> detalles, boolean tieneObservaciones) {
        String sqlUpdateOrden = "UPDATE ordenes_ingreso SET estado = ?, observaciones = ?, id_verificador = ?, fecha_verificacion = CURRENT_TIMESTAMP WHERE id_ordenes_ingreso = ?";
        String sqlUpdateDetalle = "UPDATE detalles_orden_ingreso SET cantidad_recibida = ? WHERE id_detalles_orden = ?";
        String sqlUpdateStock = "UPDATE productos SET stock_actual = stock_actual + ? WHERE id_productos = ?";
        String sqlInsertMovimiento = "INSERT INTO movimientos (tipo, cantidad, id_productos, id_responsable) VALUES ('entrada', ?, ?, ?)";
        String sqlNotif = "INSERT INTO notificaciones (mensaje, id_usuarios) VALUES (?, ?)";

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            // 1. Actualizar orden
            try (PreparedStatement stmt = conn.prepareStatement(sqlUpdateOrden)) {
                stmt.setString(1, tieneObservaciones ? "Observada" : "Verificada");
                stmt.setString(2, orden.getObservaciones());
                stmt.setInt(3, orden.getVerificador().getIdUsuarios());
                stmt.setInt(4, orden.getIdOrdenesIngreso());
                stmt.executeUpdate();
            }

            // Para cada detalle procesar recibido, actualizar stock y registrar movimiento
            try (PreparedStatement stmtDet = conn.prepareStatement(sqlUpdateDetalle);
                 PreparedStatement stmtStock = conn.prepareStatement(sqlUpdateStock);
                 PreparedStatement stmtMov = conn.prepareStatement(sqlInsertMovimiento)) {
                 
                for (DetalleOrdenIngreso det : detalles) {
                    int idDetalle = det.getIdDetallesOrden();
                    int idProd = det.getProducto().getIdProductos();
                    int recibida = det.getCantidadRecibida() != null ? det.getCantidadRecibida() : 0;
                    
                    // Actualizar detalle orden
                    stmtDet.setInt(1, recibida);
                    stmtDet.setInt(2, idDetalle);
                    stmtDet.addBatch();
                    
                    if (recibida > 0) {
                        // Aumentar stock producto
                        stmtStock.setInt(1, recibida);
                        stmtStock.setInt(2, idProd);
                        stmtStock.addBatch();
                        
                        // Generar movimiento
                        stmtMov.setInt(1, recibida);
                        stmtMov.setInt(2, idProd);
                        stmtMov.setInt(3, orden.getVerificador().getIdUsuarios());
                        stmtMov.addBatch();
                    }
                }
                
                stmtDet.executeBatch();
                stmtStock.executeBatch();
                stmtMov.executeBatch();
            }

            // Notificación al creador original (Admin o Coordinador) si hay observaciones o confirmación.
            try (PreparedStatement stmtNotif = conn.prepareStatement(sqlNotif)) {
                String mensaje = tieneObservaciones ? 
                    "La orden #" + orden.getIdOrdenesIngreso() + " fue verificada con OBSERVACIONES." :
                    "La orden #" + orden.getIdOrdenesIngreso() + " fue recibida exitosamente completa.";
                
                // Recuperar ID creador
                OrdenIngreso oDB = obtenerOrdenIngreso(orden.getIdOrdenesIngreso());
                if(oDB != null && oDB.getCreador() != null) {
                    stmtNotif.setString(1, mensaje);
                    stmtNotif.setInt(2, oDB.getCreador().getIdUsuarios());
                    stmtNotif.executeUpdate();
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
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
