package com.asistencia.repository;

import com.asistencia.model.Bachillerato;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface BachilleratoRepository extends JpaRepository<Bachillerato, Integer> {
    Optional<Bachillerato> findByNombre(String nombre);
}