FROM node:22 AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn install && yarn cache clean

COPY . .

RUN yarn run build

FROM node:22-alpine3.19

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/package.json ./package.json
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD ["yarn", "run", "start:prod"]