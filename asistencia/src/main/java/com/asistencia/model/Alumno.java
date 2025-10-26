package com.asistencia.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "alumno")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Alumno {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_alumno")
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(nullable = false, length = 100)
    private String apellido;

    @Column(name = "id_bachillerato", nullable = false)
    private Integer idBachillerato;

    @ManyToOne
    @JoinColumn(name = "id_seccion", nullable = false)
    private Seccion seccion;

    @ManyToOne
    @JoinColumn(name = "id_especialidad", nullable = false)
    private Especialidad especialidad;

    @ManyToOne
    @JoinColumn(name = "id_responsable", nullable = false)
    private Responsable responsable;

    @Transient
    public String getNombreCompleto() {
        return nombre + " " + apellido;
    }
}