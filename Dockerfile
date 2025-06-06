# Use uma imagem oficial do Node.js como imagem base
# Utilizando Alpine Linux para um tamanho de imagem menor
FROM node:18-alpine

# Defina o diretório de trabalho no contêiner
WORKDIR /usr/src/app

# Copie package.json e package-lock.json (se disponível)
# Isso aproveitará o cache do Docker para o npm install se esses arquivos não mudarem
COPY package*.json ./

# Instale as dependências da aplicação
# Use npm ci para builds mais determinísticos e rápidos se package-lock.json existir
# O --production instala apenas as dependências de produção
RUN npm ci --production || npm install --production --no-optional

# Copie o código-fonte da aplicação
COPY . .

# Variáveis de ambiente padrão
# Estas podem ser sobrescritas em tempo de execução (ex: pelo EasyPanel ou docker run -e)
ENV HOST "0.0.0.0"
ENV PORT "8080"
# IMPORTANTE: Defina CORSANYWHERE_WHITELIST em tempo de execução para restringir o acesso!
# Deixando em branco por padrão, o que permite todas as origens (NÃO RECOMENDADO para produção sem restrições)
ENV CORSANYWHERE_WHITELIST ""
ENV CORSANYWHERE_BLACKLIST ""
ENV CORSANYWHERE_RATELIMIT ""
# O server.js padrão já lida com removeHeaders e requireHeader internamente com base no código.
# Se precisar sobrescrever ou adicionar, e o app suportar via ENV, adicione-os aqui.

# Exponha a porta 8080 para o mundo fora deste contêiner
# O EasyPanel irá mapear esta porta para uma porta acessível externamente.
EXPOSE 8080

# Defina o comando para executar sua aplicação
CMD [ "node", "server.js" ]
