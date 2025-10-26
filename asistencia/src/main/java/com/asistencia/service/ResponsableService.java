package com.asistencia.service;

import com.asistencia.model.Responsable;
import com.asistencia.repository.ResponsableRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class ResponsableService {

    @Autowired
    private ResponsableRepository responsableRepo;

    public List<Responsable> obtenerTodos() {
        return responsableRepo.findAll();
    }

    public Responsable obtenerPorId(Integer id) {
        return responsableRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Responsable no encontrado"));
    }

    public Responsable guardar(Responsable responsable) {
        if (responsableRepo.existsByCorreo(responsable.getCorreo())) {
            throw new RuntimeException("El correo ya está registrado");
        }
        return responsableRepo.save(responsable);
    }

    public Responsable actualizar(Responsable responsable) {
        if (!responsableRepo.existsById(responsable.getId())) {
            throw new RuntimeException("Responsable no encontrado");
        }
        return responsableRepo.save(responsable);
    }

    public void eliminar(Integer id) {
        responsableRepo.deleteById(id);
    }
}