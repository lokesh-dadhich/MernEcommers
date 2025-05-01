# Stage 1: Build the React frontend
FROM node:18 AS frontend

WORKDIR /app/client

COPY client/package*.json ./
RUN npm install

COPY client/ .
RUN npm run build

# Stage 2: Set up the backend
FROM node:18 AS backend

WORKDIR /app

# Copy backend files
COPY server/package*.json ./server/
RUN cd server && npm install

# Copy backend and frontend build
COPY server ./server
COPY --from=frontend /app/client/build ./server/public

# Set the working directory to the backend
WORKDIR /app/server

EXPOSE 5000

# Start the backend (assumes Express serves static files from ./public)
CMD ["npm", "start"]
