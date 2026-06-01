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
 *  ingresar sus credenciales después de cerrar sesión.
 */
@WebFilter(filterName = "SesionFilter", urlPatterns = {"/*"})
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

        // Sesión válida: dejamos pasar la petición
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
}
