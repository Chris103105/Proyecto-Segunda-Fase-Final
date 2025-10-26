// AsistenciaReporteDTO.java
package com.asistencia.dto;

import com.asistencia.model.Asistencia;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
// Lombok imports assumed: @Data, @NoArgsConstructor, @AllArgsConstructor

public class AsistenciaReporteDTO {
    private final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm:ss");

    private Integer id;
    private String nombreAlumno;
    private String bachillerato;
    private String seccion;
    private String especialidad;
    private String fecha;
    private String estado;
    private String horaRegistro;

    public AsistenciaReporteDTO(Asistencia asist) {
        this.id = asist.getId();
        this.nombreAlumno = asist.getAlumno().getNombreCompleto();

        // Es CRUCIAL que el repositorio haya cargado estos datos con JOIN FETCH
        this.bachillerato = asist.getAlumno().getSeccion().getBachillerato().getNombre();
        this.seccion = asist.getAlumno().getSeccion().getNombre();
        this.especialidad = asist.getAlumno().getEspecialidad().getNombre();

        this.fecha = asist.getFecha().format(DATE_FORMATTER);
        this.estado = asist.getEstado().getEstado().name();
        this.horaRegistro = asist.getRegistro() != null ? asist.getRegistro().format(TIME_FORMATTER) : "N/A";
    }

    // (Getters y setters deben estar aquí, si no usas Lombok)
}