pull:
	docker pull nginx:1.9.0
	docker pull php:5.6-fpm
	docker pull mysql:5.6
	docker pull redis:3.0
	docker pull memcached:1.4

dl:
	wget https://pecl.php.net/get/redis-2.2.7.tgz -O php/redis.tgz
	wget https://pecl.php.net/get/memcache-3.0.8.tgz -O php/memcache.tgz
	wget https://pecl.php.net/get/xdebug-2.3.2.tgz -O php/xdebug.tgz
	wget https://pecl.php.net/get/xhprof-0.9.4.tgz -O php/xhprof.tgz
	wget https://getcomposer.org/composer.phar -O php/composer.phar

build:
	make build-nginx
	make build-mysql
	make build-php

build-nginx:
	docker build -t web/nginx ./nginx

run-nginx:
	docker run -i -d -p 80:80 -v ~/web:/web -t web/nginx

in-nginx:
	docker run -i -p 80:80 -v ~/web:/web -t web/nginx /bin/bash

build-php:
	docker build -t web/php ./php

run-php:
	docker run -i -d -p 9000:9000 -v ~/web:/web -t web/php

in-php:
	docker run -i -p 9000:9000 -v ~/web:/web -t web/php /bin/bash

build-mysql:
	docker build -t web/mysql ./mysql

run-mysql:
	docker run -i -d -p 3306:3306 -v ~/web/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mzg168.2016 -t web/mysql

in-mysql:
	docker run -i -p 3306:3306  -v ~/web/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mzg168.2016 -t web/mysql /bin/bash
	
clean:
	docker rmi -f $(shell docker images | grep "<none>" | awk "{print \$3}")
