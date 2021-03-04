FROM php:7.4-apache

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak

RUN echo "deb http://mirrors.163.com/debian/ stretch main non-free contrib" >/etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/debian/ stretch-proposed-updates main non-free contrib" >>/etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ stretch main non-free contrib" >>/etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ stretch-proposed-updates main non-free contrib" >>/etc/apt/sources.list

RUN apt-get update \
  && apt-get install -y zlib1g-dev libicu-dev g++ git \
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl 
  
RUN apt-get install -y libwebp-dev libjpeg-dev libpng-dev libfreetype6-dev
RUN docker-php-source extract && cd /usr/src/php/ext/gd
RUN docker-php-ext-configure gd && docker-php-ext-install gd

RUN pecl install apcu \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install gd \
	&& docker-php-ext-enable apcu	

