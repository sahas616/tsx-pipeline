FROM node:20-alpine AS buildstage
WORKDIR /app
COPY package*.json /app/
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=buildstage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]