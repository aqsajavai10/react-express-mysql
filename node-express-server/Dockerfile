FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . ./

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app ./
USER node
CMD ["npm", "start"]
