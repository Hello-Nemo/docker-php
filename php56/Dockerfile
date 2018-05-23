FROM php:5.6-fpm

# Install env
ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
	git \
    cron \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    && rm -r /var/lib/apt/lists/*
	
# Install PHP extensions
COPY redis.tgz /home/redis.tgz
COPY memcache.tgz /home/memcache.tgz
#COPY xdebug.tgz /home/xdebug.tgz
#COPY xhprof.tgz /home/xhprof.tgz

RUN docker-php-ext-configure gd --enable-gd-native-ttf --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu --with-freetype-dir=/usr/lib/x86_64-linux-gnu \
        && docker-php-ext-install gd \
        && docker-php-ext-install zip \
        && docker-php-ext-install mbstring \
        && docker-php-ext-install mcrypt \
        && docker-php-ext-install mysql \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install pdo_mysql
RUN pecl install /home/redis.tgz && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
	&& pecl install /home/memcache.tgz && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini
		
# PHP config
ADD php.ini /usr/local/etc/php/php.ini
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

#Composer
ADD composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

#Cron
COPY crontabfile /root/crontabfile
RUN crontab /root/crontabfile
RUN /etc/init.d/cron start

WORKDIR /web

# Write Permission
RUN usermod -u 1000 www-data

# php-fpm:8000 xdebug:9000
EXPOSE 8000
VOLUME ["/web"]
CMD cron && php-fpm
