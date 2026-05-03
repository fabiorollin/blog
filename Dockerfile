# ---------- Stage 1: Hugo build ----------
FROM hugomods/hugo:exts-0.139.5 AS builder

WORKDIR /src
COPY . .

# Build the static site to /src/public
RUN hugo --minify --gc

# ---------- Stage 2: Nginx serve ----------
# nginx-unprivileged: same nginx, pre-configured to run as user 101 on port 8080.
# The standard nginx:alpine image needs root to write to /var/cache/nginx/*;
# nginx-unprivileged ships with those dirs already chowned to the nginx user.
FROM nginxinc/nginx-unprivileged:1.27-alpine

# Custom nginx config (gzip, cache headers, etc.)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built site
COPY --from=builder /src/public /usr/share/nginx/html

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/ || exit 1
