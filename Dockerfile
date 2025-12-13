# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libgl1 \
    libglu1-mesa \
    libxcursor1 \
    libxinerama1 \
    libxrandr2 \
    libxi6 \
    libpulse0 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy Godot binary and game files
COPY godot /app/godot
COPY godot.pck /app/godot.pck

# Make godot executable
RUN chmod +x /app/godot

# Expose ports
# Port 10000 - WebSocket game server (Render default)
# Port 8080 - HTTP status page
EXPOSE 10000 8080

# Set environment variable for Render
ENV PORT=10000

# Run the server
CMD ["./godot", "--headless"]