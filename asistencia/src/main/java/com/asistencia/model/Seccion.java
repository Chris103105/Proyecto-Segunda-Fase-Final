package com.asistencia.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "seccion", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"nombre", "id_bachillerato"})
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Seccion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_seccion")
    private Integer id;

    @Column(nullable = false, length = 50)
    private String nombre;

    @ManyToOne
    @JoinColumn(name = "id_bachillerato", nullable = false)
    @JsonIgnoreProperties({"secciones", "especialidades"}) // 👈 Evita recursión inversa
    private Bachillerato bachillerato;
}
