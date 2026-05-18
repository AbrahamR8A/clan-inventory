package com.example.claninventory.servlets;

import com.example.claninventory.beans.Usuarios;
import com.example.claninventory.daos.UsuariosDao;

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

            // 2. Llenar el objeto usando los nombres de métodos correctos
            Usuarios nuevoUsuario = new Usuarios();
            nuevoUsuario.setNombres(nombres);
            nuevoUsuario.setApellidoPaterno(apellidoPaterno);
            nuevoUsuario.setApellidoMaterno(apellidoMaterno);
            nuevoUsuario.setCorreo(correo);
            nuevoUsuario.setContrasenia(contrasenia);
            nuevoUsuario.setRol(rol);
            nuevoUsuario.setActivo(1); // setActivo(2) para usuario 'pendiente' es un deseable

            usuariosDao.registrarUsuario(nuevoUsuario);

            response.sendRedirect(request.getContextPath() + "/UsuariosServlet?msg=success");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filtroUsuarioId = request.getParameter("filtro_usuario_id");
        String buscar = request.getParameter("buscar");
        String filtroRol = request.getParameter("filtro_rol");
        String filtroEstado = request.getParameter("filtro_estado");

        UsuariosDao usuariosDao = new UsuariosDao();

        // 1. Lista COMPLETA para que el <select> siempre tenga a todos los usuarios
        request.setAttribute("listaCompletaUsuarios", usuariosDao.listarUsuarios());

        // 2. Lista FILTRADA para mostrar en la tabla HTML
        java.util.ArrayList<Usuarios> listaFiltrada = usuariosDao.listarUsuariosFiltrados(filtroUsuarioId, buscar, filtroRol, filtroEstado);
        request.setAttribute("listaUsuarios", listaFiltrada);

        // 3. Devolvemos los valores ingresados para que el formulario no se borre al recargar
        request.setAttribute("usuarioActual", filtroUsuarioId);
        request.setAttribute("busquedaActual", buscar);
        request.setAttribute("rolActual", filtroRol);
        request.setAttribute("estadoActual", filtroEstado);

        request.getRequestDispatcher("/views/administrador/GestionUsuarios_administrador.jsp").forward(request, response);
    }
}
