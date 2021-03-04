FROM php:7.4-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
  autoconf \
  build-essential \
  apt-utils \
  zlib1g-dev \
  libzip-dev \
  unzip \
  zip \
  libmagick++-dev \
  libmagickwand-dev \
  libpq-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libwebp-dev \ 
  libxpm-dev 

RUN docker-php-ext-install gd 
RUN docker-php-ext-enable gd

RUN pecl install imagick-3.4.3
RUN docker-php-ext-enable imagick

RUN apt-get install -y zlib1g-dev libicu-dev g++ git \
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl 

RUN pecl install apcu \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-enable apcu	
