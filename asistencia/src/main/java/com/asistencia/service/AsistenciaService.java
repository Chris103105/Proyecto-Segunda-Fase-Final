package com.asistencia.service;

import com.asistencia.model.*;
import com.asistencia.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.util.*;

@Service
@Transactional
public class AsistenciaService {

    @Autowired
    private AsistenciaRepository asistenciaRepo;

    @Autowired
    private AlumnoRepository alumnoRepo;

    @Autowired
    private EstadoAsistenciaRepository estadoRepo;

    // Tomar asistencia para una lista de alumnos
    public void tomarAsistencia(Map<Integer, Integer> asistenciaMap, LocalDate fecha) {
        for (Map.Entry<Integer, Integer> entry : asistenciaMap.entrySet()) {
            Integer alumnoId = entry.getKey();
            Integer estadoId = entry.getValue();

            Alumno alumno = alumnoRepo.findById(alumnoId)
                    .orElseThrow(() -> new RuntimeException("Alumno no encontrado"));

            EstadoAsistencia estado = estadoRepo.findById(estadoId)
                    .orElseThrow(() -> new RuntimeException("Estado no encontrado"));

            // Verificar si ya existe asistencia para ese día
            Optional<Asistencia> existente = asistenciaRepo.findByAlumnoIdAndFecha(alumnoId, fecha);

            if (existente.isPresent()) {
                // Actualizar
                Asistencia asist = existente.get();
                asist.setEstado(estado);
                asistenciaRepo.save(asist);
            } else {
                // Crear nueva
                Asistencia asist = new Asistencia();
                asist.setAlumno(alumno);
                asist.setEstado(estado);
                asist.setFecha(fecha);
                asistenciaRepo.save(asist);
            }
        }
    }

    // Obtener asistencia por fecha
    public List<Asistencia> obtenerPorFecha(LocalDate fecha) {
        return asistenciaRepo.findByFecha(fecha);
    }

    // Obtener asistencia por alumno
    public List<Asistencia> obtenerPorAlumno(Integer alumnoId) {
        return asistenciaRepo.findByAlumnoId(alumnoId);
    }

    // Obtener asistencia por rango de fechas
    public List<Asistencia> obtenerPorRangoFechas(LocalDate inicio, LocalDate fin) {
        return asistenciaRepo.findByFechaBetween(inicio, fin);
    }

    // Actualizar asistencia
    public void actualizarAsistencia(Integer asistenciaId, Integer estadoId) {
        Asistencia asist = asistenciaRepo.findById(asistenciaId)
                .orElseThrow(() -> new RuntimeException("Asistencia no encontrada"));

        EstadoAsistencia estado = estadoRepo.findById(estadoId)
                .orElseThrow(() -> new RuntimeException("Estado no encontrado"));

        asist.setEstado(estado);
        asistenciaRepo.save(asist);
    }

    // Estadísticas de asistencia por alumno
    public Map<String, Long> obtenerEstadisticas(Integer alumnoId, LocalDate inicio, LocalDate fin) {
        Map<String, Long> stats = new HashMap<>();

        stats.put("presente", asistenciaRepo.contarPorEstado(
                alumnoId, EstadoAsistencia.Estado.Presente, inicio, fin));
        stats.put("ausente", asistenciaRepo.contarPorEstado(
                alumnoId, EstadoAsistencia.Estado.Ausente, inicio, fin));
        stats.put("tarde", asistenciaRepo.contarPorEstado(
                alumnoId, EstadoAsistencia.Estado.Tarde, inicio, fin));
        stats.put("justificado", asistenciaRepo.contarPorEstado(
                alumnoId, EstadoAsistencia.Estado.Justificado, inicio, fin));

        return stats;
    }

    // Obtener asistencia por sección y fecha
    public List<Asistencia> obtenerPorSeccionYFecha(Integer seccionId, LocalDate fecha) {
        return asistenciaRepo.findBySeccionAndFecha(seccionId, fecha);
    }
}
