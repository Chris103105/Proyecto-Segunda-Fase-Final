package com.asistencia.repository;

import com.asistencia.model.Alumno;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AlumnoRepository extends JpaRepository<Alumno, Integer> {
    List<Alumno> findBySeccionId(Integer seccionId);
    List<Alumno> findByEspecialidadId(Integer especialidadId);
    List<Alumno> findByIdBachillerato(Integer bachilleratoId);

    @Query("SELECT a FROM Alumno a WHERE a.idBachillerato = :bachilleratoId " +
            "AND a.seccion.id = :seccionId AND a.especialidad.id = :especialidadId")
    List<Alumno> findByBachilleratoSeccionEspecialidad(
            @Param("bachilleratoId") Integer bachilleratoId,
            @Param("seccionId") Integer seccionId,
            @Param("especialidadId") Integer especialidadId
    );

    @Query("SELECT a FROM Alumno a WHERE " +
            "LOWER(a.nombre) LIKE LOWER(CONCAT('%', :busqueda, '%')) OR " +
            "LOWER(a.apellido) LIKE LOWER(CONCAT('%', :busqueda, '%'))")
    List<Alumno> buscarPorNombre(@Param("busqueda") String busqueda);
}