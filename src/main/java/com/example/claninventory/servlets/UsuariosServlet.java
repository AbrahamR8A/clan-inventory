package org.example.administrador.servlets;

import org.example.administrador.beans.Usuarios;
import org.example.administrador.daos.UsuariosDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UsuariosServlet", urlPatterns = {"/UsuariosServlet"})
public class UsuariosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        UsuariosDao usuariosDao = new UsuariosDao();

        if ("editar".equals(action)) {
            Usuarios usuario = new Usuarios();
            usuario.setIdUsuarios(Integer.parseInt(request.getParameter("id_usuario")));
            usuario.setNombres(request.getParameter("nombres"));
            usuario.setApellidoPaterno(request.getParameter("apellido_paterno"));
            usuario.setApellidoMaterno(request.getParameter("apellido_materno"));
            usuario.setCorreo(request.getParameter("correo_electronico"));
            usuario.setRol(request.getParameter("rol"));
            
            usuariosDao.actualizarUsuario(usuario);
            response.sendRedirect(request.getContextPath() + "/UsuariosServlet?msg=edit_success");
        } else if ("desactivar".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id_usuario"));
            usuariosDao.desactivarUsuario(id);
            response.sendRedirect(request.getContextPath() + "/UsuariosServlet?msg=deactivate_success");
        } else {
            // 1. Capturar los datos exactamente como se llaman en el 'name' de tu JSP
            String nombres = request.getParameter("nombres");
            String apellidoPaterno = request.getParameter("apellido_paterno");
            String apellidoMaterno = request.getParameter("apellido_materno");
            String correo = request.getParameter("correo_electronico"); // Corregido
            String contrasenia = request.getParameter("password"); // Corregido
            String rol = request.getParameter("rol");

            // 2. Llenar el objeto usando los nombres de métodos correctos de tu Bean
            Usuarios nuevoUsuario = new Usuarios();
            nuevoUsuario.setNombres(nombres);
            nuevoUsuario.setApellidoPaterno(apellidoPaterno); // Corregido camelCase
            nuevoUsuario.setApellidoMaterno(apellidoMaterno); // Corregido camelCase
            nuevoUsuario.setCorreo(correo);
            nuevoUsuario.setContrasenia(contrasenia);
            nuevoUsuario.setRol(rol);
            nuevoUsuario.setActivo(2); // 2 representa estado Pendiente

            usuariosDao.registrarUsuario(nuevoUsuario);

            response.sendRedirect(request.getContextPath() + "/UsuariosServlet?msg=success");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Instanciamos el DAO y obtenemos la lista de la base de datos
        UsuariosDao usuariosDao = new UsuariosDao();
        // Nota: Asegúrate de importar java.util.ArrayList en tu Servlet si no lo tienes
        java.util.ArrayList<Usuarios> lista = usuariosDao.listarUsuarios();

        // 2. Guardamos la lista en el request con el nombre "listaUsuarios" (el mismo que usa tu JSP)
        request.setAttribute("listaUsuarios", lista);

        // 3. Enviamos (forward) la petición al JSP para que dibuje la tabla
        request.getRequestDispatcher("/views/administrador/GestionUsuarios_administrador.jsp").forward(request, response);
    }
}