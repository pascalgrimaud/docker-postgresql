<a href="http://www.postgresql.org/" target="_blank">
    <img src="https://raw.githubusercontent.com/pascalgrimaud/docker/master/postgresql/postgresql.png"/>
</a>

# Installation
```bash
cd 9.3/
docker build -t pgrimaud/postgresql:9.3 .
```
# Usage

Quick start with bidding to port 5432 and random password
```bash
docker run -d -p 5432:5432 pgrimaud/postgresql:9.3
```

To get the password
```bash
docker logs <id>
```

Start and set a specific password for postgres user
```bash
docker run -d -p 5432:5432 -e POSTGRES_PASS="pass" pgrimaud/postgresql:9.3
```

Start and mount a volume for data persistence at ~/volumes/postgresql93/data
```bash
docker run -d -p 5432:5432 -v ~/volumes/postgresql93/data:/var/lib/postgresql pgrimaud/postgresql:9.3
```

Start and mount a volume for data persistence at ~/volumes/postgresql93/data and logs at ~/volumes/postgresql93/logs
```bash
docker run -d -p 5432:5432 -v ~/volumes/postgresql93/data:/var/lib/postgresql \
-v ~/volumes/postgresql93/logs:/var/log/postgresql pgrimaud/postgresql:9.3
```

If your forget the postgres user's password, delete the file .postgres_set_password
```bash
sudo rm ~/volumes/postgresql93/data/9.3/.postgres_set_password
```
