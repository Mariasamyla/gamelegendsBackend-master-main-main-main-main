package br.gamelegends.gamelegends.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.gamelegends.gamelegends.model.Comentarios;
import br.gamelegends.gamelegends.model.ComentariosRepository;

@Service
public class ComentariosService {

    @Autowired
    private ComentariosRepository comentariosRepository;

    public List<Comentarios> findAll() {
        return comentariosRepository.findAll();
    }

    public List<Comentarios> findByNomeJogo(String nomeJogo) {
        return comentariosRepository.findByNomeJogo(nomeJogo);
    }

    public Optional<Comentarios> findById(Long id) {
        return comentariosRepository.findById(id);
    }

    public Comentarios save(Comentarios comentarios) {
        return comentariosRepository.save(comentarios);
    }

    public void deleteById(Long id) {
        comentariosRepository.deleteById(id);
    }
}