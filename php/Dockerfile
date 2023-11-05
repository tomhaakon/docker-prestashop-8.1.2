FROM prestashop/prestashop:latest

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

#install git
# chown -R www-data:www-data /var/www/html/php-ps-info \
#  git clone https://github.com/PrestaShop/php-ps-info.git /var/www/html/php-ps-info \

#php conf
COPY php.ini /usr/local/etc/php/

#gitignore
COPY ignorefile /var/www/html/.gitignore
COPY ignorefile /var/lib/mysql/.gitignore

#RUN mkdir -p /var/www/html/themes

#RUN mkdir -p /var/www/html/themes/panda
ADD panda.zip /tmp/panda.zip

RUN unzip /tmp/panda.zip -d /var/www/html/themes/panda && rm /tmp/panda.zip && chown -R www-data:www-data /var/www/html/themes/panda
#php config for prestashop 8
COPY phppsinfo.php /var/www/html/
#COPY init.sh /usr/local/bin/init.sh
#RUN chmod +x /usr/local/bin/init.sh

# Set the script as the entrypoint
#ENTRYPOINT ["/usr/local/bin/init.sh"]

RUN apt-get purge -y --auto-remove git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
