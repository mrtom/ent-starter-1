FROM ghcr.io/lolopinto/ent:0.1.0-alpha.30-nodejs-17-slim
# ghcr.io/lolopinto/ent:0.0.33-nodejs-17-slim
# ghcr.io/lolopinto/ent:0.0.33-nodejs-14-slim
# ghcr.io/lolopinto/ent:0.0.33-nodejs-16-slim

WORKDIR /app

COPY . /app

RUN rm -rf node_modules
#RUN rm package-lock.json
ENV NODE_ENV=production
RUN npm install --production
RUN npm run compile

ARG DB_CONNECTION_STRING=$DB_CONNECTION_STRING
ENV DB_CONNECTION_STRING=$DB_CONNECTION_STRING

RUN tsent upgrade

CMD ["node", "dist/graphql/index.js"]
