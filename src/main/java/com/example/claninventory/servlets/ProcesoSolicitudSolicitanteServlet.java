package com.example.claninventory.servlets;

import com.example.claninventory.beans.DetalleSolicitante;
import com.example.claninventory.daos.SolicitudesSolicitanteDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Servlet de la vista "Proceso de Solicitud" del Solicitante.
 *
 *  - GET (sin action)   : muestra la cajita en la "Tabla de productos seleccionados".
 *  - GET action=eliminar: quita un producto de la cajita (botón del tacho).
 *  - POST action=enviar : crea la solicitud en la base de datos (estado 'pendiente')
 *                         siempre que haya productos y se haya escrito el motivo.
 */
@WebServlet(name = "ProcesoSolicitudSolicitanteServlet",
            urlPatterns = {"/ProcesoSolicitudSolicitanteServlet"})
public class ProcesoSolicitudSolicitanteServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ArrayList<DetalleSolicitante> cajita = obtenerCajita(request);

        // ── Eliminar un producto de la cajita ────────────────────────────────
        if ("eliminar".equals(action)) {
            int idProducto = Integer.parseInt(request.getParameter("id"));
            Iterator<DetalleSolicitante> it = cajita.iterator();
            while (it.hasNext()) {
                if (it.next().getIdProductos() == idProducto) {
                    it.remove();
                    break;
                }
            }
            response.sendRedirect(request.getContextPath()
                    + "/ProcesoSolicitudSolicitanteServlet");
            return;
        }

        // ── Carga normal de la vista ─────────────────────────────────────────
        request.setAttribute("cajita", cajita);
        request.setAttribute("cajitaCount", cajita.size());
        request.getRequestDispatcher("/views/solicitante/Proceso_solicitud_solicitante.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("enviar".equals(action)) {
            ArrayList<DetalleSolicitante> cajita = obtenerCajita(request);
            String motivo = request.getParameter("motivo");

            // Validación: debe haber productos y un motivo escrito
            if (cajita.isEmpty()) {
                response.sendRedirect(request.getContextPath()
                        + "/ProcesoSolicitudSolicitanteServlet?error=vacia");
                return;
            }
            if (motivo == null || motivo.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath()
                        + "/ProcesoSolicitudSolicitanteServlet?error=motivo");
                return;
            }

            // Actualizar las cantidades escritas en el formulario
            for (DetalleSolicitante item : cajita) {
                String valor = request.getParameter("cantidad_" + item.getIdProductos());
                int cantidad = 1;
                if (valor != null && !valor.trim().isEmpty()) {
                    try { cantidad = Integer.parseInt(valor.trim()); }
                    catch (NumberFormatException e) { cantidad = 1; }
                }
                if (cantidad < 1) cantidad = 1;
                if (cantidad > item.getStockActual()) cantidad = item.getStockActual();
                item.setCantidad(cantidad);
            }

            // Tomar el ID del usuario logueado desde la sesión
            Integer idSolicitante = (Integer) request.getSession().getAttribute("idUsuario");

            // Crear la solicitud (estado 'pendiente') con sus detalles
            SolicitudesSolicitanteDao dao = new SolicitudesSolicitanteDao();
            int idSolicitud = dao.crearSolicitud(motivo.trim(), idSolicitante, cajita);

            if (idSolicitud > 0) {
                // Solicitud creada: se vacía la cajita y se vuelve al Inicio
                request.getSession().removeAttribute("cajita");
                response.sendRedirect(request.getContextPath()
                        + "/InicioSolicitanteServlet?msg=creada&id=" + idSolicitud);
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/ProcesoSolicitudSolicitanteServlet?error=db");
            }
            return;
        }

        doGet(request, response);
    }

    /**
     * Devuelve la cajita guardada en la sesión; si no existe, la crea vacía.
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
