-- 🔍 CONSULTAR CÓDIGOS DE VERIFICAÇÃO

-- Ver todos os códigos ativos (não expirados e não usados)
SELECT 
    id,
    email,
    codigo,
    data_expiracao,
    usado,
    data_criacao,
    CASE 
        WHEN data_expiracao > GETDATE() AND usado = 0 THEN '✅ VÁLIDO'
        WHEN data_expiracao <= GETDATE() THEN '⏰ EXPIRADO'
        WHEN usado = 1 THEN '✔️ USADO'
        ELSE '❓ OUTRO'
    END as status
FROM codigo_verificacao 
ORDER BY data_criacao DESC;

-- Ver último código de um email específico
-- SUBSTITUA 'SEU_EMAIL@gmail.com' pelo email que você quer consultar
SELECT TOP 1 
    id,
    email,
    codigo,
    data_expiracao,
    usado,
    data_criacao,
    CASE 
        WHEN data_expiracao > GETDATE() AND usado = 0 THEN '✅ VÁLIDO'
        WHEN data_expiracao <= GETDATE() THEN '⏰ EXPIRADO'
        WHEN usado = 1 THEN '✔️ USADO'
        ELSE '❓ OUTRO'
    END as status
FROM codigo_verificacao 
WHERE email = 'SEU_EMAIL@gmail.com'  -- MUDE AQUI
ORDER BY data_criacao DESC;

-- Limpar códigos expirados (opcional)
-- DELETE FROM codigo_verificacao WHERE data_expiracao < GETDATE();