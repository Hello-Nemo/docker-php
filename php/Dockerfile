FROM php:7.1-fpm

# Install env
ADD sources.list /etc/apt/sources.list
RUN echo "nameserver 223.5.5.5" > /etc/resolv.conf
RUN apt-get update && apt-get install -y \
	git \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libz-dev \
    libmemcached-dev \
    libxml2-dev \
    && rm -r /var/lib/apt/lists/*
	
# Install PHP extensions
# COPY xdebug.tgz /home/xdebug.tgz

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install gd \
        && docker-php-ext-install zip \
        && docker-php-ext-install mbstring \
        && docker-php-ext-install tokenizer \
        && docker-php-ext-install bcmath \
        && docker-php-ext-install mcrypt \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install pdo_mysql

		
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
EXPOSE 8001 
VOLUME ["/web"]
