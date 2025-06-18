FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

ARG user
ARG uid

RUN apt-get update && \
    apt-get install -yq tzdata && \
    dpkg-reconfigure -f noninteractive tzdata

ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install NGINX
RUN apt-get install -y curl unzip build-essential nano wget mcrypt
RUN apt-get install -y software-properties-common
RUN apt-get update && apt-get install -y \
    vim \
    nginx \
    php7.4-fpm \
    apt-utils \
    curl \
    git \
    imagemagick \
    php7.4-cli \
    php7.4-json \
    php7.4-curl \
    php7.4-gd \
    php7.4-ldap \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-soap \
    php7.4-sqlite3 \
    php7.4-xml \
    php7.4-zip \
    php7.4-intl \
    php7.4-common \
    php7.4-bcmath \
    php7.4-bz2 \
    php7.4-dev \
    php7.4-imagick \
    php7.4-gd \
    php7.4-opcache \
    php7.4-redis \
    openssl \
    nano \
    graphicsmagick \
    imagemagick \
    ghostscript \
    mysql-client \
    iputils-ping \
    locales \
    sqlite3 \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://github.com/tideways/php-xhprof-extension/archive/v5.0.2.tar.gz" -o php-xhprof-extension.tar.gz && \
    tar xf php-xhprof-extension.tar.gz && \
    cd php-xhprof-extension-5.0.2 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    autoconf && \
    rm -rf /var/lib/apt/lists/* && \
    phpize && \
    ./configure && \
    make && \
    make install

RUN rm -rf ./php-xhprof-extension.tar.gz ./php-xhprof-extension-5.0.2
RUN echo "extension=tideways_xhprof.so" > /opt/bitnami/php/etc/conf.d/99-xhprof.ini

RUN pecl install mongodb-1.16.2
RUN echo "extension=mongodb.so" > /opt/bitnami/php/etc/conf.d/99-mongodb.ini

RUN sed -i -e 's/^error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/7.4/fpm/php.ini
RUN sed -i -e 's/^display_errors\s*=.*/display_errors = On/' /etc/php/7.4/fpm/php.ini
RUN sed -i -e 's/^zlib.output_compression\s*=.*/zlib.output_compression = Off/' /etc/php/7.4/fpm/php.ini
RUN sed -i -e 's/^post_max_size\s*=.*/post_max_size = 32M/' /etc/php/7.4/fpm/php.ini
RUN sed -i -e 's/^upload_max_filesize\s*=.*/upload_max_filesize = 32M/' /etc/php/7.4/fpm/php.ini

RUN rm /etc/nginx/sites-available/default
COPY default /etc/nginx/sites-available/default

# Expose port 80 to the outside world
EXPOSE 80 443 8088 8089

RUN apt-get update
#RUN apt-get -y purge '^php8.0*'
RUN php -v

RUN apt-get install -y php-cli
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN HASH="$(wget -q -O - https://composer.github.io/installer.sig)" && php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# install the package that will collect data
WORKDIR /var/xhgui
RUN composer require perftools/php-profiler perftools/xhgui-collector alcaeus/mongo-php-adapter

# copy the configuration file
COPY xhgui_config.php /var/xhgui/config/config.php

# Start NGINX when the container launches
CMD service php7.4-fpm start && nginx -g 'daemon off;'