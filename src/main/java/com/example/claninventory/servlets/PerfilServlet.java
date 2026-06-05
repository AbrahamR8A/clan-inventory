package com.example.claninventory.servlets;

import com.example.claninventory.daos.UsuariosDao;
import com.example.claninventory.beans.Usuarios;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "PerfilServlet", urlPatterns = {"/PerfilServlet"})
public class PerfilServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        UsuariosDao dao = new UsuariosDao();

        // Si se pide la foto de perfil
        if ("foto".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    byte[] foto = dao.obtenerFotoPerfil(id);
                    if (foto != null && foto.length > 0) {
                        response.setContentType("image/jpeg");
                        response.getOutputStream().write(foto);
                        return;
                    }
                } catch (NumberFormatException e) {
                    // ignorar y retornar error 404 abajo
                }
            }
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Si no es foto, simplemente mostramos el perfil del usuario en sesión
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            Usuarios usuarioSesion = (Usuarios) session.getAttribute("usuario");
            // Pasamos el objeto usuario actual
            request.setAttribute("usuarioPerfil", usuarioSesion);
        }
        
        request.getRequestDispatcher("/perfil.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("cambiarContrasenia".equals(action)) {
            String idStr = request.getParameter("idUsuario");
            String actual = request.getParameter("contraseniaActual");
            String nueva = request.getParameter("nuevaContrasenia");
            String confirmar = request.getParameter("confirmarContrasenia");

            if (idStr == null || actual == null || nueva == null || confirmar == null || !nueva.equals(confirmar)) {
                response.sendRedirect(request.getContextPath() + "/PerfilServlet?msg=password_error");
                return;
            }

            try {
                int idUsuario = Integer.parseInt(idStr);
                UsuariosDao dao = new UsuariosDao();

                // 1. Validar la contraseña actual (utiliza la validación con Salt)
                boolean esValida = dao.validarContraseniaActual(idUsuario, actual);

                if (esValida) {
                    // 2. Actualizar a la nueva contraseña
                    boolean actualizado = dao.actualizarContrasenia(idUsuario, nueva);
                    if (actualizado) {
                        response.sendRedirect(request.getContextPath() + "/PerfilServlet?msg=password_ok");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/PerfilServlet?msg=password_error");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/PerfilServlet?msg=password_error");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/PerfilServlet?msg=password_error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/PerfilServlet");
        }
    }
}
