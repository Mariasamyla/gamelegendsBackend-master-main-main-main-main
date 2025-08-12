USE bd_gamelegends;

-- Verificar se existem projetos
SELECT COUNT(*) as 'Total Projetos' FROM projetos;

-- Mostrar todos os projetos
SELECT id, nomeProjeto, descricao, genero FROM projetos;

-- Se não houver dados, inserir projetos de teste
IF NOT EXISTS (SELECT * FROM projetos)
BEGIN
    INSERT INTO projetos (nomeProjeto, descricao, dataInicio, tecnologias, genero, statusProjeto)
    VALUES 
    ('Happy Cat Tavern', 'Jogo divertido de digitação com gatos', '2024-01-01', 'Java, Spring Boot', 'Educativo', 'Ativo'),
    ('Space Adventure', 'Aventura espacial épica', '2024-02-01', 'Unity, C#', 'Aventura', 'Ativo'),
    ('Racing Thunder', 'Corrida de alta velocidade', '2024-03-01', 'Unreal Engine', 'Esporte', 'Ativo');
    
    PRINT 'Projetos de teste inseridos!';
END