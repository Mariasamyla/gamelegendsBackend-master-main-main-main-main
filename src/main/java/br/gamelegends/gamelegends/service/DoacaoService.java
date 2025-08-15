package br.gamelegends.gamelegends.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import br.gamelegends.gamelegends.model.Doacao;
import br.gamelegends.gamelegends.model.DoacaoRepository;

@Service
public class DoacaoService {

    final DoacaoRepository doacaoRepository;

    public DoacaoService(DoacaoRepository doacaoRepository) {
        this.doacaoRepository = doacaoRepository;
    }

    public Doacao save(Doacao doacao) {
        return doacaoRepository.save(doacao);
    }

    public List<Doacao> findAll() {
        return doacaoRepository.findAll();
    }

    public Optional<Doacao> findById(Long id) {
        return doacaoRepository.findById(id);
    }

    public Doacao update(Long id, Doacao novaDoacao) {
        return doacaoRepository.findById(id).map(doacao -> {
            doacao.setValor(novaDoacao.getValor());
            doacao.setConfirm(novaDoacao.getConfirm());
            return doacaoRepository.save(doacao);
        }).orElseThrow(() -> new RuntimeException("Doação não encontrada"));
    }

    public void delete(Long id) {
        doacaoRepository.deleteById(id);
    }

    public String gerarCodigoPix(long valor) {
        // Simulação de geração de código PIX
        // Em um sistema real, aqui seria integrado com um provedor de pagamento
        String chavePix = "gamelegends@pix.com.br";
        String valorFormatado = String.format("%.2f", valor / 100.0);
        
        // Código PIX simulado (normalmente seria gerado por uma API de pagamento)
        return String.format("00020126580014br.gov.bcb.pix0136%s0204%s5303986540%s5802BR5913Game Legends6009SAO PAULO62070503***6304", 
                chavePix, "DOA" + System.currentTimeMillis(), valorFormatado.length() + valorFormatado);
    }
}