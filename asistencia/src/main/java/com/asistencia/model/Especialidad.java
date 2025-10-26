package com.asistencia.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "especialidad", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"nombre", "id_bachillerato"})
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Especialidad {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_especialidad")
    private Integer id;

    @Column(nullable = false, length = 50)
    private String nombre;

    @ManyToOne
    @JoinColumn(name = "id_bachillerato", nullable = false)
    @JsonIgnoreProperties({"secciones", "especialidades"}) // 👈 Evita recursión
    private Bachillerato bachillerato;
}
