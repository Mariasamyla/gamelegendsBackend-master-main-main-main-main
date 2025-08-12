USE bd_gamelegends;

-- Verificar se a tabela projetos existe
IF EXISTS (SELECT * FROM sysobjects WHERE name='projetos' AND xtype='U')
BEGIN
    -- Verificar se a coluna nomeProjeto existe
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('projetos') AND name = 'nomeProjeto')
    BEGIN
        -- Se não existe, adicionar a coluna
        ALTER TABLE projetos ADD nomeProjeto NVARCHAR(255) NOT NULL DEFAULT 'Projeto Sem Nome';
        PRINT 'Coluna nomeProjeto adicionada com sucesso!';
    END
    ELSE
    BEGIN
        PRINT 'Coluna nomeProjeto já existe na tabela projetos.';
    END
END
ELSE
BEGIN
    -- Se a tabela não existe, criar ela completa
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
    PRINT 'Tabela projetos criada com sucesso!';
END

-- Verificar a estrutura da tabela
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'projetos'
ORDER BY ORDINAL_POSITION;