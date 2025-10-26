package com.asistencia.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "estado_asistencia")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EstadoAsistencia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_estado")
    private Integer id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, unique = true)
    private Estado estado;

    public enum Estado {
        Presente, Ausente, Tarde, Justificado
    }
}
