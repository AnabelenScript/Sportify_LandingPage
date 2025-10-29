FROM nginx:alpine

RUN apk update && apk add nginx
RUN rm -rf /etc/nginx/conf.d/*
COPY config/nginx.conf /etc/nginx/conf.d/default.conf
COPY certs/cloudflare.crt /etc/nginx/certs/cloudflare.crt
COPY certs/cloudflare.key /etc/nginx/certs/cloudflare.key
RUN chown -R nginx:nginx /etc/nginx/certs
RUN chmod 600 /etc/nginx/certs/cloudflare.key
RUN chmod 644 /etc/nginx/certs/cloudflare.crt
COPY html/ /usr/share/nginx/html/
EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]