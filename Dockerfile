FROM php:7.2-apache

RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv mysqli session gd pdo pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install xdebug-2.6.1 \
    && docker-php-ext-enable xdebug

RUN a2enmod rewrite

# add configs
ADD ./xdebug.ini /usr/local/etc/php/conf.d/201-xdebug.ini
ADD ./php.ini /usr/local/etc/php/conf.d/php.ini
