FROM bitnami/php-fpm:7.4.33-debian-11-r25

USER root

RUN install_packages \
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
    php7.4-dev \
    php7.4-opcache \
    openssl \
    nano \
    graphicsmagick \
    ghostscript \
    default-mysql-client \
    iputils-ping \
    locales \
    sqlite3

RUN apt-get update && apt-get install -y \
    make \
    gcc \
    g++ \
    autoconf \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
# RUN apt-get install php-redis
RUN pecl install redis
RUN echo "extension=redis.so" > /opt/bitnami/php/etc/conf.d/99-redis.ini
# RUN curl "https://github.com/tideways/php-xhprof-extension/archive/v5.0.2.tar.gz" -fsL -o ./php-xhprof-extension.tar.gz && \
#     tar xf ./php-xhprof-extension.tar.gz && \
#     cd php-xhprof-extension-5.0.2 && \
#     apk add --update --no-cache build-base autoconf && \
#     phpize && \
#     ./configure && \
#     make && \
#     make install
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


# install mongodb extension. The xhgui-collector will send xprof data to mongo

RUN pecl install mongodb-1.16.2
RUN echo "extension=mongodb.so" > /opt/bitnami/php/etc/conf.d/99-mongodb.ini

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install the package that will collect data
WORKDIR /var/xhgui
RUN composer require perftools/php-profiler perftools/xhgui-collector alcaeus/mongo-php-adapter

# copy the configuration file
COPY xhgui_config.php /var/xhgui/config/config.php
    
# Update PHP configuration
# RUN sed -i -e 's/^error_reporting\s*=.*/error_reporting = E_ALL/' /opt/bitnami/php/etc/php.ini && \
#     sed -i -e 's/^display_errors\s*=.*/display_errors = On/' /opt/bitnami/php/etc/php.ini && \
#     sed -i -e 's/^log_errors\s*=.*/log_errors = On/' /opt/bitnami/php/etc/php.ini && \
#     sed -i -e 's/^error_log\s*=.*/error_log = /dev/stderr/' /opt/bitnami/php/etc/php.ini && \
#     sed -i -e 's/^zlib.output_compression\s*=.*/zlib.output_compression = Off/' /opt/bitnami/php/etc/php.ini && \
#     sed -i -e 's/^post_max_size\s*=.*/post_max_size = 32M/' /opt/bitnami/php/etc/php.ini && \
#     sed -i -e 's/^upload_max_filesize\s*=.*/upload_max_filesize = 32M/' /opt/bitnami/php/etc/php.ini
RUN sed -i -e 's/^error_reporting\s*=.*/error_reporting = E_ALL/' /opt/bitnami/php/etc/php.ini && \
    sed -i -e 's/^display_errors\s*=.*/display_errors = On/' /opt/bitnami/php/etc/php.ini && \
    sed -i -e 's/^log_errors\s*=.*/log_errors = On/' /opt/bitnami/php/etc/php.ini && \
    sed -i -e 's|^error_log\s*=.*|error_log = /dev/stderr|' /opt/bitnami/php/etc/php.ini && \
    sed -i -e 's/^zlib.output_compression\s*=.*/zlib.output_compression = Off/' /opt/bitnami/php/etc/php.ini && \
    sed -i -e 's/^post_max_size\s*=.*/post_max_size = 32M/' /opt/bitnami/php/etc/php.ini && \
    sed -i -e 's/^upload_max_filesize\s*=.*/upload_max_filesize = 32M/' /opt/bitnami/php/etc/php.ini
