# Dockerfile for Frontend (React)
FROM node:18-alpine AS builder
WORKDIR /app

# Ensure correct paths
COPY package.json package-lock.json ./
WORKDIR /app/react-client
COPY . .
RUN npm install && npm run build

# Serve the app with Nginx
FROM nginx:alpine
COPY --from=builder /app/react-client/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Docker Compose File
