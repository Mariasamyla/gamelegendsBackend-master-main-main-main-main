package br.gamelegends.gamelegends.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface CodigoVerificacaoRepository extends JpaRepository<CodigoVerificacao, Long> {
    Optional<CodigoVerificacao> findByEmailAndCodigoAndUsadoFalse(String email, String codigo);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM CodigoVerificacao c WHERE c.email = ?1")
    void deleteByEmail(String email);
}