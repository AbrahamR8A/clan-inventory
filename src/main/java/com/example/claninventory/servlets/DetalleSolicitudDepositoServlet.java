package com.example.claninventory.servlets;

import com.example.claninventory.beans.Detalles;
import com.example.claninventory.beans.Solicitudes;
import com.example.claninventory.beans.Usuarios;
import com.example.claninventory.daos.SolicitudesCoordinadorDao;
import com.example.claninventory.daos.SolicitudesDepositoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "DetalleSolicitudDepositoServlet", urlPatterns = {"/DetalleSolicitudDepositoServlet"})
public class DetalleSolicitudDepositoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/InicioDepositoServlet");
            return;
        }

        int idSolicitud = Integer.parseInt(idParam);
        SolicitudesCoordinadorDao coordDao = new SolicitudesCoordinadorDao();
        
        Solicitudes solicitud = coordDao.obtenerSolicitudPorId(idSolicitud);
        ArrayList<Detalles> listaDetalles = coordDao.obtenerDetallesPorSolicitud(idSolicitud);

        if (solicitud != null) {
            request.setAttribute("solicitud", solicitud);
            request.setAttribute("listaDetalles", listaDetalles);
            request.getRequestDispatcher("/views/deposito/detalle_solicitud.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/InicioDepositoServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Usuarios usuarioLogueado = (Usuarios) session.getAttribute("usuario");
        String action = request.getParameter("action");

        if ("entregar".equals(action)) {
            String idParam = request.getParameter("idSolicitud");
            if (idParam != null && !idParam.isEmpty()) {
                int idSolicitud = Integer.parseInt(idParam);
                SolicitudesDepositoDao depositoDao = new SolicitudesDepositoDao();
                
                boolean exito = depositoDao.marcarComoEntregada(idSolicitud, usuarioLogueado.getIdUsuarios());
                if (exito) {
                    response.sendRedirect(request.getContextPath() + "/InicioDepositoServlet?success=entrega");
                } else {
                    response.sendRedirect(request.getContextPath() + "/InicioDepositoServlet?error=entrega");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/InicioDepositoServlet");
            }
        }
    }
}
