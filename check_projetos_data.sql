USE bd_gamelegends;

-- Verificar se existem projetos na tabela
SELECT COUNT(*) as 'Total de Projetos' FROM projetos;

-- Mostrar todos os projetos
SELECT id, nomeProjeto, descricao, genero, statusProjeto FROM projetos;

-- Verificar estrutura da tabela
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'projetos'
ORDER BY ORDINAL_POSITION;