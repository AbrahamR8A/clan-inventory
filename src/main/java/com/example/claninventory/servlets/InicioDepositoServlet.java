package com.example.claninventory.servlets;

import com.example.claninventory.beans.Detalles;
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

@WebServlet(name = "InicioDepositoServlet", urlPatterns = {"/InicioDepositoServlet"})
public class InicioDepositoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* --- COMENTADO TEMPORALMENTE PARA DESARROLLO ---
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        -------------------------------------------------- */

        String action = request.getParameter("action") == null ? "inicio" : request.getParameter("action");
        SolicitudesDepositoDao depositoDao = new SolicitudesDepositoDao();

        switch (action) {
            case "inicio":{
                // 1. Cargar datos para los KPIs
                int aprobadas = depositoDao.contarSolicitudesAprobadas();
                int entregadas = depositoDao.contarSolicitudesEntregadas();

                request.setAttribute("totalAprobadas", aprobadas);
                request.setAttribute("totalEntregadas", entregadas);

                // 2. Cargar listas para los Dropdowns
                request.setAttribute("listaSolicitantes", depositoDao.listarSolicitantesAprobados());
                request.setAttribute("listaCoordinadores", depositoDao.listarCoordinadoresAprobadores());

                // 3. Capturar parámetros de búsqueda
                String idSolicitante = request.getParameter("idSolicitante");
                String idCoordinador = request.getParameter("idCoordinador");
                String fecha = request.getParameter("fecha");

                request.setAttribute("paramSolicitante", idSolicitante);
                request.setAttribute("paramCoordinador", idCoordinador);
                request.setAttribute("paramFecha", fecha);

                // 4. Cargar la bandeja principal
                request.setAttribute("listaBandeja", depositoDao.listarBandejaDeposito(idSolicitante, idCoordinador, fecha));

                request.getRequestDispatcher("/views/deposito/inicio_deposito.jsp").forward(request, response);
                break;}

            case "historial":{
                // 1. Capturar los parámetros de los filtros desde la URL (GET)
                String idSolicitante = request.getParameter("idSolicitante");
                String idCoordinador = request.getParameter("idCoordinador");
                String fechaEntrega = request.getParameter("fecha");

                // Normalizamos los valores (si vienen null de la primera carga, los volvemos vacíos)
                idSolicitante = (idSolicitante == null) ? "" : idSolicitante.trim();
                idCoordinador = (idCoordinador == null) ? "" : idCoordinador.trim();
                fechaEntrega = (fechaEntrega == null) ? "" : fechaEntrega.trim();

                // 2. Mantener las selecciones en la vista para que no se reseteen al filtrar
                request.setAttribute("paramSolicitante", idSolicitante);
                request.setAttribute("paramCoordinador", idCoordinador);
                request.setAttribute("paramFecha", fechaEntrega);

                // 3. Cargar las listas exclusivas de los dropdowns (solo usuarios con entregas realizadas)
                request.setAttribute("listaSolicitantes", depositoDao.listarSolicitantesEntregados());
                request.setAttribute("listaCoordinadores", depositoDao.listarCoordinadoresEntregados());

                // 4. Llamamos al DAO y mandamos la lista al JSP
                ArrayList<Solicitudes> historialDepo = depositoDao.listarHistorialEntregadas(idSolicitante, idCoordinador, fechaEntrega);
                request.setAttribute("listaHistorial", historialDepo);

                // 5. Redireccionar a la vista del historial del depósito
                request.getRequestDispatcher("/views/deposito/historial_entregas.jsp").forward(request, response);
                break;}

            case "vistaDetalle":
                HttpSession sesionActual = request.getSession();
                if (sesionActual.getAttribute("detalleSolicitud") != null) {
                    Solicitudes solicitudTemporal = (Solicitudes) sesionActual.getAttribute("detalleSolicitud");

                    request.setAttribute("solicitud", solicitudTemporal);
                    request.setAttribute("listaDetalles", sesionActual.getAttribute("detalleMateriales"));

                    sesionActual.removeAttribute("detalleSolicitud");
                    sesionActual.removeAttribute("detalleMateriales");

                    // REDIRECCIÓN DINÁMICA:
                    if ("entregada".equals(solicitudTemporal.getEstado())) {
                        request.getRequestDispatcher("/views/deposito/detalle_entregado.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/views/deposito/solicitud_por_entregar.jsp").forward(request, response);
                    }
                } else {
                    response.sendRedirect("InicioDepositoServlet?action=inicio");
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        SolicitudesDepositoDao depositoDao = new SolicitudesDepositoDao();

        if ("verDetalle".equals(action)) {
            int idSolicitud = Integer.parseInt(request.getParameter("id"));

            // Obtenemos los datos desde el DAO
            Solicitudes solicitud = depositoDao.obtenerSolicitudPorId(idSolicitud);
            ArrayList<Detalles> listaDetalles = depositoDao.obtenerDetallesPorSolicitud(idSolicitud);

            // Los guardamos en la sesión
            HttpSession session = request.getSession();
            session.setAttribute("detalleSolicitud", solicitud);
            session.setAttribute("detalleMateriales", listaDetalles);

            // Redirigimos por GET para limpiar la petición
            response.sendRedirect("InicioDepositoServlet?action=vistaDetalle");

        }

        else if ("procesarEntrega".equals(action)) {
            int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));

            // Hardcodeamos el id del encargado de depósito en sesión (ej: ID = 3)
            // Cuando la sesión esté activa, sería:
            // int idEncargadoLogueado = ((Usuarios) request.getSession().getAttribute("usuario")).getIdUsuarios();
            int idEncargadoLogueado = 3;

            // Ejecutamos la transacción
            boolean resultado = depositoDao.marcarComoEntregada(idSolicitud, idEncargadoLogueado);

            if (resultado) {
                // Redirige al inicio enviando parámetro de éxito para mostrar el Toast verde
                response.sendRedirect("InicioDepositoServlet?action=inicio&delivery=success");
            } else {
                // Si algo falló a nivel de base de datos, mostramos un error genérico o no mostramos el toast
                response.sendRedirect("InicioDepositoServlet?action=inicio&error=true");
            }
        }
    }
}
