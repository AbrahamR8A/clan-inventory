package com.example.claninventory.servlets;

import com.example.claninventory.daos.SolicitudesDepositoDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "InicioDepositoServlet", urlPatterns = {"/InicioDepositoServlet"})
public class InicioDepositoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* --- COMENTADO TEMPORALMENTE PARA DESARROLLO ---
        // Verificar que el usuario haya iniciado sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        -------------------------------------------------- */


        // Instanciar el DAO
        SolicitudesDepositoDao depositoDao = new SolicitudesDepositoDao();

        // 1. Cargar datos para los KPIs (Tarjetas Superiores)
        int aprobadas = depositoDao.contarSolicitudesAprobadas();
        int entregadas = depositoDao.contarSolicitudesEntregadas();

        request.setAttribute("totalAprobadas", aprobadas);
        request.setAttribute("totalEntregadas", entregadas);

        // 2. Cargar listas para los Dropdowns (Filtros)
        request.setAttribute("listaSolicitantes", depositoDao.listarSolicitudesAprobadas());
        request.setAttribute("listaCoordinadores", depositoDao.listarCoordinadoresAprobadores());

        // 3. Capturar parámetros de búsqueda (si existen)
        String idSolicitante = request.getParameter("idSolicitante");
        String idCoordinador = request.getParameter("idCoordinador");
        String fecha = request.getParameter("fecha");

        // Mantener los valores seleccionados en los filtros tras recargar
        request.setAttribute("paramSolicitante", idSolicitante);
        request.setAttribute("paramCoordinador", idCoordinador);
        request.setAttribute("paramFecha", fecha);

        // 4. Cargar la bandeja principal
        request.setAttribute("listaBandeja", depositoDao.listarBandejaDeposito(idSolicitante, idCoordinador, fecha));

        request.getRequestDispatcher("/views/deposito/inicio_deposito.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("verDetalle".equals(action)) {
            // Redirige el flujo internamente al método doGet para procesar la lectura
            doGet(request, response);
        } else {
            // lógica para procesar formularios/actualizaciones
        }

    }
}
