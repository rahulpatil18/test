FROM node:20.11.1

WORKDIR /app

# Copy source files
COPY . .

# Install pnpm
RUN npm install -g pnpm@8.15.3

# ⚡ Use persistent pnpm store cache
RUN --mount=type=cache,target=/root/.pnpm-store \
    pnpm config set store-dir /root/.pnpm-store && \
    pnpm install --frozen-lockfile
