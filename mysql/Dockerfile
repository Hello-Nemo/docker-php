FROM mysql:5.6

#写入权限配置

RUN usermod -u 501 mysql && chown mysql.mysql /var/run/mysqld/

RUN usermod -o -u 501 mysql || true

RUN grouped -o -u 20 mysql || true

EXPOSE 3306