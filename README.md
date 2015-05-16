[![logo](https://raw.githubusercontent.com/pascalgrimaud/docker-postgresql/master/postgresql.png)]
(http://www.postgresql.org/)

[![Circle CI](https://circleci.com/gh/pascalgrimaud/docker-postgresql.svg?style=svg)]
(https://circleci.com/gh/pascalgrimaud/docker-postgresql)


# Information

The base docker image :

  * [pascalgrimaud/ubuntu](https://registry.hub.docker.com/u/pascalgrimaud/ubuntu/)

The GitHub project :

  * [pascalgrimaud/docker-ubuntu](https://github.com/pascalgrimaud/docker-postgresql/)


# Installation

You can clone this project and build with docker command :

```
git clone https://github.com/pascalgrimaud/docker-postgresql.git
cd docker-postgresql
docker build -t pascalgrimaud/postgresql:9.3 .
```

You can build directly from the [GitHub project](https://github.com/pascalgrimaud/docker-postgresql/) :

```
docker build -t pascalgrimaud/ubuntu github.com/pascalgrimaud/docker-postgresql.git
```


# Usage

Quick start with binding to port 5432 and random password :

```
docker run -d -p 5432:5432 pgrimaud/postgresql:9.3
```

To get the password :

```
docker logs <id>
```

Start and set a specific password for postgres user :

```
docker run -d -p 5432:5432 -e POSTGRES_PASS="pass" pgrimaud/postgresql:9.3
```


# Usage with volumes

Start and mount a volume for data persistence at ~/volumes/postgresql93/data :

```
docker run -d -p 5432:5432 -v ~/volumes/postgresql93/data:/var/lib/postgresql pgrimaud/postgresql:9.3
```

Start and mount a volume for data persistence at ~/volumes/postgresql93/data and logs at ~/volumes/postgresql93/logs :

```
docker run -d -p 5432:5432 -v ~/volumes/postgresql93/data:/var/lib/postgresql \
-v ~/volumes/postgresql93/logs:/var/log/postgresql pgrimaud/postgresql:9.3
```

Alternately, use the docker-compose.yml (edit this file) :

```
docker-compose up
```

If your forget the postgres user's password, delete the file .postgres_set_password :

```
sudo rm ~/volumes/postgresql93/data/9.3/.postgres_set_password
```
