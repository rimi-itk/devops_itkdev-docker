# Docker
This repos contains the setup to build docker images for ITK-dev.

See https://hub.docker.com/search?q=itkdev&type=image

## Drush6
Drush 6 image with memcached support enabled.

```sh
docker build --tag=itkdev/drush6 .
```

### Alias
```sh
alias ddrush='docker-compose run --rm drush'
```

## PHP 7.0 FPM

```sh
docker build --tag=itkdev/php7.0-fpm .
```

# Docker compose

## docker-compose.yml
```yml
version: "3"

services:
  mariadb:
    image: mariadb:10.3
    ports:
      - '3306'
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_USER: db
      MYSQL_PASSWORD: db
      MYSQL_DATABASE: db

  phpfpm:
    image: itkdev/php7.0-fpm:latest
    restart: always
    depends_on:
      - mariadb
    volumes:
      - .:/app:delegated

  nginx:
    image: nginx:latest
    depends_on:
      - phpfpm
      - memcached
    volumes:
      - ${PWD}/.docker/vhost.conf:/etc/nginx/conf.d/default.conf:ro
      - ./:/app:delegated

  memcached:
    image: 'memcached:latest'
    ports:
      - '11211'
    environment:
      - MEMCACHED_CACHE_SIZE=64

  varnish:
    image: 'wodby/varnish:4'
    depends_on:
      - nginx
    environment:
      VARNISHD_VCL_SCRIPT: /etc/varnish/ereolen.vcl
      VARNISH_SECRET: eca2b7c263eae74c0d746f147691e7ce
    volumes:
      - ${PWD}/.docker/ereolen.vcl:/etc/varnish/ereolen.vcl:ro
    labels:
      - "traefik.frontend.rule=Host:ereolen.docker.localhost"

  drush:
    image: itkdev/drush6:latest
    depends_on:
      - mariadb
    entrypoint:
      - drush
    volumes:
      - drush-cache:/root/.drush
      - ./:/app

  reverse-proxy:
    image: traefik  # The official Traefik docker image
    command: --api --docker  # Enables the web UI and tells Traefik to listen to docker
    ports:
      - "80"
      - "8080"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock  # So that Traefik can listen to the Docker events

# Drush cache volume to persist cache between runs. 
volumes:
  drush-cache:
```

## setting.local.php
```php
<?php

$databases['default']['default'] = array(
 'database' => 'db',
 'username' => 'db',
 'password' => 'db',
 'host' => 'mariadb',
 'port' => '',
 'driver' => 'mysql',
 'prefix' => '',
);

/**
 * Memcached configuration.
 */
include_once('./includes/cache.inc');
include_once('./profiles/ding2/modules/contrib/memcache/memcache.inc');

// Forms cache table.
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';

$conf['cache_backends'][] = 'profiles/ding2/modules/contrib/memcache/memcache.inc';
$conf['cache_default_class'] = 'MemCacheDrupal';
$conf['memcache_key_prefix'] = $databases['default']['default']['database'];
$conf['memcache_servers'] = array(
  'memcached:11211' => 'default',
);
$conf['memcache_bins'] = array(
  'cache' => 'default',
);
$conf['memcache_log_data_pieces'] = 10;

$conf['404_fast_paths_exclude'] = '/\/(?:styles)\//';
$conf['404_fast_paths'] = '/\.(?:txt|png|gif|jpe?g|css|js|ico|swf|flv|cgi|bat|pl|dll|exe|asp)$/i';
$conf['404_fast_html'] = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.0//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title>404 Not Found</title></head><body><h1>Not Found</h1><p>The requested URL "@path" was not found on this server.</p></body></html>';

/**
 * Varnish configutation.
 */
$conf['reverse_proxy'] = TRUE;
$conf['reverse_proxy_addresses'] = array('varnish');

// Set varnish configuration.
$conf['varnish_control_key'] = 'eca2b7c263eae74c0d746f147691e7ce';
$conf['varnish_socket_timeout'] = 500;
$conf['varnish_version'] = 4;

// Set ding varnish content types to override ding_base.
$conf['ding_varnish_content_types'] = array(
  'ding_page' => 'ding_page',
  'article' => 'article',
  'author_portrait' => 'author_portrait',
  'inspiration' => 'inspiration',
  'ereol_page' => 'ereol_page',
  'video' => 'video',
  'faq' => 'faq',
  'ding_group' => 'ding_group',
  'panel' => 0,
  'webform' => 0,
);

// Set varnish server IP's sperated by spaces
$conf['varnish_control_terminal'] = 'varnish:6082';
```

## vhost.conf
```conf
server {
  listen 0.0.0.0:8000;
  server_name ereolen.vm;

  root /app;

  location /robots.txt {
    allow all;
    log_not_found off;
    access_log off;
  }

  ## Replicate the Apache <FilesMatch> directive of Drupal standard
  ## .htaccess. Disable access to any code files. Return a 404 to curtail
  ## information disclosure. Hide also the text files.
  location ~* ^(?:.+\.(?:htaccess|make|txt|engine|inc|info|install|module|profile|po|sh|.*sql|theme|tpl(?:\.php)?|xtmpl)|code-style\.pl|/Entries.*|/Repository|/Root|/Tag|/Template)$ {
    return 404;
  }

  # Very rarely should these ever be accessed outside of your network
  location ~* \.(txt|log)$ {
    allow 127.0.0.1;
    deny all;
  }

  location ~* \.(?:css|js|jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc|woff|eot)$ {
    expires 1w;
    add_header ETag "";
    add_header Cache-Control "max-age=2628000, no-transform, public";

    access_log off;
    log_not_found off;

    try_files $uri @rewrite;
  }

  location ~* \.(?:css|js)$ {
    access_log off;
    log_not_found off;
  }

  location / {
    index  index.php;
    try_files $uri @rewrite;
  }

  # Catch image styles for D7 too.
  location ~ ^/sites/.*/files/styles/ {
    try_files $uri @rewrite;
  }

  location @rewrite {
    rewrite ^ /index.php last;
  }

  location ~ \.php$ {
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_pass phpfpm:9000;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME /app/$fastcgi_script_name;
    fastcgi_param HTTP_X_REQUEST_START "t=${msec}";
  }
}
```
