package com.example.claninventory.servlets;

import com.example.claninventory.beans.DetalleSolicitante;
import com.example.claninventory.beans.ProductoSolicitante;
import com.example.claninventory.daos.ProductosSolicitanteDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

/**
 * Servlet de la vista "Nueva Solicitud" del Solicitante.
 *
 *  - GET (sin action)  : muestra la lista de productos disponibles.
 *  - GET action=agregar: agrega un producto a la cajita (carrito en sesión).
 *  - GET action=foto   : sirve la imagen binaria de un producto.
 *
 * La cajita se guarda en la sesión como una lista de DetalleSolicitante
 * con la clave "cajita".
 */
@WebServlet(name = "NuevaSolicitudSolicitanteServlet",
            urlPatterns = {"/NuevaSolicitudSolicitanteServlet"})
public class NuevaSolicitudSolicitanteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ProductosSolicitanteDao dao = new ProductosSolicitanteDao();

        // ── Servir la imagen de un producto ──────────────────────────────────
        if ("foto".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            byte[] imagen = dao.obtenerImagenProducto(id);
            if (imagen != null && imagen.length > 0) {
                response.setContentType("image/jpeg");
                try (OutputStream os = response.getOutputStream()) {
                    os.write(imagen);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
            return;
        }

        // ── Agregar un producto a la cajita ──────────────────────────────────
        if ("agregar".equals(action)) {
            int idProducto = Integer.parseInt(request.getParameter("id"));
            ArrayList<DetalleSolicitante> cajita = obtenerCajita(request);

            // Evitar duplicados: si el producto ya está en la cajita, no se agrega otra vez
            boolean yaEsta = false;
            for (DetalleSolicitante d : cajita) {
                if (d.getIdProductos() == idProducto) { yaEsta = true; break; }
            }

            if (!yaEsta) {
                ProductoSolicitante p = dao.obtenerProducto(idProducto);
                if (p != null) {
                    DetalleSolicitante item = new DetalleSolicitante();
                    item.setIdProductos(p.getIdProductos());
                    item.setCodigo(p.getCodigo());
                    item.setSiglaCategoria(p.getSiglaCategoria());
                    item.setNombre(p.getNombre());
                    item.setCategoria(p.getNombreCategoria());
                    item.setStockActual(p.getStockActual());
                    item.setCantidad(1);
                    cajita.add(item);
                }
            }
            response.sendRedirect(request.getContextPath()
                    + "/NuevaSolicitudSolicitanteServlet?msg=" + (yaEsta ? "repetido" : "agregado"));
            return;
        }

        // ── Carga normal de la vista ─────────────────────────────────────────
        request.setAttribute("listaProductos", dao.listarProductosDisponibles());
        request.setAttribute("listaCategorias", dao.listarCategorias());
        request.setAttribute("cajitaCount", obtenerCajita(request).size());

        request.getRequestDispatcher("/views/solicitante/Nueva_solicitud_solicitante.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Devuelve la cajita (carrito) guardada en la sesión. Si aún no existe,
     * la crea vacía y la guarda.
     */
    @SuppressWarnings("unchecked")
    private ArrayList<DetalleSolicitante> obtenerCajita(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ArrayList<DetalleSolicitante> cajita =
                (ArrayList<DetalleSolicitante>) session.getAttribute("cajita");
        if (cajita == null) {
            cajita = new ArrayList<>();
            session.setAttribute("cajita", cajita);
        }
        return cajita;
    }
}
