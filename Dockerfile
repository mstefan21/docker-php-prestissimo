FROM php:7.3.11-fpm-alpine

RUN apt-get update && apt-get install -yq \
	zip \
	libzip-dev \
	git \
	&& docker-php-ext-configure zip --with-libzip \
	&& docker-php-ext-install zip \
	&& apt-get clean all \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php --install-dir=/usr/bin --filename=composer \
	&& rm composer-setup.php \
	&& composer global require hirak/prestissimo:0.3.9
