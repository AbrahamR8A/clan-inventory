package com.example.claninventory.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet de la vista Inicio del Encargado de Depósito.
 *
 * Si no hay un usuario en la sesión (no inició sesión), se redirige al login.
 * Si hay sesión activa, se carga la vista de inicio del depósito.
 *
 * Cuando se implemente el backend completo del depósito (DAOs y datos
 * dinámicos), aquí se cargarán los KPIs y demás datos antes del forward.
 */
@WebServlet(name = "InicioDepositoServlet", urlPatterns = {"/InicioDepositoServlet"})
public class InicioDepositoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar que el usuario haya iniciado sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // (Aquí se cargarán los datos del depósito cuando exista el módulo completo)
        request.getRequestDispatcher("/views/deposito/inicio_deposito.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
