package com.example.claninventory.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Cierra la sesión del usuario.
 *
 *  1. Invalida la sesión actual (borra todos los atributos y el JSESSIONID).
 *  2. Envía cabeceras anti-caché para que el navegador no muestre páginas
 *     en caché si el usuario pulsa el botón "atrás".
 *  3. Redirige al formulario de login.
 *
 * Junto con el SesionFilter, esto asegura que después de cerrar sesión
 * el usuario tenga que volver a ingresar sus credenciales para entrar.
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        cerrarSesion(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        cerrarSesion(request, response);
    }

    private void cerrarSesion(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // 1. Invalidar la sesión (si existe)
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // 2. Cabeceras anti-caché (refuerzo del filtro)
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // 3. Mandar al login
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
