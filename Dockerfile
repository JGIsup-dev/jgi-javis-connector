FROM oven/bun:1
WORKDIR /app
COPY package.json bun.lock ./
RUN bun install --production
COPY . .
ENV CLAUDE_PEERS_BROKER_HOST=0.0.0.0
ENV CLAUDE_PEERS_PORT=7899
EXPOSE 7899
CMD ["bun", "broker.ts"]
