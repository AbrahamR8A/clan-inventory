package com.example.claninventory.servlets;

import com.example.claninventory.beans.Productos;
import com.example.claninventory.daos.ProductosDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

@WebServlet(name = "ProductosServlet", urlPatterns = {"/ProductosServlet"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)   // 5 MB máx
public class ProductosServlet extends HttpServlet {

    // ─── Helper compatible con Java 8 ────────────────────────────────────────
    private byte[] leerBytes(InputStream is) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        byte[] chunk = new byte[4096];
        int n;
        while ((n = is.read(chunk)) != -1) buffer.write(chunk, 0, n);
        return buffer.toByteArray();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ProductosDao dao = new ProductosDao();

        if ("editar".equals(action)) {
            Productos p = new Productos();
            p.setIdProductos(Integer.parseInt(request.getParameter("id_producto")));
            p.setCodigo(request.getParameter("codigo"));
            p.setNombre(request.getParameter("nombre"));
            p.setStockBajo(Integer.parseInt(request.getParameter("stock_bajo")));
            p.setStockCritico(Integer.parseInt(request.getParameter("stock_critico")));
            p.setIdCategorias(Integer.parseInt(request.getParameter("id_categorias")));
            p.setDescripcion(request.getParameter("descripcion"));
            // Imagen opcional en edición
            Part fotoPart = request.getPart("imagen");
            if (fotoPart != null && fotoPart.getSize() > 0) {
                p.setImagen(leerBytes(fotoPart.getInputStream()));
            }
            dao.actualizarProducto(p);
            response.sendRedirect(request.getContextPath() + "/ProductosServlet?msg=edit_success");

        } else if ("desactivar".equals(action)) {
            dao.desactivarProducto(Integer.parseInt(request.getParameter("id_producto")));
            response.sendRedirect(request.getContextPath() + "/ProductosServlet?msg=deactivate_success");

        } else if ("activar".equals(action)) {
            dao.activarProducto(Integer.parseInt(request.getParameter("id_producto")));
            response.sendRedirect(request.getContextPath() + "/ProductosServlet?msg=activate_success");

        } else {
            // Registrar nuevo producto
            Productos p = new Productos();
            p.setCodigo(request.getParameter("codigo"));
            p.setNombre(request.getParameter("nombre"));
            p.setStockActual(Integer.parseInt(request.getParameter("stock_actual")));
            p.setStockBajo(Integer.parseInt(request.getParameter("stock_bajo")));
            p.setStockCritico(Integer.parseInt(request.getParameter("stock_critico")));
            p.setIdCategorias(Integer.parseInt(request.getParameter("id_categorias")));
            p.setDescripcion(request.getParameter("descripcion"));
            // Imagen opcional al crear
            Part fotoPart = request.getPart("imagen");
            if (fotoPart != null && fotoPart.getSize() > 0) {
                p.setImagen(leerBytes(fotoPart.getInputStream()));
            }
            boolean ok = dao.registrarProducto(p);
            response.sendRedirect(request.getContextPath() + "/ProductosServlet?msg=" + (ok ? "success" : "error"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Servir imagen binaria de un producto ─────────────────────────────
        String accion = request.getParameter("action");
        if ("foto".equals(accion)) {
            int idProducto = Integer.parseInt(request.getParameter("id"));
            byte[] imagen = new ProductosDao().obtenerImagenProducto(idProducto);
            if (imagen != null && imagen.length > 0) {
                response.setContentType("image/jpeg");
                response.getOutputStream().write(imagen);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
            return;
        }

        // ── Listar productos con filtros ──────────────────────────────────────
        String buscar          = request.getParameter("buscar");
        String filtroCategoria = request.getParameter("filtro_categoria");
        String filtroEstado    = request.getParameter("filtro_estado");

        ProductosDao dao = new ProductosDao();
        request.setAttribute("listaCategorias", dao.listarCategorias());
        request.setAttribute("listaProductos",  dao.listarProductosFiltrados(buscar, filtroCategoria, filtroEstado));
        request.setAttribute("busquedaActual",  buscar);
        request.setAttribute("categoriaActual", filtroCategoria);
        request.setAttribute("estadoActual",    filtroEstado);

        request.getRequestDispatcher("/views/administrador/GestionInventario_administrador.jsp")
               .forward(request, response);
    }
}
