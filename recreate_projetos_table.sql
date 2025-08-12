USE bd_gamelegends;

-- Remover tabela projetos se existir
IF EXISTS (SELECT * FROM sysobjects WHERE name='projetos' AND xtype='U')
BEGIN
    DROP TABLE projetos;
    PRINT 'Tabela projetos removida.';
END

-- Criar tabela projetos com estrutura correta
CREATE TABLE projetos (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nomeProjeto NVARCHAR(255) NOT NULL UNIQUE,
    descricao NVARCHAR(500) NOT NULL,
    dataInicio NVARCHAR(255) NOT NULL,
    tecnologias NVARCHAR(255) NOT NULL,
    genero NVARCHAR(255) NOT NULL,
    statusProjeto NVARCHAR(255),
    imagemUrl NVARCHAR(500),
    foto VARBINARY(MAX)
);

PRINT 'Tabela projetos recriada com sucesso!';

-- Inserir dados de exemplo (opcional)
INSERT INTO projetos (nomeProjeto, descricao, dataInicio, tecnologias, genero, statusProjeto)
VALUES 
('Happy Cat Tavern', 'Jogo de digitação divertido com gatos', '2024-01-01', 'Java, Spring Boot', 'Educativo', 'Ativo'),
('Adventure Quest', 'RPG de aventura épica', '2024-02-01', 'Unity, C#', 'RPG', 'Em Desenvolvimento');

PRINT 'Dados de exemplo inseridos!';