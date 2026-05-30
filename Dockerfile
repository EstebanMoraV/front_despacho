# ETAPA 1: Construcción (Build)
FROM node:18-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# ETAPA 2: Producción (Runtime)
FROM nginx:stable-alpine
# Copiamos el resultado del build a la carpeta de Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html
# Exponemos el puerto 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
