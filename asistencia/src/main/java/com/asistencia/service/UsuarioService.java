package com.asistencia.service;

import com.asistencia.model.Usuario;
import com.asistencia.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepo;

    // Obtener todos los usuarios
    public List<Usuario> obtenerTodos() {
        return usuarioRepo.findAll();
    }

    // Obtener usuario por ID
    public Usuario obtenerPorId(Integer id) {
        return usuarioRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    }

    // Obtener usuario por email
    public Usuario obtenerPorEmail(String email) {
        return usuarioRepo.findByEmail(email).orElse(null);
    }

    // Guardar usuario
    public Usuario guardar(Usuario usuario) {
        if (usuarioRepo.existsByEmail(usuario.getEmail())) {
            throw new RuntimeException("El email ya está registrado");
        }
        return usuarioRepo.save(usuario);
    }

    // Actualizar usuario
    public Usuario actualizar(Usuario usuario) {
        if (!usuarioRepo.existsById(usuario.getId())) {
            throw new RuntimeException("Usuario no encontrado");
        }
        return usuarioRepo.save(usuario);
    }

    // Eliminar usuario
    public void eliminar(Integer id) {
        usuarioRepo.deleteById(id);
    }
}