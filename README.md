# ITK-dev docker setup

This repository contains the custom images used by ITK-dev to support docker in development and production. It also contains tools to make docker usage easier in development. 

# Docker install
Recommend to that you install [Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/) and create account at https://hub.docker.com/ the account can be link to "itkdev" organisation allow you to push new images.

## Optimisations 

There are some simple tricks that makes docker perform better on Mac's. Open the docker preferences in the via the dock icon.

* File Sharing (Only set path where you have your source code)
* Disk (Ensure the file has type `raw`)
* Advanced (CPU's, Memory)

# Usage

## Templates

The [`templates`](templates/) directory contains templates for adding
the itkdev `docker-compose` setup to new or exiting projects.

`rsync -avz templates/<TYPE>/ <PATH TO HTDOCS FOLDER>`

Also create an `.env` file beside the `docker-compose.yml` file that contains `COMPOSE_PROJECT_NAME=<NAME>` to namespace the docker setup for the projekt.

## Docker commands

Start containers: `docker-compose up -d`

Stop containers: `docker-compose stop`

Stop and remove containers: `docker-compose down`

List containers in the project: `docker-compose ps`

Restart container: `docker-compose restart <CONTAINER NAME>`


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

After updating your path, run `itkdev-docker-compose` in your project folder to see what the script can do.

## Environment
The helper script uses an `.env` file in the root of the project for projekt base configuration.

The `COMPOSE_PROJECT_NAME` is always required and the script will stop execution if any of the need variables have not been set when needed.

### Example .env file
```sh
COMPOSE_PROJECT_NAME=ereolen
REMOTE_HOST=ereolen.dk
REMOTE_DB_DUMP_CMD='drush --root=/data/www/ereolen_dk/htdocs --uri=ereolen.dk sql-dump'
REMOTE_PATH='/data/www/ereolen_dk/htdocs/sites/default/files'
REMOTE_EXCLUDE=(ting styles advagg_*)
LOCAL_PATH='sites/default/files'
```

### Completion
To enable bash completion (tab commands).

```sh
ln -s $(git rev-parse --show-toplevel)/scripts/itkdev-docker-compose-completion.bash $(brew --prefix)/etc/bash_completion.d/itkdev-docker-compose
```

## Docker UI
If you want a graphical user interface to see what images and containers are running in you local setup you can use "potainer".

`docker run -d -p 9080:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer`

Open you browser at http://0.0.0.0:9080 and follow the on-screen instructions.

# ITK Images

At ITK-dev we have created docker images that matches our development.

The fuld list can be see at https://hub.docker.com/search?q=itkdev&type=image

## How to build
Please remember that changes to these images that are pushed to docker hub will effect all development projects. So changes should be coordinated with the development team.

```sh
docker build --tag=itkdev/php7.2-fpm .
docker push itkdev/php7.2-fpm
```
