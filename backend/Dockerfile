FROM node:14-alpine

WORKDIR /app

# Install dependencies
COPY package.json ./
RUN npm install

# Copy all source files
COPY . .

EXPOSE 5000

CMD ["node", "src/server.js"]
