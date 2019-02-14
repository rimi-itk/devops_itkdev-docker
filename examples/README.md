# Itkdev docker examples

Update docker setup in examples:

```
./scripts/sync-docker-setup
```

Start an example:

```sh
cd «example directory»
docker-compose pull
docker-compose up -d
open $(../../scripts/itkdev-docker-compose url)
```
