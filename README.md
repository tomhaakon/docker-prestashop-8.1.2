## Prestashop docker med msqli, imagick, memcached
21.10.23

### huske huske
docker-compose up -d --build
docker logs -f <container>
docker exec -ti <container> /bin/bash
docker image list
 
### nyttige linker

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