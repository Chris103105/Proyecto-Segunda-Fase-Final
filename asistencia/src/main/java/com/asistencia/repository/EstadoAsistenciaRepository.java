package com.asistencia.repository;

import com.asistencia.model.EstadoAsistencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface EstadoAsistenciaRepository extends JpaRepository<EstadoAsistencia, Integer> {
    Optional<EstadoAsistencia> findByEstado(EstadoAsistencia.Estado estado);
}
