FROM nginx:1.18.0

RUN apt-get update
RUN apt-get install -y git

RUN git clone https://github.com/perftools/xhgui.git /var/www/xhgui
RUN chmod -R 0777 /var/www/xhgui/cache

COPY xhgui.conf /etc/nginx/conf.d/default.conf