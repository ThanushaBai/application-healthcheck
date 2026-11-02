# Use a lightweight Node.js image
FROM node:22-alpine

# Install curl (required for the health check)
RUN apk add --no-cache curl

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy the application code
COPY app.js ./

# Expose the port
EXPOSE 3000

# Command to run the app
CMD ["node", "app.js"]

# Docker Health Check
HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -fsS http://localhost:3000/health || exit 1
