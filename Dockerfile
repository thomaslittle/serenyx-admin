FROM node:18-alpine as builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies using npm install instead of npm ci
RUN npm install

# Copy source files
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Copy built assets from builder stage
COPY --from=builder /app/build build/
COPY --from=builder /app/package.json .
COPY --from=builder /app/node_modules node_modules/

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "build"]