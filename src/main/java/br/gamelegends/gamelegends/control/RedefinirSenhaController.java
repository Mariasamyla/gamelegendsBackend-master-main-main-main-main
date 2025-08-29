package br.gamelegends.gamelegends.control;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.gamelegends.gamelegends.rest.response.MessageResponse;
import br.gamelegends.gamelegends.service.RedefinirSenhaService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/redefinir-senha")
public class RedefinirSenhaController {

    @Autowired
    private RedefinirSenhaService redefinirSenhaService;

    @PostMapping("/enviar-codigo")
    public ResponseEntity<?> enviarCodigo(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            String codigo = redefinirSenhaService.gerarCodigoVerificacao(email);
            
            // Aqui você pode integrar com um serviço de email real
            // Por enquanto, retornamos o código para teste
            return ResponseEntity.ok(Map.of(
                "message", "Código enviado com sucesso"
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                .body(new MessageResponse("Erro: " + e.getMessage()));
        }
    }

    @PostMapping("/verificar-codigo")
    public ResponseEntity<?> verificarCodigo(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String codigo = request.get("codigo");
        
        boolean valido = redefinirSenhaService.verificarCodigo(email, codigo);
        
        if (valido) {
            return ResponseEntity.ok(new MessageResponse("Código válido"));
        } else {
            return ResponseEntity.badRequest()
                .body(new MessageResponse("Código inválido ou expirado"));
        }
    }

    @PostMapping("/nova-senha")
    public ResponseEntity<?> novaSenha(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String codigo = request.get("codigo");
        String novaSenha = request.get("novaSenha");
        
        boolean sucesso = redefinirSenhaService.redefinirSenha(email, codigo, novaSenha);
        
        if (sucesso) {
            return ResponseEntity.ok(new MessageResponse("Senha redefinida com sucesso"));
        } else {
            return ResponseEntity.badRequest()
                .body(new MessageResponse("Erro ao redefinir senha"));
        }
    }
    
    @GetMapping("/emails-disponiveis")
    public ResponseEntity<?> emailsDisponiveis() {
        try {
            return ResponseEntity.ok(redefinirSenhaService.listarEmails());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erro: " + e.getMessage());
        }
    }
    

}