USE bd_gamelegends;

-- Limpar e recriar tabela
DROP TABLE IF EXISTS projetos;

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

-- Inserir dados de teste
INSERT INTO projetos (nomeProjeto, descricao, dataInicio, tecnologias, genero, statusProjeto)
VALUES 
('Happy Cat Tavern', 'Um jogo divertido de digitação com gatos adoráveis', '2024-01-01', 'Java, Spring Boot', 'Educativo', 'Ativo'),
('Adventure Quest', 'RPG de aventura épica com mundos fantásticos', '2024-02-01', 'Unity, C#', 'RPG', 'Em Desenvolvimento'),
('Space Runner', 'Jogo de corrida espacial com naves futuristas', '2024-03-01', 'Unreal Engine, C++', 'Ação', 'Ativo');

-- Verificar dados
SELECT id, nomeProjeto, descricao FROM projetos;