FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html.template
COPY docker-entrypoint.d/40-render-template.sh /docker-entrypoint.d/40-render-template.sh
