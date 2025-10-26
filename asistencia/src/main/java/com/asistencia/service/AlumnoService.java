package com.asistencia.service;


import com.asistencia.model.Alumno;
import com.asistencia.model.Responsable;
import com.asistencia.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class AlumnoService {

    @Autowired
    private AlumnoRepository alumnoRepo;

    @Autowired
    private ResponsableRepository responsableRepo;

    @Autowired
    private SeccionRepository seccionRepo;

    @Autowired
    private EspecialidadRepository especialidadRepo;

    // Obtener todos los alumnos
    public List<Alumno> obtenerTodos() {
        return alumnoRepo.findAll();
    }

    // Obtener alumno por ID
    public Alumno obtenerPorId(Integer id) {
        return alumnoRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Alumno no encontrado"));
    }

    // Guardar alumno
    public Alumno guardar(Alumno alumno) {
        return alumnoRepo.save(alumno);
    }

    // Actualizar alumno
    public Alumno actualizar(Alumno alumno) {
        if (!alumnoRepo.existsById(alumno.getId())) {
            throw new RuntimeException("Alumno no encontrado");
        }
        return alumnoRepo.save(alumno);
    }

    // Eliminar alumno
    public void eliminar(Integer id) {
        alumnoRepo.deleteById(id);
    }

    // Buscar alumnos por nombre
    public List<Alumno> buscarPorNombre(String nombre) {
        return alumnoRepo.buscarPorNombre(nombre);
    }

    // Obtener alumnos por sección
    public List<Alumno> obtenerPorSeccion(Integer seccionId) {
        return alumnoRepo.findBySeccionId(seccionId);
    }

    // Obtener alumnos por filtros
    public List<Alumno> obtenerPorFiltros(Integer bachilleratoId, Integer seccionId, Integer especialidadId) {
        if (bachilleratoId != null && seccionId != null && especialidadId != null) {
            return alumnoRepo.findByBachilleratoSeccionEspecialidad(bachilleratoId, seccionId, especialidadId);
        } else if (seccionId != null) {
            return alumnoRepo.findBySeccionId(seccionId);
        } else if (especialidadId != null) {
            return alumnoRepo.findByEspecialidadId(especialidadId);
        } else if (bachilleratoId != null) {
            return alumnoRepo.findByIdBachillerato(bachilleratoId);
        }
        return alumnoRepo.findAll();
    }
}
