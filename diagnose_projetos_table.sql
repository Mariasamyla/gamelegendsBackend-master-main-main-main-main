USE bd_gamelegends;

-- Verificar se a tabela projetos existe
IF EXISTS (SELECT * FROM sysobjects WHERE name='projetos' AND xtype='U')
BEGIN
    PRINT 'Tabela projetos existe.';
    
    -- Mostrar estrutura da tabela
    PRINT 'Estrutura da tabela projetos:';
    SELECT 
        COLUMN_NAME as 'Nome da Coluna',
        DATA_TYPE as 'Tipo de Dados',
        IS_NULLABLE as 'Permite NULL',
        CHARACTER_MAXIMUM_LENGTH as 'Tamanho Máximo'
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'projetos'
    ORDER BY ORDINAL_POSITION;
    
    -- Contar registros
    DECLARE @count INT;
    SELECT @count = COUNT(*) FROM projetos;
    PRINT 'Número de registros na tabela: ' + CAST(@count AS VARCHAR(10));
    
END
ELSE
BEGIN
    PRINT 'ERRO: Tabela projetos NÃO existe!';
    PRINT 'Execute o script recreate_projetos_table.sql para criar a tabela.';
END