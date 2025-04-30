# DEV DOCKERFILE
FROM node:18-slim

WORKDIR /app


COPY package.json package-lock.json ./
RUN npm install


COPY . .


EXPOSE 4200


CMD ["npm", "run", "start"]
