FROM nginx:latest

ADD conf/vhost.conf /etc/nginx/conf.d/default.conf