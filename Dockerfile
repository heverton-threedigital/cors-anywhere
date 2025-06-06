FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

ENV HOST "0.0.0.0"
ENV PORT "8080"

CMD [ "node", "server.js" ]

EXPOSE 8080
