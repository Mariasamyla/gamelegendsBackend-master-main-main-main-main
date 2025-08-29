package br.gamelegends.gamelegends.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void enviarCodigoVerificacao(String email, String codigo) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("gamelegends.jogos@gmail.com");
            message.setTo(email);
            message.setSubject("🎮 Game Legends - Código de Verificação");
            message.setText(
                "🎮 GAME LEGENDS - REDEFINIÇÃO DE SENHA\n\n" +
                "Olá!\n\n" +
                "Você solicitou a redefinição de senha na plataforma Game Legends.\n\n" +
                "📧 Seu código de verificação é: " + codigo + "\n\n" +
                "⏰ Este código expira em 10 minutos.\n\n" +
                "🔒 Por segurança, não compartilhe este código com ninguém.\n\n" +
                "❌ Se você não solicitou esta redefinição, ignore este email.\n\n" +
                "Atenciosamente,\n" +
                "Equipe Game Legends 🚀\n\n" +
                "---\n" +
                "Game Legends - Sua plataforma de jogos indie favorita!"
            );
            
            mailSender.send(message);
            System.out.println("✅ Email enviado com sucesso para: " + email);
        } catch (Exception e) {
            System.err.println("❌ Erro ao enviar email para " + email + ": " + e.getMessage());
            throw new RuntimeException("Falha ao enviar email: " + e.getMessage());
        }
    }
}