FROM node:12.16.0-alpine as build

WORKDIR /app/

COPY package*.json ./

RUN npm ci

COPY ./ ./

ENV NODE_ENV=production

RUN npm run build

FROM nginx:1.16.1-alpine

WORKDIR /usr/share/nginx/html/

COPY docker/nginx.conf /etc/nginx/

COPY --from=build /app/dist ./
