FROM node:18-alpine
# Ou uma versão mais recente/adequada do Node

WORKDIR /usr/src/app

# Copiar package.json e package-lock.json
COPY package*.json ./

# Instalar dependências
RUN npm install --production

# Copiar o resto do código da aplicação
COPY . .

# Expor a porta que o cors-anywhere usa (padrão é 8080, mas pode ser configurada via env var PORT)
EXPOSE 8080

# Comando para iniciar a aplicação
CMD [ "npm", "start" ]
# Ou diretamente: CMD [ "node", "server.js" ]
