package com.example.claninventory.servlets;

import com.example.claninventory.daos.SolicitudesSolicitanteDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet de la vista Inicio del Solicitante.
 * Carga desde la base de datos los KPIs (4 tarjetas) y la Tabla de
 * Actividad Reciente con todas las solicitudes del solicitante.
 */
@WebServlet(name = "InicioSolicitanteServlet", urlPatterns = {"/InicioSolicitanteServlet"})
public class InicioSolicitanteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Tomar el ID del usuario logueado desde la sesión
        Integer idSolicitante = (Integer) request.getSession().getAttribute("idUsuario");

        SolicitudesSolicitanteDao dao = new SolicitudesSolicitanteDao();

        // KPIs (tarjetas superiores) y solicitudes del solicitante
        request.setAttribute("kpis", dao.obtenerKpis(idSolicitante));
        request.setAttribute("listaSolicitudes", dao.listarPorSolicitante(idSolicitante));

        request.getRequestDispatcher("/views/solicitante/Inicio_solicitante.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
