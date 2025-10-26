package com.asistencia.config;

import com.asistencia.model.Usuario;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class SessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();

        // Permitir acceso sin login a estas rutas
        if (uri.contains("/login") || uri.contains("/css") || uri.contains("/js") || uri.contains("/images")) {
            return true;
        }

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        // Si no hay usuario en sesión y no está en login, redirigir
        if (usuario == null && !uri.contains("/login")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // Verificar permisos de administrador
        if (uri.contains("/admin/") && usuario != null) {
            if (usuario.getRol() != Usuario.Rol.ADMINISTRADOR) {
                response.sendRedirect(request.getContextPath() + "/profesor/dashboard");
                return false;
            }
        }

        return true;
    }
}
