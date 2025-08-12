USE bd_gamelegends;

-- Inserir projetos de teste se não existirem
IF NOT EXISTS (SELECT * FROM projetos WHERE nomeProjeto = 'Happy Cat Tavern')
BEGIN
    INSERT INTO projetos (nomeProjeto, descricao, dataInicio, tecnologias, genero, statusProjeto)
    VALUES ('Happy Cat Tavern', 'Um jogo divertido de digitação com gatos adoráveis', '2024-01-01', 'Java, Spring Boot', 'Educativo', 'Ativo');
END

IF NOT EXISTS (SELECT * FROM projetos WHERE nomeProjeto = 'Adventure Quest')
BEGIN
    INSERT INTO projetos (nomeProjeto, descricao, dataInicio, tecnologias, genero, statusProjeto)
    VALUES ('Adventure Quest', 'RPG de aventura épica com mundos fantásticos', '2024-02-01', 'Unity, C#', 'RPG', 'Em Desenvolvimento');
END

IF NOT EXISTS (SELECT * FROM projetos WHERE nomeProjeto = 'Space Runner')
BEGIN
    INSERT INTO projetos (nomeProjeto, descricao, dataInicio, tecnologias, genero, statusProjeto)
    VALUES ('Space Runner', 'Jogo de corrida espacial com naves futuristas', '2024-03-01', 'Unreal Engine, C++', 'Ação', 'Ativo');
END

PRINT 'Projetos de teste inseridos com sucesso!';

-- Verificar os dados inseridos
SELECT id, nomeProjeto, descricao, genero, statusProjeto FROM projetos;