## Setup Oracle database

Run the following commands

```sh
cp .env .env.docker
mkdir oracle-home/data
sudo chown 54321:54321 oracle-home/data
```

### Start docker-compose

```sh
docker-compose up -d
```

Login to SqlPlus as dba

```sh
docker-compose exec oracle sqlplus sys/pgsql@localhost:1521/XEPDB1 as sysdba
```

Or you can change afterwards

```sql
alter session set container = XEPDB1;
```