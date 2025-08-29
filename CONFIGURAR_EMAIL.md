# 📧 Configuração de Email para Recuperação de Senha

## 🚀 Como Configurar o Gmail para Envio de Emails

### 1. Criar uma Conta Gmail Dedicada
- Crie uma conta Gmail específica para o sistema (ex: `gamelegends.noreply@gmail.com`)
- Ou use uma conta existente

### 2. Ativar Verificação em 2 Etapas
1. Acesse [myaccount.google.com](https://myaccount.google.com)
2. Vá em **Segurança**
3. Ative a **Verificação em duas etapas**

### 3. Gerar Senha de App
1. Na mesma seção de Segurança
2. Clique em **Senhas de app**
3. Selecione **Email** como aplicativo
4. Copie a senha gerada (16 caracteres)

### 4. Configurar no application.properties
```properties
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=SEU_EMAIL@gmail.com
spring.mail.password=SUA_SENHA_DE_APP_AQUI
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
spring.mail.properties.mail.smtp.ssl.trust=smtp.gmail.com
```

### 5. Substituir no Arquivo
Edite o arquivo `src/main/resources/application.properties`:
- Substitua `gamelegends.noreply@gmail.com` pelo seu email
- Substitua `sua_senha_app_aqui` pela senha de app gerada

## 🔧 Como Funciona o Sistema

### Para Emails Reais (Gmail, Yahoo, etc.)
- ✅ Código é enviado por email real
- 📧 Usuário recebe no Gmail/Yahoo/etc.
- 🔒 Funciona mesmo se não cadastrado no sistema

### Para Emails Cadastrados no Sistema
- 💾 Código é salvo no banco de dados
- 🧪 Ideal para testes e desenvolvimento
- 📊 Pode ser consultado no banco na tabela `codigo_verificacao`

## 🎯 Provedores Suportados
- Gmail (@gmail.com)
- Yahoo (@yahoo.com)
- Hotmail (@hotmail.com)
- Outlook (@outlook.com)
- Live (@live.com)
- iCloud (@icloud.com)
- ProtonMail (@protonmail.com)
- UOL (@uol.com.br)
- BOL (@bol.com.br)
- Terra (@terra.com.br)

## 🛠️ Testando o Sistema

### 1. Teste com Email Real
```
Email: seuemail@gmail.com
Resultado: Código enviado por email
```

### 2. Teste com Email Cadastrado
```
Email: usuario@teste.com (cadastrado no sistema)
Resultado: Código salvo no banco
```

### 3. Consultar Código no Banco
```sql
SELECT * FROM codigo_verificacao 
WHERE email = 'email@teste.com' 
ORDER BY id DESC;
```

## ⚠️ Importante
- Mantenha a senha de app segura
- Não compartilhe as credenciais
- Use uma conta dedicada para o sistema
- Teste sempre antes de colocar em produção