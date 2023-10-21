FROM prestashop/prestashop:latest

#imagick må ha libmagickwand-dev for å funke
#libmemcached-dev, libssl-dev, ziliblg-dev trengs for memcached
RUN apt-get update && apt-get install -y \
    libmagickwand-dev \ 
    libmemcached-dev \
    libssl-dev \
    zlib1g-dev 


# imagick bildedrit
RUN pecl install imagick \
    && docker-php-ext-enable imagick

# snodig men funker
RUN yes '' | pecl install -f memcached-3.2.0 \
  && docker-php-ext-enable memcached

# mysqlI HER
RUN docker-php-ext-install mysqli


RUN apt-get clean && rm -rf /var/lib/apt/lists/*


#php config for prestashop 8
COPY php.ini /usr/local/etc/php/