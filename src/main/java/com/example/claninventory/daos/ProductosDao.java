package com.example.claninventory.daos;

import com.example.claninventory.beans.Categorias;
import com.example.claninventory.beans.Productos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductosDao extends BaseDao {

    // ─── Mapeo ResultSet → Productos ─────────────────────────────────────────

    private Productos mapear(ResultSet rs) throws SQLException {
        Productos p = new Productos();
        p.setIdProductos(rs.getInt("id_productos"));
        p.setCodigo(rs.getString("codigo"));
        p.setNombre(rs.getString("nombre"));
        p.setStockActual(rs.getInt("stock_actual"));
        p.setStockBajo(rs.getInt("stock_bajo"));
        p.setStockCritico(rs.getInt("stock_critico"));
        p.setImagen(rs.getBytes("imagen"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setActivo(rs.getInt("activo"));
        p.setIdCategorias(rs.getInt("id_categorias"));
        p.setNombreCategoria(rs.getString("nombre_categoria"));
        p.setSiglaCategoria(rs.getString("sigla_categoria"));
        return p;
    }

    // ─── 1. LISTAR todos ─────────────────────────────────────────────────────

    public ArrayList<Productos> listarProductos() {
        ArrayList<Productos> lista = new ArrayList<>();
        String sql = "SELECT p.*, c.nombre AS nombre_categoria, c.sigla AS sigla_categoria " +
                     "FROM productos p " +
                     "JOIN categorias c ON p.id_categorias = c.id_categorias " +
                     "ORDER BY p.nombre ASC";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ─── 2. LISTAR con filtros del servidor ───────────────────────────────────

    public ArrayList<Productos> listarProductosFiltrados(
            String buscar, String filtroCategoria, String filtroEstado) {

        ArrayList<Productos> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, c.nombre AS nombre_categoria, c.sigla AS sigla_categoria " +
            "FROM productos p JOIN categorias c ON p.id_categorias = c.id_categorias WHERE 1=1 ");

        if (buscar != null && !buscar.trim().isEmpty())
            sql.append("AND (p.nombre LIKE ? OR p.codigo LIKE ?) ");
        if (filtroCategoria != null && !filtroCategoria.trim().isEmpty())
            sql.append("AND p.id_categorias = ? ");
        if (filtroEstado != null && !filtroEstado.trim().isEmpty()) {
            switch (filtroEstado) {
                case "critico": sql.append("AND p.stock_actual <= p.stock_critico "); break;
                case "bajo":    sql.append("AND p.stock_actual > p.stock_critico AND p.stock_actual <= p.stock_bajo "); break;
                case "optimo":  sql.append("AND p.stock_actual > p.stock_bajo "); break;
            }
        }
        sql.append("ORDER BY p.nombre ASC");

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (buscar != null && !buscar.trim().isEmpty()) {
                String like = "%" + buscar.trim() + "%";
                pstmt.setString(idx++, like);
                pstmt.setString(idx++, like);
            }
            if (filtroCategoria != null && !filtroCategoria.trim().isEmpty())
                pstmt.setInt(idx++, Integer.parseInt(filtroCategoria));

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // ─── 3. REGISTRAR ────────────────────────────────────────────────────────

    public boolean registrarProducto(Productos producto) {
        boolean tieneImagen = producto.getImagen() != null && producto.getImagen().length > 0;
        String sql = tieneImagen
            ? "INSERT INTO productos (codigo, nombre, stock_actual, stock_bajo, stock_critico, imagen, descripcion, activo, id_categorias, id_usuarios) VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?, 1)"
            : "INSERT INTO productos (codigo, nombre, stock_actual, stock_bajo, stock_critico, descripcion, activo, id_categorias, id_usuarios) VALUES (?, ?, ?, ?, ?, ?, 1, ?, 1)";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, producto.getCodigo());
            pstmt.setString(2, producto.getNombre());
            pstmt.setInt(3, producto.getStockActual());
            pstmt.setInt(4, producto.getStockBajo());
            pstmt.setInt(5, producto.getStockCritico());
            int idx = 6;
            if (tieneImagen) pstmt.setBytes(idx++, producto.getImagen());
            pstmt.setString(idx++, producto.getDescripcion());
            pstmt.setInt(idx, producto.getIdCategorias());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── OBTENER imagen de un producto ───────────────────────────────────────

    public byte[] obtenerImagenProducto(int idProducto) {
        String sql = "SELECT imagen FROM productos WHERE id_productos = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idProducto);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getBytes("imagen");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ─── 4. ACTUALIZAR ───────────────────────────────────────────────────────

    public boolean actualizarProducto(Productos producto) {
        boolean tieneImagen = producto.getImagen() != null && producto.getImagen().length > 0;
        String sql = tieneImagen
            ? "UPDATE productos SET codigo=?, nombre=?, stock_bajo=?, stock_critico=?, id_categorias=?, imagen=?, descripcion=? WHERE id_productos=?"
            : "UPDATE productos SET codigo=?, nombre=?, stock_bajo=?, stock_critico=?, id_categorias=?, descripcion=? WHERE id_productos=?";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, producto.getCodigo());
            pstmt.setString(2, producto.getNombre());
            pstmt.setInt(3, producto.getStockBajo());
            pstmt.setInt(4, producto.getStockCritico());
            pstmt.setInt(5, producto.getIdCategorias());
            if (tieneImagen) {
                pstmt.setBytes(6, producto.getImagen());
                pstmt.setString(7, producto.getDescripcion());
                pstmt.setInt(8, producto.getIdProductos());
            } else {
                pstmt.setString(6, producto.getDescripcion());
                pstmt.setInt(7, producto.getIdProductos());
            }
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── 5. DESACTIVAR ───────────────────────────────────────────────────────

    public boolean desactivarProducto(int idProducto) {
        String sql = "UPDATE productos SET activo = 0 WHERE id_productos = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idProducto);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── 6. ACTIVAR ──────────────────────────────────────────────────────────

    public boolean activarProducto(int idProducto) {
        String sql = "UPDATE productos SET activo = 1 WHERE id_productos = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idProducto);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── 7. LISTAR categorías ─────────────────────────────────────────────────

    public ArrayList<Categorias> listarCategorias() {
        ArrayList<Categorias> lista = new ArrayList<>();
        String sql = "SELECT * FROM categorias ORDER BY nombre ASC";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Categorias c = new Categorias();
                c.setIdCategorias(rs.getInt("id_categorias"));
                c.setNombre(rs.getString("nombre"));
                c.setSigla(rs.getString("sigla"));
                lista.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
