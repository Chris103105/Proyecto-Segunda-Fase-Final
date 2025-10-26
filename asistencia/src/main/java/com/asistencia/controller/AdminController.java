package com.asistencia.controller;

import com.asistencia.model.*;
import com.asistencia.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AlumnoService alumnoService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private ResponsableService responsableService;

    @Autowired
    private CatalogoService catalogoService;

    // Dashboard del administrador
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null || usuario.getRol() != Usuario.Rol.ADMINISTRADOR) {
            return "redirect:/login";
        }

        model.addAttribute("totalAlumnos", alumnoService.obtenerTodos().size());
        model.addAttribute("totalUsuarios", usuarioService.obtenerTodos().size());
        model.addAttribute("usuario", usuario);
        return "admin/dashboard";
    }

    // ========== GESTIÓN DE ESTUDIANTES ==========

    @GetMapping("/estudiantes")
    public String listarEstudiantes(Model model) {
        model.addAttribute("alumnos", alumnoService.obtenerTodos());
        return "admin/estudiantes/lista";
    }

    @GetMapping("/estudiantes/nuevo")
    public String nuevoEstudianteForm(Model model) {
        model.addAttribute("alumno", new Alumno());
        model.addAttribute("bachilleratos", catalogoService.obtenerBachilleratos());
        model.addAttribute("responsables", responsableService.obtenerTodos());
        return "admin/estudiantes/form";
    }

    @PostMapping("/estudiantes/guardar")
    public String guardarEstudiante(@ModelAttribute Alumno alumno,
                                    @RequestParam Integer idBachillerato,
                                    @RequestParam Integer idSeccion,
                                    @RequestParam Integer idEspecialidad,
                                    @RequestParam Integer idResponsable,
                                    RedirectAttributes redirectAttributes) {
        try {
            // Asignar relaciones
            alumno.setIdBachillerato(idBachillerato);
            alumno.setSeccion(catalogoService.obtenerSecciones().stream()
                    .filter(s -> s.getId().equals(idSeccion))
                    .findFirst().orElse(null));
            alumno.setEspecialidad(catalogoService.obtenerEspecialidades().stream()
                    .filter(e -> e.getId().equals(idEspecialidad))
                    .findFirst().orElse(null));
            alumno.setResponsable(responsableService.obtenerPorId(idResponsable));

            alumnoService.guardar(alumno);
            redirectAttributes.addFlashAttribute("success", "Estudiante guardado exitosamente");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/estudiantes";
    }

    @GetMapping("/estudiantes/editar/{id}")
    public String editarEstudianteForm(@PathVariable Integer id, Model model) {
        Alumno alumno = alumnoService.obtenerPorId(id);
        model.addAttribute("alumno", alumno);
        model.addAttribute("bachilleratos", catalogoService.obtenerBachilleratos());
        model.addAttribute("responsables", responsableService.obtenerTodos());
        return "admin/estudiantes/form";
    }

    @PostMapping("/estudiantes/actualizar")
    public String actualizarEstudiante(@ModelAttribute Alumno alumno,
                                       @RequestParam Integer idBachillerato,
                                       @RequestParam Integer idSeccion,
                                       @RequestParam Integer idEspecialidad,
                                       @RequestParam Integer idResponsable,
                                       RedirectAttributes redirectAttributes) {
        try {
            alumno.setIdBachillerato(idBachillerato);
            alumno.setSeccion(catalogoService.obtenerSecciones().stream()
                    .filter(s -> s.getId().equals(idSeccion))
                    .findFirst().orElse(null));
            alumno.setEspecialidad(catalogoService.obtenerEspecialidades().stream()
                    .filter(e -> e.getId().equals(idEspecialidad))
                    .findFirst().orElse(null));
            alumno.setResponsable(responsableService.obtenerPorId(idResponsable));

            alumnoService.actualizar(alumno);
            redirectAttributes.addFlashAttribute("success", "Estudiante actualizado");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/estudiantes";
    }

    @GetMapping("/estudiantes/eliminar/{id}")
    public String eliminarEstudiante(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            alumnoService.eliminar(id);
            redirectAttributes.addFlashAttribute("success", "Estudiante eliminado");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/estudiantes";
    }

    // ========== GESTIÓN DE USUARIOS ==========

    @GetMapping("/usuarios")
    public String listarUsuarios(Model model) {
        model.addAttribute("usuarios", usuarioService.obtenerTodos());
        return "admin/usuarios/lista";
    }

    @GetMapping("/usuarios/nuevo")
    public String nuevoUsuarioForm(Model model) {
        model.addAttribute("usuario", new Usuario());
        model.addAttribute("roles", Usuario.Rol.values());
        return "admin/usuarios/form";
    }

    @PostMapping("/usuarios/guardar")
    public String guardarUsuario(@ModelAttribute Usuario usuario,
                                 RedirectAttributes redirectAttributes) {
        try {
            usuarioService.guardar(usuario);
            redirectAttributes.addFlashAttribute("success", "Usuario creado exitosamente");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/usuarios";
    }

    @GetMapping("/usuarios/editar/{id}")
    public String editarUsuarioForm(@PathVariable Integer id, Model model) {
        Usuario usuario = usuarioService.obtenerPorId(id);
        model.addAttribute("usuario", usuario);
        model.addAttribute("roles", Usuario.Rol.values());
        return "admin/usuarios/form";
    }

    @PostMapping("/usuarios/actualizar")
    public String actualizarUsuario(@ModelAttribute Usuario usuario,
                                    RedirectAttributes redirectAttributes) {
        try {
            usuarioService.actualizar(usuario);
            redirectAttributes.addFlashAttribute("success", "Usuario actualizado");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/usuarios";
    }

    @GetMapping("/usuarios/eliminar/{id}")
    public String eliminarUsuario(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            usuarioService.eliminar(id);
            redirectAttributes.addFlashAttribute("success", "Usuario eliminado");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/usuarios";
    }

    // ========== GESTIÓN DE RESPONSABLES ==========

    @GetMapping("/responsables")
    public String listarResponsables(Model model) {
        model.addAttribute("responsables", responsableService.obtenerTodos());
        return "admin/responsables/lista";
    }

    @GetMapping("/responsables/nuevo")
    public String nuevoResponsableForm(Model model) {
        model.addAttribute("responsable", new Responsable());
        return "admin/responsables/form";
    }

    @PostMapping("/responsables/guardar")
    public String guardarResponsable(@ModelAttribute Responsable responsable,
                                     RedirectAttributes redirectAttributes) {
        try {
            responsableService.guardar(responsable);
            redirectAttributes.addFlashAttribute("success", "Responsable guardado");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/responsables";
    }

    @GetMapping("/responsables/editar/{id}")
    public String editarResponsableForm(@PathVariable Integer id, Model model) {
        model.addAttribute("responsable", responsableService.obtenerPorId(id));
        return "admin/responsables/form";
    }

    @PostMapping("/responsables/actualizar")
    public String actualizarResponsable(@ModelAttribute Responsable responsable,
                                        RedirectAttributes redirectAttributes) {
        try {
            responsableService.actualizar(responsable);
            redirectAttributes.addFlashAttribute("success", "Responsable actualizado");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/responsables";
    }

    @GetMapping("/responsables/eliminar/{id}")
    public String eliminarResponsable(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            responsableService.eliminar(id);
            redirectAttributes.addFlashAttribute("success", "Responsable eliminado");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/admin/responsables";
    }

    // ========== GESTIÓN DE CATÁLOGOS ==========

    @GetMapping("/catalogos")
    public String gestionarCatalogos(Model model) {
        model.addAttribute("bachilleratos", catalogoService.obtenerBachilleratos());
        model.addAttribute("secciones", catalogoService.obtenerSecciones());
        model.addAttribute("especialidades", catalogoService.obtenerEspecialidades());
        return "admin/catalogos";
    }
}
