FROM php:7.4-apache

RUN apt-get -y update \
	&& apt-get install -y zlib1g-dev libicu-dev g++ \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install intl

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install apcu \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-enable apcu
