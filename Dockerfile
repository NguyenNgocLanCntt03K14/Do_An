FROM php:7.4-apache

RUN a2enmod rewrite && \
    a2enmod headers

RUN useradd theuser -m -p '09sjakfw_ka11sadf' && \
    usermod -aG theuser,root theuser

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN apt-get update && \
    apt-get install -y \
        vim \
        git \
        curl

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
