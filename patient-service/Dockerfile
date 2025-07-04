FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# ✅ Expose the correct port your app balu
EXPOSE 80

# ✅ Start the app correctly
CMD ["npm", "start"]

