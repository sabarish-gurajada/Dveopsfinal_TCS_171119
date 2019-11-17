FROM node:alpine

COPY package.json package.json

RUN npm install

EXPOSE 3000

RUN npm build

CMD [ "npm", "start" ]
