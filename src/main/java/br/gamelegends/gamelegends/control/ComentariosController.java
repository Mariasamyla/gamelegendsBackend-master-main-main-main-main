package br.gamelegends.gamelegends.control;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.gamelegends.gamelegends.model.Comentarios;
import br.gamelegends.gamelegends.service.ComentariosService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600, allowCredentials = "false")
@RequestMapping("/comentarios")
public class ComentariosController {

    @Autowired
    private ComentariosService comentariosService;

    @GetMapping
    public ResponseEntity<List<Comentarios>> getAllComentarios() {
        List<Comentarios> comentarios = comentariosService.findAll();
        return ResponseEntity.ok(comentarios);
    }

    @GetMapping("/jogo/{nomeJogo}")
    public ResponseEntity<List<Comentarios>> getComentariosByJogo(@PathVariable String nomeJogo) {
        List<Comentarios> comentarios = comentariosService.findByNomeJogo(nomeJogo);
        return ResponseEntity.ok(comentarios);
    }

    @PostMapping
    public ResponseEntity<Comentarios> createComentario(@RequestBody Comentarios comentarios) {
        Comentarios novoComentario = comentariosService.save(comentarios);
        return ResponseEntity.status(HttpStatus.CREATED).body(novoComentario);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteComentario(@PathVariable Long id) {
        if (comentariosService.findById(id).isPresent()) {
            comentariosService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}