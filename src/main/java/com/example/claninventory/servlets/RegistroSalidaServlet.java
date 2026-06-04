package com.example.claninventory.servlets;

import com.example.claninventory.beans.Solicitudes;
import com.example.claninventory.daos.SolicitudesDepositoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "RegistroSalidaServlet", urlPatterns = {"/RegistroSalidaServlet"})
public class RegistroSalidaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String solicitanteId = request.getParameter("solicitanteId");
        String fecha = request.getParameter("fecha");

        SolicitudesDepositoDao depositoDao = new SolicitudesDepositoDao();
        
        // Cargar las solicitudes 'entregada'
        ArrayList<Solicitudes> listaEntregadas = depositoDao.listarSolicitudesPorEstado("entregada", solicitanteId, fecha);
        request.setAttribute("listaSolicitudesEntregadas", listaEntregadas);

        // Retener los valores de búsqueda en la vista
        request.setAttribute("filtroSolicitanteId", solicitanteId);
        request.setAttribute("filtroFecha", fecha);

        request.getRequestDispatcher("/views/deposito/registro_salida.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
