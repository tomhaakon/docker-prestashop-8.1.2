## Prestashop docker med msqli, imagick, memcached
21.10.23

kjør uten ny buildkit: 
```
sudo docker-compose up -d --build

```

docker-compose.yml
```
version: '3'
services:
  mysql:
    container_name: ps-mysql
    image: mysql:latest
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: admin
      MYSQL_DATABASE: prestashop
    networks:
      - prestashop_network
    volumes:
      - type: bind
        source: ./dbdata
        target: /var/lib/mysql

  phpmyadmin:

    image: phpmyadmin/phpmyadmin
    container_name: phpmyadmin
    environment:
      PMA_HOST: ps-mysql
      PMA_PORT: 3306
      PMA_ARBITRARY: 1
    restart: unless-stopped
    ports:
      - 81:80
    networks:
      - prestashop_network

  prestashop:    
    build:
      context: ./php/
      dockerfile: Dockerfile
    container_name: prestashop
    image: prestashop/prestashop:latest
    restart: unless-stopped
    depends_on:
      - mysql
    ports:
      - 80:80
    environment:
      DB_SERVER: ps-mysql
      DB_NAME: prestashop
      DB_USER: root
      DB_PASSWD: admin
      PS_DOMAIN: 192.168.86.36
      PS_INSTALL_AUTO: 1
      PS_FOLDER_ADMIN: admin4577
      PS_FOLDER_INSTALL: install4577
    networks:
      - prestashop_network
    volumes:
      - type: bind
        source: ./psdata
        target: /var/www/html

networks:
  prestashop_network:
volumes:
  psdata:
  dbdata:

```
Dockerfile
```
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
```
nyttige linker

(https://github.com/mlocati/docker-php-extension-installer)

### invalid host header
docker problem fix (invalid host header), problem med 2904
Bruk version 2893 istedet for 2904

```
snap info docker
snap refresh --stable docker
sudo snap refresh --revision=2893 docker
```

### clear all
```
docker system prune -a 
```