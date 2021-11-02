FROM nginx:latest

COPY _site  /usr/share/nginx/site
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY plugins /usr/share/nginx/plugins
