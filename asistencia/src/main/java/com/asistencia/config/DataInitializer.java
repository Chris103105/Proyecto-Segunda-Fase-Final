package com.asistencia.config;

import com.asistencia.model.*;
import com.asistencia.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private EstadoAsistenciaRepository estadoRepo;

    @Override
    public void run(String... args) throws Exception {
        // Inicializar estados de asistencia si no existen
        if (estadoRepo.count() == 0) {
            EstadoAsistencia presente = new EstadoAsistencia();
            presente.setId(1);
            presente.setEstado(EstadoAsistencia.Estado.Presente);
            estadoRepo.save(presente);

            EstadoAsistencia ausente = new EstadoAsistencia();
            ausente.setId(2);
            ausente.setEstado(EstadoAsistencia.Estado.Ausente);
            estadoRepo.save(ausente);

            EstadoAsistencia tarde = new EstadoAsistencia();
            tarde.setId(3);
            tarde.setEstado(EstadoAsistencia.Estado.Tarde);
            estadoRepo.save(tarde);

            EstadoAsistencia justificado = new EstadoAsistencia();
            justificado.setId(4);
            justificado.setEstado(EstadoAsistencia.Estado.Justificado);
            estadoRepo.save(justificado);

            System.out.println("✅ Estados de asistencia inicializados correctamente");
        } else {
            System.out.println("✅ Estados de asistencia ya existen en la base de datos");
        }
    }
}