# Step 1: Build the React frontend
FROM node:16 AS client-build
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client/ .
RUN npm run build
# Step 2: Set up the Node.js backend
FROM node:16
WORKDIR /app
# Copy server code and install dependencies
COPY server/package*.json ./
RUN npm install
COPY server/ .
# Copy the React build output into the backend's public folder
COPY --from=client-build /app/client/build ./public
# Expose the backend server port
EXPOSE 5000
# Start the Node.js server
CMD ["node", "server.js"]
