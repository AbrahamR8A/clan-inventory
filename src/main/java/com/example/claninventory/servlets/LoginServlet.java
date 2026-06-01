package com.example.claninventory.servlets;

import com.example.claninventory.beans.Usuarios;
import com.example.claninventory.daos.UsuariosDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet de autenticación de CLAN INVENTORY.
 *
 *  - POST  : recibe correo + contrasenia del formulario de login.jsp.
 *            Si las credenciales son válidas, guarda el usuario en la
 *            sesión y redirige al Inicio correspondiente al rol.
 *  - GET   : si no hay sesión muestra el login; si ya hay sesión activa
 *            redirige directo al Inicio del rol del usuario logueado.
 *
 * Roles soportados:
 *   administrador        ->  /InicioAdminServlet
 *   coordinador          ->  /InicioCoordinadorServlet
 *   solicitante          ->  /InicioSolicitanteServlet
 *   encargado_deposito   ->  /InicioDepositoServlet
 *   superadmin           ->  /InicioAdminServlet
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String correo = request.getParameter("email");
        String contrasenia = request.getParameter("password");

        // Validación rápida de campos vacíos
        if (correo == null || correo.trim().isEmpty()
                || contrasenia == null || contrasenia.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=campos");
            return;
        }

        // Validar credenciales en la base de datos
        UsuariosDao dao = new UsuariosDao();
        Usuarios usuario = dao.validarLogin(correo.trim(), contrasenia);

        if (usuario == null) {
            // Credenciales incorrectas o usuario inactivo
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=credenciales");
            return;
        }

        // Crear sesión y guardar los datos del usuario logueado
        HttpSession session = request.getSession(true);
        session.setAttribute("usuario", usuario);
        session.setAttribute("idUsuario", usuario.getIdUsuarios());
        session.setAttribute("rol", usuario.getRol());
        session.setAttribute("nombreCompleto",
                usuario.getNombres() + " " + usuario.getApellidoPaterno());

        // Redirigir al Inicio según el rol
        response.sendRedirect(request.getContextPath() + destinoPorRol(usuario.getRol()));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Si ya hay un usuario en sesión, redirige a su Inicio.
        // Si no, manda al formulario de login.
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            String rol = (String) session.getAttribute("rol");
            response.sendRedirect(request.getContextPath() + destinoPorRol(rol));
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    /**
     * Devuelve la URL del Inicio correspondiente al rol indicado.
     * Si el rol no es reconocido, manda de vuelta al login.
     */
    private String destinoPorRol(String rol) {
        if (rol == null) return "/login.jsp";
        switch (rol) {
            case "administrador":      return "/InicioAdminServlet";
            case "coordinador":        return "/InicioCoordinadorServlet";
            case "solicitante":        return "/InicioSolicitanteServlet";
            case "encargado_deposito": return "/InicioDepositoServlet";
            case "superadmin":         return "/InicioAdminServlet";
            default:                   return "/login.jsp";
        }
    }
}
