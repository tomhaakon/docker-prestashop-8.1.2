FROM prestashop/prestashop:8.1.2

#imagick må ha libmagickwand-dev for å funke
#libmemcached-dev, libssl-dev, ziliblg-dev trengs for memcached
RUN apt-get update && apt-get install -y \
    libmagickwand-dev \ 
    libmemcached-dev \
    libssl-dev \
    zlib1g-dev \
    git \
    unzip

# imagick bildedrit
RUN pecl install imagick \
    && docker-php-ext-enable imagick

# snodig men funker
RUN yes '' | pecl install -f memcached-3.2.0 \
  && docker-php-ext-enable memcached

# mysqlI HER
RUN docker-php-ext-install mysqli


#php conf
COPY php.ini /usr/local/etc/php/
RUN a2enmod headers

RUN mkdir -p /var/www/html/app/Resources/translations && \
    chown -R www-data:www-data /var/www/html/app/Resources/translations

#gitignore
COPY ignorefile /var/www/html/.gitignore
COPY ignorefile /var/lib/mysql/.gitignore

ADD panda.zip /tmp/panda.zip

#RUN unzip /tmp/panda.zip -d /var/www/html/themes/panda && rm /tmp/panda.zip && chown -R www-data:www-data /var/www/html/themes/panda
#php config for prestashop 8
ADD phppsinfo.php /var/www/html/

# Set the script as the entrypoint
#ENTRYPOINT ["/usr/local/bin/init.sh"]

RUN apt-get purge -y --auto-remove git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
