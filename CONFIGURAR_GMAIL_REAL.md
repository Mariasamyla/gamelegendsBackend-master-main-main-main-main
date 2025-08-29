# 📧 Configurar Gmail Real - PASSO A PASSO

## 🚀 1. Criar Senha de App no Gmail

### Passo 1: Ativar Verificação em 2 Etapas
1. Acesse: https://myaccount.google.com/security
2. Clique em "Verificação em duas etapas"
3. Siga os passos para ativar

### Passo 2: Gerar Senha de App
1. Na mesma página de Segurança
2. Clique em "Senhas de app"
3. Selecione "Email" 
4. Copie a senha de 16 caracteres (ex: abcd efgh ijkl mnop)

## 🔧 2. Configurar no Backend

Edite o arquivo: `src/main/resources/application.properties`

Substitua estas linhas:
```properties
spring.mail.username=gamelegends.noreply@gmail.com
spring.mail.password=sua_senha_app_aqui
```

Por:
```properties
spring.mail.username=SEU_EMAIL@gmail.com
spring.mail.password=SUA_SENHA_DE_APP_16_CARACTERES
```

## ⚠️ IMPORTANTE
- Use SUA conta Gmail real
- Use a SENHA DE APP (não a senha normal)
- Não use espaços na senha de app

## 🧪 3. Testar
1. Reinicie o backend
2. Use seu Gmail real no Flutter
3. Verifique sua caixa de entrada