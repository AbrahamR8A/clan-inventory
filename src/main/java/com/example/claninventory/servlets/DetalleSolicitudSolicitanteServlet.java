package com.example.claninventory.servlets;

import com.example.claninventory.beans.SolicitudSolicitante;
import com.example.claninventory.daos.SolicitudesSolicitanteDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet de la vista "Detalle de Solicitud" del Solicitante.
 * Recibe el id de una solicitud (parámetro 'id', enviado por el botón del ojito
 * en la tabla de Actividad Reciente) y carga su información y sus materiales.
 */
@WebServlet(name = "DetalleSolicitudSolicitanteServlet",
            urlPatterns = {"/DetalleSolicitudSolicitanteServlet"})
public class DetalleSolicitudSolicitanteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Si no llega un id válido, se regresa al Inicio
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/InicioSolicitanteServlet");
            return;
        }

        int idSolicitud;
        try {
            idSolicitud = Integer.parseInt(idParam.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/InicioSolicitanteServlet");
            return;
        }

        SolicitudesSolicitanteDao dao = new SolicitudesSolicitanteDao();
        SolicitudSolicitante solicitud = dao.obtenerPorId(idSolicitud);

        // Si la solicitud no existe, se regresa al Inicio
        if (solicitud == null) {
            response.sendRedirect(request.getContextPath() + "/InicioSolicitanteServlet");
            return;
        }

        request.setAttribute("solicitud", solicitud);
        request.setAttribute("detalles", dao.listarDetalles(idSolicitud));

        request.getRequestDispatcher("/views/solicitante/Detalle_solicitud_solicitante.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
