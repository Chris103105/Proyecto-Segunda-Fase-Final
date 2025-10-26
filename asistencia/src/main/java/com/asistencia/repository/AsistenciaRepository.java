package com.asistencia.repository;

import com.asistencia.model.Asistencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AsistenciaRepository extends JpaRepository<Asistencia, Integer> {
    List<Asistencia> findByFecha(LocalDate fecha);
    List<Asistencia> findByAlumnoId(Integer alumnoId);
    Optional<Asistencia> findByAlumnoIdAndFecha(Integer alumnoId, LocalDate fecha);

    @Query("SELECT a FROM Asistencia a WHERE a.fecha BETWEEN :inicio AND :fin")
    List<Asistencia> findByFechaBetween(
            @Param("inicio") LocalDate inicio,
            @Param("fin") LocalDate fin
    );

    @Query("SELECT a FROM Asistencia a WHERE a.alumno.id = :alumnoId " +
            "AND a.fecha BETWEEN :inicio AND :fin")
    List<Asistencia> findByAlumnoAndFechaBetween(
            @Param("alumnoId") Integer alumnoId,
            @Param("inicio") LocalDate inicio,
            @Param("fin") LocalDate fin
    );

    @Query("SELECT a FROM Asistencia a WHERE a.alumno.seccion.id = :seccionId " +
            "AND a.fecha = :fecha")
    List<Asistencia> findBySeccionAndFecha(
            @Param("seccionId") Integer seccionId,
            @Param("fecha") LocalDate fecha
    );

    @Query("SELECT COUNT(a) FROM Asistencia a WHERE a.alumno.id = :alumnoId " +
            "AND a.estado.estado = :estado AND a.fecha BETWEEN :inicio AND :fin")
    Long contarPorEstado(
            @Param("alumnoId") Integer alumnoId,
            @Param("estado") com.asistencia.model.EstadoAsistencia.Estado estado,
            @Param("inicio") LocalDate inicio,
            @Param("fin") LocalDate fin
    );
}