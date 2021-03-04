# Wiki-Docker
## 一、MediaWiki系统环境要求
- PHP 7.3.19+
- MySQL 5.5.8+, MariaDB, SQLite or PostgreSQL
- 找不到GD库或ImageMagick。缩略图功能将不可用。
- 发现Git版本控制软件：/usr/bin/git
- 使用PHP intl 扩展程序标准化Unicode。

## 二、官网MediaWiki下载链接
[mediawiki-1.35.1](https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.1.zip)

## 三、docker-compose.yml
```docker-compose
version: '3'

services:
    mariadb:
        image: mariadb
        restart: always
        environment:
            - MYSQL_ROOT_PASSWORD=123456
        volumes:
            - ./mysql:/var/lib/mysql
        expose:
            - "3306"
        networks:
            wiki-network:
                ipv4_address: 172.16.11.111

    memcached:
        image: memcached
        restart: always
        expose:
            - "11211"
        networks:
            wiki-network:
                ipv4_address: 172.16.11.112
        
    mediawiki:
        build: .
        restart: always
        volumes:
            - ./mediawiki-1.35.1:/var/www/html/
        depends_on:
            - mariadb
            - memcached
        ports:
            - "8080:80"
        networks:
            wiki-network:
                ipv4_address: 172.16.11.113
networks:
    wiki-network:
        ipam:
            config:
                - subnet: 172.16.11.0/24
```
## 四、Dockerfile
```Dockerfile
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
```


