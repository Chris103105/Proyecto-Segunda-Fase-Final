package com.asistencia.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "asistencia",
        uniqueConstraints = @UniqueConstraint(columnNames = {"id_alumno", "fecha"}),
        indexes = {
                @Index(name = "idx_asistencia_fecha", columnList = "fecha"),
                @Index(name = "idx_asistencia_alumno", columnList = "id_alumno")
        })
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Asistencia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_asistencia")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_alumno", nullable = false)
    private Alumno alumno;

    @ManyToOne
    @JoinColumn(name = "id_estado", nullable = false)
    private EstadoAsistencia estado;

    @Column(nullable = false)
    private LocalDate fecha;

    @Column
    private LocalDateTime registro;

    @PrePersist
    protected void onCreate() {
        if (registro == null) {
            registro = LocalDateTime.now();
        }
    }
}