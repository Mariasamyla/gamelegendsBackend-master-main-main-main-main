-- 📧 Tabela para Códigos de Verificação de Email
-- Execute este script no SQL Server Management Studio

USE bd_gamelegends;
GO

-- Criar tabela se não existir
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='codigo_verificacao' AND xtype='U')
BEGIN
    CREATE TABLE codigo_verificacao (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        email NVARCHAR(255) NOT NULL,
        codigo NVARCHAR(6) NOT NULL,
        data_expiracao DATETIME2 NOT NULL,
        usado BIT NOT NULL DEFAULT 0,
        data_criacao DATETIME2 DEFAULT GETDATE()
    );
    
    PRINT '✅ Tabela codigo_verificacao criada com sucesso!';
END
ELSE
BEGIN
    PRINT '⚠️ Tabela codigo_verificacao já existe.';
END

-- Criar índices para melhor performance
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_codigo_verificacao_email_codigo')
BEGIN
    CREATE INDEX IX_codigo_verificacao_email_codigo 
    ON codigo_verificacao (email, codigo, usado);
    
    PRINT '✅ Índice IX_codigo_verificacao_email_codigo criado!';
END

-- Verificar estrutura da tabela
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'codigo_verificacao'
ORDER BY ORDINAL_POSITION;

PRINT '📊 Estrutura da tabela codigo_verificacao exibida acima.';

-- Exemplo de consulta para ver códigos ativos
PRINT '🔍 Códigos ativos (não expirados e não usados):';
SELECT 
    email,
    codigo,
    data_expiracao,
    CASE 
        WHEN data_expiracao > GETDATE() THEN 'Válido'
        ELSE 'Expirado'
    END as status
FROM codigo_verificacao 
WHERE usado = 0
ORDER BY data_criacao DESC;