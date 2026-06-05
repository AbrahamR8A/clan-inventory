package com.example.claninventory.servlets;

import com.example.claninventory.beans.ActividadSistemaDTO;
import com.example.claninventory.beans.AlertaStockDTO;
import com.example.claninventory.beans.DashboardAdminDTO;
import com.example.claninventory.beans.Notificaciones;
import com.example.claninventory.daos.DashboardAdminDao;
import com.example.claninventory.daos.NotificacionesDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "InicioAdminServlet", urlPatterns = {"/InicioAdminServlet"})
public class InicioAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtenemos el ID del usuario logueado desde la sesión
        int idAdminActual = (Integer) request.getSession().getAttribute("idUsuario");

        DashboardAdminDao dashboardDao = new DashboardAdminDao();
        NotificacionesDao notificacionesDao = new NotificacionesDao();

        // 1. Obtener KPIs (Tarjetas superiores)
        DashboardAdminDTO kpis = dashboardDao.obtenerKPIs();

        // 2. Obtener la Actividad Reciente del Sistema
        List<ActividadSistemaDTO> actividadReciente = dashboardDao.obtenerActividadReciente();

        // 3. Obtener Alertas de Stock
        List<AlertaStockDTO> alertasStock = dashboardDao.obtenerAlertasStock();

        // 4. Obtener Notificaciones y el contador de no leídas
        List<Notificaciones> listaNotificaciones = notificacionesDao.obtenerUltimasNotificaciones(idAdminActual);
        int notificacionesNoLeidas = notificacionesDao.obtenerCantidadNoLeidas(idAdminActual);

        // Guardar la información en el request para que el JSP pueda consumirla
        request.setAttribute("kpis", kpis);
        request.setAttribute("actividadReciente", actividadReciente);
        request.setAttribute("alertasStock", alertasStock);
        request.setAttribute("listaNotificaciones", listaNotificaciones);
        request.setAttribute("notificacionesNoLeidas", notificacionesNoLeidas);

        // Hacer un forward hacia la vista
        request.getRequestDispatcher("/views/administrador/inicio_administrador.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Para este inicio no necesitamos POST, si llega algo lo mandamos al GET
        doGet(request, response);
    }
}
