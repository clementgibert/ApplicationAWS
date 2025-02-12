FROM node:14-alpine

WORKDIR /app

# Install dependencies
COPY package.json ./
RUN npm install

# Copy all files
COPY . .

EXPOSE 3000

CMD ["npm", "start"]
