package com.asistencia.service;

import com.asistencia.model.*;
import com.asistencia.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class CatalogoService {

    @Autowired
    private BachilleratoRepository bachilleratoRepo;

    @Autowired
    private SeccionRepository seccionRepo;

    @Autowired
    private EspecialidadRepository especialidadRepo;

    @Autowired
    private EstadoAsistenciaRepository estadoRepo;

    // Bachilleratos
    public List<Bachillerato> obtenerBachilleratos() {
        return bachilleratoRepo.findAll();
    }

    public Bachillerato guardarBachillerato(Bachillerato bachillerato) {
        return bachilleratoRepo.save(bachillerato);
    }

    // Secciones
    public List<Seccion> obtenerSecciones() {
        return seccionRepo.findAll();
    }

    public List<Seccion> obtenerSeccionesPorBachillerato(Integer bachilleratoId) {
        return seccionRepo.findByBachilleratoId(bachilleratoId);
    }

    public Seccion guardarSeccion(Seccion seccion) {
        return seccionRepo.save(seccion);
    }

    // Especialidades
    public List<Especialidad> obtenerEspecialidades() {
        return especialidadRepo.findAll();
    }

    public List<Especialidad> obtenerEspecialidadesPorBachillerato(Integer bachilleratoId) {
        return especialidadRepo.findByBachilleratoId(bachilleratoId);
    }

    public Especialidad guardarEspecialidad(Especialidad especialidad) {
        return especialidadRepo.save(especialidad);
    }

    // Estados de asistencia
    public List<EstadoAsistencia> obtenerEstados() {
        return estadoRepo.findAll();
    }
}
