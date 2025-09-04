package br.gamelegends.gamelegends.control;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.gamelegends.gamelegends.model.CadCartao;
import br.gamelegends.gamelegends.service.CadCartaoService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/teste")
public class TesteController {

    final CadCartaoService cadCartaoService;

    public TesteController(CadCartaoService cadCartaoService) {
        this.cadCartaoService = cadCartaoService;
    }

    @GetMapping("/ping")
    public ResponseEntity<String> ping() {
        return ResponseEntity.ok("Sistema funcionando!");
    }

    @PostMapping("/cartao")
    public ResponseEntity<Object> testeCartao(@RequestBody CadCartao cartao) {
        try {
            CadCartao salvo = cadCartaoService.save(cartao);
            return ResponseEntity.ok(salvo);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erro: " + e.getMessage());
        }
    }
}