package com.example.claninventory.daos;

import com.example.claninventory.beans.Categorias;
import com.example.claninventory.beans.ProductoSolicitante;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * DAO de productos para el rol Solicitante.
 * Carga desde la base de datos los productos disponibles que el solicitante
 * puede ver y agregar a la cajita en la vista "Nueva Solicitud".
 */
public class ProductosSolicitanteDao extends BaseDao {

    // ─── Mapeo ResultSet -> ProductoSolicitante ──────────────────────────────

    private ProductoSolicitante mapear(ResultSet rs) throws SQLException {
        ProductoSolicitante p = new ProductoSolicitante();
        p.setIdProductos(rs.getInt("id_productos"));
        p.setCodigo(rs.getString("codigo"));
        p.setNombre(rs.getString("nombre"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setStockActual(rs.getInt("stock_actual"));
        p.setStockBajo(rs.getInt("stock_bajo"));
        p.setStockCritico(rs.getInt("stock_critico"));
        p.setIdCategorias(rs.getInt("id_categorias"));
        p.setNombreCategoria(rs.getString("nombre_categoria"));
        p.setSiglaCategoria(rs.getString("sigla_categoria"));
        return p;
    }

    // ─── 1. Listar todos los productos disponibles ───────────────────────────

    public ArrayList<ProductoSolicitante> listarProductosDisponibles() {
        ArrayList<ProductoSolicitante> lista = new ArrayList<>();
        String sql =
            "SELECT p.id_productos, p.codigo, p.nombre, p.descripcion, " +
            "       p.stock_actual, p.stock_bajo, p.stock_critico, p.id_categorias, " +
            "       c.nombre AS nombre_categoria, c.sigla AS sigla_categoria " +
            "FROM clan_db.productos p " +
            "JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias " +
            "WHERE p.activo = 1 " +
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

    // ─── 2. Obtener un producto por su id (para agregarlo a la cajita) ────────

    public ProductoSolicitante obtenerProducto(int idProducto) {
        String sql =
            "SELECT p.id_productos, p.codigo, p.nombre, p.descripcion, " +
            "       p.stock_actual, p.stock_bajo, p.stock_critico, p.id_categorias, " +
            "       c.nombre AS nombre_categoria, c.sigla AS sigla_categoria " +
            "FROM clan_db.productos p " +
            "JOIN clan_db.categorias c ON p.id_categorias = c.id_categorias " +
            "WHERE p.id_productos = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idProducto);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ─── 3. Listar categorías (para el filtro de la vista) ───────────────────

    public ArrayList<Categorias> listarCategorias() {
        ArrayList<Categorias> lista = new ArrayList<>();
        String sql = "SELECT id_categorias, nombre, sigla FROM clan_db.categorias ORDER BY nombre ASC";

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

    // ─── 4. Obtener la imagen binaria de un producto ─────────────────────────

    public byte[] obtenerImagenProducto(int idProducto) {
        String sql = "SELECT imagen FROM clan_db.productos WHERE id_productos = ?";
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
}
