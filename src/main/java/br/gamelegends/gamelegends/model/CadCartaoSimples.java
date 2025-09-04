package br.gamelegends.gamelegends.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "CadCartao")
public class CadCartaoSimples {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String nomeT;
    private String numC;
    private String validade;
    private String CVV;
    private String bandeira;
    private Long clienteId;
    
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getNomeT() { return nomeT; }
    public void setNomeT(String nomeT) { this.nomeT = nomeT; }
    
    public String getNumC() { return numC; }
    public void setNumC(String numC) { this.numC = numC; }
    
    public String getValidade() { return validade; }
    public void setValidade(String validade) { this.validade = validade; }
    
    public String getCVV() { return CVV; }
    public void setCVV(String CVV) { this.CVV = CVV; }
    
    public String getBandeira() { return bandeira; }
    public void setBandeira(String bandeira) { this.bandeira = bandeira; }
    
    public Long getClienteId() { return clienteId; }
    public void setClienteId(Long clienteId) { this.clienteId = clienteId; }
}