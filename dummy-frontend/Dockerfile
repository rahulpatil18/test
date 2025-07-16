# Use Node base image
FROM node:20.11.1

# Set working directory
WORKDIR /app

# Install pnpm
RUN npm install -g pnpm@8.15.3

# Pre-copy only package manager files for cache efficiency
COPY package.json pnpm-lock.yaml ./

# Setup persistent pnpm store
RUN --mount=type=cache,target=/root/.pnpm-store \
    pnpm config set store-dir /root/.pnpm-store && \
    pnpm install --frozen-lockfile

# Copy the rest of the source files after caching deps
COPY . .

# Default CMD (optional)
CMD ["pnpm", "dev"]
