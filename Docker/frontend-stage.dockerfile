
FROM node:18-slim AS builder

WORKDIR /build

COPY package.json package-lock.json ./
RUN npm ci

COPY . .


RUN npm run build:stage


FROM node:18-slim

WORKDIR /app


RUN npm install -g serve


COPY --from=builder /build/dist/ /app

EXPOSE 8080

CMD ["serve", "-s", ".", "-l", "8080"]
