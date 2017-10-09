FROM nginx:1.13.3

ADD nginx.conf /etc/nginx/nginx.conf
ADD sites-enabled/* /etc/nginx/conf.d/
RUN mkdir -p /web/htdocs && mkdir -p /web/log && mkdir -p /web/log/nginx
RUN chown -R www-data.www-data /web/htdocs /web/log

EXPOSE 80
VOLUME ["/web"]
