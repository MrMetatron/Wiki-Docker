FROM php:7.4-apache

RUN apt-get update && apt-get install -y g++ git \
  	zlib1g-dev \
	libicu-dev \
  	libmagick++-dev   \
  	libmagickwand-dev \
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl 
  
RUN pecl install imagick-3.4.3
RUN docker-php-ext-enable imagick

RUN 

RUN pecl install apcu \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-enable apcu
