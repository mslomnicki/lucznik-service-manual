FROM nginx/nginx-unprivileged:1.30.7-alpine-slim
COPY --chown=101:101 . /usr/share/nginx/html
EXPOSE 8080
