package com.asistencia.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.util.List;

@Entity
@Table(name = "bachillerato")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Bachillerato {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_bachillerato")
    private Integer id;

    @Column(nullable = false, unique = true, length = 50)
    private String nombre;

    @OneToMany(mappedBy = "bachillerato")
    @JsonIgnore  // 🚫 Evita recursión infinita
    private List<Seccion> secciones;

    @OneToMany(mappedBy = "bachillerato")
    @JsonIgnore  // 🚫 Evita recursión infinita
    private List<Especialidad> especialidades;
}
