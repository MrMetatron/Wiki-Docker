FROM php:7.4-apache

RUN apt-get update && apt-get install -y g++ git zlib1g-dev \
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl 

RUN 

RUN pecl install apcu \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-enable apcu
