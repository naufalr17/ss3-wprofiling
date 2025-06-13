FROM ubuntu/nginx:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

ARG user
ARG uid

# Install PHP CLI and utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        tzdata \
        nano \
        software-properties-common \
        php-cli \
        unzip \
        build-essential \
        wget \
        ca-certificates && \
    ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy custom NGINX site config
COPY default /etc/nginx/sites-available/default
# RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Expose ports
EXPOSE 80 443 8088 8089

# Install XHGui
# RUN git clone https://github.com/perftools/xhgui.git /opt/bitnami/xhgui && \
#     cd /opt/bitnami/xhgui && \
#     php install.php

# Verify PHP
RUN php -v
# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    HASH="$(wget -q -O - https://composer.github.io/installer.sig)" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); exit(1); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
