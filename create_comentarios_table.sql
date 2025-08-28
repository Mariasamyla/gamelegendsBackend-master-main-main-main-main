-- Criar tabela de comentários
CREATE TABLE IF NOT EXISTS comentarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    comentario TEXT NOT NULL,
    nome_jogo VARCHAR(255) NOT NULL,
    nome_usuario VARCHAR(255) NOT NULL,
    data_comentario VARCHAR(50),
    is_admin BOOLEAN DEFAULT FALSE
);

-- Inserir alguns comentários de exemplo
INSERT INTO comentarios (comentario, nome_jogo, nome_usuario, data_comentario, is_admin) VALUES
('Jogo muito bom!', 'Jogo Exemplo', 'Usuario1', '2024-01-15', FALSE),
('Excelente gameplay', 'Jogo Exemplo', 'Admin', '2024-01-16', TRUE),
('Poderia melhorar os gráficos', 'Jogo Exemplo', 'Usuario2', '2024-01-17', FALSE);