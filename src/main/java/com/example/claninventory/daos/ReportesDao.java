package com.example.claninventory.daos;

import com.example.claninventory.beans.ConsumoCategoriaDTO;
import com.example.claninventory.beans.ProductoSolicitadoDTO;
import com.example.claninventory.beans.ReporteConsumo;
import com.example.claninventory.beans.ReporteKpiDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO de la vista Reportes. Carga desde la base de datos clan_db:
 *   - Los KPIs de solicitudes del mes (4 tarjetas).
 *   - La "Tabla de Consumo del Mes" (entradas / salidas por producto).
 *   - El gráfico de barras "Productos más solicitados".
 *   - El gráfico de dona "Consumo por categoría".
 *
 * NOTA SOBRE LA TABLA 'detalles':
 * Los gráficos asumen que la tabla 'detalles' (detalle de cada solicitud)
 * tiene las columnas: id_detalles, id_solicitudes, id_productos, cantidad.
 * Si en tu base de datos los nombres son distintos, ajusta únicamente
 * los nombres de columna en obtenerProductosMasSolicitados() y
 * obtenerConsumoPorCategoria().
 */
public class ReportesDao extends BaseDao {

    // ─── 1. KPIs: tarjetas de solicitudes del mes ────────────────────────────

    /**
     * Cuenta las solicitudes del mes/año indicados agrupadas por estado.
     * Se cuenta por fecha_solicitud (solicitudes generadas en ese periodo).
     */
    public ReporteKpiDTO obtenerKpis(int mes, int anio) {
        ReporteKpiDTO dto = new ReporteKpiDTO();
        String sql =
            "SELECT " +
            "  COUNT(*) AS totales, " +
            "  SUM(CASE WHEN estado = 'aprobada'  THEN 1 ELSE 0 END) AS aprobadas, " +
            "  SUM(CASE WHEN estado = 'entregada' THEN 1 ELSE 0 END) AS entregadas, " +
            "  SUM(CASE WHEN estado = 'rechazada' THEN 1 ELSE 0 END) AS rechazadas " +
            "FROM clan_db.solicitudes " +
            "WHERE YEAR(fecha_solicitud) = ? AND MONTH(fecha_solicitud) = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, anio);
            pstmt.setInt(2, mes);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto.setSolicitudesTotales(rs.getInt("totales"));
                    dto.setSolicitudesAprobadas(rs.getInt("aprobadas"));
                    dto.setSolicitudesEntregadas(rs.getInt("entregadas"));
                    dto.setSolicitudesRechazadas(rs.getInt("rechazadas"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dto;
    }

    // ─── 2. Tabla de Consumo del Mes (con filtro de búsqueda) ────────────────

    /**
     * Lista todos los productos activos con sus entradas y salidas
     * registradas en la tabla 'movimientos' durante el mes/año indicados.
     * El filtro de fecha va en el ON del LEFT JOIN para que los productos
     * sin movimientos también aparezcan (con 0 entradas / 0 salidas).
     *
     * @param buscar texto opcional para filtrar por nombre o código.
     */
    public ArrayList<ReporteConsumo> listarConsumoMensual(int mes, int anio, String buscar) {
        ArrayList<ReporteConsumo> lista = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT p.id_productos, p.codigo, p.nombre AS producto, " +
            "       c.nombre AS categoria, p.stock_actual, " +
            "       COALESCE(SUM(CASE WHEN m.tipo = 'entrada' THEN m.cantidad ELSE 0 END), 0) AS entrada_mes, " +
            "       COALESCE(SUM(CASE WHEN m.tipo = 'salida'  THEN m.cantidad ELSE 0 END), 0) AS salida_mes " +
            "FROM clan_db.productos p " +
            "JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias " +
            "LEFT JOIN clan_db.movimientos m " +
            "       ON m.id_productos = p.id_productos " +
            "      AND YEAR(m.fecha_movimiento) = ? " +
            "      AND MONTH(m.fecha_movimiento) = ? " +
            "WHERE p.activo = 1 "
        );

        boolean conBusqueda = buscar != null && !buscar.trim().isEmpty();
        if (conBusqueda) {
            sql.append("AND (p.nombre LIKE ? OR p.codigo LIKE ?) ");
        }
        sql.append("GROUP BY p.id_productos, p.codigo, p.nombre, c.nombre, p.stock_actual ");
        sql.append("ORDER BY p.nombre ASC");

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            pstmt.setInt(idx++, anio);
            pstmt.setInt(idx++, mes);
            if (conBusqueda) {
                String like = "%" + buscar.trim() + "%";
                pstmt.setString(idx++, like);
                pstmt.setString(idx++, like);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReporteConsumo r = new ReporteConsumo();
                    r.setIdProductos(rs.getInt("id_productos"));
                    r.setCodigo(rs.getString("codigo"));
                    r.setProducto(rs.getString("producto"));
                    r.setCategoria(rs.getString("categoria"));
                    r.setStockActual(rs.getInt("stock_actual"));
                    r.setEntradaMes(rs.getInt("entrada_mes"));
                    r.setSalidaMes(rs.getInt("salida_mes"));
                    lista.add(r);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ─── 3. Gráfico de barras: productos más solicitados ─────────────────────

    /**
     * Devuelve los 6 productos con mayor cantidad solicitada en el mes/año.
     * Se basa en la tabla 'detalles' (detalle de cada solicitud).
     */
    public List<ProductoSolicitadoDTO> obtenerProductosMasSolicitados(int mes, int anio) {
        List<ProductoSolicitadoDTO> lista = new ArrayList<>();
        String sql =
            "SELECT p.nombre AS producto, COALESCE(SUM(d.cantidad), 0) AS cantidad " +
            "FROM clan_db.detalles d " +
            "JOIN clan_db.solicitudes s ON d.id_solicitudes = s.id_solicitudes " +
            "JOIN clan_db.productos p   ON d.id_productos   = p.id_productos " +
            "WHERE YEAR(s.fecha_solicitud) = ? AND MONTH(s.fecha_solicitud) = ? " +
            "GROUP BY p.id_productos, p.nombre " +
            "ORDER BY cantidad DESC " +
            "LIMIT 6";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, anio);
            pstmt.setInt(2, mes);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(new ProductoSolicitadoDTO(
                            rs.getString("producto"),
                            rs.getInt("cantidad")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ─── 4. Gráfico de dona: consumo por categoría ───────────────────────────

    /**
     * Devuelve la cantidad total solicitada agrupada por categoría
     * en el mes/año indicados. Se basa en la tabla 'detalles'.
     */
    public List<ConsumoCategoriaDTO> obtenerConsumoPorCategoria(int mes, int anio) {
        List<ConsumoCategoriaDTO> lista = new ArrayList<>();
        String sql =
            "SELECT c.nombre AS categoria, COALESCE(SUM(d.cantidad), 0) AS cantidad " +
            "FROM clan_db.detalles d " +
            "JOIN clan_db.solicitudes s ON d.id_solicitudes = s.id_solicitudes " +
            "JOIN clan_db.productos p   ON d.id_productos   = p.id_productos " +
            "JOIN clan_db.categorias c  ON p.id_categorias  = c.id_categorias " +
            "WHERE YEAR(s.fecha_solicitud) = ? AND MONTH(s.fecha_solicitud) = ? " +
            "GROUP BY c.id_categorias, c.nombre " +
            "ORDER BY cantidad DESC";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, anio);
            pstmt.setInt(2, mes);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(new ConsumoCategoriaDTO(
                            rs.getString("categoria"),
                            rs.getInt("cantidad")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
