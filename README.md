# ITK-dev docker setup

This repository contains the custom images used by ITK-dev to support docker in development and production. It also contains tools to make docker usage easier in development. 

See https://hub.docker.com/search?q=itkdev&type=image

# Docker install
Install [Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/) and create account at https://hub.docker.com/.

## Optimizations 

* File Sharing (Only set path where you have your source code)
* Disk (Ensure the file has type `raw`)
* Advanced (CPU's, Memory)

# Usage

## Templates

The [`templates`](templates/) directory contains templates for adding
the itkdev `docker-compose` setup to new or exiting projects.


## Helper scripts

The [`scripts/itkdev-docker-compose`](scripts/itkdev-docker-compose)
script makes it easier to run common commands in the docker
containers.

Add the `scripts` directory to your `PATH` environment variable to run
the script from your `docker-compose` project.

If you're using the `bash` shell, run

```sh
echo 'export PATH="'$(git rev-parse --show-toplevel)/scripts':$PATH"' >> ~/.bashrc
```

to add the script to your `PATH`. If you're running `zsh`, run

```sh
echo 'export PATH="'$(git rev-parse --show-toplevel)/scripts':$PATH"' >> ~/.zshrc
```

After updating your path, run `itkdev-docker-compose` in your project
folder to see what the script can do.

__Note__: .env file.

## Docker UI

`docker run -d -p 9080:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer`

# ITK Images

## Drush6
Drush 6 image with memcached support enabled.

```sh
docker build --tag=itkdev/drush6 .
```

## PHP 7.0 FPM

```sh
docker build --tag=itkdev/php7.0-fpm .
```
