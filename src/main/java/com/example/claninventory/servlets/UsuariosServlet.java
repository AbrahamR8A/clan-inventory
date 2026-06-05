package com.example.claninventory.servlets;

import com.example.claninventory.beans.Usuarios;
import com.example.claninventory.daos.UsuariosDao;
import com.example.claninventory.utils.HashUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // máximo 5 MB por foto
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

            // Procesar foto del modal de edición (opcional)
            Part fotoPart = request.getPart("foto_perfil_editar");
            if (fotoPart != null && fotoPart.getSize() > 0) {
                try (InputStream is = fotoPart.getInputStream()) {
                    usuario.setFotoPerfil(leerBytes(is));
                }
            }

            usuariosDao.actualizarUsuario(usuario);
            response.sendRedirect(request.getContextPath() + "/UsuariosServlet?msg=edit_success");
        } else if ("desactivar".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id_usuario"));
            usuariosDao.desactivarUsuario(id);
            response.sendRedirect(request.getContextPath() + "/UsuariosServlet?msg=deactivate_success");
        } else if ("activar".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id_usuario"));
            usuariosDao.activarUsuario(id);
            response.sendRedirect(request.getContextPath() + "/UsuariosServlet?msg=activate_success");
        } else {
            // Registro de nuevo usuario (aplicamos trim() para limpiar espacios invisibles al inicio y final)
            String nombres = request.getParameter("nombres").trim();
            String apellidoPaterno = request.getParameter("apellido_paterno").trim();
            String apellidoMaterno = request.getParameter("apellido_materno").trim();
            String correo = request.getParameter("correo_electronico").trim();
            String contrasenia = request.getParameter("password").trim();
            String rol = request.getParameter("rol").trim();

            // 2. Llenar el objeto usando los nombres de métodos correctos
            Usuarios nuevoUsuario = new Usuarios();
            nuevoUsuario.setNombres(nombres);
            nuevoUsuario.setApellidoPaterno(apellidoPaterno);
            nuevoUsuario.setApellidoMaterno(apellidoMaterno);
            nuevoUsuario.setCorreo(correo);
            nuevoUsuario.setContrasenia(contrasenia); // Se envía plana, el DAO le pone el salt y el hash
            nuevoUsuario.setRol(rol);
            nuevoUsuario.setActivo(1); // setActivo(2) para usuario 'pendiente' es un deseable

            // Procesar foto de perfil (campo opcional del modal)
            Part fotoPart = request.getPart("foto_perfil");
            if (fotoPart != null && fotoPart.getSize() > 0) {
                try (InputStream is = fotoPart.getInputStream()) {
                    nuevoUsuario.setFotoPerfil(leerBytes(is));
                }
            }

            usuariosDao.registrarUsuario(nuevoUsuario);
            response.sendRedirect(request.getContextPath() + "/UsuariosServlet?msg=success");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Endpoint para servir la foto de un usuario directamente (usada en <img src="...">)
        if ("foto".equals(action)) {
            UsuariosDao usuariosDao = new UsuariosDao();
            int id = Integer.parseInt(request.getParameter("id"));
            byte[] foto = usuariosDao.obtenerFotoPerfil(id);
            if (foto != null && foto.length > 0) {
                response.setContentType("image/jpeg");
                response.setContentLength(foto.length);
                try (OutputStream os = response.getOutputStream()) {
                    os.write(foto);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
            return;
        }

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
    /**
     * Lee todos los bytes de un InputStream.
     * Equivalente a InputStream.readAllBytes() de Java 9+, compatible con Java 8.
     */
    private byte[] leerBytes(InputStream is) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        byte[] chunk = new byte[8192];
        int bytesLeidos;
        while ((bytesLeidos = is.read(chunk)) != -1) {
            buffer.write(chunk, 0, bytesLeidos);
        }
        return buffer.toByteArray();
    }
}
