# Hero DB

This repo contains the scripts to create and load sample data into the database.

## Docker

You can build the Docker image with the following command.

```
docker build -t hero-db .
```

And run it.

```
docker run -d --name hero-db -e MYSQL_ROOT_PASSWORD=root hero-db
```