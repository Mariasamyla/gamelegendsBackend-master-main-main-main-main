-- EXECUTE ESTE SCRIPT COMPLETO NO SQL SERVER MANAGEMENT STUDIO

-- 1. Criar banco se não existir
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'bd_gamelegends')
BEGIN
    CREATE DATABASE bd_gamelegends;
    PRINT 'Banco bd_gamelegends criado';
END
GO

USE bd_gamelegends;
GO

-- 2. Remover todas as tabelas (ordem correta para evitar FK)
IF OBJECT_ID('Doacao', 'U') IS NOT NULL 
BEGIN
    DROP TABLE Doacao;
    PRINT 'Tabela Doacao removida';
END

IF OBJECT_ID('CadCartao', 'U') IS NOT NULL 
BEGIN
    DROP TABLE CadCartao;
    PRINT 'Tabela CadCartao removida';
END

IF OBJECT_ID('Avaliacao', 'U') IS NOT NULL 
BEGIN
    DROP TABLE Avaliacao;
    PRINT 'Tabela Avaliacao removida';
END

IF OBJECT_ID('Fatura', 'U') IS NOT NULL 
BEGIN
    DROP TABLE Fatura;
    PRINT 'Tabela Fatura removida';
END

IF OBJECT_ID('projetos', 'U') IS NOT NULL 
BEGIN
    DROP TABLE projetos;
    PRINT 'Tabela projetos removida';
END

IF OBJECT_ID('Cadastro', 'U') IS NOT NULL 
BEGIN
    DROP TABLE Cadastro;
    PRINT 'Tabela Cadastro removida';
END

-- 3. Criar tabela Cadastro
CREATE TABLE Cadastro (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(255) NOT NULL,
    sobrenome NVARCHAR(255) NOT NULL,
    cpf NVARCHAR(14) NOT NULL,
    datanascimento DATE NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    telefone NVARCHAR(15) NOT NULL,
    senha NVARCHAR(255) NOT NULL,
    usuario NVARCHAR(50) NOT NULL DEFAULT 'Cliente'
);
PRINT 'Tabela Cadastro criada';

-- 4. Criar tabela CadCartao
CREATE TABLE CadCartao (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nomeT NVARCHAR(255) NOT NULL,
    numC NVARCHAR(19) NOT NULL,
    validade NVARCHAR(7) NOT NULL,
    CVV NVARCHAR(4) NOT NULL,
    bandeira NVARCHAR(50) NOT NULL,
    clienteId BIGINT NOT NULL,
    CONSTRAINT FK_CadCartao_Cadastro FOREIGN KEY (clienteId) REFERENCES Cadastro(id)
);
PRINT 'Tabela CadCartao criada';

-- 5. Criar tabela Doacao
CREATE TABLE Doacao (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    valor INT NOT NULL,
    fk_Cliente_ID BIGINT NOT NULL,
    cartaoId NVARCHAR(255) NOT NULL,
    CONSTRAINT FK_Doacao_Cadastro FOREIGN KEY (fk_Cliente_ID) REFERENCES Cadastro(id)
);
PRINT 'Tabela Doacao criada';

-- 6. Criar outras tabelas necessárias
CREATE TABLE projetos (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nomeProjeto NVARCHAR(255) NOT NULL UNIQUE,
    descricao NVARCHAR(500) NOT NULL,
    dataInicio NVARCHAR(255) NOT NULL,
    tecnologias NVARCHAR(255) NOT NULL,
    genero NVARCHAR(255) NOT NULL,
    statusProjeto NVARCHAR(255),
    foto VARBINARY(MAX)
);
PRINT 'Tabela projetos criada';

CREATE TABLE Avaliacao (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    comentario NVARCHAR(MAX) NOT NULL,
    estrelas INT NOT NULL CHECK (estrelas >= 1 AND estrelas <= 5),
    nomeJogo NVARCHAR(255) NOT NULL,
    nomeUsuario NVARCHAR(255) NOT NULL,
    dataAvaliacao NVARCHAR(10) NOT NULL
);
PRINT 'Tabela Avaliacao criada';

-- 7. Inserir dados de teste
INSERT INTO Cadastro (nome, sobrenome, cpf, datanascimento, email, telefone, senha, usuario) 
VALUES 
('Admin', 'Sistema', '000.000.000-00', '1990-01-01', 'admin@gamelegends.com', '(11) 99999-9999', 'admin123', 'ADM'),
('Cliente', 'Teste', '111.111.111-11', '1995-05-15', 'cliente@teste.com', '(11) 88888-8888', 'cliente123', 'Cliente'),
('João', 'Silva', '222.222.222-22', '1988-03-20', 'joao@teste.com', '(11) 77777-7777', 'joao123', 'Cliente');

PRINT 'Usuários inseridos';

-- 8. Inserir cartão de teste
INSERT INTO CadCartao (nomeT, numC, validade, CVV, bandeira, clienteId) 
VALUES ('CLIENTE TESTE', '4111 1111 1111 1111', '12/28', '123', 'Visa', 2);

PRINT 'Cartão de teste inserido';

-- 9. Verificar estrutura
SELECT 'Cadastro' as Tabela, COUNT(*) as Registros FROM Cadastro
UNION ALL
SELECT 'CadCartao' as Tabela, COUNT(*) as Registros FROM CadCartao
UNION ALL
SELECT 'Doacao' as Tabela, COUNT(*) as Registros FROM Doacao;

PRINT '=== BANCO CONFIGURADO COM SUCESSO ===';
PRINT 'Usuários disponíveis:';
PRINT 'ID 1: admin@gamelegends.com / admin123';
PRINT 'ID 2: cliente@teste.com / cliente123';
PRINT 'ID 3: joao@teste.com / joao123';
PRINT 'Cartão teste inserido para cliente ID 2';
PRINT 'REINICIE O SERVIDOR SPRING BOOT AGORA!';