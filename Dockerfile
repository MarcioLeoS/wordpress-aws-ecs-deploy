# Usamos la imagen oficial de WordPress
#FROM wordpress:6.6.2

# Establecer variables de entorno para configurar la base de datos
#ENV WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST}
#ENV WORDPRESS_DB_USER=${WORDPRESS_DB_USER}
#ENV WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}
#ENV WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME}

# Configuración de PHP para aumentar el tamaño máximo de subida a 2.4GB (necesario para backup)
#RUN echo "upload_max_filesize = 2358M" > /usr/local/etc/php/conf.d/uploads.ini && \
#    echo "post_max_size = 2358M" >> /usr/local/etc/php/conf.d/uploads.ini && \
#    echo "memory_limit = 2358M" >> /usr/local/etc/php/conf.d/uploads.ini

# Crear el directorio de mu-plugins
#RUN mkdir -p /usr/src/wordpress/wp-content/mu-plugins

# Copiar el mu-plugin al directorio de mu-plugins
#COPY disable-updates.php /usr/src/wordpress/wp-content/mu-plugins/

# Exponer el puerto 80 para el contenedor
#EXPOSE 80

# Comando por defecto para iniciar Apache
#CMD ["apache2-foreground"]
# Usamos la imagen oficial de WordPress
FROM wordpress:6.6.2

# Establecer variables de entorno para configurar la base de datos
ENV WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST}
ENV WORDPRESS_DB_USER=${WORDPRESS_DB_USER}
ENV WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}
ENV WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME}

# Exponer el puerto 80 para el contenedor
EXPOSE 80

# Configuración de PHP para aumentar el tamaño máximo de subida a 2.4GB (necesario para backup)
# Configuración de PHP para aumentar el tamaño máximo de subida y tiempos de ejecución
RUN echo "upload_max_filesize = 5000M" > /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size = 5000M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "memory_limit = 5000M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "max_execution_time = 0" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "max_input_time = -1" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "track_errors = 1" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "display_errors = On" >> /usr/local/etc/php/conf.d/uploads.ini

# COPY ./config-files/* /path/in/container/
