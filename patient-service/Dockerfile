FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# ✅ Expose the correct port your app uses
EXPOSE 80

# ✅ Start the app correctly
CMD ["npm", "start"]

