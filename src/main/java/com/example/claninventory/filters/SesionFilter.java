package com.example.claninventory.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filtro de sesión y caché para CLAN INVENTORY.
 *
 *  Para cada petición:
 *   1. Si la URL es pública (login, registro, recursos estáticos),
 *      deja pasar la petición sin más.
 *   2. Si la URL es privada (cualquier servlet o JSP de las vistas):
 *      a) Pone cabeceras anti-caché para que el navegador no guarde
 *         la página en caché. Esto bloquea el botón "atrás" después
 *         de cerrar sesión.
 *      b) Verifica que exista una sesión válida con un usuario logueado.
 *         Si no hay sesión, redirige a login.jsp.
 *
 *  Junto con el LogoutServlet, esto fuerza al usuario a volver a
 *  Junto con el LogoutServlet, esto fuerza al usuario a volver a
 *  ingresar sus credenciales después de cerrar sesión.
 */
@WebFilter(filterName = "SesionFilter", urlPatterns = {"/*"}, dispatcherTypes = {jakarta.servlet.DispatcherType.REQUEST, jakarta.servlet.DispatcherType.FORWARD})
public class SesionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // Ruta relativa al contexto de la app (ej: "/InicioAdminServlet")
        String path = request.getRequestURI().substring(request.getContextPath().length());

        // ── 1. Rutas públicas (no requieren sesión) ──────────────────────────
        if (esRutaPublica(path)) {
            chain.doFilter(req, res);
            return;
        }

        // ── 2. Anti-caché para todas las páginas privadas ────────────────────
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // ── 3. Verificar sesión activa ───────────────────────────────────────
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ── 4. Verificar permisos (Control de Acceso por Roles) ──────────────
        String rol = (String) session.getAttribute("rol");
        if (rol == null) rol = "";

        if (!tienePermiso(rol, path)) {
            // Si intenta entrar a una vista/servlet que no es de su rol, lo redirigimos a su inicio correspondiente
            response.sendRedirect(request.getContextPath() + destinoPorRol(rol));
            return;
        }

        // Sesión válida y con permisos: dejamos pasar la petición
        chain.doFilter(req, res);
    }

    /**
     * Define qué rutas son públicas y no requieren sesión activa.
     * Cualquier ruta que no esté en esta lista exige login.
     */
    private boolean esRutaPublica(String path) {
        if (path == null || path.isEmpty()) return true;

        // Página de bienvenida y formularios de autenticación
        if (path.equals("/")
                || path.equals("/index.jsp")
                || path.equals("/login.jsp")
                || path.equals("/register.jsp")
                || path.equals("/forgot-password.jsp")
                || path.equals("/LoginServlet")
                || path.equals("/LogoutServlet")
                || path.equals("/RegistrarUsuarioServlet")) {
            return true;
        }

        // Recursos estáticos (CSS, JS, imágenes, fuentes, librerías)
        if (path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/img/")
                || path.startsWith("/vendor/")
                || path.startsWith("/scss/")
                || path.startsWith("/favicon")) {
            return true;
        }

        return false;
    }

    /**
     * Verifica si el rol actual tiene permiso para acceder a la ruta solicitada.
     */
    private boolean tienePermiso(String rol, String path) {
        // 0. Vistas globales para todos los roles
        if (path.equals("/PerfilServlet") || path.equals("/perfil.jsp")) return true;

        // 1. Bloqueo de carpetas de vistas exclusivas (por si intentan entrar directo al JSP)
        if (path.startsWith("/views/administrador/") && !(rol.equals("administrador") || rol.equals("superadmin"))) return false;
        if (path.startsWith("/views/coordinador/") && !rol.equals("coordinador")) return false;
        if (path.startsWith("/views/deposito/") && !rol.equals("encargado_deposito")) return false;
        if (path.startsWith("/views/solicitante/") && !rol.equals("solicitante")) return false;

        // 2. Bloqueo estricto de Servlets por rol
        // ADMIN / SUPERADMIN
        if ((path.equals("/InicioAdminServlet") || path.equals("/UsuariosServlet") || path.equals("/ReportesServlet")) 
            && !(rol.equals("administrador") || rol.equals("superadmin"))) {
            return false;
        }

        // COORDINADOR
        if (path.equals("/InicioCoordinadorServlet") && !rol.equals("coordinador")) {
            return false;
        }

        // ENCARGADO DE DEPOSITO
        if ((path.equals("/InicioDepositoServlet") || path.equals("/DetalleSolicitudDepositoServlet") || path.equals("/RegistroSalidaServlet")) 
            && !rol.equals("encargado_deposito")) {
            return false;
        }

        // SOLICITANTE
        if ((path.equals("/InicioSolicitanteServlet") || path.equals("/NuevaSolicitudSolicitanteServlet") || 
             path.equals("/ProcesoSolicitudSolicitanteServlet") || path.equals("/DetalleSolicitudSolicitanteServlet")) 
            && !rol.equals("solicitante")) {
            return false;
        }

        // COMPARTIDOS: ADMIN + COORDINADOR
        if (path.equals("/ProductosServlet") && !(rol.equals("administrador") || rol.equals("superadmin") || rol.equals("coordinador"))) {
            return false;
        }

        // COMPARTIDOS: ADMIN + COORDINADOR + DEPOSITO
        if (path.equals("/OrdenIngresoServlet") && !(rol.equals("administrador") || rol.equals("superadmin") || rol.equals("coordinador") || rol.equals("encargado_deposito"))) {
            return false;
        }

        return true;
    }

    /**
     * Devuelve la URL del Inicio correspondiente al rol indicado.
     */
    private String destinoPorRol(String rol) {
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
