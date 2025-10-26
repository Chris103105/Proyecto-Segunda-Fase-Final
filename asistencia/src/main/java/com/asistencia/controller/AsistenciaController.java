package com.asistencia.controller;

import com.asistencia.model.*;
import com.asistencia.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

@Controller
@RequestMapping("/profesor")
public class AsistenciaController {

    @Autowired
    private AsistenciaService asistenciaService;

    @Autowired
    private AlumnoService alumnoService;

    @Autowired
    private CatalogoService catalogoService;

    // ===================== DASHBOARD =====================
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) return "redirect:/login";
        model.addAttribute("usuario", usuario);
        return "profesor/dashboard";
    }

    // ===================== API COMBOS =====================
    @GetMapping("/api/secciones")
    @ResponseBody
    public List<Seccion> obtenerSeccionesPorBachillerato(@RequestParam Integer bachilleratoId) {
        return catalogoService.obtenerSeccionesPorBachillerato(bachilleratoId);
    }

    @GetMapping("/api/especialidades")
    @ResponseBody
    public List<Especialidad> obtenerEspecialidadesPorBachillerato(@RequestParam Integer bachilleratoId) {
        return catalogoService.obtenerEspecialidadesPorBachillerato(bachilleratoId);
    }

    // ===================== TOMAR ASISTENCIA =====================
    @GetMapping("/asistencia/tomar")
    public String tomarAsistenciaForm(Model model) {
        model.addAttribute("bachilleratos", catalogoService.obtenerBachilleratos());
        model.addAttribute("secciones", catalogoService.obtenerSecciones());
        model.addAttribute("especialidades", catalogoService.obtenerEspecialidades());
        model.addAttribute("fecha", LocalDate.now());
        return "profesor/tomar-asistencia";
    }

    @GetMapping("/asistencia/alumnos")
    @ResponseBody
    public List<Alumno> obtenerAlumnosPorFiltros(
            @RequestParam(required = false) Integer bachilleratoId,
            @RequestParam(required = false) Integer seccionId,
            @RequestParam(required = false) Integer especialidadId) {

        return alumnoService.obtenerPorFiltros(bachilleratoId, seccionId, especialidadId);
    }

    @PostMapping("/asistencia/guardar")
    public String guardarAsistencia(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha,
                                    @RequestParam Map<String, String> params,
                                    RedirectAttributes redirectAttributes) {
        Map<Integer, Integer> asistenciaMap = new HashMap<>();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (entry.getKey().startsWith("alumno_")) {
                Integer alumnoId = Integer.parseInt(entry.getKey().replace("alumno_", ""));
                Integer estadoId = Integer.parseInt(entry.getValue());
                asistenciaMap.put(alumnoId, estadoId);
            }
        }
        asistenciaService.tomarAsistencia(asistenciaMap, fecha);
        redirectAttributes.addFlashAttribute("success", "Asistencia registrada para " + asistenciaMap.size() + " alumnos.");
        return "redirect:/profesor/asistencia/tomar";
    }

    // ===================== VER ASISTENCIA =====================
    @GetMapping("/asistencia/ver")
    public String verAsistencia(@RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha,
                                @RequestParam(required = false) Integer seccionId,
                                Model model) {
        if (fecha == null) fecha = LocalDate.now();
        List<Asistencia> asistencias = (seccionId != null)
                ? asistenciaService.obtenerPorSeccionYFecha(seccionId, fecha)
                : asistenciaService.obtenerPorFecha(fecha);

        model.addAttribute("asistencias", asistencias);
        model.addAttribute("fecha", fecha);
        model.addAttribute("secciones", catalogoService.obtenerSecciones());
        model.addAttribute("seccionId", seccionId);
        return "profesor/ver-asistencia";
    }

    // ===================== EDITAR ASISTENCIA =====================
    @GetMapping("/asistencia/editar")
    public String editarAsistenciaForm(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha,
            @RequestParam(required = false) Integer seccionId,
            Model model) {

        if (fecha == null) fecha = LocalDate.now();

        List<Asistencia> asistencias = (seccionId != null)
                ? asistenciaService.obtenerPorSeccionYFecha(seccionId, fecha)
                : asistenciaService.obtenerPorFecha(fecha);

        // Para JSP, enviar fecha como java.util.Date
        model.addAttribute("asistencias", asistencias);
        model.addAttribute("fecha", Date.from(fecha.atStartOfDay(ZoneId.systemDefault()).toInstant()));
        model.addAttribute("estados", catalogoService.obtenerEstados());
        model.addAttribute("secciones", catalogoService.obtenerSecciones());
        model.addAttribute("seccionId", seccionId);
        return "profesor/editar-asistencia";
    }

    @PostMapping("/asistencia/actualizar")
    public String actualizarAsistencia(
            @RequestParam Long asistenciaId,
            @RequestParam Integer estadoId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha,
            @RequestParam(required = false) Integer seccionId,
            RedirectAttributes redirectAttrs) {

        // Actualizar la asistencia
        asistenciaService.actualizarAsistencia(asistenciaId.intValue(), estadoId);
        redirectAttrs.addFlashAttribute("success", "✅ Estado de asistencia actualizado.");

        // Redirigir a la misma página de edición con la misma fecha y sección
        if (fecha != null && seccionId != null) {
            return "redirect:/profesor/asistencia/editar?fecha=" + fecha + "&seccionId=" + seccionId;
        } else if (fecha != null) {
            return "redirect:/profesor/asistencia/editar?fecha=" + fecha;
        } else {
            return "redirect:/profesor/asistencia/editar";
        }
    }

    // ===================== ESTUDIANTES =====================
    @GetMapping("/estudiantes")
    public String verEstudiantes(@RequestParam(required = false) String busqueda,
                                 @RequestParam(required = false) Integer seccionId,
                                 Model model) {
        List<Alumno> alumnos;
        if (busqueda != null && !busqueda.isEmpty()) {
            alumnos = alumnoService.buscarPorNombre(busqueda);
        } else if (seccionId != null) {
            alumnos = alumnoService.obtenerPorSeccion(seccionId);
        } else {
            alumnos = alumnoService.obtenerTodos();
        }
        model.addAttribute("alumnos", alumnos);
        model.addAttribute("secciones", catalogoService.obtenerSecciones());
        return "profesor/estudiantes";
    }

    @GetMapping("/estudiante/{id}/historial")
    public String verHistorialEstudiante(@PathVariable Integer id,
                                         @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
                                         @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fin,
                                         Model model) {

        Alumno alumno = alumnoService.obtenerPorId(id);
        if (inicio == null) inicio = LocalDate.now().minusMonths(1);
        if (fin == null) fin = LocalDate.now();

        List<Asistencia> historial = asistenciaService.obtenerPorRangoFechas(inicio, fin);
        historial.removeIf(a -> !a.getAlumno().getId().equals(id));

        Map<String, Long> estadisticas = asistenciaService.obtenerEstadisticas(id, inicio, fin);

        // 🔹 Convertir LocalDate a java.util.Date para el JSP
        Date inicioDate = Date.from(inicio.atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date finDate = Date.from(fin.atStartOfDay(ZoneId.systemDefault()).toInstant());

        model.addAttribute("alumno", alumno);
        model.addAttribute("historial", historial);
        model.addAttribute("estadisticas", estadisticas);
        model.addAttribute("inicio", inicioDate); // ahora java.util.Date
        model.addAttribute("fin", finDate);       // ahora java.util.Date

        return "profesor/historial-estudiante";
    }
}