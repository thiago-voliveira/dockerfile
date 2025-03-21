FROM node:18 AS build

WORKDIR /usr/src/app

COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn ./.yarn
COPY .yarn/releases/yarn-3.5.1.cjs .yarn/releases/yarn-3.5.1.cjs  

RUN yarn install --immutable


COPY . .

RUN yarn run build


FROM node:18-alpine3.19 

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist

COPY --from=build /usr/src/app/node_modules ./node_modules



EXPOSE 3000

CMD ["yarn",  "start"]