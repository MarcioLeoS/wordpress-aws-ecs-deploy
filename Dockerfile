# wordpress official image
FROM wordpress:latest

ENV WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST}
ENV WORDPRESS_DB_USER=${WORDPRESS_DB_USER}
ENV WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}
ENV WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME}


EXPOSE 80

# Config PHP to use 2gb ram
RUN echo "upload_max_filesize = 2358M" > /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size = 2358M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "memory_limit = 2358M" >> /usr/local/etc/php/conf.d/uploads.ini

# COPY ./config-files/* /path/in/container/

