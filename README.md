# Itkdev docker

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
