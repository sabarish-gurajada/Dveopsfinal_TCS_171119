FROM node:alpine

COPY package.json /usr/src/app

RUN npm install

EXPOSE 3000

RUN npm build

CMD [ "npm", "start" ]