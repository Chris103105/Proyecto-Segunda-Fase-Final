package com.asistencia.repository;

import com.asistencia.model.Responsable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface ResponsableRepository extends JpaRepository<Responsable, Integer> {
    Optional<Responsable> findByCorreo(String correo);
    boolean existsByCorreo(String correo);
}
