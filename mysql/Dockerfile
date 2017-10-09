FROM mysql:5.6

#写入权限配置
#RUN usermod -u 1000 mysql && chown mysql.mysql /var/run/mysqld/
RUN usermod -u 501 mysql && chown mysql.mysql /var/run/mysqld/
RUN usermod -o -u 501 mysql || true
RUN groupmod -o -g 20 mysql || true

ADD my.cnf /etc/mysql/my.cnf

#RUN echo "default-time_zone = '+8:00'" >> /etc/mysql/conf.d/timezone.cnf

RUN echo "Asia/Shanghai" > /etc/timezone \
	&& dpkg-reconfigure -f noninteractive tzdata

EXPOSE 3306
VOLUME ["/web"]