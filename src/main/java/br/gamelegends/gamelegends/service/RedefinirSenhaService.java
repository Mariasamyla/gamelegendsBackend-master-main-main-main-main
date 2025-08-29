package br.gamelegends.gamelegends.service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.gamelegends.gamelegends.model.Cadastro;
import br.gamelegends.gamelegends.model.CadastroRepository;
import br.gamelegends.gamelegends.model.CodigoVerificacao;
import br.gamelegends.gamelegends.model.CodigoVerificacaoRepository;

@Service
public class RedefinirSenhaService {

    @Autowired
    private CadastroRepository cadastroRepository;

    @Autowired
    private CodigoVerificacaoRepository codigoRepository;

    @Autowired
    private EmailService emailService;

    @Transactional
    public String gerarCodigoVerificacao(String email) {
        // Verificar se email existe no banco OU se é um email real
        Cadastro usuario = cadastroRepository.findByEmail(email);
        boolean isEmailReal = isEmailRealProvider(email);
        
        if (usuario == null && !isEmailReal) {
            throw new RuntimeException("Email não encontrado ou inválido");
        }
        
        // Gerar código de 6 dígitos
        String codigo = String.format("%06d", new Random().nextInt(1000000));
        
        // Limpar códigos antigos do email
        codigoRepository.deleteByEmail(email);
        
        // Criar novo código com expiração de 10 minutos
        CodigoVerificacao codigoVerificacao = new CodigoVerificacao(
            email, 
            codigo, 
            LocalDateTime.now().plusMinutes(10)
        );
        
        codigoRepository.save(codigoVerificacao);
        
        // Log do código gerado
        System.out.println("📝 Código " + codigo + " gerado EXCLUSIVAMENTE para: " + email + " (ID: " + codigoVerificacao.getId() + ")");
        
        // Sempre salvar no banco e tentar enviar email se for real
        if (isEmailReal) {
            try {
                emailService.enviarCodigoVerificacao(email, codigo);
                System.out.println("📧 Email real - código enviado E salvo no banco: " + email);
            } catch (Exception e) {
                System.err.println("❌ Erro ao enviar email, mas código salvo no banco: " + e.getMessage());
                // Mantém o código no banco mesmo se falhar o envio
            }
        } else {
            System.out.println("💾 Email cadastrado - código salvo no banco: " + email);
        }
        
        return codigo;
    }

    public boolean verificarCodigo(String email, String codigo) {
        System.out.println("🔍 Verificando se código " + codigo + " pertence ao email: " + email);
        
        Optional<CodigoVerificacao> codigoOpt = codigoRepository
            .findByEmailAndCodigoAndUsadoFalse(email, codigo);
        
        if (!codigoOpt.isPresent()) {
            System.out.println("❌ Código não encontrado no banco");
            return false;
        }
        
        CodigoVerificacao codigoVerificacao = codigoOpt.get();
        
        // Verificar se não expirou
        if (LocalDateTime.now().isAfter(codigoVerificacao.getDataExpiracao())) {
            System.out.println("⏰ Código expirado");
            return false;
        }
        
        System.out.println("✅ Código " + codigo + " válido para " + email + " - ID: " + codigoVerificacao.getId());
        return true;
    }

    @Transactional
    public boolean redefinirSenha(String email, String codigo, String novaSenha) {
        Optional<CodigoVerificacao> codigoOpt = codigoRepository
            .findByEmailAndCodigoAndUsadoFalse(email, codigo);
        
        if (!codigoOpt.isPresent()) {
            return false;
        }
        
        CodigoVerificacao codigoVerificacao = codigoOpt.get();
        
        // Verificar se não expirou
        if (LocalDateTime.now().isAfter(codigoVerificacao.getDataExpiracao())) {
            return false;
        }
        
        // Marcar código como usado
        codigoVerificacao.setUsado(true);
        codigoRepository.save(codigoVerificacao);
        
        // Atualizar senha do usuário (se existir no banco)
        Cadastro usuario = cadastroRepository.findByEmail(email);
        if (usuario != null) {
            usuario.setSenha(novaSenha);
            cadastroRepository.save(usuario);
            return true;
        }
        
        // Se for email real mas não cadastrado, ainda permite redefinição
        boolean isEmailReal = isEmailRealProvider(email);
        
        return isEmailReal; // Retorna true para emails reais mesmo sem cadastro
    }
    
    public boolean emailExiste(String email) {
        Cadastro usuario = cadastroRepository.findByEmail(email);
        return usuario != null;
    }
    
    public java.util.List<String> listarEmails() {
        return cadastroRepository.findAll().stream()
            .map(Cadastro::getEmail)
            .collect(java.util.stream.Collectors.toList());
    }
    
    private boolean isEmailRealProvider(String email) {
        if (email == null || !email.contains("@")) {
            return false;
        }
        
        String domain = email.toLowerCase().substring(email.indexOf("@"));
        
        // Lista de provedores de email reais
        return domain.equals("@gmail.com") ||
               domain.equals("@yahoo.com") ||
               domain.equals("@hotmail.com") ||
               domain.equals("@outlook.com") ||
               domain.equals("@live.com") ||
               domain.equals("@icloud.com") ||
               domain.equals("@protonmail.com") ||
               domain.equals("@uol.com.br") ||
               domain.equals("@bol.com.br") ||
               domain.equals("@terra.com.br");
    }
}