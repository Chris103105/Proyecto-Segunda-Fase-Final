package com.asistencia.controller;

import com.asistencia.model.Usuario;
import com.asistencia.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class HomeController {

    @Autowired
    private UsuarioService usuarioService;

    // Página de inicio - Login
    @GetMapping("/")
    public String index(HttpSession session) {
        // Si ya tiene sesión, redirigir al dashboard correspondiente
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario != null) {
            if (usuario.getRol() == Usuario.Rol.ADMINISTRADOR) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/profesor/dashboard";
            }
        }
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login(HttpSession session) {
        // Si ya está logueado, redirigir a su dashboard
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario != null) {
            if (usuario.getRol() == Usuario.Rol.ADMINISTRADOR) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/profesor/dashboard";
            }
        }
        return "login";
    }

    @PostMapping("/login")
    public String autenticar(@RequestParam String email,
                             @RequestParam(required = false) String password,
                             HttpSession session,
                             Model model) {
        try {
            System.out.println("🔐 Intentando login con email: " + email);

            Usuario usuario = usuarioService.obtenerPorEmail(email);

            if (usuario != null) {
                System.out.println("✅ Usuario encontrado: " + usuario.getNombre() + " - Rol: " + usuario.getRol());

                // Guardar usuario en sesión
                session.setAttribute("usuario", usuario);
                session.setAttribute("rol", usuario.getRol().name());
                session.setMaxInactiveInterval(3600); // 1 hora

                // Redirigir según rol
                if (usuario.getRol() == Usuario.Rol.ADMINISTRADOR) {
                    System.out.println("➡️ Redirigiendo a /admin/dashboard");
                    return "redirect:/admin/dashboard";
                } else {
                    System.out.println("➡️ Redirigiendo a /profesor/dashboard");
                    return "redirect:/profesor/dashboard";
                }
            } else {
                System.out.println("❌ Usuario no encontrado con email: " + email);
                model.addAttribute("error", "Usuario no encontrado. Verifica tu correo electrónico.");
                return "login";
            }
        } catch (Exception e) {
            System.out.println("❌ Error en login: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error al iniciar sesión: " + e.getMessage());
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        System.out.println("🚪 Cerrando sesión");
        session.invalidate();
        return "redirect:/login?logout";
    }
}