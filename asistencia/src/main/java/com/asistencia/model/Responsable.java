package com.asistencia.model;

import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "responsable")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Responsable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_responsable")
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(nullable = false, length = 100)
    private String apellido;

    @Column(nullable = false, unique = true, length = 255)
    private String correo;

    @Column(length = 15)
    private String telefono;
}
