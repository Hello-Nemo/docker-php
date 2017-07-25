FROM php:5.6-fpm

# Install env
ADD sources.list /etc/apt/sources.list
RUN echo "nameserver 223.5.5.5" > /etc/resolv.conf
RUN apt-get update && apt-get install -y \
	git \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libz-dev \
    libmemcached-dev \
    libxml2-dev \
    && rm -r /var/lib/apt/lists/*
	
# Install PHP extensions
COPY redis.tgz /home/redis.tgz
COPY memcached.tgz /home/memcached.tgz
COPY xdebug.tgz /home/xdebug.tgz
COPY xhprof.tgz /home/xhprof.tgz
COPY swoole-1.8.6.tgz /home/swoole.tgz

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install zip \
        && docker-php-ext-install gd \
        && docker-php-ext-install mbstring \
        && docker-php-ext-install tokenizer \
        && docker-php-ext-install bcmath \
        && docker-php-ext-install mcrypt \
        && docker-php-ext-install mysql \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install pdo_mysql
RUN pecl install /home/redis.tgz && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
        && pecl install /home/memcached.tgz && echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini \
        && pecl install /home/swoole.tgz && echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini \
        && pecl install /home/xhprof.tgz && echo "extension=xhprof.so" > /usr/local/etc/php/conf.d/xhprof.ini \
        && pecl install /home/xdebug.tgz && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_host=192.168.65.1" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_idekey=netbeans-xdebug" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_connect_back=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini
		
# PHP config
ADD php.ini /usr/local/etc/php/php.ini
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

#Composer
ADD composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

WORKDIR /web

# Write Permission
RUN usermod -u 1000 www-data

# php-fpm:8000 xdebug:9000
EXPOSE 8000 
VOLUME ["/web"]
