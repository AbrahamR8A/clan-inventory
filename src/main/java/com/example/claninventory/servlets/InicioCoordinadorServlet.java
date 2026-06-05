package com.example.claninventory.servlets;

import com.example.claninventory.beans.Detalles;
import com.example.claninventory.beans.Solicitudes;
import com.example.claninventory.daos.SolicitudesCoordinadorDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "InicioCoordinadorServlet", urlPatterns = {"/InicioCoordinadorServlet"})
public class InicioCoordinadorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action") == null ? "inicio" : request.getParameter("action");
        SolicitudesCoordinadorDao solicitudesCoordinadorDao = new SolicitudesCoordinadorDao();

        switch (action) {
            case "inicio": {

                String buscar = request.getParameter("buscar");
                String fecha = request.getParameter("fecha");
                ArrayList<Solicitudes> pendientes = solicitudesCoordinadorDao.listarSolicitudesPendientes(buscar, fecha);

                // Contamos las solicitudes por estado
                int totalAprobadas = solicitudesCoordinadorDao.contarSolicitudesPorEstado("aprobada");
                int totalPendientes = solicitudesCoordinadorDao.contarSolicitudesPorEstado("pendiente");
                int totalRechazadas = solicitudesCoordinadorDao.contarSolicitudesPorEstado("rechazada");

                // Enviamos los atributos al JSP
                request.setAttribute("listaPendientes", pendientes);
                request.setAttribute("totalAprobadas", totalAprobadas);
                request.setAttribute("totalPendientes", totalPendientes);
                request.setAttribute("totalRechazadas", totalRechazadas);

                request.getRequestDispatcher("views/coordinador/Inicio_coordinador.jsp").forward(request, response);

                break;}

            case "historial":
                // Carga el historial de solicitudes procesadas
                String buscar = request.getParameter("buscar");
                String fecha = request.getParameter("fecha");
                String estado = request.getParameter("estado");

                ArrayList<Solicitudes> historial = solicitudesCoordinadorDao.listarSolicitudesProcesadas(buscar, fecha, estado);
                request.setAttribute("listaHistorial", historial);
                request.getRequestDispatcher("views/coordinador/hist_soli.jsp").forward(request, response);
                break;

            case "verDetalle":
                int idSolicitud = Integer.parseInt(request.getParameter("id"));

                // 1. Obtenemos los datos maestros de la solicitud
                Solicitudes solicitud = solicitudesCoordinadorDao.obtenerSolicitudPorId(idSolicitud);
                // 2. Obtenemos la lista de materiales asociados
                ArrayList<Detalles> listaDetalles = solicitudesCoordinadorDao.obtenerDetallesPorSolicitud(idSolicitud);

                request.setAttribute("solicitud", solicitud);
                request.setAttribute("listaDetalles", listaDetalles);

                // Redirección dinámica basada en el estado de la solicitud
                if ("pendiente".equals(solicitud.getEstado())) {
                    request.getRequestDispatcher("views/coordinador/detalles_pendientes.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("views/coordinador/detalles_procesados.jsp").forward(request, response);
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        SolicitudesCoordinadorDao solicitudesCoordinadorDao = new SolicitudesCoordinadorDao();

        // Obtenemos el ID del coordinador logueado desde la sesión
        int idCoordinadorLogueado = (Integer) request.getSession().getAttribute("idUsuario");

        if ("procesarSolicitud".equals(action)) {
            int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
            String decision = request.getParameter("decisionRadio"); // 'aprobada' o 'rechazada'

            boolean resultado = false;

            if ("aprobada".equals(decision)) {
                // Llama a la transacción que aprueba la cabecera y descuenta el stock
                resultado = solicitudesCoordinadorDao.aprobarSolicitud(idSolicitud, idCoordinadorLogueado);
            } else if ("rechazada".equals(decision)) {
                String motivo = request.getParameter("motivoRechazo");
                resultado = solicitudesCoordinadorDao.rechazarSolicitud(idSolicitud, idCoordinadorLogueado, motivo);
            }

            if (resultado) {
                // Redirige al inicio enviando parámetros url para que tu script JS pinte el Toast de éxito
                response.sendRedirect("InicioCoordinadorServlet?action=inicio&action=" + decision + "&id=" + idSolicitud);
            } else {
                // En caso de error (ej: el stock bajó a menos de cero inesperadamente)
                response.sendRedirect("InicioCoordinadorServlet?action=verDetalle&id=" + idSolicitud + "&error=true");
            }
        }
    }
}
